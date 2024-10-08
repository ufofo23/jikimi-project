<template>
  <div class="carousel-wrapper">
    <!-- 캐러셀 컴포넌트 등록 -->
    <el-carousel
      ref="carouselCardRef"
      :interval="7000"
      :autoplay="false"
      height="600px"
      type="card"
      arrow="always"
      :animation="false"
    >
      <!-- 각 카드 컴포넌트를 캐러셀 아이템으로 등록하고 데이터를 전달 -->
      <el-carousel-item name="CardCommonSense">
        <CardCommonSense
          :currentPieceSense="currentPieceSense"
          :currentCommonSenseNo="currentCommonSenseNo"
        />
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import 'element-plus/es/components/carousel/style/css'; // Element Plus 캐러셀 CSS import
import { ElCarousel, ElCarouselItem } from 'element-plus';

// 카드 컴포넌트 import
import CardCommonSense from '@/components/Cards/CardCommonSense.vue';

// 캐러셀 제어를 위한 참조 변수
const carouselCardRef = ref(null);

// 캐러셀 제어 메서드
const next = () => {
  carouselCardRef.value?.next();
};

const prev = () => {
  carouselCardRef.value?.prev();
};

const setToFirst = () => {
  carouselCardRef.value?.setActiveItem(0);
};

// 첫 번째 카드에서 필요한 데이터 상태 관리
const currentPieceSense = ref('Some sense data');
const currentCommonSenseNo = ref('1');
</script>

<style scoped>
.carousel-page {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh; /* Viewport Height을 100%로 설정 */
  margin: 0;
  padding: 0;
}
/* 캐러셀 컨테이너 스타일 */
.carousel-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  position: relative;
  text-align: center; /* 중앙 정렬 */
}

/* 캐러셀 항목의 스타일 */
.el-carousel__item {
  display: flex; /* flexbox를 사용하여 중앙 정렬 */
  justify-content: center; /* 수평 중앙 정렬 */
  align-items: center; /* 수직 중앙 정렬 */
  transform: scale(0.7); /* 좌우 카드의 크기를 축소 */
  opacity: 0.5; /* 좌우 카드의 투명도 조정 */
  transition: transform 0.3s ease, opacity 0.3s ease; /* 부드러운 트랜지션 */
}

.el-carousel__item.is-active {
  transform: scale(1); /* 중앙 카드 확대 */
  opacity: 1; /* 중앙 카드의 투명도 100% */
}

/* 캐러셀 제어 버튼 */
.controls {
  margin-top: 20px;
  text-align: center;
}

button {
  margin: 0 5px;
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
