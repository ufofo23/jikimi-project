<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">
      <i class="fa-solid fa-paste"></i> 부동산 용어 사전
    </h1>

    <!-- 필터 버튼 -->
    <div class="filter-buttons mb-4">
      <button
        v-for="letter in letters"
        :key="letter"
        class="btn btn-outline-primary mx-1"
        @click="filterArticles(letter)"
      >
        {{ letter }}
      </button>
      <button class="btn btn-outline-secondary mx-1" @click="clearFilter">
        모두 보기
      </button>

      <!-- 새 검색창 -->
      <div class="new-search">
        <input
          type="text"
          class="form-control"
          v-model="searchTerm"
          placeholder="검색할 단어를 입력하세요"
          @input="filterBySearch"
        />
        <button class="btn btn-outline-success" @click="filterBySearch">🔍</button>
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

    <!-- 게시글 목록 그리드 -->
    <div v-else class="grid-container">
      <div
        v-for="article in filteredArticles"
        :key="article.dictionaryNo"
        class="grid-item"
      >
        <div class="card" @click="detail(article.dictionaryNo)">
          <div class="card-body text-center">
            <!-- 아이콘 클릭 이벤트에 stopPropagation() 적용 -->
            <font-awesome-icon
              :icon="[clickedIcons[article.dictionaryNo] ? 'fas' : 'far', 'circle-question']"
              @click.stop="toggleIcon(article.dictionaryNo)" 
              class="question-icon"
            />
            <h3 class="card-title d-inline-block ml-2">{{ article.dictionaryTitle }}</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'; // Font Awesome 아이콘 사용

import api from '@/api/dictionaryApi'; // API 모듈
import { getInitial } from 'hangul-js'; // hangul-js 라이브러리 임포트

const cr = useRoute();
const router = useRouter();
const isLoading = ref(true);
const errorMessage = ref('');
const page = ref({ list: [], totalCount: 0 });
const filterLetter = ref('');
const searchTerm = ref(''); // 검색어 추가
const letters = 'ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ'.split(''); // 한글 자음만 남김

// 자음에 해당하는 유니코드 범위를 정의
const consonantRanges = {
  'ㄱ': ['가'.charCodeAt(0), '깋'.charCodeAt(0)],
  'ㄴ': ['나'.charCodeAt(0), '닣'.charCodeAt(0)],
  'ㄷ': ['다'.charCodeAt(0), '딯'.charCodeAt(0)],
  'ㄹ': ['라'.charCodeAt(0), '맇'.charCodeAt(0)],
  'ㅁ': ['마'.charCodeAt(0), '밓'.charCodeAt(0)],
  'ㅂ': ['바'.charCodeAt(0), '빟'.charCodeAt(0)],
  'ㅅ': ['사'.charCodeAt(0), '싷'.charCodeAt(0)],
  'ㅇ': ['아'.charCodeAt(0), '잏'.charCodeAt(0)],
  'ㅈ': ['자'.charCodeAt(0), '짛'.charCodeAt(0)],
  'ㅊ': ['차'.charCodeAt(0), '칳'.charCodeAt(0)],
  'ㅋ': ['카'.charCodeAt(0), '킿'.charCodeAt(0)],
  'ㅌ': ['타'.charCodeAt(0), '팋'.charCodeAt(0)],
  'ㅍ': ['파'.charCodeAt(0), '핗'.charCodeAt(0)],
  'ㅎ': ['하'.charCodeAt(0), '힣'.charCodeAt(0)],
};

const clickedIcons = ref({}); // 각 article의 아이콘 상태를 저장하는 객체

// 아이콘 클릭 시 상태 변경 함수
const toggleIcon = (dictionaryNo) => {
  clickedIcons.value[dictionaryNo] = !clickedIcons.value[dictionaryNo];
};

// 검색어에 따라 필터링
const filteredArticles = computed(() => {
  let result = page.value.list;

  // 자음 필터링 적용
  if (filterLetter.value) {
    const range = consonantRanges[filterLetter.value];
    
    if (range) {
      result = result.filter(article => {
        const firstChar = article.dictionaryTitle[0]; // 단어의 첫 글자
        const charCode = firstChar.charCodeAt(0);
        return charCode >= range[0] && charCode <= range[1];
      });
    }
  }

  // 검색어 필터링 적용
  if (searchTerm.value) {
    result = result.filter(article =>
      article.dictionaryTitle.includes(searchTerm.value)
    );
  }

  return result;
});

const detail = (no) => {
  router.push({
    name: 'dictionaryDetailPage',
    params: { no: no },
    query: cr.query,
  });
};

// 데이터 로드 함수
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await api.getList();
    if (Array.isArray(response)) {
      page.value = { list: response, totalCount: response.length };
    } else {
      console.warn('응답이 배열이 아닙니다:', response);
    }
  } catch (error) {
    console.error('게시글 로드 실패:', error);
    errorMessage.value = '게시글을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// 자음 필터링 함수
const filterArticles = (letter) => {
  filterLetter.value = letter;
  searchTerm.value = ''; // 자음을 누르면 검색어 초기화
};

const clearFilter = () => {
  filterLetter.value = '';
  searchTerm.value = ''; // 검색어도 초기화
};

// 검색어에 따라 필터링하는 함수
const filterBySearch = () => {
  filterLetter.value = ''; // 검색 시 자음 필터 초기화
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});
</script>

<style scoped>
/* 컨테이너 스타일 */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
}

/* 필터 버튼 스타일 */
.filter-buttons {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  border-bottom: none;
}


/* 자음 버튼 스타일 */
.filter-buttons button {
  margin: 0 10px;
  padding: 3px 10px;
}

/* 검색창 스타일 */
.new-search {
  display: flex;
  justify-content: flex-end;
  margin-right: 10px;
  margin-left: 10px;
  border-bottom: none;
}

/* 카드 크기 수정 */
.grid-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 16px;
  border-bottom: none;
}

.grid-item {
  border-bottom: none;
}
.grid-item .card {
  width: 100%;
  max-width: 250px;
  margin: auto;
  border: 1px solid #ddd;
  border-radius: 8px;
  transition: transform 0.2s ease-in-out;
  text-align: center;
}

.grid-item .card:hover {
  transform: scale(1.05);
}


/* 아이콘 및 제목 중앙 정렬 */
.card-body {
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: none;
}

.card-title {
  border-bottom: none;
}

.question-icon {
  cursor: pointer;
  font-size: 24px;
  margin-right: 8px;
}

/* 반응형 디자인 */
@media (max-width: 600px) {
  .container {
    padding: 0 10px;
  }

  .grid-container {
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  }
}
</style>
