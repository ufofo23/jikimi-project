<template>
  <div class="carousel-wrapper mt-4">
    <!-- 캐러셀 컴포넌트 -->
    <el-carousel
      :interval="7000"
      :autoplay="false"
      height="400px"
      arrow="always"
      type="card"
      :animation="false"
    >
      <!-- 게시글을 순회하여 각 게시글을 캐러셀 아이템으로 보여주기 -->
      <el-carousel-item
        v-for="article in articles"
        :key="article.commonSenseNo"
      >
        <CardCommonSense
          :commonSenseTitle="article.commonSenseTitle"
          :commonSenseNo="article.commonSenseNo"
          :commonSenseContent="article.commonSenseContent"
          :commonPieceSense="article.pieceSense"
        />
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, reactive } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import api from '@/api/senseApi'; // API 모듈

// CardCommonSense 컴포넌트 import
import CardCommonSense from '@/components/Cards/CardCommonSense.vue';

// 게시글 목록 상태 관리
const page = reactive({
  list: [],
  totalCount: 0,
});
const isLoading = ref(true);
const errorMessage = ref('');
const route = useRoute();
const router = useRouter();
// 페이지 요청 상태
const pageRequest = reactive({
  page: parseInt(route.query.page) || 1,
  amount: parseInt(route.query.amount) || 37,
});

// 게시글 목록 계산 속성
const articles = computed(() => page.list);

// 게시글 상세 보기 함수
const detail = (no) => {
  router.push({
    name: 'senseDetailPage',
    params: { no: no },
    query: router.query,
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
    errorMessage.value = '게시글을 불러오는 데 실패했습니다.';
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
.carousel-wrapper {
  max-width: 800px;
  margin: 0 auto;
}
</style>
