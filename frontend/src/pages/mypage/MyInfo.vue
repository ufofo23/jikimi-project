<template>
  <div>
    <h2>회원정보</h2>
    <form @submit.prevent="updateUserInfo">
      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" v-model="userName" disabled />
      </div>
      <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="email" v-model="userEmail" disabled />
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
      <div class="form-group">
        <label for="birthday">생년월일</label>
        <input type="date" id="birthday" v-model="userBirthday" />
      </div>
      <div class="form-group">
        <label for="phone">전화번호</label>
        <input type="text" id="phone" v-model="userPhone" @input="formatPhoneNumber" placeholder="010-0000-0000" />
      </div>
      <button type="submit" class="update-btn">정보 업데이트</button>
    </form>

    <div class="delete-account">
      <p>탈퇴를 원하시는 경우, 회원 탈퇴 버튼을 눌러 주세요.</p>
      <button type="submit" class="delete-btn" @click="handleAccountDelete">회원 탈퇴하기</button>
    </div>
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
  if(!authStore.isAuthenticated){
    router.push('/login');
  }else{
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

.sidebar ul li a {
  text-decoration: none;
  font-size: 16px;
  color: #333;
  transition: color 0.3s;
}

.sidebar ul li a:hover {
  color: #007bff;
}

.sidebar ul li .info-btn {
  display: block;
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  text-align: left;
}

.sidebar ul li .info-btn.active {
  background-color: #0056b3;
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