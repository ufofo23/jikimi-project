<template>
  <div class="flex justify-center">
    <div
      class="mx-auto w-full max-w-screen-xl px-4 py-8 sm:px-6 sm:py-12 lg:px-8"
    >
      <!-- 리포트 제목 -->
      <div class="mx-auto max-w-3xl text-center">
        <h2 class="text-3xl font-bold text-gray-900 sm:text-4xl">리포트</h2>

        <p class="mt-4 text-gray-500 sm:text-xl">
          연경동화아이위시 108동 108호에 대한 리포트가 도착했어요!
        </p>
      </div>

      <!-- 지도 및 도넛 차트 -->
      <div class="flex justify-center mt-6 sm:mt-8 gap-4">
        <div
          class="flex flex-col justify-center items-center rounded-lg bg-blue-50 px-4 py-8 text-center flex-grow basis-1/3 min-h-[250px]"
        >
          <dt class="order-last text-lg font-medium text-gray-500">현위치</dt>
          <dd class="text-4xl font-extrabold text-blue-600 md:text-5xl">
            지도
          </dd>
        </div>

        <div
          class="flex flex-col justify-center items-center rounded-lg bg-blue-50 px-4 py-8 text-center flex-grow basis-1/3 min-h-[250px]"
        >
          <dt class="order-last text-lg font-medium text-gray-500"></dt>
          <dd class="text-4xl font-extrabold text-blue-600 md:text-5xl">
            <DonutChart />
          </dd>
        </div>
      </div>

      <!-- 아코디언 메뉴 -->
      <div class="mx-auto max-w-screen-xl mt-8">
        <!-- Section 1: 안전진단 점수 - 안전 -->
        <button @click="togglePanel(1)" class="sec">
          1. 안전진단 점수 <span class="summary">안전</span>
        </button>
        <div v-show="openPanels[1]" class="panel bg-blue-100 p-4">
          <p>안전진단 점수와 관련된 세부 정보.</p>
        </div>

        <!-- Section 2: 전세가율 - 80% -->
        <button @click="togglePanel(2)" class="sec">
          2. 전세가율 <span class="summary">80%</span>
        </button>
        <div v-show="openPanels[2]" class="panel bg-blue-100 p-4">
          <p>전세가율과 관련된 세부 정보.</p>
        </div>

        <!-- Section 3: 소유자 = 계약자 여부 - 동일 -->
        <button @click="togglePanel(3)" class="sec">
          3. 소유자와 계약자의 일치 여부 <span class="summary">동일</span>
        </button>
        <div v-show="openPanels[3]" class="panel bg-blue-100 p-4">
          <p>소유자와 계약자가 동일한지 여부에 관한 세부 정보.</p>
        </div>

        <!-- Section 4: 근저당권 채권 최고액 - 5억 -->
        <button @click="togglePanel(4)" class="sec">
          4. 근저당권 채권 최고액 <span class="summary">5억</span>
        </button>
        <div v-show="openPanels[4]" class="panel bg-blue-100 p-4">
          <p>근저당권 채권 최고액에 대한 세부 정보.</p>
        </div>

        <!-- Section 5: 건물의 주용도 (거주 등등) - 거주 -->
        <button @click="togglePanel(5)" class="sec">
          5. 건물의 주용도 <span class="summary">거주</span>
        </button>
        <div v-show="openPanels[5]" class="panel bg-blue-100 p-4">
          <p>건물의 주용도(거주 등)에 관한 세부 정보.</p>
        </div>

        <!-- Section 6: 대지권등기 - 있음 -->
        <button @click="togglePanel(6)" class="sec">
          6. 대지권등기 <span class="summary">있음</span>
        </button>
        <div v-show="openPanels[6]" class="panel bg-blue-100 p-4">
          <p>대지권등기에 관한 세부 정보.</p>
        </div>

        <!-- Section 7: 공동소유/ 단독소유 여부 - 단독 -->
        <button @click="togglePanel(7)" class="sec">
          7. 공동소유 단독소유 여부<span class="summary">단독</span>
        </button>
        <div v-show="openPanels[7]" class="panel bg-blue-100 p-4">
          <p>공동소유 또는 단독소유 여부에 관한 세부 정보.</p>
        </div>

        <!-- Section 8: 소유권 변경 횟수 - 2회 (압류/가압류) -->
        <button @click="togglePanel(8)" class="sec">
          8. 소유권 변경 횟수 <span class="summary">2회 (압류/가압류)</span>
        </button>
        <div v-show="openPanels[8]" class="panel bg-blue-100 p-4">
          <p>소유권 변경 횟수 및 그 원인(압류/가압류 등)에 관한 세부 정보.</p>
        </div>

        <!-- Section 9: 전유 부분 (건물 소유 면적) - 85㎡ -->
        <button @click="togglePanel(9)" class="sec">
          9. 전유 부분 (건물 소유 면적) <span class="summary">85㎡</span>
        </button>
        <div v-show="openPanels[9]" class="panel bg-blue-100 p-4">
          <p>전유 부분의 건물 소유 면적에 관한 세부 정보.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import DonutChart from '@/components/DonutChart.vue';

// 여러 패널의 상태를 관리하는 배열 (각 패널의 열림 상태를 저장)
const openPanels = ref([]);

// 패널을 토글하는 함수 (패널의 인덱스 번호로 제어)
function togglePanel(panelNumber) {
  openPanels.value[panelNumber] = !openPanels.value[panelNumber]; // 해당 패널의 상태만 토글
}
</script>

<style>
.sec {
  text-align: left;
  padding: 24px; /* 패딩을 크게 */
  font-weight: 900; /* font-black */
  font-size: 1.25rem; /* 글씨 크기 키움 */
  background-color: #e4fdf7; /* Tailwind's gray-100 */
  border-radius: 0.25rem; /* 테두리 살짝 더 둥글게 */
  width: 100%; /* w-full */
  transition: background-color 0.3s ease;
  border: 2px solid #cdcecd; /* 연한 회색 테두리 (사진의 색상) */
}

.sec:hover {
  background-color: #93c5fd; /* Tailwind's blue-300 */
}

.sec:focus {
  background-color: #fde047; /* Tailwind's yellow-300 */
}

.panel {
  overflow: hidden;
}

.summary {
  font-size: 1.1rem;
  font-weight: 700;
  color: #2563eb; /* Tailwind's blue-600 */
}
</style>
