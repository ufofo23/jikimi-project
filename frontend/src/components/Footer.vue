<template>
  <footer class="footer">
    <p>© 2024 부동산 거래 서비스</p>
    <button class="quick-chat" @click="openChat">Quick Chat</button>
  </footer>
</template>

<script setup>

</script>

<style scoped>
.footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  background-color: #fcd94d;
  padding: 10px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.quick-chat {
  background-color: #d1c4e9;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
}
</style>
