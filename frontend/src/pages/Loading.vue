<template>
  <div class="loading-page">
    <!-- 거북이 이미지 -->
    <h2>로딩 중입니다... ⏳</h2>
    <img src="@/assets/turtle.png" alt="Turtle" class="turtle" />
  </div>
</template>

<script setup>
// 로딩 화면에서는 특별한 로직이 필요 없으므로, setup 스크립트는 비워두었습니다.
</script>

<style scoped>
.loading-page {
  display: flex;
  flex-direction: column; /* 세로 방향으로 정렬 */
  justify-content: center;
  align-items: center;
  height: 80vh;
  overflow: hidden; /* 애니메이션이 화면 밖으로 나가지 않도록 */
}

.turtle {
  width: 200px; /* 적절한 크기로 설정 */
  animation: moveTurtle 3s ease-in-out infinite; /* 무한 애니메이션 */
}

@keyframes moveTurtle {
  0% {
    transform: translateX(-150px); /* 화면 밖에서 시작 */
  }
  100% {
    transform: translateX(calc(100% + 150px)); /* 화면 오른쪽 밖으로 이동 */
  }
}
</style>
