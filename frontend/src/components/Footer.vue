<template>
  <footer class="footer" :class="{ visible: isFooterVisible }">
    <p>© 2024 부동산 거래 서비스</p>
    <ul class="footer-list">
      <li>
        제주특별자치도 제주시 애월읍 애월리 2481-3 대표번호: 010-1357-2468
      </li>
      <li>2024 Sagi Check. All Right Reserved</li>
      <li>
        본 웹사이트에서 제공하는 실거래가 정보는 투자 참고용이며 오류가 발생할
        수 있습니다.
      </li>
      <li>제공된 정보에 의한 투자 결과에 대해 법적인 책임을 지지 않습니다.</li>
      <li>기타 비용이 추가로 발생할 수 있습니다.</li>
    </ul>
  </footer>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const isFooterVisible = ref(false);

const handleScroll = () => {
  const scrollPosition = window.scrollY + window.innerHeight;
  const documentHeight = document.documentElement.scrollHeight;

  if (scrollPosition >= documentHeight) {
    isFooterVisible.value = true;
  } else {
    isFooterVisible.value = false;
  }
};

onMounted(() => {
  window.addEventListener('scroll', handleScroll);
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});
</script>

<style scoped>
.footer {
  position: relative;
  bottom: 0;
  width: 100%;
  background-color: white; /* 브랜드 색상 */
  padding: 10px 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: left;
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none; /* 클릭 불가능 */
}

.footer.visible {
  opacity: 1;
  pointer-events: auto; /* 클릭 가능 */
}

.footer-list {
  list-style-type: circle; /* 동그라미로 리스트 표시 */
  padding-left: 20px; /* 리스트 들여쓰기 */
  margin-top: 10px; /* 본문과 리스트 사이 간격 */
}

.footer-list li {
  margin-bottom: 5px; /* 각 항목 사이 간격 */
}
</style>
