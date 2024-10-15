<template>
  <section
    class="relative z-20 overflow-hidden bg-white dark:bg-dark pt-20 pb-12 lg:pt-[120px] lg:pb-[90px]"
  >
    <div class="container mx-auto">
      <div class="-mx-4 flex flex-wrap">
        <div class="w-full px-4">
          <div class="mx-auto mb-[60px] max-w-[520px] text-center lg:mb-20">
            <h2
              class="mb-4 text-3xl font-bold text-primary dark:text-white sm:text-[40px] sm:leading-[48px]"
            >
              FAQ
            </h2>
            <p class="text-base text-xl text-body-color dark:text-dark-6">
              자주 묻는 질문을 통해 궁금증을 빠르게 해결하세요!
            </p>
          </div>
        </div>
      </div>

      <div class="-mx-4 flex flex-wrap">
        <div class="w-full px-4 lg:w-1/2">
          <template v-for="article in oddArticles" :key="article.faqNo">
            <div
              class="mb-8 w-full rounded-lg bg-white p-4 shadow-[0px_20px_95px_0px_rgba(201,203,204,0.30)] dark:bg-dark-2 dark:shadow-[0px_20px_95px_0px_rgba(0,0,0,0.30)] sm:p-8 lg:px-6 xl:px-8"
            >
              <button
                class="faq-btn flex w-full text-left"
                @click="handleToggle(article.faqNo)"
              >
                <div
                  class="mr-5 flex h-10 w-full max-w-[40px] items-center justify-center rounded-lg bg-primary/5 text-primary dark:bg-white/5"
                >
                  <svg
                    class="fill-primary stroke-primary duration-200 ease-in-out"
                    :class="{ 'rotate-180': activeFaq === article.faqNo }"
                    width="17"
                    height="10"
                    viewBox="0 0 17 10"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                      fill=""
                      stroke=""
                    />
                  </svg>
                </div>

                <div class="w-full">
                  <h4
                    class="mt-1 text-lg font-semibold text-dark dark:text-white"
                  >
                    {{ article.faqQuestion }}
                  </h4>
                </div>
              </button>

              <div v-show="activeFaq === article.faqNo" class="pl-[62px]">
                <p
                  class="py-3 text-base leading-relaxed text-body-color dark:text-dark-6 text-left"
                >
                  {{ article.faqAnswer }}
                </p>
              </div>
            </div>
          </template>
        </div>

        <div class="w-full px-4 lg:w-1/2">
          <template v-for="article in evenArticles" :key="article.faqNo">
            <div
              class="mb-8 w-full rounded-lg bg-white p-4 shadow-[0px_20px_95px_0px_rgba(201,203,204,0.30)] dark:bg-dark-2 dark:shadow-[0px_20px_95px_0px_rgba(0,0,0,0.30)] sm:p-8 lg:px-6 xl:px-8"
            >
              <button
                class="faq-btn flex w-full text-left"
                @click="handleToggle(article.faqNo)"
              >
                <div
                  class="mr-5 flex h-10 w-full max-w-[40px] items-center justify-center rounded-lg bg-primary/5 text-primary dark:bg-white/5"
                >
                  <svg
                    class="fill-primary stroke-primary duration-200 ease-in-out"
                    :class="{ 'rotate-180': activeFaq === article.faqNo }"
                    width="17"
                    height="10"
                    viewBox="0 0 17 10"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                      fill=""
                      stroke=""
                    />
                  </svg>
                </div>

                <div class="w-full">
                  <h4
                    class="mt-1 text-lg font-semibold text-dark dark:text-white"
                  >
                    {{ article.faqQuestion }}
                  </h4>
                </div>
              </button>

              <div v-show="activeFaq === article.faqNo" class="pl-[62px]">
                <p
                  class="py-3 text-base leading-relaxed text-body-color dark:text-dark-6 text-left"
                >
                  {{ article.faqAnswer }}
                </p>
              </div>
            </div>
          </template>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import api from '@/api/faqApi'; // API 모듈

// 상태 관리
const page = ref({
  list: [],
  totalCount: 0,
});
const isLoading = ref(true);
const errorMessage = ref('');

// 페이지 요청 정보
const pageRequest = ref({
  page: 1,
  amount: 10,
});

// 게시글 목록 계산 속성
const articles = computed(() => page.value.list);

// 홀수와 짝수 번호의 게시글을 분리
const oddArticles = computed(() =>
  articles.value.filter((article, index) => index % 2 === 0)
);
const evenArticles = computed(() =>
  articles.value.filter((article, index) => index % 2 !== 0)
);

// 상세 보기 토글을 위한 변수 (단일 섹션만 열림)
const activeFaq = ref(null);

// 토글 함수 (단일 섹션만 열림)
const handleToggle = (faqNo) => {
  activeFaq.value = activeFaq.value === faqNo ? null : faqNo;
};

// 데이터 로드 함수
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await api.getList(pageRequest.value);
    page.value = response;
    console.log('게시글 목록:', page.value);
  } catch (error) {
    console.error('게시글 로드 실패:', error);
    errorMessage.value =
      '게시글을 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});
</script>

<style>
/* 스타일은 이전과 동일하게 유지합니다. */
.text-base {
  font-size: 28px; /* 설명 텍스트의 글씨 크기를 28px로 키웠습니다. */
}

/* 버튼을 둘러싼 동그라미 스타일 */
.faq-btn .mr-5 {
  background-color: #e7f3ff;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
