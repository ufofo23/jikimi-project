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
    <div v-else-if="errorMessage" class="alert alert-danger" role="alert">
      {{ errorMessage }}
    </div>

    <!-- 테이블 데이터 -->
    <div v-else>
      <table class="table table-hover">
        <thead>
          <tr>
            <th style="width: 50px; text-align: center;" class="position-relative">
              선택
            </th>
            <th style="width: 100px; text-align: center;" class="position-relative">
              날짜
              <i
                class="fa-solid"
                :class="isDateDropdownOpen ? 'fa-caret-up' : 'fa-caret-down'"
                @click="toggleDateDropdown"
                style="cursor: pointer;"
              ></i>
              <div v-if="isDateDropdownOpen" class="dropdown-menu show">
                <div class="dropdown-item" @click="sortByDate('oldest')">오래된 순으로</div>
                <div class="dropdown-item" @click="sortByDate('latest')">최신 순으로</div>
              </div>
            </th>
            <th style="width: 250px; text-align: center;">주소</th>
            <th style="width: 100px; text-align: center;" class="position-relative">
              진단 결과
              <i
                class="fa-solid"
                :class="isResultDropdownOpen ? 'fa-caret-up' : 'fa-caret-down'"
                @click="toggleResultDropdown"
                style="cursor: pointer;"
              ></i>
              <div v-if="isResultDropdownOpen" class="dropdown-menu show">
                <div class="dropdown-item" @click="selectResult('전체')">전체</div>
                <div class="dropdown-item" @click="selectResult('안전')">안전</div>
                <div class="dropdown-item" @click="selectResult('위험')">위험</div>
                <div class="dropdown-item" @click="selectResult('판단불가')">판단 불가</div>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in paginatedData" :key="index">
            <td class="text-center">
              <input type="checkbox" v-model="selectedItems" :value="item" />
            </td>
            <td class="text-center">{{ item.date }}</td>
            <td class="text-center">{{ item.address }}</td>
            <td class="text-center">{{ item.score }}</td>
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
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M11.78 5.22a.75.75 0 0 1 0 1.06L8.06 10l3.72 3.72a.75.75 0 1 1-1.06 1.06l-4.25-4.25a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd" />
              </svg>
            </a>

            <a
              v-for="pageNum in totalPages"
              :key="pageNum"
              href="#"
              class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
              :class="{ 'bg-indigo-600 text-white z-10': currentPage === pageNum, 'hover:bg-gray-50': currentPage !== pageNum }"
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
              :class="{ 'opacity-50 cursor-not-allowed': currentPage === totalPages }"
              :disabled="currentPage === totalPages"
            >
              <span class="sr-only">Next</span>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M8.22 5.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L11.94 10 8.22 6.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
              </svg>
            </a>
          </div>
        </nav>

        <button class="btn btn-danger ml-4" @click="deleteSelected">삭제</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// 임시 데이터
const originalData = ref([
  { date: '2024-01-01', address: '부산 북구', score: '안전' },
  { date: '2024-01-02', address: '부산 강서구', score: '안전' },
  { date: '2024-01-03', address: '대구 수성구', score: '안전' },
  { date: '2024-01-04', address: '부산 사하구', score: '안전' },
  { date: '2024-01-05', address: '부산 진구', score: '위험' },
  { date: '2024-01-06', address: '대구 북구', score: '위험' },
  { date: '2024-01-07', address: '서울 강서구', score: '안전' },
  { date: '2024-01-08', address: '부산 중구', score: '판단불가' },
  { date: '2024-01-09', address: '부산 동구', score: '안전' },
  { date: '2024-01-10', address: '부산 서구', score: '불가' },
  { date: '2024-01-11', address: '부산 남구', score: '판단불가' },
  { date: '2024-01-12', address: '서울 강남구', score: '안전' },
]);

const currentPage = ref(1);
const itemsPerPage = 10;
const isLoading = ref(false);
const errorMessage = ref(''); // 에러 메시지
const isDateDropdownOpen = ref(false); // 날짜 드롭다운 상태
const isResultDropdownOpen = ref(false); // 진단 결과 드롭다운 상태
const selectedResult = ref('전체'); // 선택된 단일 결과 옵션
const selectedSortOrder = ref('latest'); // 선택된 정렬 기준
const selectedItems = ref([]); // 선택된 항목을 저장할 배열

// 총 페이지 계산
const totalPages = computed(() => {
  return Math.ceil(filteredData.value.length / itemsPerPage);
});

// 필터링된 데이터
const filteredData = computed(() => {
  let data = originalData.value.filter((item) => {
    if (selectedResult.value === '전체') {
      return true; // 모든 데이터 표시
    }
    return item.score === selectedResult.value; // 선택된 진단 결과와 일치하는 데이터만 필터링
  });

  // 날짜 정렬
  if (selectedSortOrder.value === 'oldest') {
    data.sort((a, b) => new Date(a.date) - new Date(b.date)); // 오래된 순으로 정렬
  } else {
    data.sort((a, b) => new Date(b.date) - new Date(a.date)); // 최신 순으로 정렬
  }

  return data; // 여기서 반환
});

// 페이지네이션된 데이터
const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage;
  return filteredData.value.slice(start, start + itemsPerPage);
});

// 페이지 변경 함수
const changePage = (pageNum) => {
  currentPage.value = pageNum;
};

// 이전 페이지
const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
};

// 다음 페이지
const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
  }
};

// 선택된 모든 항목 토글
const toggleSelectAll = (event) => {
  if (event.target.checked) {
    selectedItems.value = paginatedData.value.map(item => item); // 모든 항목 선택
  } else {
    selectedItems.value = []; // 모든 항목 선택 해제
  }
};

// 선택된 항목 삭제
const deleteSelected = () => {
  originalData.value = originalData.value.filter(item => !selectedItems.value.includes(item));
  selectedItems.value = []; // 삭제 후 선택 해제
};

// 날짜 드롭다운 토글
const toggleDateDropdown = () => {
  isDateDropdownOpen.value = !isDateDropdownOpen.value;
};

// 진단 결과 드롭다운 토글
const toggleResultDropdown = () => {
  isResultDropdownOpen.value = !isResultDropdownOpen.value;
};

// 진단 결과 선택
const selectResult = (result) => {
  selectedResult.value = result;
  isResultDropdownOpen.value = false; // 드롭다운 닫기
};

// 정렬 기준 선택
const sortByDate = (order) => {
  selectedSortOrder.value = order;
  isDateDropdownOpen.value = false; // 드롭다운 닫기
};
</script>

<style scoped>
.nav-container {
  display: flex;
  justify-content: space-between; /* Keeps the delete button on the right */
  align-items: center; /* Aligns items vertically */
}

.pagination {
  flex-grow: 1; /* Allows the pagination to take available space */
  text-align: center; /* Centers the pagination items */
}

.dropdown-menu {
  position: absolute; /* 드롭다운 위치 조정 */
  background-color: white;
  border: 1px solid #ddd;
  border-radius: 0.25rem;
  z-index: 1000; /* 드롭다운이 다른 요소들 위에 나타나도록 설정 */
  min-width: 100px; /* 드롭다운 최소 너비 설정 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
  display: none; /* 기본적으로 숨김 */
}

.dropdown-menu.show {
  display: block; /* show 클래스가 있을 때 보이도록 설정 */
}

.dropdown-item {
  padding: 0.5rem 1rem;
  cursor: pointer;
  transition: background-color 0.2s; /* 부드러운 배경색 전환 효과 */
  text-align: center;
}

.dropdown-item:hover {
  background-color: #f8f9fa; /* 호버 시 배경색 변경 */
}

/* 드롭다운 메뉴의 위치를 조정하기 위한 추가 스타일 */
.position-relative {
  position: relative; /* 드롭다운 메뉴의 부모 요소에 위치 설정 */
}

</style>
