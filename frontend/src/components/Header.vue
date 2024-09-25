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
          <router-link :to="{ name: 'study' }">Study</router-link>
        </li>
        <li>
          <router-link :to="{ name: 'faq' }">FAQ</router-link>
        </li>
        <li>
          <router-link :to="{ name: 'introduce' }">About us</router-link>
        </li>
      </ul>
      <div class="auth" v-if="!isLoggedIn">
        <router-link :to="{ name: 'login' }">Login</router-link>
      </div>

      <div class="auth" v-else>
        <router-link :to="{ name: 'logout' }" @click="logout"
          >Logout</router-link
        >
        <router-link :to="{ name: 'mypage' }">MyPage</router-link>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { useRouter } from 'vue-router';
import { ref, onMounted } from 'vue';

const isLoggedIn = ref(false);
const router = useRouter();

onMounted(() => {
  // 쿠키에서 JWT 토큰 확인하여 로그인 상태 설정
  isLoggedIn.value = document.cookie
    .split('; ')
    .some((cookie) => cookie.startsWith('jwt='));
});

function logout() {
  // 쿠키에서 JWT 삭제 (여기서는 만료 시간을 과거로 설정)
  document.cookie = 'jwt=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
  isLoggedIn.value = false; // 로그인 상태 변경
  router.push({ name: 'login' }); // 로그인 페이지로 리디렉션
}
</script>

<style scoped>
/* 헤더 스타일 */
.header {
  position: flex;
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
</style>
