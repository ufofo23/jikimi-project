<template>
  <!-- ====== Hero Section Start -->
  <div class="hero-section">
    <!-- 왼쪽 섹션 -->
    <div class="left-section">
      <div class="hero-compo">
        <div class="hero-content">
          <h1 class="hero-title">내 집은<br />안전할까?</h1>
        </div>

        <p class="hero-description">
          계약 진행 단계에 따라 반드시 필요한 <br />체크리스트와 발생 가능
          시나리오를 준비했어요. <br />지금 바로 확인해보세요!
        </p>
        <ul class="button-list">
          <li>
            <router-link :to="{ name: 'preventionList' }" class="button-primary"
              >계약이 처음이라면?</router-link
            >
          </li>
          <li>
            <router-link :to="{ name: 'ScenarioMain' }" class="button-secondary"
              >계약 진행/완료 상태라면!</router-link
            >
          </li>
        </ul>
        <div class="swiper">
          <div class="piece-sense-container">
            <div class="scroll-container" ref="scrollContainer">
              <div class="scroll-wrapper">
                <div
                  v-for="article in articles"
                  :key="article.commonSenseNo"
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
          </div>
        </div>
      </div>
    </div>

    <div class="right-section">
      <div class="map-container">
        <img src="@/assets/map.png" alt="hero" class="map-image" />
        <router-link :to="{ name: 'map' }" class="button-primary right-button"
          >안전 진단 받기</router-link
        >
        <p class="map-description">
          지도를 통해 원하시는 지역의 시세를 확인하고,<br />
          등기부 등본 분석을 통해 안전 진단 리포트를 제공해 드릴게요.
        </p>
      </div>
    </div>
  </div>
  <!-- ====== Hero Section End -->
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, ref, computed, reactive } from 'vue'; // 한 번에 ref, onMounted 가져오기
import { useRouter } from 'vue-router'; // Vue Router 사용
import useAuthStore from '@/stores/auth'; // 인증 스토어 가져오기
import api from '@/api/senseApi';
import PieceSenseCard from '@/components/Cards/PieceSenseCard.vue';

const open = ref(false);
const dropdownButtonRef = ref<HTMLButtonElement | null>(null);
const router = useRouter(); // 라우터 사용
const isNavbarOpen = ref(false); // 햄버거 메뉴 열림 상태
const isDropdownOpen = ref(false); // 드롭다운 열림 상태

const toggleNavbar = () => {
  isNavbarOpen.value = !isNavbarOpen.value;
};
// 외부 클릭 감지
const handleClickOutside = (event: MouseEvent) => {
  if (
    dropdownButtonRef.value &&
    !dropdownButtonRef.value.contains(event.target as Node)
  ) {
    open.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

// 상태 관리: 인증 여부
const authStore = useAuthStore();
const isAuthenticated = computed(() => authStore.isAuthenticated);

// 로그아웃 기능
const logout = () => {
  authStore.logout();
};

// 클라이언트 로고 정보
const clients = ref([]);

// senseApi를 통해 데이터를 로드할 함수 (API 정의 필요)
const pieceSenseList = ref([]); // API에서 받은 데이터를 저장할 곳

// 상세 페이지로 이동하는 함수
const detail = (no: number) => {
  router.push({
    name: 'senseDetailPage',
    params: { no: no },
  });
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});

//  <!-- ====== common Section  -->

const scrollContainer = ref(null);
let scrollInterval: number | null = null;

const page = reactive({
  list: [],
  totalCount: 0,
});
const isLoading = ref(true);
const errorMessage = ref('');
const pageRequest = reactive({
  page: 1,
  amount: 100, // 표시할 카드 수 조정
});

const articles = computed(() => page.list);

// 데이터 로드
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

// 자동 스크롤 함수
const startAutoScroll = () => {
  if (scrollInterval) return;

  scrollInterval = setInterval(() => {
    if (scrollContainer.value) {
      const container = scrollContainer.value;
      const cardWidth = container.querySelector('.card')?.offsetWidth || 0;

      if (
        container.scrollLeft >=
        container.scrollWidth - container.clientWidth
      ) {
        // 끝에 도달하면 처음으로 돌아감
        container.scrollTo({ left: 0, behavior: 'smooth' });
      } else {
        // 다음 카드로 스크롤
        container.scrollBy({ left: cardWidth, behavior: 'smooth' });
      }
    }
  }, 3000); // 3초마다 스크롤
};

const stopAutoScroll = () => {
  if (scrollInterval) {
    clearInterval(scrollInterval);
    scrollInterval = null;
  }
};

onMounted(() => {
  load();
  startAutoScroll();
});

onUnmounted(() => {
  stopAutoScroll();
});
</script>

<style scoped>
/* 네비게이션 바의 선 제거 */
.container,
.flex,
.header,
nav,
ul,
li,
div,
a {
  border: none !important;
}

/* 버튼 등의 추가적인 요소들에 대한 선 제거 */
button,
.block,
.py-3,
.px-7,
.px-4,
.rounded-md,
.bg-primary {
  border: none !important;
}

/* 기타 가능한 요소들에 대한 선 제거 */
.hero-content,
.clients,
.bg-white,
.bg-gray-100 {
  border: none !important;
}

/* 텍스트와 이미지의 경계에도 선 제거 */
.text-dark,
.text-body-color,
img {
  border: none !important;
}

/* 불필요한 하단의 border 관련된 다른 클래스 제거 */
.lg:px-12,
.lg:pr-0,
.rounded-md {
  border: none !important;
}
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
/* 메뉴 토글 버튼 (모바일용) */
.menu-toggle {
  display: none;
  font-size: 24px;
  cursor: pointer;
  background: none;
  border: none;
}

/* 기본 스타일 */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.map-container {
  display: flex; /* Flexbox 사용 */
  flex-direction: column; /* 수직 방향 정렬 */
  align-items: center; /* 수평 중앙 정렬 */
  justify-content: center; /* 수직 중앙 정렬 */
  height: 100%; /* 컨테이너의 높이를 100%로 설정 */
  text-align: center; /* 텍스트를 가운데 정렬 */
}

/* 토막 바 스타일 */

.piece-sense-title {
  font-size: 1.2rem;
  font-weight: bold;
  margin-bottom: 1rem;
}

.scroll-container {
  width: 100%;
  overflow-x: hidden;
  overflow-y: visible; /* 수직 방향으로 카드가 잘리지 않도록 설정 */

  position: relative;
}

.scroll-wrapper {
  display: flex;
  animation: scroll 20s linear infinite; /* 20초 동안 부드럽게 스크롤, 반복 */
}

/* 애니메이션 정의 */
@keyframes scroll {
  0% {
    transform: translateX(0); /* 시작 위치 */
  }
  100% {
    transform: translateX(-100%); /* 끝 위치 */
  }
}

.card {
  flex: 0 0 380px; /* 카드의 고정된 크기 */
  scroll-snap-align: start;
  background-color: transparent; /* 카드 배경을 투명하게 */
  border: none; /* 경계선 제거 */
  padding: 0;
  margin: 0;
  box-shadow: none !important; /* 그림자 제거 */
  min-height: 100%; /* 카드의 최소 높이를 설정해 부모 요소에 맞도록 설정 */

  /* flex: 0 0 auto; /* 카드가 한 줄로 수평 정렬되도록 설정 */
  /* max-width: 380px; 카드의 최대 너비 */
}

/* 네비게이션 바 스타일 */

.logo {
  flex-grow: 1;
}

.space {
  flex-grow: 5;
}
.container {
  width: 100%;
}
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%; /* 화면 너비 전체 */
  background-color: white;
  z-index: 1000;
}

.navbar-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  width: 1600px;
}

.logo img {
  height: 40px;
}

.menu-toggle {
  display: none;
}

.nav-menu {
  display: flex;
  align-items: center;
  flex-grow: 10;
}

.nav-list {
  display: flex;
  list-style: none;
}

.nav-item {
  margin: 0 1rem;
  color: #333;
  text-decoration: none;
}

.auth-menu {
  justify-content: flex-end; /* 우측 정렬 */

  display: flex;
  align-items: center;
  text-align: right;
  margin-left: auto; /* 우측으로 밀기 */
  flex-grow: 1;
}

.auth-item {
  padding: 10px 20px;
  border-radius: 5px;
  text-decoration: none;
  color: #333;
  justify-content: space-between;
}

/* Hero 섹션 스타일 */
.hero-section {
  display: flex;
  min-height: 100vh;

  padding-top: 0; /* 헤더 높이 + 여백 */
  padding-bottom: 20px; /* 하단에 약간의 여백 추가 */
}
.hero-compo {
  margin-left: 6rem;
}
.piece-sense-container {
  margin-top: 2rem;
  width: 100%;
}

.swiper {
  margin-left: 0;
}
.left-section,
.right-section {
  flex: 1;
  padding: 2rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.left-section {
  background-color: #f5f7fb; /* 밝은 회색 배경 추가 */
  border-bottom-right-radius: 80px; /* 우측 하단 모서리 둥글게 */
  width: 50%; /* 전체 화면의 50% */
  overflow: hidden; /* 내부 요소가 섹션을 넘지 않도록 설정 */
}

.right-section {
  background-color: transparent;
  display: flex;
  justify-content: center; /* 가로 중앙 정렬 */
  align-items: center; /* 세로 중앙 정렬 */
  flex-direction: column; /* 요소들을 세로로 쌓음 */
  text-align: center; /* 텍스트 중앙 정렬 */
}

.hero-title {
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

.hero-description {
  margin-bottom: 2rem;
}

.button-list {
  list-style: none;
  display: flex;
  gap: 1rem;
}

.button-primary,
.button-secondary {
  padding: 0.75rem 1.5rem;
  border-radius: 0.375rem;
  text-decoration: none;
  display: inline-block;
  margin-bottom: 2rem; /* 버튼 아래에 여백 추가 */
  margin-top: 2rem; /* 버튼 아래에 여백 추가 */
}

.button-secondary {
  border: 2px solid #0066cc; /* 테두리 두께와 색상 설정 */
  color: #0066cc; /* 글자 색상 설정 */
  background-color: white; /* 배경색을 투명하게 설정 */
  padding: 0.75rem 1.5rem; /* 패딩 추가 */
  border-radius: 0.375rem; /* 모서리를 둥글게 설정 */
  text-decoration: none; /* 링크의 기본 밑줄 제거 */
  display: inline-block; /* 버튼처럼 보이도록 블록 설정 */
  transition: background-color 0.3s ease, color 0.3s ease; /* 배경과 텍스트 색상 전환 효과 */
}

.button-secondary:hover {
  background-color: #0066cc; /* 마우스를 올렸을 때 배경색 변경 */
  color: white; /* 마우스를 올렸을 때 텍스트 색상 변경 */
}

.button-primary {
  background-color: #0066cc;
  color: white;
}

.right-button {
  justify-content: center;
}

.button-secondary {
  border: 1px solid #0066cc;
  color: #0066cc;
}

.map-image {
  max-width: 80%;
  margin-bottom: 1rem;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
  .card {
    max-width: 100%; /* 모바일에서는 카드 너비를 100%로 */
  }
  .menu-toggle {
    display: block;
  }

  .nav-menu {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    background-color: white;
    padding: 1rem;
  }

  .nav-menu.nav-open {
    display: flex;
  }

  .nav-list {
    flex-direction: column;
  }

  .nav-item {
    margin: 0.5rem 0;
  }

  .hero-section {
    flex-direction: column;
  }

  .left-section,
  .right-section {
    padding: 1rem;
    width: 100%; /* 작은 화면에서는 각각 100% 차지 */
  }
  .card {
    max-width: 100%; /* 카드도 섹션을 넘어가지 않도록 설정 */
  }
  .button-list {
    flex-direction: column;
  }

  .button-primary,
  .button-secondary {
    width: 100%;
    text-align: center;
  }
}
</style>
