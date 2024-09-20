<template>
  <header class="header">
    <nav>
      <span><router-link :to="{ name: 'main' }">App Name</router-link></span>
      <ul>
        <li>
          <router-link :to="{ name: 'analyzing' }">Analyzing</router-link>
        </li>
        <li><router-link :to="{ name: 'map' }">Map</router-link></li>
        <li><router-link :to="{ name: 'study' }">Study</router-link></li>
        <li><router-link :to="{ name: 'faq' }">FAQ</router-link></li>
      </ul>
      <div v-if="!isLoggedIn">
        <router-link :to="{ name: 'login' }">Login</router-link>
        <router-link :to="{ name: 'signup' }">Join</router-link>
      </div>

      <div v-else>
        <router-link :to="{ name: 'logout' }">Logout</router-link>
        <router-link :to="{ name: 'mypage' }">MyPage</router-link>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { useRouter } from 'vue-router';
import { ref, onMounted } from 'vue';

const isLoggedIn = ref(false);

onMounted(() => {
  // 쿠키에서 JWT 토큰 확인하여 로그인 상태 설정
  isLoggedIn.value = document.cookie.split('; ').some((cookie) => cookie.startsWith('jwt='));
});

function logout() {
  // 쿠키에서 JWT 삭제 (여기서는 만료 시간을 과거로 설정)
  document.cookie = "jwt=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
  isLoggedIn.value = false; // 로그인 상태 변경
  router.push('/login'); // 로그인 페이지로 리디렉션
}

const router = useRouter();
</script>

<style scoped>
.header {
  position: fixed;
  top: 0;
  width: 100%;
  background-color: #fcd94d; /* 브랜드 색상 적용 */
  padding: 10px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
nav ul {
  list-style: none;
  display: flex;
  gap: 15px;
}
nav ul li {
  display: inline;
}
</style>
