<<<<<<< HEAD
<!-- 싱글페이지(SPA): 페이지를 하나만 만들고 컴포넌트를 갈아끼우는 형식 -->

<script setup>
import { RouterLink, RouterView } from 'vue-router'
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';

</script>

<template> <!-- 얘네를 꾸며야함! -->
  <Header> <!-- 고정 - 홈페이지 위에 있는 노란색 바 (퀵 챗 같은거도 만들어야함) -->
=======
<template>
  <Header>
    <!-- 고정 - 홈페이지 위에 있는 노란색 바 (퀵 챗 같은거도 만들어야함) -->
>>>>>>> ed87022f1751b139d4533ee9ca8629b90b003aa1
  </Header>

  <!-- 라우터 뷰로 컴포넌트 전환 -->
  <RouterView />
<<<<<<< HEAD
  
  <Footer>
  </Footer>
=======

  <Footer> </Footer>

  <!-- Quick Chat 버튼 전역으로 추가 -->
  <QuickChat />
>>>>>>> ed87022f1751b139d4533ee9ca8629b90b003aa1
</template>

<script setup>
import { RouterLink, RouterView } from 'vue-router';
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
import QuickChat from './components/QuickChat.vue'; // QuickChat 컴포넌트 불러오기
</script>

<style scoped></style>
