<template>
  <div id="kakao-login">
    <button @click="kakaoLogin">
      <img src="@/assets/kakao.png" alt="Kakao Login" class="kakao-logo" />
    </button>
  </div>
</template>

<script setup>
const kakaoLogin = () => {
  // 카카오 로그인 로직
};
</script>

<style scoped>
.kakao-logo {
  width: 55px;
  height: 55px;
}
button {
  background: none;
  border: none;
  cursor: pointer;
}
</style>
