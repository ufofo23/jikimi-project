<template>
  <div class="container">
    <div class="checklist-section" v-show="!showResults">
      <h1>✔️ 전세 사기 위험 체크리스트 ✔️</h1>
      
      <form @submit.prevent="submitChecklist">
        <div
          v-for="(question, index) in questions"
          :key="index"
          class="question-item"
        >
          <p>{{ question.text }}</p>
          <div class="radio-group">
            <label>
              <input
                type="radio"
                :name="'question-' + index"
                value="yes"
                v-model="selectedAnswers[index]"
              />
              예
            </label>
            <label>
              <input
                type="radio"
                :name="'question-' + index"
                value="no"
                v-model="selectedAnswers[index]"
              />
              아니오
            </label>
            <label>
              <input
                type="radio"
                :name="'question-' + index"
                value="unknown"
                v-model="selectedAnswers[index]"
              />
              모르겠습니다
            </label>
          </div>
        </div>
        <button type="submit" :disabled="loading">사기 시나리오 확인하기</button>
      </form>
    </div>

    <div class="results-section" v-show="showResults">
      <h1>시나리오가 도착했어요 📊</h1>
      <Loading v-if="loading" /> 

      <div v-else>
        <div v-if="scenarios.length === 0" class="no-results">
          <p>시나리오를 찾을 수 없습니다.</p>
        </div>
        <div v-else>
          <div v-for="(scenario, index) in scenarios" :key="index" class="scenario-item">
            <!-- <h3>시나리오 {{ index + 1 }}</h3> -->
            <div class="scenario-content">
              <div v-html="formatContent(scenario)"></div>
            </div>
          </div>
        </div>
        <button @click="resetForm" class="reset-button">다시 체크하기</button>
      </div>
    </div>
  </div>
</template>

<script>
import { marked } from 'marked';
import Loading from '@/pages/Loading.vue'; 

export default {
  components: {
    Loading, 
  },
  data() {
    return {
      questions: [
        {
          text: '집 주인과 계약하려는 사람이 같은 사람인가요?',
          message: 'A situation where the person trying to contract is different from the actual owner of the house',
        },
        {
          text: '집 주인이 보증금을 줄여주겠다고 하나요?',
          message: 'A situation where the owner offers a deposit much lower than the market price',
        },
        // 다른 질문들도 동일하게 추가됩니다
      ],
      selectedAnswers: Array(10).fill(null),
      scenarios: [],
      loading: false,
      showResults: false,
    };
  },
  methods: {
    async submitChecklist() {
      this.loading = true;
      this.showResults = true;

      const selectedMessages = this.questions
        .filter((question, index) => this.selectedAnswers[index] === 'yes')
        .map(question => question.message);

      try {
        const response = await fetch('http://localhost:8080/api/chat/scenario', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ selectedAnswers: selectedMessages }),
        });

        if (!response.ok) {
          throw new Error('서버로 부터 응답이 없습니다.');
        }

        const data = await response.json();
        this.scenarios = this.extractScenarios(data.content);
      } catch (error) {
        console.error('문제가 발생했습니다:', error);
      } finally {
        this.loading = false;
      }
    },

    extractScenarios(content) {
      const scenarios = [];
      const scenarioRegex = /\/start\/([\s\S]*?)\/end\//g;
      let match;

      while ((match = scenarioRegex.exec(content)) !== null) {
      // /start/와 /end/ 사이의 내용을 가져옵니다.
        const scenarioContent = match[1].trim(); 
        scenarios.push(scenarioContent);
      }

      return scenarios;
    },

    formatContent(content) {
      // 마크다운 형식으로 변환
      return marked(content);
    },


    resetForm() {
      this.selectedAnswers = Array(10).fill(null);
      this.scenarios = [];
      this.showResults = false;
    },
  },
};
</script>

<style scoped>
.container {
  max-width: 50%;
  margin: 0 auto;
  padding: 20px;
}

.question-item {
  margin-bottom: 20px;
  padding: 15px;
  border: 1px solid #eee;
  border-radius: 8px;
}

.radio-group {
  display: flex;
  justify-content: right;
  gap: 10px;
  margin-top: 10px;
}

.radio-group label {
  display: flex;
  align-items: center;
  gap: 5px;
}

button {
  padding: 12px 24px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #45a049;
}

button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.scenario-item {
  margin: 20px 0;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: #fff;
}

.fraud-warning {
  background-color: #fff3f3;
  padding: 15px;
  margin: 10px 0;
  border-left: 4px solid #ff4444;
  border-radius: 4px;
}

.measures {
  background-color: #f3fff3;
  padding: 15px;
  margin: 10px 0;
  border-left: 4px solid #44ff44;
  border-radius: 4px;
}

.loading {
  text-align: center;
  padding: 20px;
}

.reset-button {
  margin-top: 20px;
  background-color: #2196F3;
}

.reset-button:hover {
  background-color: #1976D2;
}

.no-results {
  text-align: center;
  padding: 20px;
  color: #666;
}
</style>
