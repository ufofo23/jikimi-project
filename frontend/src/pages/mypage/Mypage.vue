<template>
  <div class="mypage-container">
    <!-- Sidebar -->
    <div class="sidebar">
      <h2>{{ userName }}님</h2>
      <ul>
        <li>
          <router-link to="/mypage/myreport" exact-active-class="active-link"
            >My Report</router-link
          >
        </li>
        <li>
          <router-link to="/mypage/myinfo" exact-active-class="active-link"
            >회원 정보</router-link
          >
        </li>
      </ul>
      <button class="logout-btn" @click="handleLogout">로그아웃</button>
    </div>

    <!-- Main Content Section -->
    <div class="info-section">
      <router-view></router-view>
      <!-- 여기서 메인 컨텐츠가 동적으로 로드됩니다. -->
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import useAuthStore from '@/stores/auth';
import api from '@/api/authApi';

const router = useRouter();
const authStore = useAuthStore();
const userName = ref('');
const errorMessage = ref('');

// 사용자 정보를 불러오는 함수
const loadUserInfo = async () => {
  try {
    const userInfo = await api.getInfo();
    userName.value = userInfo.name;
  } catch (error) {
    console.error('Failed to load user information:', error);
    errorMessage.value =
      '사용자 정보를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  }
};

// 로그아웃 함수
const handleLogout = async () => {
  try {
    authStore.logout();
    router.push('/login');
  } catch (error) {
    console.error('Failed to logout:', error);
    errorMessage.value = '로그아웃에 실패했습니다. 다시 시도해 주세요.';
  }
};

onMounted(async () => {
  await authStore.checkAuth();
  if (!authStore.isAuthenticated) {
    router.push('/login');
  } else {
    loadUserInfo();
  }
});
</script>

<style scoped>
/* 메인 컨테이너 */
.mypage-container {
  display: flex;
  min-height: 100vh;
  padding: 40px; /* 좌우 여백 추가 */
  background-color: #f7f9fc;
  align-items: stretch;
  justify-content: center; /* 가운데 정렬 */
  margin: 0 auto; /* 페이지 가운데 정렬 */
}

/* 사이드바 */
.sidebar {
  width: 20%;
  background-color: #f0f4f8;
  padding: 20px;
  border-radius: 10px;
  text-align: left;
}

.sidebar h2 {
  font-size: 22px;
  font-weight: bold;
  margin-bottom: 20px;
  color: #030f1d;
}

.sidebar ul {
  list-style: none;
  padding: 0;
}

.sidebar ul li {
  margin-bottom: 10px;
}

.active-link {
  background-color: #1e32e8; /* 클릭 시 파란색 */
  color: white !important; /* 클릭 시 흰색 텍스트 */
  border-radius: 5px;
}

.sidebar ul li a {
  text-decoration: none;
  font-size: 16px;
  color: #000000;
  display: block;
  padding: 10px;
  transition: background-color 0.3s, color 0.3s;
}

.sidebar ul li a:hover {
  background-color: #1e32e8;
  color: white;
}

.logout-btn {
  margin-top: 20px;
  padding: 10px;
  width: 100%;
  background-color: #f8f9fa;
  border: 1px solid #ddd;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  color: #030f1d;
}

/* 정보 섹션 */
.info-section {
  width: 60%; /* 페이지를 가운데로 몰기 위해 */
  background-color: white;
  padding: 40px;
  border-radius: 10px;
  margin-left: 20px;
}

.info-section h2 {
  font-size: 24px; /* 제목 크기 증가 */
  margin-bottom: 20px;
  color: #1e32e8; /* 파란색으로 변경 */
}

.info-section p {
  margin-bottom: 30px;
  color: #6c757d;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 10px;
  font-size: 16px;
  color: #333;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 16px;
}

/* 라디오 버튼 그룹 */
.radio-group {
  display: flex;
}

.radio-button {
  display: flex;
}

.radio-button input[type='radio'] {
  margin-right: 5px;
}

/* 버튼 스타일 */
.update-btn {
  background-color: #1e32e8; /* 지정된 색상으로 변경 */
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  margin-top: 20px;
}

.delete-account {
  margin-top: 40px;
  text-align: right;
}

.delete-btn {
  background-color: #dc3545;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
  .mypage-container {
    flex-direction: column;
  }

  .sidebar {
    width: 100%;
    margin-bottom: 20px;
  }

  .info-section {
    width: 100%;
    margin-left: 0;
  }
}
</style>
