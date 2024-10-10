<template>
  <div class="container">
    <div class="checklist-section" v-show="!showResults">
      <h5 class="text-center my-4 checklist-title">
        전세 사기 위험 체크리스트
      </h5>

      <form @submit.prevent="submitChecklist">
        <table class="table-auto w-full text-left">
          <thead>
            <tr class="border-b">
              <th class="px-4 py-2 text-left">문항 번호</th>
              <th class="px-4 py-2 text-left">질문</th>
              <th class="px-4 py-2 text-left">응답</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(question, index) in questions"
              :key="index"
              class="border-t"
            >
              <td class="px-4 py-2">{{ index + 1 }}</td>
              <td class="px-4 py-2">{{ question.text }}</td>
              <td class="px-4 py-2">
                <div class="radio-group flex space-x-4">
                  <label class="inline-flex items-center">
                    <input
                      type="radio"
                      :name="'question-' + index"
                      value="yes"
                      v-model="selectedAnswers[index]"
                      class="form-radio"
                    />
                    <span class="ml-2">예</span>
                  </label>
                  <label class="inline-flex items-center">
                    <input
                      type="radio"
                      :name="'question-' + index"
                      value="no"
                      v-model="selectedAnswers[index]"
                      class="form-radio"
                    />
                    <span class="ml-2">아니오</span>
                  </label>
                  <label class="inline-flex items-center">
                    <input
                      type="radio"
                      :name="'question-' + index"
                      value="unknown"
                      v-model="selectedAnswers[index]"
                      class="form-radio"
                    />
                    <span class="ml-2">모르겠습니다</span>
                  </label>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <div class="text-center mt-6">
          <button type="submit" :disabled="loading" class="btn-primary">
            사기 시나리오 확인하기
          </button>
        </div>
      </form>
    </div>

    <div class="results-section" v-show="showResults">
      <h1 class="text-center my-4">시나리오가 도착했어요 📊</h1>
      <Loading v-if="loading" />

      <div v-else>
        <div v-if="scenarios.length === 0" class="no-results">
          <p>시나리오를 찾을 수 없습니다.</p>
        </div>
        <div v-else>
          <div
            v-for="(scenario, index) in scenarios"
            :key="index"
            class="scenario-item"
          >
            <div class="scenario-content">
              <div v-html="formatContent(scenario)"></div>
            </div>
          </div>
        </div>
        <div class="text-center mt-6">
          <button @click="resetForm" class="btn-primary">다시 체크하기</button>
        </div>
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
  max-width: 70%;
  margin: 0 auto;
  padding: 20px;
}

.table-auto {
  width: 100%;
  border-collapse: collapse;
  margin-top: 50px;
}

td {
  border-bottom: 0.7px solid #ddd;
  padding: 10px;
  font-size: 1rem;
}

th {
  font-weight: bold;

  border-bottom: 2px solid #dddddd;
  padding: 10px;
  font-size: 1rem;
}

.radio-group label {
  display: inline-flex;
  align-items: center;
}

button {
  padding: 12px 24px;
  background-color: #0066ff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #0037ff;
}

button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.reset-button {
  margin-top: 20px;
  background-color: #2196f3;
}

.reset-button:hover {
  background-color: #1976d2;
}
.checklist-title {
  font-size: 1.8rem; /* 글자 크기 증가 */
  font-weight: bold;
}
</style>
