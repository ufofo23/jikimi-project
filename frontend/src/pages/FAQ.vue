<template>
  <section class="faq-section">
    <div class="container">
      <div class="column">
        <div class="heading">
          <h2 class="title">FAQ</h2>
          <p class="description">
            자주 묻는 질문을 통해 궁금증을 빠르게 해결해보세요!
          </p>
        </div>
      </div>

      <!-- 로딩 상태 -->
      <div v-if="isLoading" class="text-center my-4">
        <div class="spinner-border" role="status">
          <span class="visually-hidden">로딩 중...</span>
        </div>
      </div>

      <!-- 에러 메시지 -->
      <div v-else-if="errorMessage" class="alert alert-danger" role="alert">
        {{ errorMessage }}
      </div>

      <!-- 게시글 목록 -->
      <div v-else class="faq-grid">
        <div v-for="article in articles" :key="article.faqNo" class="faq-card">
          <button class="faq-btn" @click="toggleDetails(article.faqNo)">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openSections.includes(article.faqNo) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">{{ article.faqQuestion }}</h4>
            </div>
          </button>

          <div v-if="openSections.includes(article.faqNo)" class="faq-answer">
            <p class="faq-text">{{ article.faqAnswer }}</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script setup>
import { ref, computed, onMounted } from 'vue';
import api from '@/api/faqApi'; // API 모듈

// 상태 관리
const page = ref({
  list: [],
  totalCount: 0,
});
const isLoading = ref(true);
const errorMessage = ref('');

// 페이지 요청 정보 (현재는 단순 페이지 1, 항목 수 10으로 설정)
const pageRequest = ref({
  page: 1,
  amount: 10,
});

// 게시글 목록 계산 속성
const articles = computed(() => page.value.list);

// 상세 보기 토글을 위한 변수 (여러 섹션을 열 수 있도록 배열로 설정)
const openSections = ref([]);

// 토글 함수
const toggleDetails = (no) => {
  const index = openSections.value.indexOf(no);
  if (index === -1) {
    openSections.value.push(no);
  } else {
    openSections.value.splice(index, 1);
  }
};

// 데이터 로드 함수
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await api.getList(pageRequest.value);
    page.value = response;
    console.log('게시글 목록:', page.value);
  } catch (error) {
    console.error('게시글 로드 실패:', error);
    errorMessage.value =
      '게시글을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});
</script>
<style>
/* 전체 섹션 스타일 */
.faq-section {
  position: relative;
  padding-top: 120px;
  padding-bottom: 90px;
  background-color: white;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  text-align: center;
}

/* 헤더 섹션 */
.heading {
  text-align: center;
  margin-bottom: 60px;
}

.subheading {
  display: block;
  font-size: 18px;
  font-weight: 600;
  color: #007bff;
  margin-bottom: 20px;
}

.title {
  font-size: 36px;
  font-weight: 700;
  color: #007bff;
  margin-bottom: 20px;
}

.description {
  font-size: 16px;
  color: #666;
}

/* FAQ 카드 */
.faq-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr); /* 2열로 설정 */
  gap: 40px; /* 카드 간 간격을 넓혀줌 */
}

.faq-card {
  padding: 30px; /* 카드 크기 증가 */
  background-color: white;
  border-radius: 10px;
  box-shadow: 0px 20px 95px rgba(201, 203, 204, 0.3);
  text-align: left;
}

.faq-btn {
  display: flex;
  align-items: center;
  width: 100%;
  text-align: left;
  cursor: pointer;
  background: none;
  border: none;
  outline: none;
  padding: 0;
}

.faq-icon {
  margin-right: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background-color: #e7f3ff;
  border-radius: 50%;
}

.icon {
  transition: transform 0.3s ease;
}

.rotate-180 {
  transform: rotate(180deg);
}

.faq-content {
  flex-grow: 1;
}

.faq-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.faq-answer {
  padding-top: 15px;
  font-size: 16px;
  color: #666;
  line-height: 1.6;
}

/* 반응형 디자인 */
@media (max-width: 1024px) {
  .faq-grid {
    grid-template-columns: 1fr; /* 태블릿 이하에서 1열로 변경 */
  }
}
</style>
