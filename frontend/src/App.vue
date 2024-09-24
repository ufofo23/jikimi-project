<template>
  <Header>
    <!-- 고정 - 홈페이지 위에 있는 노란색 바 (퀵 챗 같은거도 만들어야함) -->
  </Header>

  <!-- 라우터 뷰로 컴포넌트 전환 -->
  <RouterView />

  <Footer> </Footer>

  <!-- Quick Chat 버튼 전역으로 추가 -->
  <QuickChat />
</template>

<script setup>
import { RouterLink, RouterView } from 'vue-router';
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
import QuickChat from './components/QuickChat.vue'; // QuickChat 컴포넌트 불러오기
</script>

<style scoped></style>
