<template>
  <header class="header">
    <div class="container">
      <div class="header-content">
        <div class="logo">
          <router-link :to="{ name: 'main' }">
            <img src="@/assets/jikimi.png" alt="logo" />
          </router-link>
        </div>
        <nav class="main-nav">
          <ul class="nav-list">
            <li>
              <router-link :to="{ name: 'map' }" class="nav-item">Map</router-link>
            </li>
            <li class="dropdown">
              <button class="nav-item dropdown-toggle" @click="toggleDropdown" aria-haspopup="true" :aria-expanded="isDropdownOpen">
                Study
              </button>
              <ul class="dropdown-menu" v-if="isDropdownOpen" @click.stop>
                <li>
                  <router-link :to="{ path: '/study/commonsense/list' }" class="dropdown-item">
                    부동산 토막 상식
                  </router-link>
                </li>
                <li>
                  <router-link :to="{ path: '/study/dictionary/list' }" class="dropdown-item">
                    부동산 용어 사전
                  </router-link>
                </li>
              </ul>
            </li>
            <li>
              <router-link :to="{ name: 'faq' }" class="nav-item">FAQ</router-link>
            </li>
            <li>
              <router-link :to="{ name: 'introduce' }" class="nav-item">About us</router-link>
            </li>
          </ul>
        </nav>
        <div class="auth-nav">
          <ul class="nav-list">
            <li v-if="isAuthenticated">
              <router-link :to="{ name: 'mypage' }" class="nav-item">MyPage</router-link>
            </li>
            <li v-if="isAuthenticated">
              <a @click.prevent="logout" class="nav-item">Logout</a>
            </li>
            <li v-else>
              <router-link :to="{ name: 'login' }" class="nav-item">Sign in</router-link>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { useRouter } from 'vue-router';
import useAuthStore from '@/stores/auth';

const router = useRouter();
const authStore = useAuthStore();

const isDropdownOpen = ref(false);

const isAuthenticated = computed(() => authStore.isAuthenticated);

const toggleDropdown = () => {
  isDropdownOpen.value = !isDropdownOpen.value;
};

const logout = () => {
  authStore.logout();
  router.push('/login');
};

const closeDropdown = (event: MouseEvent) => {
  if (isDropdownOpen.value && event.target instanceof Element) {
    if (!event.target.closest('.dropdown')) {
      isDropdownOpen.value = false;
    }
  }
};

onMounted(() => {
  document.addEventListener('click', closeDropdown);
});

onUnmounted(() => {
  document.removeEventListener('click', closeDropdown);
});
</script>

<style scoped>
.header {
  position: sticky;
  top: 0;
  left: 0;
  width: 100%;
  background-color: #ffffff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  height: 180px;
}

.container {
  max-width: 1600px;
  margin: 0 auto;
  padding: 0 20px;
  height: 100%;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100%;
}

.logo {
  margin-right: auto;
}

.logo img {
  height: auto;
  max-height: 160px;
  width: auto;
}

/* 메인 4뭉치 */
.main-nav {
  margin-right: 25%;
}

/* login logout 뭉치 */
.auth-nav {
  margin-left: auto;
}

.nav-list {
  display: flex;
  list-style-type: none;
  margin: 0;
  padding: 0;
  height: 100%;
  align-items: center;
}

.nav-item, .dropdown-toggle {
  color: #333333;
  text-decoration: none;
  font-size: 25px;
  font-weight: 500;
  padding: 0 20px;
  transition: color 0.3s ease;
  height: 100%;
  display: flex;
  align-items: center;
  background: none;
  border: none;
  cursor: pointer;
}

.nav-item:hover,
.nav-item:focus,
.router-link-active,
.dropdown-toggle:hover,
.dropdown-toggle:focus {
  color: #0066cc;
}

.dropdown {
  position: relative;
  height: 100%;
}

.dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  background-color: #ffffff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  border-radius: 4px;
  padding: 10px 0;
  min-width: 200px;
  z-index: 1000;
  display: block;
}

.dropdown-item {
  display: block;
  padding: 10px 20px;
  color: #333333;
  text-decoration: none;
  transition: background-color 0.3s ease;
  font-size: 16px;
}

.dropdown-item:hover {
  background-color: #f8f9fa;
}

@media (max-width: 1024px) {
  .header {
    height: 120px;
  }

  .logo img {
    max-height: 100px;
  }

  .nav-item, .dropdown-toggle {
    font-size: 24px;
    padding: 0 15px;
  }
}

@media (max-width: 768px) {
  .header {
    height: auto;
    min-height: 80px;
  }

  .logo img {
    max-height: 60px;
  }

  .header-content {
    flex-direction: column;
    align-items: flex-start;
  }

  .logo, .main-nav, .auth-nav {
    width: 100%;
    margin: 0;
  }

  .main-nav, .auth-nav {
    display: block;
  }

  .nav-list {
    flex-direction: column;
    height: auto;
  }

  .nav-item, .dropdown-toggle {
    padding: 15px 0;
    font-size: 20px;
    height: auto;
  }

  .dropdown {
    height: auto;
  }

  .dropdown-menu {
    position: static;
    box-shadow: none;
    padding-left: 20px;
  }

  .dropdown-item {
    font-size: 18px;
  }
}
</style>