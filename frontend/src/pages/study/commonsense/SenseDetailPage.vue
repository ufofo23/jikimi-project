<template>
  <div class="container d-flex flex-column min-vh-100">
    <div class="card-container">
      <div class="card">
        <h1 class="card-title">{{ article.commonSenseTitle }}</h1>
        <hr class="card-divider" />
        <p>{{ article.pieceSense }}</p>
        <div v-if="isLoading" class="text-center my-4">
          <div class="spinner-border" role="status">
            <span class="visually-hidden">로딩 중...</span>
          </div>
        </div>

        <div
          v-else-if="errorMessage"
          class="alert alert-danger my-4"
          role="alert"
        >
          {{ errorMessage }}
        </div>

        <div v-else class="card-content">{{ article.commonSenseContent }}</div>
      </div>
    </div>

    <div class="button-container">
      <button
        class="btn btn-primary"
        @click="back"
        aria-label="목록으로 돌아가기"
      >
        <i class="fa-solid fa-list"></i> 목록
      </button>
    </div>
  </div>
</template>

<script setup>
import { useRoute, useRouter } from 'vue-router';
import api from '@/api/senseApi';
import { ref, onMounted } from 'vue';

const cr = useRoute();
const router = useRouter();

const no = cr.params.no;
const article = ref({});
const isLoading = ref(true);
const errorMessage = ref('');

// 목록으로 돌아가는 함수
const back = () => {
  router.push({ name: 'senseListPage' }); // 올바른 라우트 이름을 사용하여 이동
};

const load = async () => {
  try {
    article.value = await api.get(no);
    console.log('DETAIL', article.value);
  } catch (error) {
    console.error('Failed to load article:', error);
    errorMessage.value =
      '게시물을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});
</script>

<style scoped>
.container {
  max-width: 800px; /* 최대 너비 설정 */
  margin: 0 auto; /* 중앙 정렬 */
  padding: 0 15px; /* 좌우 패딩 추가 */
  display: flex;
  flex-direction: column;
  min-height: 100vh; /* 화면 전체 높이 차지 */
  justify-content: center; /* 수직 중앙 정렬 */
}

.card-container {
  display: flex;
  justify-content: center; /* 카드 수평 중앙 정렬 */
  margin: 2rem 0; /* 카드 간격 조정 */
}

.card {
  background-color: white; /* bg-white */
  width: 20rem; /* 카드 너비 증가 */
  height: auto; /* 높이를 자동으로 조정 */
  position: relative; /* absolute에서 relative로 변경 */
  border-radius: 0.5rem; /* rounded-lg */
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* shadow-lg */
  transition: all 0.15s ease-out; /* transition-all duration-150 ease-out */
  padding: 1rem; /* 카드 내부 패딩 추가 */
}

.card:hover {
  margin: -0.5rem; /* hover:-m-2 */
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* hover:shadow-2xl */
}

.card-title {
  margin: 0; /* 카드 제목의 여백 조정 */
  font-size: 1.25rem; /* 제목 크기 증가 */
  font-weight: bold; /* font-bold */
}

.card-divider {
  margin: 1rem 0; /* 카드 구분선의 여백 조정 */
  border-radius: 1rem; /* rounded-2xl */
  border-top-width: 2px; /* border-t-2 */
}

.card-content {
  margin: 1rem 0; /* 카드 내용의 여백 조정 */
  font-size: 1rem; /* 내용 크기 조정 */
}

.button-container {
  display: flex;
  justify-content: flex-end; /* 버튼을 우측으로 정렬 */
  padding: 20px 0; /* 상하 패딩 추가 */
}
</style>
