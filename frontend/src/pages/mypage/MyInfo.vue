<template>
  <div>
    <h2>회원정보</h2>
    <form @submit.prevent="updateUserInfo" class="form">
      <div class="form-row">
        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" id="name" v-model="userName" disabled />
        </div>
        <div class="form-group">
          <label for="email">이메일</label>
          <input type="email" id="email" v-model="userEmail" disabled />
        </div>
      </div>

      <div class="form-group radio-button">
        <label>성별</label>
        <div class="radio-group">
          <div>
            <label class="radio-label">
              <input type="radio" id="female" value="0" v-model="userGender" />
              <span class="radio"></span> 여성
            </label>
          </div>
          <div>
            <label class="radio-label">
              <input type="radio" id="male" value="1" v-model="userGender" />
              <span class="radio"></span> 남성
            </label>
          </div>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="birthday">생년월일</label>
          <input type="date" id="birthday" v-model="userBirthday" />
        </div>
        <div class="form-group">
          <label for="phone">전화번호</label>
          <input
            type="text"
            id="phone"
            v-model="userPhone"
            @input="formatPhoneNumber"
            placeholder="010-0000-0000"
          />
        </div>
      </div>

      <div class="button-group">
        <button type="submit" class="update-btn">정보 업데이트</button>
        <button type="button" class="delete-btn" @click="handleAccountDelete">
          회원 탈퇴하기
        </button>
      </div>
    </form>
  </div>
</template>
<script setup>
// Import necessary functions
import useAuthStore from '@/stores/auth';
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import api from '@/api/authApi'; // API containing getInfo and updateInfo

// Router for navigation
const router = useRouter();
const authStore = useAuthStore();
const userName = ref('');
const userEmail = ref('');
const userGender = ref(''); // 성별 변수 추가
const userBirthday = ref(''); // 생일 변수 추가
const userPhone = ref(''); // 전화번호 변수 추가
const errorMessage = ref(''); // Error handling

// Load user information from API
const loadUserInfo = async () => {
  try {
    const userInfo = await api.getInfo();
    userName.value = userInfo.name;
    userEmail.value = userInfo.email;
    userGender.value = userInfo.gender;
    userBirthday.value = userInfo.birthday;
    userPhone.value = userInfo.mobileE164;
  } catch (error) {
    console.error('Failed to load user information:', error);
    errorMessage.value =
      '사용자 정보를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  }
};

// 전화번호 형식화 함수 (입력 시 호출)
const formatPhoneNumber = () => {
  let cleaned = userPhone.value.replace(/\D/g, ''); // 숫자만 남기기
  if (cleaned.length >= 7) {
    userPhone.value = `${cleaned.slice(0, 3)}-${cleaned.slice(
      3,
      7
    )}-${cleaned.slice(7)}`;
  } else if (cleaned.length >= 4) {
    userPhone.value = `${cleaned.slice(0, 3)}-${cleaned.slice(3)}`;
  }
};

// Update user information (PUT request)
const updateUserInfo = async () => {
  try {
    const updatedInfo = {
      name: userName.value,
      email: userEmail.value,
      gender: userGender.value, // 성별 필드 확인
      birthday: userBirthday.value, // 생일 필드 확인
      mobileE164: userPhone.value, // E.164 형식으로 전화번호 변환
    };

    // 전송할 데이터 로그 출력
    console.log('전송할 데이터:', updatedInfo);

    // 백엔드에 PUT 요청으로 정보 업데이트
    await api.updateInfo(updatedInfo);

    // 정보 업데이트 후 최신 데이터 다시 로드
    await loadUserInfo();

    await api.updateInfo(updatedInfo); // 데이터를 전송
    alert('정보가 성공적으로 업데이트되었습니다.');
  } catch (error) {
    console.error('Failed to update user information:', error);
    errorMessage.value =
      '정보를 업데이트하는 데 실패했습니다. 다시 시도해 주세요.';
  }
};

// Load user info on component mount
onMounted(async () => {
  await authStore.checkAuth();
  if (!authStore.isAuthenticated) {
    router.push('/login');
  } else {
    loadUserInfo();
  }
});

// Account deletion handler
const handleAccountDelete = async () => {
  try {
    await api.deleteAccount(); // Assume delete account API exists
    router.push('/login'); // Redirect to login page after deletion
  } catch (error) {
    console.error('회원 탈퇴 실패:', error);
    errorMessage.value = '회원 탈퇴에 실패했습니다. 다시 시도해 주세요.';
  }
};
</script>

<style scoped>
.mypage-container {
  display: flex;
  min-height: 100vh;
  padding: 40px;
  background-color: #f7f9fc;
  align-items: stretch;
  justify-content: center;
  margin: 0 auto;
}

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

.sidebar ul li a {
  text-decoration: none;
  font-size: 16px;

  display: block;
  padding: 10px;
  border-radius: 5px;
  transition: background-color 0.3s, color 0.3s;
}

.sidebar ul li a:hover {
  background-color: #1e32e8;
  color: white;
}

.sidebar ul li a.active-link {
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

.info-section {
  width: 60%;
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
  color: #1e32e8;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 10px;
  font-size: 16px;
  color: #1e32e8;
}

.form-group input {
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 16px;
}

/* 라디오 버튼 스타일 수정 */
.radio-group {
  display: flex;
  align-items: center;
  gap: 80px; /* 라디오 버튼 선택지 간 거리 조정 */
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
  border-color: #283ba7;
  background-color: #fff;

  transition: box-shadow 0.3s ease-in-out;
}

.radio-button input[type='radio']:checked + .radio::before {
  background-color: #2626e2;
  opacity: 1;
  box-shadow: 0px 0px 10px rgba(40, 167, 69, 0.8);
}
.button-group {
  display: flex;
  justify-content: flex-start; /* 버튼을 왼쪽으로 정렬 */
  gap: 20px;
  margin-top: 40px;
}
.delete-account {
  margin-top: 40px;
  text-align: right; /* 텍스트와 버튼을 오른쪽 정렬 */
}

.form {
  display: flex;
  flex-direction: column;
}

.form-row {
  display: flex;
  justify-content: space-between;
  gap: 20px;
}

.form-row .form-group {
  flex: 1;
}

.button-group {
  display: flex;
  justify-content: flex-end;
  gap: 20px;
  margin-top: 40px;
}

.update-btn {
  background-color: #4caf50;
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: background-color 0.3s ease;
}

.update-btn:hover {
  background-color: #45a049;
}

.delete-btn {
  background-color: #f44336;
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: background-color 0.3s ease;
}

.delete-btn:hover {
  background-color: #d32f2f;
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
