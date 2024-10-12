<template>
  <div class="container mt-4">
    <h1 class="text-center my-4 card-title">토막 상식 목록</h1>
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
    <!-- 게시글 목록 그리드 -->
    <div v-else class="sense-grid">
      <div
        v-for="article in articles"
        :key="article.commonSenseNo"
        class="sense-item"
        @click="detail(article.commonSenseNo)"
      >
        <div class="sense-content">
          <div class="sense-title">{{ article.pieceSense }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import api from '@/api/senseApi'; // API 모듈

const router = useRouter();
// 상태 관리
const articles = ref([]);
const isLoading = ref(true);
const errorMessage = ref('');

// 게시글 상세 보기
const detail = (no) => {
  router.push({
    name: 'senseDetailPage',
    params: { no: no },
  });
};

// 데이터 로드 함수
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await api.getList({ page: 1, amount: 1000 }); // 큰 수를 지정하여 모든 항목을 가져옵니다
    articles.value = response.list;
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

<style scoped>
.card-title {
  font-size: 32px;
  font-weight: bold;
  margin-bottom: 40px;
}

.container {
  max-width: 1500px;
  margin: 0 auto;
  padding: 0 20px;
}

.sense-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.sense-item {
  background-color: #f0f0f0;
  border-radius: 25px;
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  cursor: pointer;
  aspect-ratio: 1 / 1;
  padding: 10px; /* 패딩 추가 */
  position: relative; /* 숫자를 위치시키기 위해 필요 */
}

.sense-item:hover {
  transform: scale(1.05);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.sense-content {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  text-align: center;
}

.sense-number {
  font-size: 14px; /* 숫자 크기 감소 */
  font-weight: bold;
  position: absolute; /* 좌측 상단으로 이동시키기 위해 추가 */
  top: 10px;
  left: 10px;
}

.sense-title {
  font-size: 20px; /* 제목 크기 증가 */
  font-weight: bold;
  margin-top: 20px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
}

@media (max-width: 768px) {
  .sense-grid {
    grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
    gap: 15px;
  }

  .sense-number {
    font-size: 12px;
  }

  .sense-title {
    font-size: 16px;
  }
}

@media (min-width: 1024px) {
  .sense-grid {
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  }

  .sense-number {
    font-size: 16px;
  }

  .sense-title {
    font-size: 22px; /* 데스크탑에서는 더 크게 설정 */
  }
}
</style>
