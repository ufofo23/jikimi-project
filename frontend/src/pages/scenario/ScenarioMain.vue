<template>
  <div class="container">
    <div class="checklist-section" v-show="!showResults">
      <h1 class="title">🏠 전세 사기 위험 체크리스트 🔍</h1>

      <form @submit.prevent="submitChecklist" class="checklist-form">
        <div
          v-for="(question, index) in questions"
          :key="index"
          class="question-item"
        >
          <p class="question-text">{{ question.text }}</p>
          <div class="radio-group">
            <label
              v-for="option in ['예', '아니오', '모르겠습니다']"
              :key="option"
            >
              <input
                type="radio"
                :name="'question-' + index"
                :value="
                  option === '예'
                    ? 'yes'
                    : option === '아니오'
                    ? 'no'
                    : 'unknown'
                "
                v-model="selectedAnswers[index]"
              />
              <span class="radio-label">{{ option }}</span>
            </label>
          </div>
        </div>
        <button type="submit" :disabled="loading" class="submit-button">
          <span v-if="!loading">사기 시나리오 확인하기</span>
          <span v-else class="loading-spinner"></span>
        </button>
      </form>
    </div>

    <div class="results-section" v-show="showResults">
      <h1 class="title">📊 시나리오 분석 결과</h1>
      <Loading v-if="loading" />

      <div v-else>
        <div v-if="scenarios.length === 0" class="no-results">
          <p>시나리오를 찾을 수 없습니다.</p>
        </div>
        <div v-else class="scenarios-container">
          <div
            v-for="(scenario, index) in scenarios"
            :key="index"
            class="scenario-item"
          >
            <div
              class="scenario-content"
              v-html="formatContent(scenario)"
            ></div>
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
          message:
            'A situation where the person trying to contract is different from the actual owner of the house',
        },
        {
          text: '집 주인이 보증금을 줄여주겠다고 하나요?',
          message:
            'A situation where the owner offers a deposit much lower than the market price',
        },
        {
          text: '집 주인이 집의 소유증명서를 보여주지 않나요?',
          message:
            'A situation where the owner does not show or refuses to provide the proof of ownership',
        },
        {
          text: '이 집에 다른 세입자가 살고 있나요?',
          message:
            'A situation where there are already other tenants living in the house I am trying to contract with',
        },
        {
          text: '집의 상태나 위치가 설명과 많이 다른가요?',
          message:
            'A situation where the information in the advertisement and the actual condition or location of the property is significantly different',
        },
        {
          text: '집 주인이 급하게 계약하자고 하나요?',
          message:
            'A situation where the owner is trying to rush the contract and pressuring me to make a quick decision',
        },
        {
          text: '계약을 갑자기 미루자고 하나요?',
          message:
            'A situation where the landlord suddenly tries to postpone the contract and may later become unreachable or vanish',
        },
        {
          text: '계약서를 대충 작성하자고 하나요?',
          message:
            'A situation where the contract is poorly written and important details are missing',
        },
        {
          text: '보증금을 돌려주는 보험 가입을 거부하나요?',
          message:
            'A situation where the owner refuses to sign up for insurance that returns the deposit',
        },
        {
          text: '임대인이 세입자의 신분증이나 서류를 지나치게 요구하나요?',
          message:
            'A situation where the landlord excessively demands personal information like ID or other documents',
        },
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
        .map((question) => question.message);

      try {
        const response = await fetch(
          'http://localhost:8080/api/chat/scenario',
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({ selectedAnswers: selectedMessages }),
          }
        );

        if (!response.ok) {
          throw new Error('서버로부터 응답이 없습니다.');
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
        const scenarioContent = match[1].trim();
        scenarios.push(scenarioContent);
      }

      return scenarios;
    },

    formatContent(content) {
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
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.title {
  color: #1e3a8a;
  font-size: 2.5rem;
  text-align: center;
  margin-bottom: 2rem;
  font-weight: 700;
}

.checklist-form {
  background-color: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.question-item {
  margin-bottom: 1.5rem;
  padding: 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.question-item:hover {
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.question-text {
  font-size: 1.1rem;
  color: #2d3748;
  margin-bottom: 0.75rem;
}

.radio-group {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.radio-group label {
  flex: 1;
  display: flex;
  align-items: center;
  padding: 0.5rem;
  margin: 0.25rem;
  background-color: #edf2f7;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.radio-group label:hover {
  background-color: #e2e8f0;
}

.radio-group input[type='radio'] {
  display: none;
}

.radio-group input[type='radio']:checked + .radio-label {
  background-color: #3b82f6;
  color: white;
  font-weight: bold;
}

.radio-label {
  padding: 0.5rem 1rem;
  border-radius: 4px;
  font-size: 0.9rem;
  transition: all 0.2s ease;
}

.submit-button,
.reset-button {
  display: block;
  width: 100%;
  padding: 1rem;
  margin-top: 2rem;
  font-size: 1.1rem;
  color: white;
  background-color: #3b82f6;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.submit-button:hover,
.reset-button:hover {
  background-color: #2563eb;
}

.submit-button:disabled {
  background-color: #9ca3af;
  cursor: not-allowed;
}

.loading-spinner {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: #fff;
  animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.results-section {
  margin-top: 2rem;
}

.scenarios-container {
  display: grid;
  gap: 1.5rem;
}

.scenario-item {
  background-color: white;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.scenario-content {
  color: #4a5568;
  line-height: 1.6;
}

.scenario-content h1,
.scenario-content h2,
.scenario-content h3 {
  color: #2d3748;
  margin-top: 1rem;
  margin-bottom: 0.5rem;
}

.scenario-content ul,
.scenario-content ol {
  padding-left: 1.5rem;
  margin-bottom: 1rem;
}

.scenario-content p {
  margin-bottom: 1rem;
}

.no-results {
  text-align: center;
  padding: 2rem;
  color: #718096;
  font-style: italic;
}

@media (max-width: 640px) {
  .container {
    padding: 20px 10px;
  }

  .title {
    font-size: 2rem;
  }

  .radio-group {
    flex-direction: column;
  }

  .radio-group label {
    margin: 0.25rem 0;
  }
}
</style>
