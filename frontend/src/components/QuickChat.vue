<template>
  <div class="quick-chat">
    <button @click="toggleChat" class="btn btn-warning quick-chat-button">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="chat-icon"
        viewBox="0 0 24 24"
        fill="currentColor"
      >
        <path
          d="M20 2H4C2.897 2 2 2.897 2 4V18L6 14H20C21.103 14 22 13.103 22 12V4C22 2.897 21.103 2 20 2Z"
        />
      </svg>
      Quick Chat
    </button>
    <div v-if="chatVisible" class="chat-box">
      <iframe
        src="https://your-chatbot-service.com"
        width="100%"
        height="100%"
        frameborder="0"
        allow="microphone; camera"
      >
      </iframe>
      <button @click="toggleChat" class="btn btn-warning close-button">
        닫기
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

// 챗봇 창의 표시 여부를 관리하는 반응형 변수
const chatVisible = ref(false);

// 챗봇 창을 토글하는 함수
const toggleChat = () => {
  chatVisible.value = !chatVisible.value;
};
</script>

<style scoped>
.quick-chat {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 1000;
}

.quick-chat-button {
  display: flex;
  align-items: center;
  padding: 12px 20px;
  border-radius: 50px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease; /* 트랜지션 추가 */
}

.quick-chat-button:hover {
  transform: scale(1.1); /* 호버 시 살짝 커지게 */
}

.chat-icon {
  width: 20px;
  height: 20px;
  margin-right: 8px;
}

.chat-box {
  position: absolute;
  bottom: 60px;
  right: 0;
  width: 350px;
  height: 500px;
  background: #ffffff;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
  border-radius: 10px;
  overflow: hidden;
  animation: fadeIn 0.3s ease;
}

.close-button {
  position: absolute;
  top: 10px;
  right: 10px;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
</style>
