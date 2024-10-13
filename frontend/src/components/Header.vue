<!-- ====== Navbar Section Start -->
<template>
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
          <div class="space">
            <ul class="nav-list">
              <li>
                <router-link :to="{ name: 'map' }" class="nav-item"
                  >Map</router-link
                >
              </li>

              <li class="dropdown">
                <div class="nav-item">Study</div>
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
          </div>
          <div class="auth-menu">
            <div v-if="!isAuthenticated">
              <router-link
                :to="{ name: 'login' }"
                class="auth-item button-border"
                >Sign in</router-link
              >
            </div>
            <div v-else>
              <button @click="logout" class="auth-item button-border">
                Logout
              </button>
              <router-link :to="{ name: 'mypage' }" class="auth-item"
                >MyPage</router-link
              >
            </div>
          </div>
        </nav>
      </div>
    </div>
  </header>
</template>
<!-- ====== Navbar Section End -->

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
  router.push('/login'); 
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

/* 드롭다운이 포함된 li에 position: relative 추가 */
.dropdown {
  position: relative;
}

/* 드롭다운 메뉴 기본 상태는 숨김 */
.dropdown-menu {
  display: none;
  position: absolute;
  top: 100%; /* 부모 요소 바로 아래에 배치 */
  left: 0;
  background-color: white;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  padding: 1rem;
  z-index: 1000;
  list-style: none;
  margin: 0;
}

/* 드롭다운 메뉴 아이템 */
.dropdown-item {
  padding: 0.5rem 1rem;
  text-decoration: none;
  color: #333;
  display: block;
}

.dropdown-item:hover {
  background-color: #f0f0f0;
}

/* 호버 시 드롭다운 메뉴 보이도록 설정 */
.dropdown:hover .dropdown-menu {
  display: block;
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
  position: sticky;
  top: 0;
  left: 0;
  width: 100%; /* 화면 너비 전체 */
  background-color: white;
  z-index: 10000;
  height: 180px;
  border-bottom: 1px solid #ccc; /* 아래쪽 보더라인 추가 */
}

.navbar-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  width: 1600px;
}

.logo img {
  height: full;
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
  font-size: 30px;
}

.button-border {
  padding: 0.75rem 1.5rem;
  border: 2px solid #0066cc;
  border-radius: 0.375rem;
  text-decoration: none;
  color: #333;
  background-color: white;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.nav-item:hover,
.auth-item:hover {
  color: #0066cc; /* 파랑색으로 색상 변환 */
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
  min-height: 1000vh;
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
