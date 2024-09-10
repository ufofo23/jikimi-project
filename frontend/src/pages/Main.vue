<template>
  <div class="main-content">
    <div class="content-area">
      <div class="real-estate-info">
        <router-link :to="{ name: 'info' }"
          >부동산 토막 상식 (슬라이드)</router-link
        >
      </div>
      <div class="price-check">
        <router-link :to="{ name: 'map' }"
          >주변 시세 확인 (대략적 주소)</router-link
        >
      </div>
      <div class="safety-check">
        <router-link :to="{ name: 'check' }"
          >이 집은 안전한가? 바로 안전진단 받기!</router-link
        >
      </div>
    </div>
  </div>
</template>

<script setup>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
</script>

<style scoped>
.main-content {
  padding-top: 60px; /* 헤더 높이 고려 */
  padding-bottom: 60px; /* 푸터 높이 고려 */
  text-align: center;
}

.content-area {
  margin: 20px 0;
}

.real-estate-info,
.price-check,
.safety-check {
  margin: 10px 0;
  padding: 20px;
  border-radius: 5px;
}

.real-estate-info {
  background-color: #fff59d; /* 슬라이드 배경 */
}

.price-check {
  background-color: #81d4fa; /* 시세 확인 배경 */
}

.safety-check {
  background-color: #d1c4e9; /* 안전진단 배경 */
}
</style>
