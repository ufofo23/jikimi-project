<template>
  <div>
    <input
      type="button"
      @click="openDaumPostcode"
      value="단지, 지역, 지하철, 학교 검색"
      class="search-input"
    />

    <!-- Display the extracted address data -->
    <div v-if="addressDetails" class="search-output">
      <p>
        <strong>검색 결과:</strong>
        {{ addressDetails.roadAddress }}
      </p>
      <!-- 
      <p>
        <strong>건물명:</strong>
        {{ addressDetails.buildingName }}
      </p>

      <p>
        <strong>아파트 여부:</strong>
        {{
          addressDetails.apartment === 'Y' ? '예' : '아니오'
        }}
      </p> -->
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
          doroJuso: data.roadAddress,
        });
      }

      isPostcodeOpen.value = false; // 팝업 닫힘 상태 업데이트
    },
  }).open();
};
</script>

<style scoped>
.search-input {
  width: 100%; /* 검색 버튼의 너비 조정 */
  height: 60px; /* 기본 높이 */
  border-radius: 10px; /* 둥근 테두리 */
  border: 1px solid #ccc; /* 테두리 색상 */
  padding: 0 40px; /* 내부 여백 */
  font-size: 16px; /* 기본 글자 크기 */
  transition: all 0.3s ease; /* 애니메이션 적용 */
}

.search-input:focus {
  border-color: rgb(
    0,
    181,
    0
  ); /* 포커스 시 테두리 색상 변경 */
  outline: none; /* 기본 아웃라인 제거 */
}

.search-output {
  text-align: center;
  margin-top: 20px;
}

/* 반응형 디자인 적용 */
@media (max-width: 768px) {
  .search-input {
    width: 100%; /* 작은 화면에서는 100% 너비 */
    height: 50px; /* 높이를 줄임 */
    font-size: 14px; /* 글자 크기 축소 */
  }
}

@media (max-width: 480px) {
  .search-input {
    width: 100%; /* 모바일에서는 전체 너비 */
    height: 45px; /* 높이를 더 줄임 */
    font-size: 12px; /* 모바일 글자 크기 */
  }
}
</style>
