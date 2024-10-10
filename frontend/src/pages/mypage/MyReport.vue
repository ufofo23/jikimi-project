<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">
      <i class="fa-solid fa-paste"></i> 데이터 목록
    </h1>

    <!-- 로딩 상태 -->
    <div v-if="isLoading" class="text-center my-4">
      <div class="spinner-border" role="status">
        <span class="visually-hidden">로딩 중...</span>
      </div>
    </div>

    <!-- 에러 메시지 -->
    <div
      v-else-if="errorMessage"
      class="alert alert-danger"
      role="alert"
    >
      {{ errorMessage }}
    </div>

    <!-- 테이블 데이터 -->
    <div v-else>
      <table class="table table-hover">
        <thead>
          <tr>
            <th
              style="width: 50px; text-align: center"
              class="position-relative"
            >
              선택
            </th>
            <th
              style="width: 100px; text-align: center"
              class="position-relative"
            >
              날짜
              <i
                class="fa-solid"
                :class="
                  isDateDropdownOpen
                    ? 'fa-caret-up'
                    : 'fa-caret-down'
                "
                @click="toggleDateDropdown"
                style="cursor: pointer"
              ></i>
              <div
                v-if="isDateDropdownOpen"
                class="dropdown-menu show"
              >
                <div
                  class="dropdown-item"
                  @click="sortByDate('oldest')"
                >
                  오래된 순으로
                </div>
                <div
                  class="dropdown-item"
                  @click="sortByDate('latest')"
                >
                  최신 순으로
                </div>
              </div>
            </th>
            <th style="width: 250px; text-align: center">
              주소
            </th>
            <th
              style="width: 100px; text-align: center"
              class="position-relative"
            >
              진단 결과
              <i
                class="fa-solid"
                :class="
                  isResultDropdownOpen
                    ? 'fa-caret-up'
                    : 'fa-caret-down'
                "
                @click="toggleResultDropdown"
                style="cursor: pointer"
              ></i>
              <div
                v-if="isResultDropdownOpen"
                class="dropdown-menu show"
              >
                <div
                  class="dropdown-item"
                  @click="selectResult('전체')"
                >
                  전체
                </div>
                <div
                  class="dropdown-item"
                  @click="selectResult('안전')"
                >
                  안전
                </div>
                <div
                  class="dropdown-item"
                  @click="selectResult('위험')"
                >
                  위험
                </div>
                <div
                  class="dropdown-item"
                  @click="selectResult('판단불가')"
                >
                  판단 불가
                </div>
              </div>
            </th>
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
              <input
                type="checkbox"
                v-model="selectedItems"
              />
            </td>
            <td class="text-center">
              {{ formatDate(article.contractStartDate) }}
            </td>
            <td class="text-center">
              {{ article.address }}
            </td>
            <td class="text-center">
              {{ article.totalScore }}
            </td>
          </tr>
        </tbody>
      </table>

      <div class="d-flex justify-between items-center mt-4">
        <!-- 페이지네이션 -->
        <nav
          class="flex-grow text-center"
          aria-label="Pagination"
        >
          <div
            class="isolate inline-flex -space-x-px rounded-md shadow-sm"
          >
            <a
              href="#"
              class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
              @click.prevent="prevPage"
              :class="{
                'opacity-50 cursor-not-allowed':
                  currentPage === 1,
              }"
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
                'bg-indigo-600 text-white z-10':
                  currentPage === pageNum,
                'hover:bg-gray-50': currentPage !== pageNum,
              }"
              @click.prevent="changePage(pageNum)"
            >
              {{ pageNum }}
            </a>

            <span
              class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0"
              v-if="
                totalPages > 5 &&
                currentPage + 2 < totalPages
              "
            >
              ...
            </span>

            <a
              href="#"
              class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
              @click.prevent="nextPage"
              :class="{
                'opacity-50 cursor-not-allowed':
                  currentPage === totalPages,
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

        <button
          class="btn btn-danger ml-4"
          @click="deleteSelected"
        >
          삭제
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, reactive } from 'vue';
import likeReportApi from '@/api/like/likeReportApi'; // likeReportApi 가져오기
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const originalData = ref([]);
const currentPage = ref(1);
const itemsPerPage = 10;
const isLoading = ref(false);
const errorMessage = ref(''); // 에러 메시지
const isDateDropdownOpen = ref(false); // 날짜 드롭다운 상태
const isResultDropdownOpen = ref(false); // 진단 결과 드롭다운 상태
const selectedResult = ref('전체'); // 선택된 단일 결과 옵션
const selectedSortOrder = ref('latest'); // 선택된 정렬 기준
const selectedItems = ref([]); // 선택된 항목을 저장할 배열

// date 포맷
const formatDate = (value) => {
  if (!value) return '';
  const date = new Date(value);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(
    2,
    '0'
  ); // 1을 더해 월을 조정
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};

// 페이지 요청 상태
const pageRequest = reactive({
  page: parseInt(route.query.page) || 1,
  amount: parseInt(route.query.amount) || 10,
});

// 상태 관리
const page = reactive({
  list: [],
  totalCount: 0,
});

// 게시글 목록 계산 속성
const articles = computed(() => page.list);

// // 데이터 로드 함수
// const loadReports = async () => {
//   isLoading.value = true;
//   errorMessage.value = '';
//   try {
//     const response = await likeReportApi.getList({
//       page: pageRequest.page,
//       amount: pageRequest.amount,
//     }); // API에서 데이터 가져오기
//     page.list = response.list;
//     page.totalCount = response.totalCount;
//   } catch (error) {
//     console.error('보고서 로드 실패:', error);
//     errorMessage.value =
//       '보고서를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
//   } finally {
//     isLoading.value = false;
//   }
// };

const loadReports = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await likeReportApi.getList({
      page: pageRequest.page,
      amount: pageRequest.amount,
    }); // API에서 데이터 가져오기
    console.log('Response:', response);
    page.list = response.list;
    page.totalCount = response.totalCount;
    console.log('Page List:', page.list);
  } catch (error) {
    console.error('보고서 로드 실패:', error);
    errorMessage.value =
      '보고서를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// 총 페이지 계산
const totalPages = computed(() => {
  return Math.ceil(
    filteredData.value.length / itemsPerPage
  );
});

// 필터링된 데이터를 제공하는 computed 함수
const filteredData = computed(() => {
  // originalData.value가 배열인지 확인하고, 배열일 때만 filter 적용
  return Array.isArray(originalData.value)
    ? originalData.value
        .filter((item) => {
          return (
            selectedResult.value === '전체' ||
            item.score === selectedResult.value
          ); // 선택된 진단 결과에 따라 필터링
        })
        .sort((a, b) => {
          return selectedSortOrder.value === 'oldest'
            ? new Date(a.date) - new Date(b.date)
            : new Date(b.date) - new Date(a.date);
        })
    : [];
});

// 페이지네이션된 데이터
const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage;
  return filteredData.value.slice(
    start,
    start + itemsPerPage
  );
});

// 페이지 변경 핸들러
const changePage = (pageNum) => {
  if (pageNum > 0 && pageNum <= totalPages.value) {
    currentPage.value = pageNum;
  }
};

// 이전 페이지로 이동
const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
};

// 다음 페이지로 이동
const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
  }
};

// 진단 결과 선택 핸들러
const selectResult = (result) => {
  selectedResult.value = result;
  currentPage.value = 1; // 결과 선택 후 페이지를 1로 초기화
};

// 날짜 드롭다운 토글 핸들러
const toggleDateDropdown = () => {
  isDateDropdownOpen.value = !isDateDropdownOpen.value;
};

// 진단 결과 드롭다운 토글 핸들러
const toggleResultDropdown = () => {
  isResultDropdownOpen.value = !isResultDropdownOpen.value;
};

// 선택된 항목 삭제 핸들러
const deleteSelected = () => {
  if (selectedItems.value.length > 0) {
    // API 호출하여 선택된 항목 삭제 로직 추가
    console.log('삭제할 항목:', selectedItems.value);
  } else {
    alert('삭제할 항목이 선택되지 않았습니다.');
  }
};

// 특정 reportNo를 기반으로 보고서 상세 페이지로 이동
const goToReportDetail = (no) => {
  router.push({
    name: 'report', // 라우터에서 정의된 report 페이지의 name
    params: { no: no }, // reportNo를 params로 전달
    query: router.query,
  });
};

// 컴포넌트 마운트 시 데이터 로드
onMounted(loadReports);
</script>

<style scoped>
.container {
  max-width: 1200px;
  margin: auto;
}
.table th,
.table td {
  vertical-align: middle; /* 수직 중앙 정렬 */
}
.table-hover tbody tr:hover {
  background-color: #f1f1f1; /* 마우스 오버 시 배경색 변경 */
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
.dropdown-menu.show {
  display: block;
  position: absolute;
  will-change: transform;
}
</style>
