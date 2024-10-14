<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">
      <i class="fa-solid fa-paste"></i> 부동산 용어 사전
    </h1>

    <div class="alphabet-nav mb-4">
      <a
        v-for="consonant in koreanConsonants"
        :key="consonant"
        :href="'#' + consonant"
        class="btn btn-outline-primary mx-1"
      >
        {{ consonant }}
      </a>
    </div>

    <div class="filter-container mb-4">
      <div class="filter-buttons">
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
    <div v-else>
      <div
        v-for="consonant in sortedConsonants"
        :key="consonant"
        class="consonant-section"
      >
        <h2 :id="consonant" class="consonant-title">{{ consonant }}</h2>
        <div class="grid-container">
          <div
            v-for="article in getArticlesByConsonant(consonant)"
            :key="article.dictionaryNo"
            class="grid-item"
          >
            <div class="card" @click="openDetailModal(article.dictionaryNo)">
              <div class="card-body text-center">
                <font-awesome-icon
                  :icon="[
                    clickedIcons[article.dictionaryNo] ? 'fas' : 'far',
                    'star',
                  ]"
                  @click.stop="toggleIcon(article.dictionaryNo)"
                  class="star-icon"
                  :style="{
                    color: clickedIcons[article.dictionaryNo] ? '#FFD43B' : '',
                  }"
                />
                <h3 class="card-title d-inline-block ml-2">
                  {{ article.dictionaryTitle }}
                </h3>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal for Detail Page -->
    <div v-if="showModal" class="modal" @click.self="closeModal">
      <div class="modal-content">
        <span class="close" @click="closeModal">&times;</span>
        <h2>{{ detailArticle.dictionaryTitle }}</h2>
        <div class="detail-content">{{ detailArticle.dictionaryContent }}</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import api from '@/api/dictionaryApi';
import likeApi from '@/api/like/likeDictionaryApi';

const route = useRoute();
const router = useRouter();
const isLoading = ref(true);
const errorMessage = ref('');
const page = ref({ list: [], totalCount: 0 });
const searchTerm = ref('');
const isFavoritesView = ref(false);
const clickedIcons = ref({});
const showModal = ref(false);
const detailArticle = ref({});

const koreanConsonants = [
  'ㄱ',
  'ㄴ',
  'ㄷ',
  'ㄹ',
  'ㅁ',
  'ㅂ',
  'ㅅ',
  'ㅇ',
  'ㅈ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ',
];

const consonantRanges = {
  ㄱ: ['가'.charCodeAt(0), '깋'.charCodeAt(0)],
  ㄴ: ['나'.charCodeAt(0), '닣'.charCodeAt(0)],
  ㄷ: ['다'.charCodeAt(0), '딯'.charCodeAt(0)],
  ㄹ: ['라'.charCodeAt(0), '맇'.charCodeAt(0)],
  ㅁ: ['마'.charCodeAt(0), '밓'.charCodeAt(0)],
  ㅂ: ['바'.charCodeAt(0), '빟'.charCodeAt(0)],
  ㅅ: ['사'.charCodeAt(0), '싷'.charCodeAt(0)],
  ㅇ: ['아'.charCodeAt(0), '잏'.charCodeAt(0)],
  ㅈ: ['자'.charCodeAt(0), '짛'.charCodeAt(0)],
  ㅊ: ['차'.charCodeAt(0), '칳'.charCodeAt(0)],
  ㅋ: ['카'.charCodeAt(0), '킿'.charCodeAt(0)],
  ㅌ: ['타'.charCodeAt(0), '팋'.charCodeAt(0)],
  ㅍ: ['파'.charCodeAt(0), '핗'.charCodeAt(0)],
  ㅎ: ['하'.charCodeAt(0), '힣'.charCodeAt(0)],
};

const getConsonant = (char) => {
  const code = char.charCodeAt(0);
  if (code >= 'A'.charCodeAt(0) && code <= 'Z'.charCodeAt(0)) {
    return 'A-Z';
  }
  if (code >= '0'.charCodeAt(0) && code <= '9'.charCodeAt(0)) {
    return '0-9';
  }
  for (const [consonant, [start, end]] of Object.entries(consonantRanges)) {
    if (code >= start && code <= end) {
      return consonant;
    }
  }
  return 'ㄱ-ㅎ';
};

const sortedConsonants = computed(() => {
  const consonants = new Set(
    filteredArticles.value.map((article) =>
      getConsonant(article.dictionaryTitle[0])
    )
  );
  return ['A-Z', ...koreanConsonants, '0-9'].filter((consonant) =>
    consonants.has(consonant)
  );
});

const filteredArticles = computed(() => {
  let result = page.value.list;

  if (isFavoritesView.value) {
    result = result.filter(
      (article) => clickedIcons.value[article.dictionaryNo]
    );
  }

  if (searchTerm.value) {
    result = result.filter((article) =>
      article.dictionaryTitle
        .toLowerCase()
        .includes(searchTerm.value.toLowerCase())
    );
  }

  return result.sort((a, b) =>
    a.dictionaryTitle.localeCompare(b.dictionaryTitle, 'ko-KR')
  );
});

const getArticlesByConsonant = (consonant) => {
  return filteredArticles.value
    .filter((article) => getConsonant(article.dictionaryTitle[0]) === consonant)
    .sort((a, b) =>
      a.dictionaryTitle.localeCompare(b.dictionaryTitle, 'ko-KR')
    );
};

const openDetailModal = async (no) => {
  try {
    detailArticle.value = await api.get(no);
    showModal.value = true;
  } catch (error) {
    console.error('Failed to load article:', error);
    errorMessage.value =
      '게시물을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  }
};

const closeModal = () => {
  showModal.value = false;
};

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
    for (let likeDic of likeDics) {
      clickedIcons.value[likeDic.dictionaryNo] = true;
    }
  } catch (error) {
    console.error('게시글 로드 실패:', error);
    errorMessage.value =
      '게시글을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

const toggleIcon = async (dictionaryNo) => {
  if (clickedIcons.value[dictionaryNo]) {
    try {
      await likeApi.delete(dictionaryNo);
    } catch (error) {
      console.error(error);
    }
  } else {
    try {
      await likeApi.create(dictionaryNo);
    } catch (error) {
      console.error(error);
    }
  }
  clickedIcons.value[dictionaryNo] = !clickedIcons.value[dictionaryNo];
};

const viewFavorites = () => {
  isFavoritesView.value = !isFavoritesView.value;
};

const clearFilter = () => {
  searchTerm.value = '';
  isFavoritesView.value = false;
};

const filterBySearch = () => {
  isFavoritesView.value = false;
};

onMounted(() => {
  load();
});
</script>

<style scoped>
.container {
  max-width: 1600px;
  margin: 0 auto;
  padding: 0 15px;
}

.alphabet-nav {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  margin-bottom: 20px;
  background-color: #f8f9fa;
  padding: 10px 0;
}

.alphabet-nav a {
  margin: 5px;
  padding: 5px 10px;
  text-decoration: none;
  color: #007bff;
  font-weight: bold;
}

.filter-container {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.filter-buttons {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
}

.filter-buttons button {
  margin: 0 10px;
  padding: 3px 10px;
}

.new-search {
  position: relative;
  padding-left: 20px;
}

.new-search input {
  width: 300px;
  height: 40px;
  line-height: 40px;
  padding: 0 10px;
  border-radius: 5px;
  margin-left: 10px;
  text-align: center;
}

.search-icon {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
}

.consonant-section {
  margin-bottom: 30px;
}

.consonant-title {
  text-align: left;
  font-size: 2.5rem;
  font-weight: bold;
  margin-bottom: 20px;
  padding-top: 180px;
  margin-top: -180px;
}

.grid-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
  gap: 20px;
}

.grid-item .card {
  width: 100%;
  height: 100%;
  border: 1px solid #ddd;
  border-radius: 8px;
  transition: transform 0.2s ease-in-out;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
}

.grid-item .card:hover {
  transform: scale(1.05);
}

.card-body {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.star-icon {
  cursor: pointer;
  font-size: 20px;
  margin-right: 8px;
}

.card-title {
  font-size: 1.2rem;
  margin: 0;
}

/* Modal styles */
/* Modal styles */
.modal {
  display: flex;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
  justify-content: center;
  align-items: center;
}

.modal-content {
  background-color: white; /* 배경색을 흰색으로 */
  width: 30rem; /* 카드 너비 설정 */
  padding: 1.5rem; /* 내부 패딩 추가 */
  border-radius: 0.5rem; /* 카드 모서리 둥글게 */
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
  transition: all 0.15s ease-out; /* 전환 효과 */
  position: relative; /* 상대 위치 지정 */
}

.modal-content:hover {
  margin-top: -0.5rem; /* hover 시 카드 위로 이동 */
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* hover 시 그림자 강화 */
}

.close {
  position: absolute;
  right: 10px;
  top: 10px;
  font-size: 1.5rem;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

h2 {
  margin: 0;
  font-size: 1.5rem; /* 제목 폰트 크기 증가 */
  font-weight: bold;
  margin-bottom: 1rem; /* 제목과 내용 간격 조정 */
}

.detail-content {
  white-space: pre-line;
  font-size: 1rem; /* 내용 폰트 크기 */
  line-height: 1.6; /* 줄 간격 조정 */
  margin-bottom: 1rem;
}

.button-container {
  display: flex;
  justify-content: flex-end;
  padding-top: 20px;
}
</style>
