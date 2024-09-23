<!-- 싱글페이지(SPA): 페이지를 하나만 만들고 컴포넌트를 갈아끼우는 형식 -->

<script setup>
import { RouterLink, RouterView } from 'vue-router'
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';

</script>

<template> <!-- 얘네를 꾸며야함! -->
  <Header> <!-- 고정 - 홈페이지 위에 있는 노란색 바 (퀵 챗 같은거도 만들어야함) -->
  </Header>

  <RouterView />
  
  <Footer>
  </Footer>
</template>

<style scoped>
</style>