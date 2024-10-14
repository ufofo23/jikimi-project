 
<template>
  <footer class="footer" :class="{ visible: isFooterVisible }">
    <div class="footer-content">
      <div class="footer-section">
        <h3 class="footer-title">사업자 정보</h3>
        <p class="footer-address">제주특별자치도 제주시 애월읍 애월리 2481-3</p>
        <p class="footer-phone">대표번호: 010-1357-2468</p>
      </div>
      <div class="footer-section">
        <h3 class="footer-title">법적 고지</h3>
        <ul class="footer-list">
          <li>본 웹사이트의 실거래가 정보는 투자 참고용입니다.</li>
          <li>제공된 정보에 의한 투자 결과에 대해 책임지지 않습니다.</li>
          <li>기타 비용이 추가로 발생할 수 있습니다.</li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2024 Sagi Check. All Rights Reserved</p>
    </div>
  </footer>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const isFooterVisible = ref(false);

const handleScroll = () => {
  const scrollPosition = window.scrollY + window.innerHeight;
  const documentHeight = document.documentElement.scrollHeight;

  if (scrollPosition >= documentHeight - 100) {
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
  background-color: #f8f9fa;
  color: #333;
  padding: 40px 20px;
  font-family: 'Arial', sans-serif;
  opacity: 0;
  transition: opacity 0.3s ease, transform 0.3s ease;
  transform: translateY(20px);
  pointer-events: none;
}

.footer.visible {
  opacity: 1;
  transform: translateY(0);
  pointer-events: auto;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  max-width: 1200px;
  margin: 0 auto;
}

.footer-section {
  flex: 1;
  margin-right: 40px;
}

.footer-title {
  font-size: 1.2rem;
  color: #0066cc;
  margin-bottom: 15px;
}

.footer-address,
.footer-phone {
  font-size: 0.9rem;
  margin-bottom: 5px;
}

.footer-list {
  list-style-type: none;
  padding: 0;
}

.footer-list li {
  font-size: 0.9rem;
  margin-bottom: 10px;
  position: relative;
  padding-left: 15px;
}

.footer-list li::before {
  content: '•';
  position: absolute;
  left: 0;
  color: #0066cc;
}

.footer-bottom {
  text-align: center;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #e0e0e0;
  font-size: 0.8rem;
}

@media (max-width: 768px) {
  .footer-content {
    flex-direction: column;
  }

  .footer-section {
    margin-right: 0;
    margin-bottom: 30px;
  }
}
</style>
