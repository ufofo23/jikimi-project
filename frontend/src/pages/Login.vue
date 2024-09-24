<template>
  <div class="page-container">
    <h1>소셜 로그인</h1>
    <div class="social-login-container">
      <Kakao></Kakao>
      <Google></Google>
      <Naver></Naver>
    </div>
  </div>
</template>

<script setup>
import Google from '@/components/Google.vue';
import Kakao from '@/components/Kakao.vue';
import Naver from '@/components/Naver.vue';
</script>

<style scoped>
.page-container {
  display: flex;
  flex-direction: column; /* 수직 정렬 */
  align-items: center; /* 수평 중앙 정렬 */

  height: 100vh; /* 뷰포트 전체 높이 */
  text-align: center;
}

.social-login-container {
  display: flex;
  justify-content: center; /* 가운데 정렬 */
  gap: 10px; /* 요소 간의 간격 */
  margin-top: 50px;
}

@media (max-width: 600px) {
  .social-login-container {
    flex-direction: column; /* 화면이 좁을 때 세로로 정렬 */
    gap: 20px; /* 세로 간격 증가 */
  }

  .page-container {
    padding: 20px; /* 모바일에서 여백 추가 */
  }
}
</style>
