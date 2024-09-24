<template>
  <div class="container-fluid custom-container">
    <div class="custom-grid">
      <!-- 왼쪽 큰 카드 -->
      <router-link
        :to="{ name: 'study' }"
        class="card large-card real-estate-info text-center"
      >
        <div class="card-body">
          <h3 class="card-title">부동산 토막 상식</h3>
          <p>(슬라이드)</p>
        </div>
      </router-link>

      <!-- 중간 카드 -->
      <router-link
        :to="{ name: 'map' }"
        class="card small-card price-check text-center"
      >
        <div class="card-body">
          <h3 class="card-title">주변 시세 확인</h3>
          <p>(대략적 주소)</p>
        </div>
      </router-link>

      <!-- 오른쪽 카드 -->
      <router-link
        :to="{ name: 'fraudchecklist' }"
        class="card small-card safety-check text-center"
      >
        <div class="card-body">
          <h3 class="card-title">이 집은 안전한가?</h3>
          <p>바로 안전진단 받기!</p>
        </div>
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import senseApi from '@/api/senseApi'; // study API를 가져옴

// study 데이터를 저장할 참조 변수 생성
const studyData = ref(null);

// 컴포넌트가 마운트되면 study 데이터를 불러옴
onMounted(async () => {
  try {
    const data = await studyApi.getStudyData();
    studyData.value = data; // 데이터를 참조 변수에 저장
  } catch (error) {
    console.error('데이터 로드 실패', error);
  }
});
</script>

<style scoped>
.custom-container {
  min-height: 100vh; /* 화면 전체 높이를 차지 */
  display: flex;
  align-items: stretch; /* 카드들이 화면을 꽉 채우도록 설정 */
  padding-top: 60px; /* 헤더와의 간격 */
  padding-bottom: 60px; /* 푸터와의 간격 */
}

.custom-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr; /* 왼쪽 카드가 더 넓도록 설정 */
  gap: 20px; /* 카드 간의 간격 */
  flex-grow: 1; /* 그리드가 전체 화면을 차지하도록 */
}

.card {
  padding: 30px;
  border-radius: 10px;
  height: 100%; /* 카드가 부모 요소의 전체 높이를 차지 */
  transition: transform 0.3s, background-color 0.3s, color 0.3s;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  box-sizing: border-box;
}

/* 각 카드의 기본 색상 설정 */
.real-estate-info {
  background-color: #ffffd1;
  color: #000;
}

.price-check {
  background-color: #d6fff5;
  color: #000;
}

.safety-check {
  background-color: #ffffd7;
  color: #000;
}

/* hover 상태에서 그라데이션 효과 */
.real-estate-info:hover {
  background: linear-gradient(135deg, #cbecc5, #a4eb77);
}

.price-check:hover {
  background: linear-gradient(135deg, #f7cac9, #92a8d1);
}

.safety-check:hover {
  background: linear-gradient(135deg, #cbecc5, #a4eb77);
}

.card:hover {
  transform: scale(1.05);
}

/* 카드 안의 텍스트 크기 조정 */
.card-title {
  font-size: 1.8rem; /* 제목 크기 키움 */
  margin-bottom: 10px;
}

.card-body p {
  font-size: 1.2rem; /* 본문 텍스트 크기 키움 */
}
</style>
