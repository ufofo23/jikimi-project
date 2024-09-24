<template>
  <div class="loading-page">
    <!-- 거북이 이미지 -->
    <img src="@/assets/turtle.png" alt="Turtle" class="turtle" />
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';
import { onMounted } from 'vue';

// Vue Router 사용
const router = useRouter();

// 컴포넌트가 마운트되었을 때 실행
onMounted(() => {
  // 3초 뒤에 다음 페이지로 이동
  setTimeout(() => {
    router.push('/Login'); // 'nextPage'를 실제 경로로 변경
  }, 3000); // 3초 동안 로딩
});
</script>

<style scoped>
.loading-page {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f5f5f5;
  overflow: hidden; /* 애니메이션이 화면 밖으로 나가지 않도록 */
}

.turtle {
  position: absolute;
  width: 150px; /* 적절한 크기로 설정 */
  animation: moveTurtle 3s ease-in-out; /* 3초 동안 애니메이션 */
}

@keyframes moveTurtle {
  0% {
    left: -150px; /* 화면 밖에서 시작 */
  }
  100% {
    left: calc(100% + 150px); /* 화면 오른쪽 밖으로 이동 */
  }
}
</style>
