<template>
  <div class="checklist-container">
    <h1>✔️ 전세 사기 위험 체크리스트 ✔️</h1>

    <form @submit.prevent="submitChecklist">
      <div
        v-for="(question, index) in questions"
        :key="index"
        class="question-item"
      >
        <p>{{ question.text }}</p>

        <!-- 예 / 아니오 / 모르겠습니다 선택 (가운데 정렬) -->
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

        <!-- 선택한 값이 "예"일 때만 시나리오 표시 -->
        <p v-if="selectedAnswers[index] === 'yes'" class="scenario">
          {{ question.scenario }}
        </p>
      </div>

      <button type="submit">다음 페이지로</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      questions: [
        {
          text: '매물의 소유자와 계약하려는 임대인이 동일한가요?',
          scenario: '대리 계약 사기 (가짜 임대인이 집주인 행세를 하며 사기)',
        },
        {
          text: '집주인이 최근에 집을 매입했나요?',
          scenario:
            '갭투자형 사기 (집주인이 전세금을 받아 다른 매물 매입 후 파산)',
        },
        {
          text: '집주인이 자주 바뀌었나요?',
          scenario:
            '반복된 전세 계약 사기 (짧은 기간 동안 여러 차례 매물이 소유자 손을 거치는 경우)',
        },
        {
          text: '전세금이 주변 시세보다 현저히 낮나요?',
          scenario: '시세보다 현저히 저렴한 매물로 유혹하는 사기',
        },
        {
          text: '집주인이 전세금을 감액해주겠다고 하나요?',
          scenario: '전세금 감액 사기 (낮은 보증금으로 유도 후 보증금 미반환)',
        },
        {
          text: '집에 근저당이나 압류가 걸려 있나요?',
          scenario: '근저당이 많은 주택 사기 (소유주가 근저당을 걸고 도주)',
        },
        {
          text: '매물이 공매로 넘어갈 위험이 있나요?',
          scenario:
            '공매로 넘어간 주택 사기 (채무가 쌓여 공매로 넘어가는 주택에 전세를 놓음)',
        },
        {
          text: '집주인이 세입자에게 등기부등본을 보여주지 않나요?',
          scenario:
            '서류 제공 거부형 사기 (등기부등본 등을 보여주지 않음으로써 소유권 상태를 숨김)',
        },
        {
          text: '현재 매물에 다른 임차인이 거주 중인가요?',
          scenario:
            '이중 계약 사기 (한 매물에 여러 명에게 전세 계약을 맺는 경우)',
        },
        {
          text: '집주인이 급하게 계약을 요구하나요?',
          scenario:
            '급박하게 계약을 강요하는 사기 (시간 촉박하게 계약을 진행해 생각할 여유를 주지 않음)',
        },
        {
          text: '전세금 반환 보증 보험을 거부하나요?',
          scenario:
            '보증보험 가입 거부형 사기 (보험 가입을 막음으로써 세입자 보호를 방해)',
        },
        {
          text: '임대차 계약을 갑자기 연기하자고 하나요?',
          scenario:
            '계약 연기 후 잠적형 사기 (계약을 미루며 나중에 사라지는 경우)',
        },
        {
          text: '계약서를 대충 작성하거나 나중에 수정하자고 하나요?',
          scenario:
            '불완전 계약서 사기 (계약서 작성 시 중요한 내용을 빼놓거나 추후 수정)',
        },
        {
          text: '매물이 다가구주택 또는 다세대주택인데 소유자가 공동인가요?',
          scenario: '공동 소유주 사기 (다세대주택에서 소유권이 불분명한 경우)',
        },
        {
          text: '매물의 상태나 위치가 설명과 많이 다른가요?',
          scenario: '허위 매물 사기 (실제 매물의 정보와 다르게 광고하여 유도)',
        },
        {
          text: '임대인이 임차인의 신분 증명이나 서류를 지나치게 요구하나요?',
          scenario:
            '개인정보 도용 사기 (세입자의 개인정보를 빼돌려 다른 사기 행위에 사용)',
        },
        {
          text: '전세 계약 후 임대인이 연락이 잘 되지 않나요?',
          scenario: '잠적형 사기 (계약 후 집주인이 연락이 되지 않거나 잠적)',
        },
        {
          text: '매물이 분양 예정이거나 대출을 많이 받은 매물인가요?',
          scenario:
            '미분양 또는 대출 과다 사기 (매물이 미분양 상태거나 대출이 많이 되어 있는 상태에서 전세 계약)',
        },
        {
          text: '임대인이 계약금이나 보증금을 중간업자를 통해서 받고 있나요?',
          scenario:
            '중간업자 활용 사기 (중간 대리인을 통해 돈을 받으려는 경우)',
        },
      ],
      selectedAnswers: Array(20).fill(null),
    };
  },
  methods: {
    submitChecklist() {
      console.log('선택된 질문들:', this.selectedAnswers);
      this.$router.push({
        name: 'ResultPage',
        query: { selected: JSON.stringify(this.selectedAnswers) },
      });
    },
  },
};
</script>

<style>
.checklist-container {
  max-width: 600px;
  margin: 0 auto;
}

form {
  display: flex;
  flex-direction: column;
}

.question-item {
  margin-bottom: 20px;
}

.radio-group {
  display: flex;
  justify-content: center;
  margin-bottom: 10px;
}

.radio-group label {
  margin: 0 15px;
}

.scenario {
  margin-left: 20px;
  font-size: 0.9rem;
  color: #555;
}

button[type='submit'] {
  align-self: flex-end; /* 버튼을 폼 안에서 오른쪽 끝에 배치 */
  padding: 10px 20px;
  background-color: #4caf50; /* 버튼 색상 */
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 20px; /* 내용과 버튼 사이의 간격 */
}

button[type='submit']:hover {
  background-color: #45a049; /* hover 시 색상 변경 */
}
</style>
