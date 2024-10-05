<template>
  <div>
    <input
      type="button"
      @click="openDaumPostcode"
      value="단지, 지역, 지하철, 학교 검색"
      class="search-input"
    />

    <div v-if="selectedAddress">
      <h3>주소 입력</h3>
      <label>
        도로명 주소:
        <input type="text" :placeholder="selectedAddress.roadAddress" readonly />
      </label>
      <label>
        건물명:
        <input type="text" :placeholder="selectedAddress.buildingName" readonly />
      </label>
      <p>아파트 / 오피스텔에 거주 중인가요?</p>
      <button @click="askForDetails('yes')">예</button>
      <button @click="askForDetails('no')">아니오</button>

      <div v-if="showForm">
        <form @submit.prevent="submitForm('yes')">
          <label>
            동:
            <input type="text" v-model="dong" required />
          </label>
          <label>
            호수:
            <input type="text" v-model="ho" required />
          </label>
          <button type="submit">제출</button>
        </form>
      </div>
    </div>

    <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

const selectedAddress = ref(null);
const dong = ref('');
const ho = ref('');
const showForm = ref(false);
const errorMessage = ref('');

const openDaumPostcode = () => {
  new daum.Postcode({
    oncomplete: function (data) {
      // 선택한 주소 정보를 상태 변수에 저장
      selectedAddress.value = {
        zonecode: data.zonecode,
        roadAddress: data.roadAddress,
        buildingName: data.buildingName || '없음',
        apartment: data.apartment,
        jibunAddress: data.jibunAddress,
        bname: data.bname,
        sido: data.sido 
      };
    },
  }).open();
};

const askForDetails = (response) => {
  if (response === 'yes') {
    showForm.value = true; 
  } else {
    showForm.value = false; 
    submitForm('no'); 
  }
};

const submitForm = async (realtyType = null) => {
  try {
    const payload = {
      addr_sido: selectedAddress.value.sido || "",
      addr_dong: selectedAddress.value.bname || "",
      addr_lotNumber: selectedAddress.value.jibunAddress.split(' ').pop() || "",
      buildingName: selectedAddress.value.buildingName || "",
      dong: dong.value || "",
      ho: ho.value || "",
      realtyType: realtyType === 'yes' ? 1 : undefined // 아파트/오피스텔 거주 중이면 1
    };

    const response = await axios.post('http://localhost:8080/api/safety-inspection/address', payload);
    console.log('서버 응답:', response.data);

    // 성공적으로 전송된 후 초기화
    resetForm();
  } catch (error) {
    errorMessage.value = '주소 검증 요청 실패. 다시 시도해 주세요.';
    console.error('주소 검증 요청 실패:', error);
  }
};

const resetForm = () => {
  dong.value = '';
  ho.value = '';
  showForm.value = false; 
  selectedAddress.value = null;
  errorMessage.value = ''; 
};
</script>

<style scoped>
.search-input {
  width: 90%;
  height: 60px;
  border-radius: 10px;
  border: 1px solid #ccc;
  padding: 0 15px;
  font-size: 16px;
}

.search-input:focus {
  border-color: rgb(0, 181, 0);
  outline: none;
}

.error-message {
  color: red;
  font-weight: bold;
  margin-top: 10px;
}

.input{
  
}
</style>
