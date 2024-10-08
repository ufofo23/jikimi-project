<template>
  <div class="quick-chat">
    <!-- 동그란 Chat Bot 버튼 -->
    <button @click="toggleChat" class="chat-bot-button">
      <img src="@/assets/turtle.png" alt="Turtle Icon" class="turtle-icon" />
      Bugi Bot
    </button>

    <div v-if="chatVisible" class="chat-box">
      <button @click="toggleChat" class="close-button">닫기</button>
      <div class="chat-container">
        <div class="messages" ref="messagesContainer">
          <div
            v-for="(message, index) in messages"
            :key="index"
            class="message"
          >
            <strong>{{ message.role }}:</strong> {{ message.content }}
          </div>
        </div>
        <div class="input-area">
          <input
            v-model="userInput"
            @keyup.enter="sendMessage"
            placeholder="메시지를 입력하세요"
            ref="inputField"
          />
          <button @click="sendMessage">전송</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

const chatVisible = ref(false); // 챗봇 창의 표시 여부를 관리하는 반응형 변수
const messages = ref([]); // 채팅 메시지를 저장할 배열
const userInput = ref(''); // 사용자 입력 값을 저장할 변수
const messagesContainer = ref(null); // 메시지 영역을 참조하는 ref

// API 호출 설정
const api = axios.create({
  baseURL: 'http://localhost:8080',
  withCredentials: true, // 모든 요청에 쿠키 포함
});

// 챗봇 창을 토글하는 함수
const toggleChat = () => {
  chatVisible.value = !chatVisible.value;
};

// 메시지를 전송하는 함수
const sendMessage = async () => {
  if (userInput.value.trim() === '') return; // 빈 메시지 방지

  // 유저 메시지 추가
  messages.value.push({ role: '부린이', content: userInput.value });

  try {
    const response = await api.post(
      '/api/chat/chatbot',
      { prompt: userInput.value },
      {
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      }
    );

    // 서버 응답 메시지 추가
    const content = response.data.content || '';
    messages.value.push({ role: '부기봇', content });
  } catch (error) {
    console.error('Error:', error);
    messages.value.push({
      role: '부기봇',
      content: '메시지 전송에 실패했습니다. 다시 시도해 주세요.',
    });
  }

  userInput.value = ''; // 입력 필드 초기화
  scrollToBottom(); // 스크롤을 하단으로 이동
};

// 메시지 창을 항상 하단에 고정시키는 함수
const scrollToBottom = () => {
  const container = messagesContainer.value; // messagesContainer 참조
  if (container) {
    container.scrollTop = container.scrollHeight; // 스크롤을 아래로 이동
  }
};
</script>

<style scoped>
/* Chat Bot 버튼 스타일 */
.quick-chat {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 1000;
}

.chat-bot-button {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 80px; /* 버튼 크기 */
  height: 80px; /* 버튼 크기 */
  border-radius: 50%; /* 동그란 버튼 */
  background-color: #cbecc5; /* 브랜드 색상 */
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 2px solid #9db58f; /* 테두리를 브랜드 색상과 어울리게 변경 */
  cursor: pointer;
  transition: transform 0.3s ease;
}

.chat-bot-button:hover {
  transform: scale(1.1); /* 호버 시 버튼 커짐 */
}

.turtle-icon {
  width: 40px; /* 거북이 아이콘 크기 */
  height: 40px;
}

/* Chat Box 스타일 */
.chat-box {
  position: absolute;
  bottom: 100px;
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
  background-color: #a1c49c; /* 브랜드 색상과 어울리도록 변경 */
  color: white;
  padding: 5px 10px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.3s ease;
}

.close-button:hover {
  background-color: #8cb284; /* 호버 색상 변경 */
}

.chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.messages {
  flex: 1;
  overflow-y: auto;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin-bottom: 0; /* margin-bottom 제거 */
  font-family: 'Arial', sans-serif; /* 글꼴 설정 */
  font-size: 14px; /* 글꼴 크기 설정 */
  line-height: 1.5; /* 줄 간격 설정 */
}

.input-area {
  display: flex;
  align-items: center;
  padding: 10px; /* 적절한 패딩 추가 */
  background: #fff; /* 입력란 배경색 */
}

.input-area input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin-right: 10px;
}

.input-area button {
  padding: 10px 15px;
  background-color: #a1c49c; /* 브랜드 색상과 어울리도록 변경 */
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.input-area button:hover {
  background-color: #8cb284; /* 호버 색상 변경 */
}

.message {
  margin-bottom: 5px;
}

/* 애니메이션 */
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
