<template>
  <div id="naver-login">
    <button @click="naverLogin">
      <img src="@/assets/naver.png" alt="Naver Login" class="naver-logo" />
    </button>
  </div>
</template>

<script setup>
const naverLogin = () => {
  // 네이버 로그인 로직
};
</script>

<style scoped>
.naver-logo {
  width: 55px;
  height: 55px;
}
button {
  background: none;
  border: none;
  cursor: pointer;
}
</style>
