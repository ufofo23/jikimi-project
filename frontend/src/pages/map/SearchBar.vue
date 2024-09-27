<template>
  <div>
    <button @click="openDaumPostcode">주소 검색</button>

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

// ref로 상태 변수 선언
const addressDetails = ref(null);
const x = ref(null);
const y = ref(null);
// defineEmits를 사용하여 emit 정의
const emit = defineEmits(['address-selected']);

async function getCoordinates(address) {
  try {
    const url = `https://dapi.kakao.com/v2/local/search/address.json`;

    const response = await axios.get(url, {
      headers: {
        Authorization: `KakaoAK ${KAKAO_API_KEY}`,
      },
      params: {
        query: address,
      },
    });

    // 응답이 정상적으로 왔을 경우
    if (response.data.documents.length > 0) {
      const { x, y } = response.data.documents[0]; // 첫 번째 결과의 좌표를 가져옵니다.
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
  new daum.Postcode({
    oncomplete: async function (data) {
      // addressDetails를 업데이트
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

      // 좌표 가져오기
      const coordinates = await getCoordinates(
        data.roadAddress
      );
      if (coordinates) {
        x.value = coordinates.x;
        y.value = coordinates.y;
        console.log('좌표:', coordinates); // x, y 좌표 출력

        // 좌표를 부모 컴포넌트로 전달하는 로직 수정
        emit('address-selected', {
          x: x.value,
          y: y.value,
        });
      }
    },
  }).open();
};
</script>

<style scoped></style>
