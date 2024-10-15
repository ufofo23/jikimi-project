<template>
  <div class="container mx-auto px-4 py-8">
    <div class="banner-container mb-8">
      <div class="banner-content">
        <div class="text-content">
          <h1 class="banner-title">부동산 용어 사전</h1>
          <p class="banner-description">
            쉽고 빠르게 부동산 용어를 검색하세요!
          </p>
        </div>
        <img src="@/assets/jip.png" alt="hero" class="jip-image" />
      </div>
    </div>

    <div class="flex flex-col space-y-4 mb-6">
      <div class="flex flex-wrap justify-between items-center gap-4">
        <div class="filter-buttons flex space-x-2">
          <button class="btn btn-outline-secondary mx-1" @click="clearFilter">
            모두 보기
          </button>
          <button class="btn btn-outline-warning mx-1" @click="viewFavorites">
            즐겨찾기
          </button>
        </div>

        <div class="relative flex-grow max-w-md">
          <input
            type="text"
            v-model="searchTerm"
            placeholder="검색할 단어를 입력하세요"
            @input="filterBySearch"
            class="w-full pl-10 pr-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
          <span class="absolute left-3 top-1/2 transform -translate-y-1/2"
            >🔍</span
          >
        </div>
      </div>

      <div class="consonant-nav overflow-x-auto w-full">
        <div class="flex space-x-2">
          <a
            v-for="consonant in koreanConsonants"
            :key="consonant"
            :href="'#' + consonant"
            class="flex-1 px-3 py-2 text-sm bg-blue-100 text-blue-800 rounded-md hover:bg-blue-200 transition-colors duration-200 whitespace-nowrap text-center"
          >
            {{ consonant }}
          </a>
        </div>
      </div>
    </div>

    <div v-if="isLoading" class="flex justify-center items-center h-64">
      <div
        class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-blue-500"
      ></div>
    </div>

    <div
      v-else-if="errorMessage"
      class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"
      role="alert"
    >
      {{ errorMessage }}
    </div>

    <div v-else>
      <div v-for="consonant in sortedConsonants" :key="consonant" class="mb-8">
        <h2 :id="consonant" class="text-2xl font-bold mb-4 pt-16 -mt-16">
          {{ consonant }}
        </h2>
        <div
          class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4"
        >
          <div
            v-for="article in getArticlesByConsonant(consonant)"
            :key="article.dictionaryNo"
            class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 hover:bg-secondary"
          >
            <div
              class="p-4 flex justify-between items-start"
              @click="openDetailModal(article.dictionaryNo)"
            >
              <h3 class="text-lg font-semibold">
                {{ article.dictionaryTitle }}
              </h3>
              <button
                @click.stop="toggleIcon(article.dictionaryNo)"
                class="text-2xl focus:outline-none"
                :class="{
                  'text-yellow-500': clickedIcons[article.dictionaryNo],
                }"
              >
                {{ clickedIcons[article.dictionaryNo] ? '★' : '☆' }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div
      v-if="showModal"
      class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center p-4"
      @click.self="closeModal"
    >
      <div class="bg-white rounded-lg p-6 max-w-lg w-full">
        <button
          @click="closeModal"
          class="float-right text-gray-600 hover:text-gray-800"
        >
          &times;
        </button>
        <h2 class="text-2xl font-bold mb-4">
          {{ detailArticle.dictionaryTitle }}
        </h2>
        <div class="whitespace-pre-line">
          {{ detailArticle.dictionaryContent }}
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted } from 'vue';
import api from '@/api/dictionaryApi';
import likeApi from '@/api/like/likeDictionaryApi';

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
  if (code >= 'A'.charCodeAt(0) && code <= 'Z'.charCodeAt(0)) return 'A-Z';
  if (code >= '0'.charCodeAt(0) && code <= '9'.charCodeAt(0)) return '0-9';
  for (const [consonant, [start, end]] of Object.entries(consonantRanges)) {
    if (code >= start && code <= end) return consonant;
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
h2 {
  scroll-margin-top: 300px;
}

.container {
  max-width: 1600px;
  margin: 0 auto;
  padding: 0 15px;
}

/* 검색 버튼 크기 조절 */
.relative {
  max-width: 450px; /* 너비 조정 */
}

.banner-container {
  background: linear-gradient(to right, #f0f7ff, #87c0ff);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 250px; /* 배너 높이 증가 */
  border-radius: 20px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  padding: 0 20px;
  margin-top: 5px;
}

.banner-content {
  display: flex;
  align-items: center;
  justify-content: center; /* 내용물을 양쪽으로 분산 */
  width: 100%;
  max-width: 800px; /* 최대 너비 설정 */
  height: 100%;
}

.text-content {
  text-align: center;
  flex-grow: 1; /* 텍스트 영역이 남는 공간을 차지하도록 */
}

.jip-image {
  height: 180px; /* 이미지 크기 증가 */
  width: auto;
  margin-left: 10px; /* 이미지와 텍스트 사이 간격 */
}

.banner-title {
  font-size: 48px; /* 글자 크기 증가 */
  font-weight: bold;
  color: #1a73e8;
  margin-bottom: 10px;
}

.banner-description {
  font-size: 22px; /* 설명 글자 크기 증가 */
  color: #333;
}

.star-icon {
  cursor: pointer;
  font-size: 20px;
  margin-right: 8px;
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

/* New styles for hover effect */
.hover\:bg-secondary:hover {
  background-color: #f0f7ff;
}

/* Responsive adjustments for smaller screens */
@media (max-width: 640px) {
  .banner-content {
    flex-direction: column;
  }

  .text-content {
    text-align: center;
    margin-right: 20px;
  }

  .jip-image {
    height: 120px; /* 이미지 크기 증가 */
    width: auto;
  }

  .banner-title {
    font-size: 48px; /* 글자 크기 증가 */
    font-weight: bold;
    color: #1a73e8;
    margin-bottom: 10px;
  }

  .banner-description {
    font-size: 22px; /* 설명 글자 크기 증가 */
    color: #333;
  }

  .flex-wrap {
    flex-direction: column;
  }

  .w-full {
    width: 100%;
  }
}
</style>
