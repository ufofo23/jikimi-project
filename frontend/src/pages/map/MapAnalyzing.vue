<template>
  <div class="address-search-container">
    <!-- 주소 검색과 폼 화면 -->
    <div v-if="showAddressForm">
      <div v-if="isLoading" class="loading-spinner">검색 중...</div>

      <!-- 주소 입력 폼 -->
      <div v-if="selectedAddress" class="selected-address-form">
        <h3>주소 입력</h3>
        <div class="form-group">
          <label>주소:</label>
          <input
            type="text"
            :value="selectedAddress.jibunJuso"
            readonly
            class="form-control"
          />
        </div>

        <div class="form-group">
          <label>건물명:</label>
          <input
            type="text"
            :value="selectedAddress.buildingName"
            readonly
            class="form-control"
          />
        </div>

        <!-- 동/호수 입력 폼 -->
        <div class="detail-form">
          <form @submit.prevent="submitForm">
            <div class="form-group">
              <label>동 (선택사항):</label>
              <input
                type="text"
                v-model="dong"
                class="form-control"
                pattern="[0-9]{1,4}"
                title="1-4자리 숫자만 입력 가능합니다"
              />
            </div>
            <div class="form-group">
              <label>호수 (선택사항):</label>
              <input
                type="text"
                v-model="ho"
                class="form-control"
                pattern="[0-9]{1,4}"
                title="1-4자리 숫자만 입력 가능합니다"
              />
            </div>
          </form>
        </div>

        <!-- 거래 진행 여부 선택 처리 -->
        <div class="contract-in-progress">
          <p>지금 부동산 계약을 하는 중인가요?</p>
          <div class="button-group">
            <button
              @click="handleProgressType('yes')"
              :class="[
                'progress-option-button',
                { active: progressType === 'yes' },
              ]"
            >
              예
            </button>
            <button
              @click="handleProgressType('no')"
              :class="[
                'progress-option-button',
                { active: progressType === 'no' },
              ]"
            >
              아니오
            </button>
          </div>
        </div>

        <!-- 계약 중인 경우 전세금, 계약자 성명 입력 폼 -->
        <div v-if="progressType === 'yes'" class="detail-form">
          <form @submit.prevent="submitForm">
            <div class="form-group">
              <label
                >전세금:<span v-if="Number(jeonsePrice) >= 10000"
                  >&nbsp;{{ formattedDeposit }}</span
                >
              </label>
              <input
                type="text"
                v-model="jeonsePrice"
                required
                class="form-control"
              />
            </div>
            <div class="form-group">
              <label>집주인 성명:</label>
              <div
                v-for="(name, index) in names"
                :key="index"
                class="name-input-container"
              >
                <input
                  type="text"
                  v-model="names[index]"
                  required
                  class="form-control"
                  placeholder="집주인 성명"
                />
                <div class="button-group">
                  <button
                    @click="addName(index)"
                    type="button"
                    class="add-button"
                  >
                    +
                  </button>
                  <button
                    v-if="index !== 0"
                    @click="removeName(index)"
                    type="button"
                    class="remove-button"
                  >
                    -
                  </button>
                </div>
              </div>
            </div>
          </form>
        </div>

        <!-- 제출 버튼 -->
        <div class="submit-section">
          <button
            @click="submitForm"
            class="submit-button"
            :disabled="
              isLoading ||
              !progressType ||
              (progressType === 'yes' &&
                (!jeonsePrice || names.some((name) => !name)))
            "
          >
            제출
          </button>
        </div>
      </div>
    </div>

    <!-- 유니크 코드 목록 화면 -->
    <div v-if="!showAddressForm && addresses.length > 0" class="address-list">
      <h3>현재 거주중인 주소를 선택해주세요</h3>
      <div
        v-for="address in addresses"
        :key="address.commonUniqueNo"
        class="address-item"
      >
        <div class="address-details">
          <p class="unique-code">유니크 코드: {{ address.commonUniqueNo }}</p>
          <p class="address">주소: {{ address.commAddrLotNumber }}</p>
          <p class="status">상태: {{ address.resState }}</p>
        </div>
        <button
          @click="sendUniqueCode(address.commonUniqueNo)"
          class="select-button"
          :disabled="isLoading"
        >
          선택
        </button>
      </div>

      <!-- 뒤로가기 버튼 -->
      <button @click="goBack" class="back-button">뒤로가기</button>
    </div>

    <div v-if="errorMessage" class="error-message" role="alert">
      {{ errorMessage }}
      <button @click="errorMessage = ''" class="close-error">✕</button>
    </div>
  </div>
  <div v-if="isLoadingCORS" class="loading-overlay">
    <div class="loading-content">
      <div class="spinner"></div>
      <p>안전진단 보고서를 생성하고 있습니다...</p>
      <p>잠시만 기다려주세요.</p>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import axiosInstance from '@/axiosInstance'; // axiosInstance 가져오기
import { useRoute } from 'vue-router';
import { useRouter } from 'vue-router';
const route = useRoute();
const router = useRouter();

// 상태 관리
const addresses = ref([]);
const selectedAddress = ref('');
const dong = ref('');
const ho = ref('');
const errorMessage = ref('');
const isLoading = ref(false);
const progressType = ref(null);
const showAddressForm = ref(false);
const jeonsePrice = ref('');
const names = ref(['']);
const formattedDeposit = ref('');
const isLoadingCORS = ref(false);

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
watch(jeonsePrice, (newValue) => {
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
// const api = axios.create({
//   baseURL: 'http://localhost:8080/api/safety-inspection',
//   timeout: 500000,
// });

// 에러 처리 함수
const handleError = (error, customMessage) => {
  console.error(error);
  errorMessage.value =
    customMessage || '처리 중 오류가 발생했습니다. 다시 시도해 주세요.';
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
    jeonsePrice.value = '';
    names.value = [''];
  }
};

// 공통 payload 생성 함수
const generatePayload = (uniqueCode) => {
  const jibunAddressParts = selectedAddress.value.jibunJuso.split(' ');
  const addr_sido = jibunAddressParts[0].match(/.*[시도]/)[0] || '';
  const addr_dong = jibunAddressParts[1] || '';
  const addr_lotNumber =
    jibunAddressParts[jibunAddressParts.length - 1].replace(/\r$/, '') || '';
  const jibunAddressStr = selectedAddress.value.jibunJuso;
  const jibunAddress = jibunAddressStr
    .replace(addr_sido, addr_sido + ' ')
    .trim();
  const price = String(Math.round(selectedAddress.value.price * 100000000));

  let zipCode = '';
  if (selectedAddress.value.zipcode < 10000) {
    zipCode = '0' + selectedAddress.value.zipCode;
  } else {
    zipCode = '' + selectedAddress.value.zipCode;
  }

  const payload = {
    addr_sido,
    addr_dong,
    addr_lotNumber,
    buildingName: selectedAddress.value.buildingName || '',
    dong: dong.value || '',
    ho: ho.value || '',
    zipCode,
    jeonsePrice: progressType.value === 'yes' ? jeonsePrice.value : '',
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

    const response = await axiosInstance.post(
      '/api/safety-inspection/address',
      payload,
      {
        timeout: 300000,
      }
    );
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
  isLoadingCORS.value = true;
  try {
    const payload = generatePayload(uniqueCode);
    console.log('Sending Unique Code with:', payload);
    const response = await axiosInstance.post(
      '/api/safety-inspection/cors',
      payload,
      {
        timeout: 300000,
      }
    );
    const reportNo = response.data;
    console.log(reportNo);
    router.push(`/report/${reportNo}`);
  } catch (error) {
    handleError(error, '유니크 코드 전송에 실패했습니다.');
  } finally {
    isLoading.value = false;
    isLoadingCORS.value = false;
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
  jeonsePrice.value = '';
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
      zipCode: route.query.zipCode,
      price: route.query.price,
    };
  }
});
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css');

.address-search-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.form-section {
  background-color: #ffffff;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.search-button {
  width: 100%;
  height: 60px;
  border-radius: 30px;
  border: none;
  background-color: #007bff;
  color: white;
  font-size: 18px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.search-button:hover:not(:disabled) {
  background-color: #0056b3;
  transform: translateY(-2px);
}

.search-button:disabled {
  background-color: #b0d4ff;
  cursor: not-allowed;
}

.search-button i {
  margin-right: 10px;
}

.loading-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px 0;
  color: #007bff;
}

.spinner {
  border: 4px solid rgba(0, 123, 255, 0.1);
  border-left-color: #007bff;
  border-radius: 50%;
  width: 30px;
  height: 30px;
  animation: spin 1s linear infinite;
  margin-right: 10px;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.form-title,
.list-title {
  color: #007bff;
  font-size: 24px;
  font-weight: 700;
  margin-bottom: 20px;
  text-align: center;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  color: #495057;
  font-weight: 500;
}

.form-control {
  width: 100%;
  padding: 12px;
  border: 1px solid #ced4da;
  border-radius: 4px;
  font-size: 16px;
  transition: border-color 0.3s ease;
}

.form-control:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.button-group {
  display: flex;
  gap: 10px;
  margin: 10px 0;
}

.progress-option-button {
  flex: 1;
  padding: 12px;
  border: 2px solid #007bff;
  border-radius: 4px;
  background-color: white;
  color: #007bff;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.progress-option-button.active {
  background-color: #007bff;
  color: white;
}

.name-input-container {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
}

.add-button,
.remove-button {
  width: 40px;
  height: 40px;
  border: none;
  border-radius: 20px;
  color: white;
  font-size: 18px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.add-button {
  background-color: #28a745;
}

.add-button:hover {
  background-color: #218838;
}

.remove-button {
  background-color: #dc3545;
}

.remove-button:hover {
  background-color: #c82333;
}

.submit-button,
.select-button,
.back-button {
  width: 100%;
  padding: 12px;
  border: none;
  border-radius: 4px;
  color: white;
  font-size: 18px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.submit-button {
  background-color: #007bff;
  margin-top: 20px;
}

.submit-button:hover:not(:disabled) {
  background-color: #0056b3;
}

.submit-button:disabled {
  background-color: #b0d4ff;
  cursor: not-allowed;
}

.address-list {
  background-color: #ffffff;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.address-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #f8f9fa;
  margin: 15px 0;
  padding: 20px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.address-item:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.address-details p {
  margin: 5px 0;
  color: #495057;
}

.unique-code {
  font-weight: 700;
  color: #007bff;
}

.select-button {
  background-color: #28a745;
  padding: 8px 16px;
}

.select-button:hover:not(:disabled) {
  background-color: #218838;
}

.select-button:disabled {
  background-color: #8fc7a1;
  cursor: not-allowed;
}

.back-button {
  background-color: #6c757d;
  margin-top: 20px;
}

.back-button:hover {
  background-color: #5a6268;
}

.error-message {
  background-color: #f8d7da;
  color: #721c24;
  padding: 15px;
  border-radius: 4px;
  margin-top: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.close-error {
  background: none;
  border: none;
  color: #721c24;
  font-size: 18px;
  cursor: pointer;
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}

.loading-content {
  background-color: white;
  padding: 40px;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.spinner {
  border: 4px solid rgba(0, 123, 255, 0.1);
  border-left-color: #007bff;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin 1s linear infinite;
  margin: 0 auto 20px;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.loading-content p {
  margin: 10px 0;
  color: #333;
  font-size: 18px;
}
</style>
