<template>
  <div class="map-container">
    <!-- 왼쪽 사이드바 -->
    <div class="map-sidebar">
      <h2>지도 설정</h2>
      <div class="search-container">
        <input type="text" placeholder="장소 검색..." v-model="searchQuery" />
        <button @click="searchLocation">검색</button>
      </div>
      <div class="info">실거래가가 궁금한 지역을 검색해보세요.</div>
    </div>

    <!-- 지도 영역 -->
    <div class="map-area">
      <CompoMap />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import CompoMap from '@/components/Map/CompoMap.vue';

const searchQuery = ref(''); // 검색어 상태

const searchLocation = () => {
  console.log(`Searching for: ${searchQuery.value}`);
  // 검색 로직 추가
};
</script>

<style scoped>
/* 전체 레이아웃 */
.map-container {
  flex-direction: row; /* 기본 가로 배치 */

  display: flex;
  height: 100vh; /* 화면 전체 높이 차지 */
  width: 100%;
}

/* 사이드바 스타일 */
.map-sidebar {
  width: 300px; /* 고정된 너비 */
  background-color: #f7f7f7; /* 연한 배경색 */
  padding: 20px;
  box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
}

.map-sidebar h2 {
  margin-bottom: 20px;
  font-size: 1.5rem;
}

/* 검색 박스 */
.search-container {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.search-container input {
  padding: 10px;
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.search-container button {
  padding: 10px 20px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.search-container button:hover {
  background-color: #45a049;
}

.info {
  margin-top: 20px;
  font-size: 0.9rem;
  color: #666;
}

/* 지도 영역 스타일 */
.map-area {
  flex-grow: 1; /* 남은 공간을 모두 차지 */
  height: 100%; /* 부모 높이를 모두 차지 */
  background-color: #e9e9e9; /* 지도 배경을 약간의 회색으로 설정 (지도 로드 시 덮어쓰기됨) */
}

/* 반응형 적용 - 작은 화면에서 지도가 위로, 패널이 아래로 */
@media (max-width: 768px) {
  .map-container {
    flex-direction: column; /* 세로 배치로 변경 */
  }

  .map-sidebar {
    width: 100%; /* 사이드바가 화면 전체 너비를 차지 */
    order: 2; /* 아래로 배치 */
  }

  .map-area {
    order: 1; /* 위로 배치 */
    height: 50vh; /* 화면의 절반 높이 */
  }
}
</style>
