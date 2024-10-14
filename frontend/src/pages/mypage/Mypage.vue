<template>
  <div class="mypage-container">
    <!-- Sidebar -->
    <div class="sidebar">
      <h2>{{ userName }}님</h2>
      <ul>
        <li>
          <router-link to="/mypage/myreport" exact-active-class="active-link">My Report</router-link>
        </li>
        <li>
          <router-link to="/mypage/myinfo" exact-active-class="active-link">회원 정보</router-link>
        </li>
      </ul>
      <button class="logout-btn" @click="handleLogout">로그아웃</button>
    </div>

    <!-- Main Content Section -->
    <div class="info-section">
      <router-view></router-view> <!-- 여기서 메인 컨텐츠가 동적으로 로드됩니다. -->
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
// 추가적인 변수들...

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
// Logout function
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
/* 메인 컨테이너 스타일 */
.mypage-container {
  display: flex;
  height: 100vh;
  padding: 20px;
  background-color: #f7f9fc;
}

/* 사이드바 스타일 */
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
}

.sidebar ul {
  list-style: none;
  padding: 0;
}

.sidebar ul li {
  margin-bottom: 10px;
}

/* 활성화된 링크 스타일 */
.active-link {
  background-color: #0066CC; /* 파란색 배경 */
  color: white; /* 텍스트 색상 변경 */
  border-radius: 5px; /* 모서리 둥글게 */
}

.sidebar ul li a {
  text-decoration: none;
  font-size: 16px;
  color: #333;
  display: block; /* 링크를 블록 요소로 설정하여 전체 영역 클릭 가능하게 */
  padding: 10px; /* 패딩 추가하여 클릭 영역 확대 */
  transition: background-color 0.3s, color 0.3s; /* 부드러운 효과 추가 */
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
}

/* 메인 정보 영역 스타일 */
.info-section {
  width: 80%;
  background-color: white;
  padding: 40px;
  border-radius: 10px;
  margin-left: 20px;
}

.info-section h2 {
  font-size: 22px;
  margin-bottom: 20px;
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

/* 라디오 버튼 스타일 */
.radio-group {
  display: flex;
  justify-content: space-around;
  align-items: center;
  width: 100%;
}

.radio-button input[type='radio'] {
  position: absolute;
  opacity: 0;
}

.radio {
  position: relative;
  display: inline-block;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  border: 2px solid #ccc;
  box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease-in-out;
}

.radio::before {
  position: absolute;
  content: '';
  width: 10px;
  height: 10px;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border-radius: 50%;
  background-color: #fff;
  opacity: 0;
  transition: all 0.3s ease-in-out;
}

.radio-button input[type='radio']:checked + .radio {
  border-color: #28a745;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(40, 167, 69, 0.6),
    0px 0px 20px rgba(40, 167, 69, 0.4);
  transition: box-shadow 0.3s ease-in-out;
}

.radio-button input[type='radio']:checked + .radio::before {
  background-color: #28a745;
  opacity: 1;
  box-shadow: 0px 0px 10px rgba(40, 167, 69, 0.8);
}

.delete-account {
  margin-top: 40px;
  text-align: right; /* 텍스트와 버튼을 오른쪽 정렬 */
}

.delete-btn {
  background-color: #dc3545;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  display: inline-block; /* 버튼을 오른쪽에 고정 */
}

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