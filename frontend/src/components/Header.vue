<template>
  <header class="header">
    <nav class="nav-bar">
      <span class="logo">
        <router-link :to="{ name: 'main' }">JIKIMI</router-link>
      </span>
      <ul class="menu">
        <li>
          <router-link :to="{ name: 'analyzing' }">Analyzing</router-link>
        </li>
        <li>
          <router-link :to="{ name: 'map' }">Map</router-link>
        </li>
        <li>
          <div class="dropdown">
            <router-link :to="{ name: 'study' }">Study</router-link>
            <ul class="dropdown-menu">
              <li>
                <router-link :to="{ path: '/study/commonsense/list' }">부동산 토막 상식</router-link>
              </li>
              <li>
                <router-link :to="{ path: '/study/dictionary/list' }">부동산 용어 사전</router-link>
              </li>
            </ul>
          </div>
        </li>
        <li>
          <router-link :to="{ name: 'faq' }">FAQ</router-link>
        </li>
        <li>
          <router-link :to="{ name: 'introduce' }">About us</router-link>
        </li>
      </ul>
      <div class="auth" v-if="!isAuthenticated">
        <router-link :to="{ name: 'login' }">Login</router-link>
      </div>

      <div class="auth" v-else>
        <button @click="logout" class="logout-link">Logout</button>
        <router-link :to="{ name: 'mypage' }">MyPage</router-link>
      </div>
    </nav>
  </header>
</template>

<script>
import { computed } from 'vue';
import useAuthStore from '@/stores/auth';

export default {
  setup() {
    const authStore = useAuthStore();
    const isAuthenticated = computed(() => authStore.isAuthenticated);

    const logout = () => {
      authStore.logout();
    };

    return {
      isAuthenticated,
      logout,
    };
  },
}
</script>

<style scoped>
/* 헤더 스타일 */
.header {
  position: sticky;
  top: 0;
  width: 100%;
  background-color: RGB(203, 236, 197); /* 브랜드 색상 */
  padding: 10px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  z-index: 1000; /* 헤더가 다른 요소들 위에 나타나도록 설정 */
}

/* 내비게이션 바 스타일 */
.nav-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto; /* 가운데 정렬 */
}

/* 로고 스타일 */
.logo {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.logo a {
  text-decoration: none;
  color: inherit;
}

/* 메뉴 스타일 */
.menu {
  list-style: none;
  display: flex;
  gap: 100px; /* 메뉴 간격을 30px로 설정 */
}

.menu li {
  display: inline;
}

.menu a {
  text-decoration: none;
  color: #333;
  font-size: 25px;
  font-weight: 500;
  transition: color 0.3s ease;
}

.menu a:hover {
  color: #ff6b6b; /* 호버 시 색상 변경 */
}

/* 드롭다운 메뉴 스타일 */
.dropdown {
  position: relative;
}

.dropdown-menu {
  display: none;
  position: absolute;
  background-color: white;
  padding: 10px;
  list-style: none;

  transform: translateX(-50%); /* 가로로 중앙 정렬 */
  min-width: 200px; /* 최소 너비 설정 */
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  z-index: 2000;
  opacity: 0;
  transition: opacity 0.3s ease, transform 0.3s ease; /* 부드러운 애니메이션 */
  transform: translateY(-10px); /* 초기 위치를 위로 */
  border-radius: 8px; /* 둥근 모서리 */
  text-align: center; /* 가운데 정렬 */
}

.dropdown:hover .dropdown-menu {
  display: block; /* 호버 시 드롭다운 메뉴 표시 */
  opacity: 1; /* 드롭다운 메뉴의 불투명도 설정 */
  transform: translateY(0) translateX(-32%); /* 드롭다운 애니메이션 초기화 */
}

.dropdown-menu li {
  padding: 10px 0; /* 상하 패딩을 추가하여 요소 간의 간격을 조정 */
  white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
}

.dropdown-menu li:hover {
  text-decoration-line: underline;
  font-weight: bold;
}


/* 가운데 정렬을 위해 추가 */
.dropdown-menu a {
  display: block; /* 블록 요소로 설정하여 전체 너비를 차지하도록 함 */
  text-decoration: none;
  color: #333;
  font-size: 18px;
  font-weight: 500;
  transition: color 0.3s ease;
}

.dropdown-menu a:hover {
  text-decoration-line: underline;
  font-weight: bold;
}

/* 로그인/회원가입 및 로그아웃/MyPage 스타일 */
.auth {
  display: flex;
  gap: 15px; /* 간격을 15px로 설정 */
}

.auth a {
  text-decoration: none;
  color: #333;
  font-weight: 500;
  transition: color 0.3s ease;
}

.auth a:hover {
  color: #ff6b6b;
}

/* 로그아웃 버튼을 링크처럼 스타일링 */
.logout-link {
  background: none;
  border: none;
  padding: 0;
  color: #333;
  font-weight: 550;
  font-size: 16px;
  cursor: pointer;
  text-decoration: none; /* 기본 링크처럼 보이도록 설정 */
  transition: color 0.3s ease;
}

.logout-link:hover {
  color: #ff6b6b; /* 호버 시 색상 변경 */
}
</style>
