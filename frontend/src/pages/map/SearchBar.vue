<template>
  <div>
    <input
      type="button"
      @click="openDaumPostcode"
      value="단지, 지역, 지하철, 학교 검색"
      class="search-input"
    />

    <!-- Display the extracted address data -->
    <div v-if="addressDetails">
      <p>
        <strong>도로명 주소:</strong>
        {{ addressDetails.roadAddress }}
      </p>

      <p>
        <strong>건물명:</strong>
        {{ addressDetails.buildingName }}
      </p>

      <p>
        <strong>아파트 여부:</strong>
        {{
          addressDetails.apartment === 'Y' ? '예' : '아니오'
        }}
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

const KAKAO_API_KEY = 'c6ce7f1106ed7b6e4d7d2d8a0f956afa';

const addressDetails = ref(null);
const x = ref(null);
const y = ref(null);
const emit = defineEmits(['address-selected']);
let isPostcodeOpen = ref(false); // 팝업 상태 관리

async function getCoordinates(address) {
  try {
    const url = `https://dapi.kakao.com/v2/local/search/address.json`;

    const response = await axios.get(url, {
      headers: {
        Authorization: `KakaoAK ${
          import.meta.env.VITE_DAUM_API_KEY
        }`,
      },
      params: {
        query: address,
      },
    });

    if (response.data.documents.length > 0) {
      const { x, y } = response.data.documents[0];
      return { x, y };
    } else {
      console.log('주소를 찾을 수 없습니다.');
      return null;
    }
  } catch (error) {
    console.error(
      `Failed to fetch coordinates for address: ${address}`,
      error
    );
    return null;
  }
}

const openDaumPostcode = () => {
  // if (isPostcodeOpen.value == true) return; // 팝업이 열려 있으면 무시

  isPostcodeOpen.value = true; // 팝업 상태 업데이트
  new daum.Postcode({
    oncomplete: async function (data) {
      addressDetails.value = {
        zonecode: data.zonecode,
        jibunAddress: data.jibunAddress,
        roadAddress: data.roadAddress,
        sigunguCode: data.sigunguCode,
        bcode: data.bcode,
        bname: data.bname,
        buildingName: data.buildingName,
        buildingCode: data.buildingCode,
        apartment: data.apartment,
      };

      const coordinates = await getCoordinates(
        data.roadAddress
      );
      if (coordinates) {
        x.value = coordinates.x;
        y.value = coordinates.y;
        console.log('좌표:', coordinates);

        emit('address-selected', {
          x: x.value,
          y: y.value,
          buildingName: data.buildingName,
        });
      }

      isPostcodeOpen.value = false; // 팝업 닫힘 상태 업데이트
    },
  }).open();
};
</script>

<style scoped>
.search-input {
  width: 90%; /* 너비 설정 */
  height: 60px; /* 높이 조정 */
  border-radius: 10px; /* 둥글게 */
  border: 1px solid #ccc; /* 테두리 설정 */
  padding: 0 15px; /* 여백 추가 */
  font-size: 16px; /* 글자 크기 */
}

.search-input:focus {
  border-color: rgb(0, 181, 0); /* 포커스 시 색상 변경 */
  outline: none; /* 기본 아웃라인 제거 */
}
</style>
