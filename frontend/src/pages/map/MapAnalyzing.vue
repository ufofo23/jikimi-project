<template>
  <div class="address-search-container">
    <!-- 주소 검색과 폼 화면 -->
    <div v-if="showAddressForm">
      <input
        type="button"
        @click="openDaumPostcode"
        value="단지, 지역, 지하철, 학교 검색"
        class="search-input"
        :disabled="isLoading"
      />

      <div v-if="isLoading" class="loading-spinner">검색 중...</div>

      <!-- 주소 입력 폼 -->
      <div v-if="selectedAddress" class="selected-address-form">
        <div class="texxt">조회된 주소 정보</div>
        <!-- 라벨과 입력칸 가로 배열 -->
        <div class="form-group row">
          <label class="form-label">주소</label>
          <input
            type="text"
            :value="selectedAddress.jibunJuso"
            readonly
            class="form-control"
          />
        </div>

        <div class="form-group row">
          <label class="form-label">건물명</label>
          <input
            type="text"
            :value="selectedAddress.buildingName"
            readonly
            class="form-control"
          />
        </div>

        <!-- 동/호수 입력 폼 -->
        <div class="detail-form row">
          <h5 class="texxt">필요시 동/호수 기입</h5>
          <form @submit.prevent="submitForm">
            <div class="form-group row">
              <label class="form-label">동</label>
              <input
                type="text"
                v-model="dong"
                class="form-control"
                pattern="[0-9]{1,4}"
                title="1-4자리 숫자만 입력 가능합니다"
              />
            </div>
            <div class="form-group row">
              <label class="form-label">호수</label>
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
          <p class="texxt">지금 부동산 계약이 진행 중인가요?</p>
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
            <div class="form-group row">
              <label class="form-label">전세금 </label>
              <input
                type="text"
                v-model="jeonsePrice"
                required
                class="form-control"
                placeholder="(단위 : 원)"
              />
            </div>

            <!-- 집주인 성명 입력 -->
            <div class="form-group flex">
              <label class="form-label juin">집주인 성명</label>

              <div
                v-for="(name, index) in names"
                :key="index"
                class="name-input"
              >
                <input
                  type="text"
                  v-model="names[index]"
                  required
                  class="form-control"
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
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import axios from 'axios';
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
const api = axios.create({
  baseURL: 'http://localhost:8080/api/safety-inspection',
  timeout: 100000,
});

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
  const addr_lotNumber = jibunAddressParts[jibunAddressParts.length - 1] || '';
  const jibunAddressStr = selectedAddress.value.jibunJuso;
  const jibunAddress = jibunAddressStr
    .replace(addr_sido, addr_sido + ' ')
    .trim();
  const price = selectedAddress.value.price * 100000000;

  let zipCode = '';
  if (selectedAddress.value.zipCode < 10000) {
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
    console.log(reportNo);

    router.push(`/report/${reportNo}`);
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
.detail-form h5 {
  font-size: 20px; /* 글씨 크기 줄임 */
  margin-bottom: 10px;
  color: blue;
}

.form-label {
  font-size: 25px; /* 글씨 크기 키움 */
  text-align: center; /* 가운데 정렬 */
}

.name-input-container {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}

.texxt {
  font-size: 30px;
  text-align: center;
  margin: 50px;
}

.address-search-container {
  background-color: #f8ffe9;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  display: flex;
  flex-direction: column;
  justify-content: center; /* Centers the content vertically */
  align-items: center; /* Centers the content horizontally */
  height: 100vh; /* Full viewport height for vertical centering */
}

.row {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
  justify-content: center; /* Centers row contents */
}
.form-label {
  width: 30%; /* 라벨 너비 */
  font-weight: bold;
}

.form-control {
  width: 70%; /* 입력칸 너비 */
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  transition: all 0.3s ease;
}

/* 기본 검색 입력 필드 */
.search-input {
  width: 100%;
  height: 60px;
  border-radius: 10px;
  border: 1px solid #ccc;
  padding: 0 15px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-bottom: 50px;
  margin-top: 50px;
}

.search-input:hover:not(:disabled) {
  border-color: rgb(24, 86, 210);
}

.loading-spinner {
  text-align: center;
  margin: 20px 0;
  color: #666;
}

/* 버튼 그룹 스타일 */
.button-group {
  display: flex;
  gap: 10px;
  margin: 10px 0;
  justify-content: center;
}

.submit-button {
  margin-top: 30px;
}

.submit-button,
.search-input {
  background-color: #4a61f3; /* Use the same blue color from the image */
  color: white;
  border: none;
  border-radius: 25px; /* Rounded corners */
  font-size: 16px;
  cursor: pointer;
  text-align: center;
  transition: background-color 0.3s ease;
  width: 100%; /* Full-width for your use case */
  height: 50px;
}

.submit-button:hover:not(:disabled),
.search-input:hover:not(:disabled) {
  background-color: #3a51e3; /* Slightly darker on hover */
}

.submit-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.submit-section,
.address-search-container {
  display: flex;
  justify-content: center; /* Centers the button horizontally */
  align-items: center; /* Centers the button vertically if necessary */
}
/* 계약 진행 여부 선택 버튼 */
.progress-option-button {
  padding: 8px 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: white;
  cursor: pointer;
}

.progress-option-button.active {
  background-color: rgb(24, 86, 210);
  color: white;
  border-color: rgb(24, 86, 210);
}

/* 계약자 성명 추가/제거 버튼 */
.add-button,
.remove-button {
  background-color: #0d6efd;
  color: white;
  border: none;
  padding: 10px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.add-button:hover {
  background-color: #0d6efd;
}

.remove-button:hover {
  background-color: #c82333;
}
</style>
