<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">
      <i class="fa-solid fa-paste"></i> 게시글 목록
    </h1>

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

    <!-- 게시글 목록 테이블 -->
    <div v-else>
      <table class="table table-hover">
        <thead>
          <tr>
            <th style="width: 80px">번호</th>
            <th>제목</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="article in articles" :key="article.commonSenseNo">
            <td @click="detail(article.commonSenseNo)">
              {{ article.commonSenseNo }}
            </td>

            <td @click="detail(article.commonSenseNo)">
              {{ article.commonSenseTitle }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import api from '@/api/faqApi'; // API 모듈

const article = ref({});
const cr = useRoute();
const router = useRouter();
const detail = (no) => {
  router.push({
    name: 'faqDetailPage',
    params: { no: no },
    query: cr.query,
  });
};

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

<style scoped>
.container {
  max-width: 800px; /* 최대 너비 설정 */
  margin: 0 auto; /* 중앙 정렬 */
  padding: 0 15px; /* 좌우 패딩 추가 */
}

.table-hover tbody tr:hover {
  background-color: #f5f5f5;
}

.text-decoration-none {
  color: inherit;
}

.spinner-border {
  width: 3rem;
  height: 3rem;
}

@media (max-width: 600px) {
  .container {
    padding: 0 10px;
  }
  .table th,
  .table td {
    font-size: 0.9rem;
  }
}
</style>
