<template>
  <!-- ====== Navbar Section Start -->
  <header class="navbar">
    <div class="container">
      <div class="navbar-content">
        <div class="logo">
          <!-- 로고 부분 유지 -->
          <router-link :to="{ name: 'main' }">
            <img src="@/assets/jikimi.png" alt="logo" class="dark:hidden" />
          </router-link>
        </div>

        <!-- 햄버거 메뉴 버튼 (모바일용) -->
        <button class="menu-toggle" @click="toggleNavbar">
          &#9776;
          <!-- 햄버거 메뉴 아이콘 -->
        </button>

        <nav :class="{ 'nav-open': isNavbarOpen }" class="nav-menu">
          <ul class="nav-list">
            <li>
              <router-link :to="{ name: 'map' }" class="nav-item"
                >Map</router-link
              >
            </li>
            <li class="dropdown">
              <router-link :to="{ name: 'study' }" class="nav-item"
                >Study</router-link
              >
              <ul class="dropdown-menu">
                <li>
                  <router-link
                    :to="{ path: '/study/commonsense/list' }"
                    class="dropdown-item"
                    >부동산 토막 상식</router-link
                  >
                </li>
                <li>
                  <router-link
                    :to="{ path: '/study/dictionary/list' }"
                    class="dropdown-item"
                    >부동산 용어 사전</router-link
                  >
                </li>
              </ul>
            </li>
            <li>
              <router-link :to="{ name: 'faq' }" class="nav-item"
                >FAQ</router-link
              >
            </li>
            <li>
              <router-link :to="{ name: 'introduce' }" class="nav-item"
                >About us</router-link
              >
            </li>
          </ul>

          <div class="auth-menu">
            <div v-if="!isAuthenticated">
              <router-link :to="{ name: 'login' }" class="auth-item"
                >Sign in</router-link
              >
            </div>
            <div v-else>
              <button @click="logout" class="auth-item">Logout</button>
              <router-link :to="{ name: 'mypage' }" class="auth-item"
                >MyPage</router-link
              >
            </div>
          </div>
        </nav>
      </div>
    </div>
  </header>
  <!-- ====== Navbar Section End -->

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

        <div class="clients">
          <h6 class="clients-title">Some Of Our Clients</h6>
          <div class="clients-logos">
            <a
              v-for="(client, index) in clients"
              :key="index"
              :href="client.link"
              class="client-logo"
            >
              <img :src="client.logo" :alt="client.name" />
            </a>
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
          지도를 통해 원하시는 지역의 시세를 확인하고, 등기부 등본 분석을 통해
          안전 진단 리포트를 제공해 드릴게요.
        </p>
      </div>
    </div>
  </div>
  <!-- ====== Hero Section End -->
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, ref, computed } from 'vue'; // 한 번에 ref, onMounted 가져오기
import { useRouter } from 'vue-router'; // Vue Router 사용
import useAuthStore from '@/stores/auth'; // 인증 스토어 가져오기

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
const isLoading = ref(true);
const errorMessage = ref('');

// API 호출 로직 (API 모듈 정의 필요)
const load = async () => {
  try {
    isLoading.value = true;
    // pieceSenseList.value = await senseApi.getSenseList(); // 실제 API 호출 부분
    isLoading.value = false;
  } catch (error) {
    errorMessage.value = '데이터 로드 중 오류 발생';
    isLoading.value = false;
  }
};

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

/* 네비게이션 바 스타일 */
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background-color: white;
  z-index: 1000;
}

.navbar-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
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
  margin-left: 1rem;
}

/* Hero 섹션 스타일 */
.hero-section {
  display: flex;
  min-height: 100vh;
  padding-top: 80px; /* 네비게이션 바 높이만큼 여백 */
}
.hero-compo {
  margin-left: 6rem;
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
}

.right-section {
  background-color: transparent;
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
}

.button-primary {
  background-color: #0066cc;
  color: white;
}

.right-button {
}

.button-secondary {
  border: 1px solid #0066cc;
  color: #0066cc;
}

.map-image {
  max-width: 100%;
  margin-bottom: 1rem;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
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
