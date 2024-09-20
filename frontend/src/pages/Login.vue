<template>
  <div class="login-container">
    <button @click="handleNaverLogin" class="login-button">
      <img src="@/assets/naver.png" alt="Naver Login" class="naver-logo" />
    </button>
    <button @click="handleGoogleLogin" class="login-button">
      <img src="@/assets/google.png" alt="Google Login" class="google-logo" />
    </button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'login',
  methods: {
    // handleKakaoLogin() {
    //   window.location.href = 'http://localhost:8080/oauth/KAKAO';
    // },
    handleNaverLogin() {
      window.location.href = 'http://localhost:8080/oauth/NAVER';
    },
    handleGoogleLogin() {
      window.location.href = 'http://localhost:8080/oauth/GOOGLE';
    },
    async fetchToken(code, provider) {
      try {
        // 인증 서버에서 JWT 쿠키를 설정
        const response = await axios.get(`/oauth/login/${provider}?code=${code}`, {
          withCredentials: true // 쿠키를 클라이언트에 저장
        });
        return response.data;
      } catch (error) {
        console.error("Login failed", error);
        throw error;
      }
    },
    async handleRedirect() {
      const urlParams = new URLSearchParams(window.location.search);
      const code = urlParams.get('code');
      const provider = urlParams.get('provider');
      if (code && provider) {
        await this.fetchToken(code, provider);
        this.$router.push("/");
      }
    }
  },
  mounted() {
    this.handleRedirect();
  }
};
</script>

<style scoped>
.google-logo {
  width: 55px;
  height: 55px;
}

.naver-logo {
  width: 55px;
  height: 55px;
}

.login-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
.login-button {
  padding: 10px 20px;
  font-size: 18px;
  border-radius: 5px;
  cursor: pointer;
  margin: 10px;
}

.page-container {
  display: flex;
  flex-direction: column; /* 수직 정렬 */
  align-items: center; /* 수평 중앙 정렬 */

  height: 100vh; /* 뷰포트 전체 높이 */
  text-align: center;
}

.social-login-container {
  display: flex;
  justify-content: center; /* 가운데 정렬 */
  gap: 10px; /* 요소 간의 간격 */
  margin-top: 50px;
}

@media (max-width: 600px) {
  .social-login-container {
    flex-direction: column; /* 화면이 좁을 때 세로로 정렬 */
    gap: 20px; /* 세로 간격 증가 */
  }

  .page-container {
    padding: 20px; /* 모바일에서 여백 추가 */
  }
}
</style>
