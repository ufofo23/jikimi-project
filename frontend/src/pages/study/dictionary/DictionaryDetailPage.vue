<script setup>
import { useRoute, useRouter } from 'vue-router';
import api from '@/api/dictionaryApi';
import { ref, onMounted } from 'vue';

const cr = useRoute();
const router = useRouter();

const no = cr.params.no;
const article = ref({});
const isLoading = ref(true);
const errorMessage = ref('');

const back = () => {
  router.push({ name: 'dictionaryList', query: cr.query });
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
  <div class="dictionary-detail">
    <div class="content-wrapper">
      <h1 class="title">{{ article.dictionaryTitle }}</h1>

      <div v-if="isLoading" class="loader">
        <div class="spinner"></div>
        <span>로딩 중...</span>
      </div>

      <div
        v-else-if="errorMessage"
        class="error-message"
        role="alert"
      >
        {{ errorMessage }}
      </div>

      <div v-else class="content">
        <p>{{ article.dictionaryContent }}</p>
      </div>
    </div>

    <div class="button-container">
      <button
        class="btn-back"
        @click="back"
        aria-label="목록으로 돌아가기"
      >
        <i class="fas fa-arrow-left"></i> 목록으로 돌아가기
      </button>
    </div>
  </div>
</template>

<style scoped>
.dictionary-detail {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  background-color: #ffffff;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

.content-wrapper {
  margin-bottom: 2rem;
}

.title {
  color: #3498db; /* 하늘색 브랜드 컬러 */
  font-size: 2.5rem;
  text-align: center;
  margin-bottom: 1.5rem;
  border-bottom: 2px solid #3498db;
  padding-bottom: 0.5rem;
}

.loader {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 2rem 0;
}

.spinner {
  border: 4px solid #f3f3f3;
  border-top: 4px solid #3498db;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.error-message {
  background-color: #ffecec;
  color: #ff6b6b;
  padding: 1rem;
  border-radius: 4px;
  text-align: center;
  margin: 1rem 0;
}

.content {
  background-color: #f8f9fa;
  padding: 2rem;
  border-radius: 8px;
  line-height: 1.6;
  color: #333;
}

.button-container {
  display: flex;
  justify-content: center;
  margin-top: 2rem;
}

.btn-back {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn-back:hover {
  background-color: #2980b9;
}

.btn-back i {
  margin-right: 0.5rem;
}

@media (max-width: 768px) {
  .dictionary-detail {
    padding: 1rem;
  }

  .title {
    font-size: 2rem;
  }

  .content {
    padding: 1rem;
  }
}
</style>