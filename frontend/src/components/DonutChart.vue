<template>
  <div>
    <Doughnut
      :data="chartData"
      :options="chartOptions"
      :plugins="[textCenterPlugin]"
    />
  </div>
</template>

<script setup>
import { Doughnut } from 'vue-chartjs';
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend,
} from 'chart.js';
import { computed } from 'vue';

// Chart.js 플러그인 등록
ChartJS.register(ArcElement, Tooltip, Legend);

// 부모로부터 전달된 점수를 받아옴
const props = defineProps({
  score: {
    type: Number,
    required: true,
  },
});

// 점수 설정
// const score = 65; // 예: 65점으로 설정
// chart data 설정 (여기서 props.score 사용)

// 점수에 따른 색상 및 텍스트 설정
let backgroundColor = '#4CAF50'; // 기본 색상 (안전)
let text = '안전'; // 기본 텍스트
let textColor = '#4CAF50'; // 기본 텍스트 색상

if (props.score < 50) {
  backgroundColor = '#FF0000'; // 50점 미만일 때 빨간색 (위험)
  text = '위험';
  textColor = '#FF0000';
} else if (props.score < 70) {
  backgroundColor = '#FFA500'; // 40 ~ 70점일 때 노란색 (경고)
  text = '경고';
  textColor = '#FFA500';
} else {
  backgroundColor = '#4CAF50'; // 70점 이상일 때 초록색 (안전)
  text = '안전';
  textColor = '#4CAF50';
}

// 차트 데이터 설정
const chartData = {
  datasets: [
    // labels: ['Achieved', 'Remaining'],
    {
      data: [props.score, 100 - props.score], // 점수와 남은 부분 표시
      backgroundColor: [backgroundColor, '#E0E0E0'], // 도넛 색상
      hoverBackgroundColor: [backgroundColor, '#BDBDBD'], // 호버 시 색상
      borderWidth: 0, // 경계선 제거
    },
  ],
};

// 플러그인: 도넛 차트 중앙에 텍스트 및 점수 표시 (afterDatasetsDraw 사용)
const textCenterPlugin = {
  id: 'textCenterPlugin',
  afterDatasetsDraw(chart) {
    const {
      ctx,
      chartArea: { top, bottom, left, right },
    } = chart;
    const centerX = (left + right) / 2;
    const centerY = (top + bottom) / 2;

    // 텍스트와 점수 중앙에 그리기
    ctx.save();
    // 위험일 때 텍스트 깜빡이는 효과
    if (props.score < 50) {
      ctx.fillStyle = '#FF0000';
      ctx.font = 'bold 35px sans-serif'; // 점수 크기 키우기
      ctx.fillText('⚠️', centerX - 25, centerY - 50); // 경고 아이콘 추가
    } else {
      ctx.fillStyle = 'black';
    }

    ctx.fillStyle = textColor; // 텍스트 색상 검정색으로 변경
    ctx.font = 'bold 30px sans-serif'; // 점수 크기 키우기
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(`${props.score}점`, centerX, centerY - 10); // 점수 표시
    ctx.font = '20px sans-serif'; // 문구 크기 키우기
    ctx.fillText(text, centerX, centerY + 20); // 문구 표시
    ctx.restore();
  },
};

// 차트 옵션 설정
const chartOptions = {
  responsive: true,
  maintainAspectRatio: false, // 반응형으로 비율 유지하지 않음
  cutout: '70%', // 도넛 차트 두께 설정
  plugins: {
    tooltip: { enabled: false }, // 툴팁 비활성화 (원하는 경우)
  },
  animation: {
    duration: 2000, // 애니메이션 지속 시간
    easing: 'easeInOutBounce', // 애니메이션 이펙트
  },
};
</script>

<style scoped>
div {
  height: 300px; /* 차트 크기 */
  width: 300px;
}
</style>
