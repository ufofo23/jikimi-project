<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">
      <i class="fa-solid fa-paste"></i> 부동산 용어 사전
    </h1>

    <div class="filter-container mb-4">
  <div class="filter-buttons">
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
    <button class="btn btn-outline-warning mx-1" @click="viewFavorites">
      즐겨찾기
    </button>
  </div>
  <div class="new-search">
    <input
      type="text"
      class="form-control"
      v-model="searchTerm"
      placeholder="검색할 단어를 입력하세요"
      @input="filterBySearch"
    />
    <span class="search-icon">🔍</span>
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
              :icon="[clickedIcons[article.dictionaryNo] ? 'fas' : 'far', 'star']"
              @click.stop="toggleIcon(article.dictionaryNo)"
              class="star-icon"
              :style="{ color: clickedIcons[article.dictionaryNo] ? '#FFD43B' : '' }"
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

import likeApi from '@/api/like/likeDictionaryApi';

const cr = useRoute();
const router = useRouter();
const isLoading = ref(true);
const errorMessage = ref('');
const page = ref({ list: [], totalCount: 0 });
const filterLetter = ref('');
const searchTerm = ref(''); // 검색어 추가
const letters = 'ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ'.split(''); // 한글 자음만 남김
const isFavoritesView = ref(false); // 즐겨찾기 모드 추가
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
const toggleIcon = async (dictionaryNo) => {
  if (clickedIcons.value[dictionaryNo]){
    try{
      const response = await likeApi.delete(dictionaryNo);
    } catch(error){
      console.error(error);
    }
  } else {
    try{
      const response = await likeApi.create(dictionaryNo);
    } catch(error){
      console.error(error);
    }
  }
  clickedIcons.value[dictionaryNo] = !clickedIcons.value[dictionaryNo];
};

// 즐겨찾기 보기 함수
const viewFavorites = () => {
  isFavoritesView.value = !isFavoritesView.value; // 즐겨찾기 모드 토글
  console.log(isFavoritesView);
};

// 검색어에 따라 필터링
const filteredArticles = computed(() => {
  let result = page.value.list;

  // 즐겨찾기 모드일 때 필터링
  if (isFavoritesView.value) {
    result = result.filter(article => clickedIcons.value[article.dictionaryNo]);
  }

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
    
    const likeDics = await likeApi.getList();
    for(let likeDic of likeDics){
      clickedIcons.value[likeDic.dictionaryNo] = true;
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
  isFavoritesView.value = false; // 즐겨찾기 모드 해제
};

// 검색어에 따라 필터링하는 함수
const filterBySearch = () => {
  filterLetter.value = ''; // 검색 시 자음 필터 초기화
  isFavoritesView.value = false; // 모든 필터 해제 시 즐겨찾기 모드도 해제
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});
</script>

<style scoped>
/* 컨테이너 스타일 */
.container {
  max-width: 1600px; /* 최대 너비 설정 */
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

.filter-container {
  display: flex;
  align-items: center; /* 수직 정렬을 위해 추가 */
  justify-content: center; /* 수평 정렬 */
  border-bottom: none;
}

.filter-buttons button {
  margin: 0 10px;
  padding: 3px 10px;
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

.btn {
  height: 1cm;
}

.btn-outline-primary mx-1 {
  width: 1cm;
  height: 1cm;
}

.btn-outline-secondary .btn-outline-warning {
  width: 3cm; 
  height: 1cm;
}
.new-search{
  position: relative; 
  padding-left: 20px;
  border-bottom: none;
}

.new-search input {
  width: 300px; /* 원하는 너비로 조정 */
  height: 40px; /* 버튼과 높이를 맞추기 위해 40px로 조정 */
  line-height: 40px; /* 텍스트가 중앙에 위치하도록 조정 */
  padding: 0 10px; /* 여백 조정 */
  border-radius: 5px; /* 모서리 둥글게 */
  margin-left: 10px; /* 버튼과의 간격 */
  text-align: center;
}

.search-icon {
  position: absolute;
  right: 10px; /* 오른쪽 여백 설정 */
  top: 50%; /* 세로 중앙 정렬 */
  transform: translateY(-50%); /* 세로 중앙 정렬을 위한 변환 */
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

.star-icon {
  cursor: pointer;
  font-size: 20px;
  margin-right: 8px; /* 간격 조절 */
}
</style>