<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">
      <i class="fa-solid fa-paste"></i> 계약 전 체크 사항
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
          <tr v-for="article in articles" :key="article.preventionNo">
            <td @click="detail(article.preventionNo)">
              {{ article.preventionNo }}
            </td>
            <td @click="detail(article.preventionNo)">
              {{ article.preventionTitle }}
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 페이지 네이션 -->
      <div class="d-flex justify-center mt-4">
        <nav
          class="isolate inline-flex -space-x-px rounded-md shadow-sm"
          aria-label="Pagination"
        >
          <!-- Previous 버튼 -->
          <a
            href="#"
            class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
            @click.prevent="handlePageChange(pageRequest.page - 1)"
            :class="{ 'opacity-50 cursor-not-allowed': pageRequest.page === 1 }"
            :disabled="pageRequest.page === 1"
          >
            <span class="sr-only">Previous</span>
            <svg
              class="h-5 w-5"
              viewBox="0 0 20 20"
              fill="currentColor"
              aria-hidden="true"
            >
              <path
                fill-rule="evenodd"
                d="M11.78 5.22a.75.75 0 0 1 0 1.06L8.06 10l3.72 3.72a.75.75 0 1 1-1.06 1.06l-4.25-4.25a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 0Z"
                clip-rule="evenodd"
              />
            </svg>
          </a>

          <!-- 페이지 번호 버튼들 -->
          <a
            v-for="pageNum in totalPages"
            :key="pageNum"
            href="#"
            class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
            :class="{
              'bg-indigo-600 text-white z-10': pageRequest.page === pageNum,
              'hover:bg-gray-50': pageRequest.page !== pageNum,
            }"
            @click.prevent="handlePageChange(pageNum)"
          >
            {{ pageNum }}
          </a>

          <!-- 점으로 표시된 부분 -->
          <span
            class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0"
            v-if="totalPages > 5 && pageRequest.page + 2 < totalPages"
          >
            ...
          </span>

          <!-- Next 버튼 -->
          <a
            href="#"
            class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
            @click.prevent="handlePageChange(pageRequest.page + 1)"
            :class="{
              'opacity-50 cursor-not-allowed': pageRequest.page === totalPages,
            }"
            :disabled="pageRequest.page === totalPages"
          >
            <span class="sr-only">Next</span>
            <svg
              class="h-5 w-5"
              viewBox="0 0 20 20"
              fill="currentColor"
              aria-hidden="true"
            >
              <path
                fill-rule="evenodd"
                d="M8.22 5.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L11.94 10 8.22 6.28a.75.75 0 0 1 0-1.06Z"
                clip-rule="evenodd"
              />
            </svg>
          </a>
        </nav>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, reactive, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import '@fortawesome/fontawesome-free/css/all.css';
import api from '@/api/preventionApi'; // API 모듈

const route = useRoute();
const router = useRouter();
const isLoading = ref(true);
const errorMessage = ref('');

// 게시글 상세 보기
const detail = (no) => {
  router.push({
    name: 'preventionDetail',
    params: { no: no },
    query: router.query,
  });
};

// 페이지 상태
const page = reactive({
  list: [],
  totalCount: 0,
});

// 페이지 요청 상태
const pageRequest = reactive({
  page: parseInt(route.query.page) || 1,
  amount: parseInt(route.query.amount) || 10,
});

// 총 페이지 계산 속성
const totalPages = computed(() => {
  return Math.ceil(page.totalCount / pageRequest.amount);
});

// 게시글 목록 계산 속성
const articles = computed(() => page.list);

// 페이지 변경 핸들러
const handlePageChange = async (pageNum) => {
  if (pageNum < 1 || pageNum > totalPages.value) return;
  router.push({
    query: { page: pageNum, amount: pageRequest.amount },
  });
};

// 데이터 로드 함수
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await api.getList({
      page: pageRequest.page,
      amount: pageRequest.amount,
    });
    page.list = response.list;
    page.totalCount = response.totalCount;
  } catch (error) {
    console.error('게시글 로드 실패:', error);
    errorMessage.value =
      '게시글을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// query 파라미터 변경 감지
watch(
  () => route.query,
  async (newQuery) => {
    pageRequest.page = parseInt(newQuery.page) || 1;
    pageRequest.amount = parseInt(newQuery.amount) || 10;
    await load();
  }
);

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
    font-size: 0.85rem;
    padding: 0.75rem;
  }
}
</style>
