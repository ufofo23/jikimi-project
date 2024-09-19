<template>
  <div id="google-login">
    <button @click="googleLogin">
      <img src="@/assets/google.png" alt="Google Login" class="google-logo" />
    </button>
  </div>
</template>

<script setup>
const googleLogin = () => {
  // Google 로그인 로직
};
</script>

<style scoped>
.google-logo {
  width: 55px;
  height: 55px;
}
button {
  background: none;
  border: none;
  cursor: pointer;
}
</style>
