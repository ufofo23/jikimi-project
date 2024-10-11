<template>
  <div class="address-search-container">
    <!-- 주소 검색과 폼 화면 -->
    <div v-if="showAddressForm">
      <input type="button" @click="openDaumPostcode" value="단지, 지역, 지하철, 학교 검색" class="search-input"
        :disabled="isLoading" />

      <div v-if="isLoading" class="loading-spinner">
        검색 중...
      </div>

      <!-- 주소 입력 폼 -->
      <div v-if="selectedAddress" class="selected-address-form">
        <h3>주소 입력</h3>
        <div class="form-group">
          <label>주소:</label>
          <input type="text" :value="selectedAddress.jibunJuso" readonly class="form-control" />
        </div>

        <div class="form-group">
          <label>건물명:</label>
          <input type="text" :value="selectedAddress.buildingName" readonly class="form-control" />
        </div>

        <!-- 동/호수 입력 폼 -->
        <div class="detail-form">
          <form @submit.prevent="submitForm">
            <div class="form-group">
              <label>동 (선택사항):</label>
              <input type="text" v-model="dong" class="form-control" pattern="[0-9]{1,4}"
                title="1-4자리 숫자만 입력 가능합니다" />
            </div>
            <div class="form-group">
              <label>호수 (선택사항):</label>
              <input type="text" v-model="ho" class="form-control" pattern="[0-9]{1,4}"
                title="1-4자리 숫자만 입력 가능합니다" />
            </div>
          </form>
        </div>

        <!-- 거래 진행 여부 선택 처리 -->
        <div class="contract-in-progress">
          <p>지금 부동산 계약을 하는 중인가요?</p>
          <div class="button-group">
            <button @click="handleProgressType('yes')"
              :class="['progress-option-button', { active: progressType === 'yes' }]">
              예
            </button>
            <button @click="handleProgressType('no')"
              :class="['progress-option-button', { active: progressType === 'no' }]">
              아니오
            </button>
          </div>
        </div>

        <!-- 계약 중인 경우 전세금, 계약자 성명 입력 폼 -->
        <div v-if="progressType === 'yes'" class="detail-form">
          <form @submit.prevent="submitForm">
            <div class="form-group">
              <label>전세금:<span v-if="Number(deposit) >= 10000">&nbsp;{{ formattedDeposit }}</span> </label>
              <input type="text" v-model="deposit" required class="form-control" />
            </div>
            <div class="form-group">
              <label>집주인 성명:</label>
              <div v-for="(name, index) in names" :key="index" class="name-input-container">
                <input type="text" v-model="names[index]" required class="form-control" placeholder="집주인 성명" />
                <div class="button-group">
                  <button @click="addName(index)" type="button" class="add-button">+</button>
                  <button v-if="index !== 0" @click="removeName(index)" type="button" class="remove-button">-</button>
                </div>
              </div>
            </div>
          </form>
        </div>

        <!-- 제출 버튼 -->
        <div class="submit-section">
          <button @click="submitForm" class="submit-button" :disabled="isLoading ||
            !progressType ||
            (progressType === 'yes' && (!deposit || names.some(name => !name)))
            ">
            제출
          </button>
        </div>
      </div>
    </div>

    <!-- 유니크 코드 목록 화면 -->
    <div v-if="!showAddressForm && addresses.length > 0" class="address-list">
      <h3>현재 거주중인 주소를 선택해주세요</h3>
      <div v-for="address in addresses" :key="address.commonUniqueNo" class="address-item">
        <div class="address-details">
          <p class="unique-code">유니크 코드: {{ address.commonUniqueNo }}</p>
          <p class="address">주소: {{ address.commAddrLotNumber }}</p>
          <p class="status">상태: {{ address.resState }}</p>
        </div>
        <button @click="sendUniqueCode(address.commonUniqueNo)" class="select-button" :disabled="isLoading">
          선택
        </button>
      </div>

      <!-- 뒤로가기 버튼 -->
      <button @click="goBack" class="back-button">
        뒤로가기
      </button>
    </div>

    <div v-if="errorMessage" class="error-message" role="alert">
      {{ errorMessage }}
      <button @click="errorMessage = ''" class="close-error">✕</button>
    </div>
  </div>
</template>

<script setup>
import { ref, watch ,onMounted } from 'vue';
import axios from 'axios';
import { useRoute } from 'vue-router';

const route = useRoute();

// 상태 관리
const addresses = ref([]);
const selectedAddress = ref('');
const dong = ref('');
const ho = ref('');
const errorMessage = ref('');
const isLoading = ref(false);
const progressType = ref(null);
const showAddressForm = ref(false);
const deposit = ref('');
const names = ref(['']);
const formattedDeposit = ref('');

// 뒤로가기 함수 추가
const goBack = () => {
  showAddressForm.value = true;
  addresses.value = [];
};

const formatDeposit = (value) => {
  const numValue = Number(value);
  if (isNaN(numValue)) return '';
  
  const billions = Math.floor(numValue / 100000000);
  const millions = Math.floor((numValue % 100000000) / 10000);
  
  if (billions > 0) {
    return `${billions}억${millions}만원`;
  } else {
    return `${millions}만원`;
  }
};

// deposit이 변경될 때마다 formattedDeposit 업데이트
watch(deposit, (newValue) => {
  formattedDeposit.value = formatDeposit(newValue);
});


// 계약자 추가 함수
const addName = () => {
  names.value.push('');
};

// 계약자 제거 함수
const removeName = (index) => {
  if (names.value.length > 1) {
    names.value.splice(index, 1);
  }
};

// API 설정
const api = axios.create({
  baseURL: 'http://localhost:8080/api/safety-inspection',
  timeout: 30000,
});

// 에러 처리 함수
const handleError = (error, customMessage) => {
  console.error(error);
  errorMessage.value = customMessage || '처리 중 오류가 발생했습니다. 다시 시도해 주세요.';
  isLoading.value = false;
};

// Daum 우편번호 검색
const openDaumPostcode = () => {
  new daum.Postcode({
    oncomplete: (data) => {
      selectedAddress.value = {
        zonecode: data.zonecode,
        roadAddress: data.roadAddress,
        buildingName: data.buildingName || '없음',
        apartment: data.apartment,
        jibunJuso: data.jibunAddress,
        bname: data.bname,
        sido: data.sido,
      };

      showAddressForm.value = true;
      addresses.value = [];
      resetForm(false);
    },
  }).open();
};

// 거래 진행 여부 선택 처리
const handleProgressType = (type) => {
  progressType.value = type;
  if (type === 'no') {
    deposit.value = '';
    names.value = [''];
  }
};

// 공통 payload 생성 함수
const generatePayload = (uniqueCode) => {
  const jibunAddressParts = selectedAddress.value.jibunJuso.split(' ');
  const addr_sido = jibunAddressParts[0].match(/.*[시도]/)[0] || '';
  const addr_dong = jibunAddressParts[1] || '';
  const addr_lotNumber = jibunAddressParts[jibunAddressParts.length - 1] || '';
  const jibunAddressStr = selectedAddress.value.jibunJuso;
  const jibunAddress = jibunAddressStr.replace(addr_sido, addr_sido+" ").trim();
  const price = selectedAddress.value.price * 100000000;
  

  let zipCode = "";
  if (selectedAddress.value.zipcode < 10000) {
    zipCode = "0" + selectedAddress.value.zipCode;
  } else {
    zipCode = "" + selectedAddress.value.zipCode;
  }

  const payload = {
    addr_sido,
    addr_dong,
    addr_lotNumber,
    buildingName: selectedAddress.value.buildingName || '',
    dong: dong.value || '',
    ho: ho.value || '',
    zipCode,
    deposit: progressType.value === 'yes' ? deposit.value : '',
    contractName: names.value,
    jibunAddress,
    uniqueCode,
    propertyNo: selectedAddress.value.propertyNo,
    price,
  };

  return payload;
};


// 폼 제출 함수 수정
const submitForm = async () => {
  if (isLoading.value) return;

  isLoading.value = true;
  try {
    const payload = generatePayload();
    console.log(payload);

    const response = await api.post('/address', payload);
    if (Array.isArray(response.data) && response.data.length > 0) {
      addresses.value = response.data;
      showAddressForm.value = false; // 폼 화면 숨기기
    } else {
      errorMessage.value = '조회된 주소가 없습니다.';
    }
  } catch (error) {
    handleError(error, '주소 검증에 실패했습니다.');
  } finally {
    isLoading.value = false;
  }
};

// 유니크 코드 전송
const sendUniqueCode = async (uniqueCode) => {
  if (isLoading.value) return;

  isLoading.value = true;
  try {
    const payload = generatePayload(uniqueCode);
    console.log('Sending Unique Code with:', payload);

    const response = await api.post('/cors', payload);
    const reportNo = response.data;

    route.push({ path: '/report', query: {reportNo} });
  } catch (error) {
    handleError(error, '유니크 코드 전송에 실패했습니다.');
  } finally {
    isLoading.value = false;
  }
};


// 초기화 함수 수정
const resetForm = (fullReset = true) => {
  if (fullReset) {
    selectedAddress.value = null;
    showAddressForm.value = true; // 폼 화면 보이기
    addresses.value = [];
  }
  dong.value = '';
  ho.value = '';
  deposit.value = '';
  names.value = [''];
  errorMessage.value = '';
  progressType.value = null;
};

onMounted(() => {
  resetForm(true);
  if (route.query) {
    selectedAddress.value = {
      jibunJuso: route.query.jibunJuso,
      buildingName: route.query.buildingName,
      propertyNo: route.query.propertyNo,
      zipCode: route.query.zipcode,
      price: route.query.price
    };
  }
});
</script>


<style scoped>

.back-button {
  background-color: #6c757d;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  width: 100%;
  margin-top: 20px;
  transition: background-color 0.3s ease;
}

.back-button:hover {
  background-color: #5a6268;
}

.address-search-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-input {
  width: 100%;
  height: 60px;
  border-radius: 10px;
  border: 1px solid #ccc;
  padding: 0 15px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.search-input:hover:not(:disabled) {
  border-color: rgb(0, 181, 0);
}

.search-input:disabled {
  background-color: #f5f5f5;
  cursor: not-allowed;
}

.loading-spinner {
  text-align: center;
  margin: 20px 0;
  color: #666;
}

.address-list {
  margin-top: 20px;
}

.address-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #eee;
  margin: 10px 0;
  padding: 15px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.address-item:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.select-button {
  background-color: rgb(0, 181, 0);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.select-button:hover:not(:disabled) {
  background-color: rgb(0, 150, 0);
}

.select-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.form-group {
  margin-bottom: 15px;
}

.form-control {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.error-message {
  background-color: #fff3f3;
  color: #dc3545;
  padding: 10px;
  border-radius: 4px;
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.close-error {
  background: none;
  border: none;
  color: #dc3545;
  cursor: pointer;
}

.button-group {
  display: flex;
  gap: 10px;
  margin: 10px 0;
}

.option-button,
.progress-option-button {
  padding: 8px 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: white;
  cursor: pointer;
}

.option-button.active,
.progress-option-button.active {
  background-color: rgb(0, 181, 0);
  color: white;
  border-color: rgb(0, 181, 0);
}

.submit-button {
  background-color: rgb(0, 181, 0);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  width: 100%;
  margin-top: 10px;
}

.submit-button:hover:not(:disabled) {
  background-color: rgb(0, 150, 0);
}

.submit-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.submit-section {
  margin-top: 20px;
}

.new-search-button {
  background-color: #666;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  width: 100%;
  margin-top: 20px;
  transition: background-color 0.3s ease;
}

.new-search-button:hover {
  background-color: #555;
}

.address-list {
  margin-top: 20px;
  padding: 20px;
  border-radius: 8px;
  background-color: #f8f9fa;
}


.button-group {
  display: flex;
  align-items: center;
  gap: 5px; /* 버튼들 간의 간격 */
}

.add-button,
.remove-button {
  background-color: #0d6efd; 
  color: white;
  border: none;
  padding: 10px; 
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  width: 40px; /* 버튼의 너비를 고정 */
  height: 40px; /* 버튼의 높이도 고정 */
  display: flex;
  justify-content: center;
  align-items: center;
}

.add-button {
  background-color: #0d6efd; /* 추가 버튼*/
}

.remove-button {
  background-color: #dc3545; /* 삭제 버튼*/
}

.add-button:hover {
  background-color: #0d6efd; /* 마우스 호버*/
}

.remove-button:hover {
  background-color: #c82333; /* 마우스 호버*/
}

</style>


<style scoped>
.address-search-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-input {
  width: 100%;
  height: 60px;
  border-radius: 10px;
  border: 1px solid #ccc;
  padding: 0 15px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.search-input:hover:not(:disabled) {
  border-color: rgb(0, 181, 0);
}

.search-input:disabled {
  background-color: #f5f5f5;
  cursor: not-allowed;
}

.loading-spinner {
  text-align: center;
  margin: 20px 0;
  color: #666;
}

.address-list {
  margin-top: 20px;
}

.address-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #eee;
  margin: 10px 0;
  padding: 15px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.address-item:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.select-button {
  background-color: rgb(0, 181, 0);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.select-button:hover:not(:disabled) {
  background-color: rgb(0, 150, 0);
}

.select-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.form-group {
  margin-bottom: 15px;
}

.form-control {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.error-message {
  background-color: #fff3f3;
  color: #dc3545;
  padding: 10px;
  border-radius: 4px;
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.close-error {
  background: none;
  border: none;
  color: #dc3545;
  cursor: pointer;
}

.button-group {
  display: flex;
  gap: 10px;
  margin: 10px 0;
}

.option-button,
.progress-option-button {
  padding: 8px 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: white;
  cursor: pointer;
}

.option-button.active,
.progress-option-button.active {
  background-color: rgb(0, 181, 0);
  color: white;
  border-color: rgb(0, 181, 0);
}

.submit-button {
  background-color: rgb(0, 181, 0);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  width: 100%;
  margin-top: 10px;
}

.submit-button:hover:not(:disabled) {
  background-color: rgb(0, 150, 0);
}

.submit-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.submit-section {
  margin-top: 20px;
}

.new-search-button {
  background-color: #666;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  width: 100%;
  margin-top: 20px;
  transition: background-color 0.3s ease;
}

.new-search-button:hover {
  background-color: #555;
}

.address-list {
  margin-top: 20px;
  padding: 20px;
  border-radius: 8px;
  background-color: #f8f9fa;
}


.button-group {
  display: flex;
  align-items: center;
  gap: 5px; /* 버튼들 간의 간격 */
}

.add-button,
.remove-button {
  background-color: #0d6efd; 
  color: white;
  border: none;
  padding: 10px; 
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  width: 40px; /* 버튼의 너비를 고정 */
  height: 40px; /* 버튼의 높이도 고정 */
  display: flex;
  justify-content: center;
  align-items: center;
}

.add-button {
  background-color: #0d6efd; /* 추가 버튼*/
}

.remove-button {
  background-color: #dc3545; /* 삭제 버튼*/
}

.add-button:hover {
  background-color: #0d6efd; /* 마우스 호버*/
}

.remove-button:hover {
  background-color: #c82333; /* 마우스 호버*/
}

</style>