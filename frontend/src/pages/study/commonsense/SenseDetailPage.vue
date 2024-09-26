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

<template>
  <div class="container d-flex flex-column min-vh-100">
    <div class="flex-grow-1">
      <h1 class="mt-4 text-center">{{ article.commonSenseTitle }}</h1>
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

      <div v-else class="content my-4">{{ article.commonSenseContent }}</div>
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

<style scoped>
.container {
  max-width: 800px; /* 최대 너비 설정 */
  margin: 0 auto; /* 중앙 정렬 */
  padding: 0 15px; /* 좌우 패딩 추가 */
  display: flex;
  flex-direction: column;
  min-height: 100vh; /* 화면 전체 높이 차지 */
}

.content {
  white-space: pre-line;
  margin: 0 auto; /* 좌우 여백을 자동으로 설정하여 가운데 정렬 */
  max-width: 800px; /* 내용의 최대 너비를 제한하여 읽기 편하게 */
  text-align: justify; /* 내용이 균등하게 정렬되도록 설정 */
}

.button-container {
  display: flex;
  justify-content: flex-end; /* 버튼을 우측으로 정렬 */
  padding: 20px 0; /* 상하 패딩 추가 */
}

.attach {
  font-size: 0.8rem;
  cursor: pointer;
}
</style>
