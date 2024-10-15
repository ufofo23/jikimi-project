<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4"></h1>

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

    <!-- 테이블 데이터 -->
    <div v-else>
      <table class="table table-hover">
        <thead>
          <tr>
            <th style="width: 100px; text-align: center">날짜</th>
            <th style="width: 250px; text-align: center">주소</th>
            <th style="width: 100px; text-align: center">진단 점수</th>
            <th style="width: 100px; text-align: center">안전 여부</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="article in articles"
            :key="article.reportNo"
            @click="goToReportDetail(article.reportNo)"
            style="cursor: pointer"
          >
            <td class="text-center">
              {{ article.analysisDate }}
            </td>
            <td class="text-center">{{ article.address }}</td>
            <td class="text-center">{{ article.totalScore }}</td>
            <td class="text-center">{{ resultLevel(article.totalScore) }}</td>
            <!-- <td class="text-center">{{ article.safetyStatus }}</td> -->
          </tr>
        </tbody>
      </table>

      <div class="d-flex justify-between items-center mt-4">
        <!-- 페이지네이션 -->
        <nav class="flex-grow text-center" aria-label="Pagination">
          <div class="isolate inline-flex -space-x-px rounded-md shadow-sm">
            <a
              href="#"
              class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
              @click.prevent="prevPage"
              :class="{ 'opacity-50 cursor-not-allowed': currentPage === 1 }"
              :disabled="currentPage === 1"
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

            <a
              v-for="pageNum in totalPages"
              :key="pageNum"
              href="#"
              class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
              :class="{
                'bg-indigo-600 text-white z-10': currentPage === pageNum,
                'hover:bg-gray-50': currentPage !== pageNum,
              }"
              @click.prevent="changePage(pageNum)"
            >
              {{ pageNum }}
            </a>

            <span
              class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0"
              v-if="totalPages > 5 && currentPage + 2 < totalPages"
            >
              ...
            </span>

            <a
              href="#"
              class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
              @click.prevent="nextPage"
              :class="{
                'opacity-50 cursor-not-allowed': currentPage === totalPages,
              }"
              :disabled="currentPage === totalPages"
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
          </div>
        </nav>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, reactive } from 'vue';
import likeReportApi from '@/api/like/likeReportApi';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const originalData = ref([]);
const currentPage = ref(1);
const itemsPerPage = 10;
const isLoading = ref(false);
const errorMessage = ref('');
const selectedItems = ref([]);

const resultLevel = (totalScore) => {
  return totalScore !== null
    ? totalScore < 70
      ? '위험'
      : totalScore < 85
      ? '경고'
      : '안전'
    : '판단불가';
};

// const formatDate = (value) => {
//   if (!value) return '';
//   const date = new Date(value);
//   const year = date.getFullYear();
//   const month = String(date.getMonth() + 1).padStart(2, '0');
//   const day = String(date.getDate()).padStart(2, '0');
//   return `${year}-${month}-${day}`;
// };

const pageRequest = reactive({
  page: parseInt(route.query.page) || 1,
  amount: parseInt(route.query.amount) || 10,
});

const page = reactive({
  list: [],
  totalCount: 0,
});

const articles = computed(() => page.list);

const loadReports = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await likeReportApi.getList({
      page: pageRequest.page,
      amount: pageRequest.amount,
    });
    page.list = response.list;
    page.totalCount = response.totalCount;
  } catch (error) {
    console.error('보고서 로드 실패:', error);
    errorMessage.value =
      '보고서를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

const totalPages = computed(() => {
  return Math.ceil(page.totalCount / itemsPerPage);
});

const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage;
  return articles.value.slice(start, start + itemsPerPage);
});

const changePage = (pageNum) => {
  if (pageNum > 0 && pageNum <= totalPages.value) {
    currentPage.value = pageNum;
  }
};

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
};

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
  }
};

const deleteSelected = () => {
  if (selectedItems.value.length > 0) {
    console.log('삭제할 항목:', selectedItems.value);
  } else {
    alert('삭제할 항목이 선택되지 않았습니다.');
  }
};

const goToReportDetail = (no) => {
  router.push({
    name: 'report',
    params: { no: no },
    query: router.query,
  });
};

onMounted(loadReports);
</script>

<style scoped>
.container {
  max-width: 1200px;
  margin: auto;
}
.table th,
.table td {
  vertical-align: middle;
}
.table-hover tbody tr:hover {
  background-color: #f1f1f1;
}
.spinner-border {
  width: 2rem;
  height: 2rem;
}
.btn-danger {
  background-color: #dc3545;
  color: white;
}
.btn-danger:hover {
  background-color: #c82333;
}
</style>
