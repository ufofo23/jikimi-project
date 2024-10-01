import { defineStore } from 'pinia';

export const useUserStore = defineStore('user', {
  state: () => ({
    userName: '',
    userEmail: '',
    isAuthenticated: false,
  }),
  actions: {
    setUser(user) {
      this.userName = user.name;
      this.userEmail = user.email;
      this.isAuthenticated = true;
    },
    logout() {
      this.userName = '';
      this.userEmail = '';
      this.isAuthenticated = false;
    },
  },
});
