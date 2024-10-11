<script setup>
import { ref } from 'vue';
import axios from 'axios';

const chatVisible = ref(false);
const messages = ref([]);
const userInput = ref('');
const messagesContainer = ref(null);

const api = axios.create({
  baseURL: 'http://localhost:8080',
  withCredentials: true,
});

const toggleChat = () => {
  chatVisible.value = !chatVisible.value;
};

const saveMessagesToLocalStorage = () => {
  localStorage.setItem('chatMessages', JSON.stringify(messages.value));
};

const loadMessagesFromLocalStorage = () => {
  const storedMessages = localStorage.getItem('chatMessages');
  if (storedMessages) {
    messages.value = JSON.parse(storedMessages);
  }
};

const sendMessage = async () => {
  if (userInput.value.trim() === '') return;

  messages.value.push({ role: '부린이', content: userInput.value });
  saveMessagesToLocalStorage();

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

    const content = response.data.content || '';
    messages.value.push({ role: '부기봇', content });
    saveMessagesToLocalStorage();
  } catch (error) {
    console.error('Error:', error);
    messages.value.push({
      role: '부기봇',
      content: '메시지 전송에 실패했습니다. 다시 시도해 주세요.',
    });
    saveMessagesToLocalStorage();
  }

  userInput.value = '';
  scrollToBottom();
};

const scrollToBottom = () => {
  const container = messagesContainer.value;
  if (container) {
    container.scrollTop = container.scrollHeight;
  }
};

// 컴포넌트가 마운트될 때 메시지를 로드합니다.
loadMessagesFromLocalStorage();
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
  width: 400px; /* 너비를 늘림 */
  height: 600px; /* 높이를 늘림 */
  background: #ffffff;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
  border-radius: 10px;
  overflow: hidden;
  animation: fadeIn 0.3s ease;
}

.header {
  display: flex;
  justify-content: flex-end;
  padding: 10px;
}

.close-button {
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
  height: calc(100% - 50px); /* header 높이를 고려하여 조정 */
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

.message {
  margin-bottom: 5px;
}

.user-message {
  text-align: right; /* 사용자 메시지 오른쪽 정렬 */
  align-self: flex-end; /* 사용자 메시지를 오른쪽으로 정렬 */
}

.bot-message {
  text-align: left; /* 봇 메시지 왼쪽 정렬 */
  align-self: flex-start; /* 봇 메시지를 왼쪽으로 정렬 */
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

.disclaimer {
  color: #b0b0b0; /* 연한 회색 */
  font-size: 12px; /* 글자 크기 조정 */
  text-align: center; /* 가운데 정렬 */
  padding: 10px; /* 적절한 패딩 추가 */
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