<template>
  <div class="main-content">
    <div class="content-area">
      <!-- 첫 번째 카드 (연한 초록색) -->
      <div class="real-estate-info">
        <router-link :to="{ name: 'study' }">
          부동산 토막 상식 (슬라이드)
        </router-link>
        <!-- 카드 내부 설명이 있을 경우 표시 -->
        <p v-if="studyData">{{ studyData.summary }}</p>
      </div>

      <!-- 두 번째 카드 (가운데, 파란색) -->
      <div class="price-check">
        <router-link :to="{ name: 'map' }">
          주변 시세 확인 (대략적 주소)
        </router-link>
      </div>

      <!-- 세 번째 카드 (보라색) -->
      <div class="safety-check">
        <router-link :to="{ name: 'fraudchecklist' }">
          이 집은 안전한가? 바로 안전진단 받기!
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import studyApi from '@/api/studyApi'; // study API를 가져옴

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
.main-content {
  padding-top: 60px; /* 헤더 높이 고려 */
  padding-bottom: 60px; /* 푸터 높이 고려 */
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh; /* 화면 전체 높이를 차지하도록 설정 */
  background-color: #f5f5f5; /* 전체 배경 색상 */
}

.content-area {
  display: flex; /* 가로 배열을 위한 Flexbox */
  justify-content: space-between; /* 각 카드 사이에 공간 분배 */
  align-items: center;
  max-width: 1200px; /* 최대 너비 설정 */
  gap: 20px; /* 카드 간의 간격 설정 */
}

.real-estate-info,
.price-check,
.safety-check {
  flex: 1; /* 각 항목이 동일한 크기로 나열되도록 설정 */
  margin: 10px;
  padding: 40px;
  border-radius: 10px;
  height: 300px; /* 고정된 높이 설정 */
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  box-sizing: border-box; /* 패딩에 상관없이 크기 일치 */
  transition: transform 0.3s, background-color 0.3s, color 0.3s; /* hover 효과를 위한 트랜지션 */
}

/* 각 항목의 기본 색상 구성 */
.real-estate-info {
  background-color: #ffffd1; /* 첫 번째 카드: 연한 초록색 */
  color: #fff; /* 흰색 텍스트 */
}

.price-check {
  background-color: #d6fff5; /* 두 번째 카드: 파란색 */
  color: #fff;
}

.safety-check {
  background-color: #ffffd7; /* 세 번째 카드: 보라색 */
  color: #fff;
}

/* hover 상태에서 파스텔 톤의 그라데이션 적용 */
.real-estate-info:hover {
  background: linear-gradient(
    135deg,
    #cbecc5,
    #a4eb77
  ); /* 연한 초록색에서 파스텔 초록색으로 그라데이션 */
}

.price-check:hover {
  background: linear-gradient(
    135deg,
    #f7cac9,
    #92a8d1
  ); /* 파스텔 핑크에서 파스텔 블루로 그라데이션 */
}

.safety-check:hover {
  background: linear-gradient(
    135deg,
    #cbecc5,
    #a4eb77
  ); /* 파스텔 오렌지에서 밝은 베이지로 그라데이션 */
}

/* hover 상태에서 효과 */
.real-estate-info:hover,
.price-check:hover,
.safety-check:hover {
  transform: scale(1.05); /* 살짝 커지는 효과 */
  color: #fff; /* 텍스트 색상 유지 */
}
</style>
