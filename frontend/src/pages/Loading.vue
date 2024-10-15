<template>
  <div class="loading-container">
    <div class="loading-content">
      <div class="loading-icon">
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
      </div>
      <h2 class="loading-text">시나리오 분석중입니다...</h2>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const dots = ref('...');

const updateDots = () => {
  dots.value = dots.value.length >= 3 ? '' : dots.value + '.';
};

let interval;

onMounted(() => {
  interval = setInterval(updateDots, 500);
});

onUnmounted(() => {
  clearInterval(interval);
});
</script>

<style scoped>
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #F0F7FF;
  font-family: 'Arial', sans-serif;
}

.loading-content {
  text-align: center;
}

.loading-icon {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.circle {
  width: 20px;
  height: 20px;
  background-color: #007BFF;
  border-radius: 50%;
  margin: 0 10px;
  animation: bounce 1.4s infinite ease-in-out both;
}

.circle:nth-child(1) {
  animation-delay: -0.32s;
}

.circle:nth-child(2) {
  animation-delay: -0.16s;
}

.loading-text {
  font-size: 24px;
  color: #333;
  margin: 0;
  animation: fadeInOut 1.5s infinite;
}

@keyframes bounce {
  0%, 80%, 100% { 
    transform: scale(0);
  } 
  40% { 
    transform: scale(1.0);
  }
}

@keyframes fadeInOut {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}
</style>