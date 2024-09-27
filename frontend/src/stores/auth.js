import { defineStore } from 'pinia';
import Cookies from 'js-cookie';
import axiosInstance from '@/axiosInstance';

const useAuthStore = defineStore('auth', {
  state: () => ({
    isAuthenticated: false,
    userId: null,
  }),
  actions: {
    async checkAuth() {
      try {
        const token = Cookies.get('jwtToken');
        if (!token) {
          throw new Error('No token found');
        }
        const response = await axiosInstance.get('/oauth/verify', {
          withCredentials: true,
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        this.isAuthenticated = response.data.isAuthenticated;
        this.userId = response.data.userId;
      } catch (error) {
        this.isAuthenticated = false;
        this.userId = null;
        if (error.response) {
          console.error("Authentication check failed:", error.response.data);
        } else {
          console.error("Authentication check failed:", error.message);
        }
      }
    },
  async logout() {
    try {
      await axiosInstance.post('/oauth/logout'); // 로그아웃 API 호출
      this.isAuthenticated = false; // 인증 상태 업데이트
      // 추가적인 상태 초기화
    } catch (error) {
      console.error('Logout failed:', error);
    }
  },
},
});

export default useAuthStore;
