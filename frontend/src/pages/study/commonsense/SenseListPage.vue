<template>
  <div class="scroll-container" ref="scrollContainer">
    <div class="scroll-wrapper">
      <div
        v-for="article in articles"
        :key="article.commonSenseNo + Math.random()"
        class="card"
      >
        <PieceSenseCard
          :commonSenseTitle="article.commonSenseTitle"
          :commonSenseNo="article.commonSenseNo"
          :commonSenseContent="article.commonSenseContent"
          :commonPieceSense="article.pieceSense"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, reactive } from 'vue';
import api from '@/api/senseApi';
import PieceSenseCard from '@/components/Cards/\bPieceSenseCard.vue';

const page = reactive({
  list: [],
  totalCount: 0,
});
const isLoading = ref(true);
const errorMessage = ref('');
const pageRequest = reactive({
  page: 1,
  amount: 37,
});

const articles = computed(() => page.list);

// 자동 스크롤을 위한 ref
const scrollContainer = ref(null);

// 데이터 로드
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await api.getList({
      page: pageRequest.page,
      amount: pageRequest.amount,
    });

    console.log('게시글 목록:', response.list); // ✅ 리스트 출력
    console.log('총 게시글 수:', response.totalCount); // ✅ 총 게시글 수 출력

    page.list = response.list;
    page.totalCount = response.totalCount;
  } catch (error) {
    errorMessage.value = '게시글을 불러오는 데 실패했습니다.';
  } finally {
    isLoading.value = false;
  }
};

// 자동 스크롤 함수
const startAutoScroll = () => {
  setInterval(() => {
    if (scrollContainer.value) {
      // 부드럽게 스크롤하는 방식
      scrollContainer.value.scrollBy({ left: 310, behavior: 'smooth' });

      // 끝까지 스크롤하면 처음으로 다시 돌아가기
      if (
        scrollContainer.value.scrollLeft >=
        scrollContainer.value.scrollWidth - scrollContainer.value.clientWidth
      ) {
        scrollContainer.value.scrollTo({ left: 0, behavior: 'smooth' });
      }
    }
  }, 2000); // 3초마다 자동 스크롤
};

onMounted(() => {
  load();
  startAutoScroll(); // 자동 스크롤 시작
});
</script>

<style scoped>
/* 컨테이너 스타일 */
.scroll-container {
  display: flex;
  height: 100vh; /* 화면 전체 높이를 사용하여 중앙 정렬 */
  align-items: center; /* 세로 방향 중앙 정렬 */

  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none; /* Firefox에서 스크롤바 숨기기 */
  -ms-overflow-style: none; /* IE에서 스크롤바 숨기기 */
  background: transparent; /* 배경색 제거 */
  padding: 0; /* 패딩 제거 */
  border: none; /* 경계선 제거 */
}

.scroll-container::-webkit-scrollbar {
  display: none; /* Chrome, Safari에서 스크롤바 숨기기 */
}

.scroll-wrapper {
  display: flex;
  gap: 10;
  padding: 0;
  margin: 0;
  scroll-behavior: smooth;
  background: none; /* 배경색 없음 */
  box-shadow: none; /* 그림자 없음 */
}

.card {
  flex: 0 0 380px; /* 카드의 고정된 크기 */
  scroll-snap-align: start;
  background-color: transparent; /* 카드 배경을 투명하게 */
  border: none; /* 경계선 제거 */
  padding: 0;
  margin: 0;
  box-shadow: none !important; /* 그림자 제거 */
}
</style>
