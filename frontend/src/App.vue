<template>
  <Header />
  <RouterView />
  <Footer />
  <QuickChat />
</template>

<script>
import { onMounted } from 'vue';
import useAuthStore from '@/stores/auth'; // Pinia 스토어 import
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import QuickChat from '@/components/QuickChat.vue';

export default {
  components: {
    Header,
    Footer,
    QuickChat,
  },
  setup() {
    const authStore = useAuthStore();

    onMounted(() => {
      authStore.checkAuth(); // 컴포넌트가 마운트될 때 인증 상태를 체크
    });

    return {};
  },
};
</script>

<style scoped>
/* 필요에 따라 스타일 추가 */
</style>
