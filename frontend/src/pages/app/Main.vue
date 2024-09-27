<template>
  <div class="container-fluid custom-container">
    <div class="custom-grid">
      <!-- 왼쪽 큰 카드 -->
      <div class="card large-card real-estate-info text-center">
        <div class="card-body">
          <h3 class="card-title">오늘의 토막 상식 🏡</h3>

          <div class="content my-4">
            <!-- 현재 pieceSense 표시 -->
            <div class="content my-4">
              <!-- 현재 pieceSense 표시 -->
              <button
                @click="detail(currentCommonSenseNo)"
                v-if="currentPieceSense"
                class="sense-button"
              >
                {{ currentPieceSense }}
              </button>

              <!-- 설명 문구 -->
              <div class="detail" v-if="currentPieceSense">
                접속 할 때마다 바뀌는 토막상식으로 부동산 지식 UP!
              </div>

              <p v-else>로딩 중...</p>
            </div>
          </div>
        </div>
      </div>

      <!-- 중간 카드 -->
      <router-link
        :to="{ name: 'map' }"
        class="card small-card price-check text-center"
      >
        <div class="card-body">
          <h1 class="card-title">주변 시세 확인📍</h1>
          <p>(안용's 마스터피스)</p>

          <div class="detail">궁금한 지역의 시세를 지금 바로 확인!</div>
        </div>
      </router-link>

      <!-- 오른쪽 카드 -->
      <router-link
        :to="{ name: 'fraudchecklist' }"
        class="card small-card safety-check text-center"
      >
        <div class="card-body">
          <h1 class="card-title">이 집은 안전한가?🕵🏻‍♂️</h1>
          <p>바로 안전진단 받기!</p>

          <div class="detail">원하는 집의 안전 분석 리포트 제공!</div>
        </div>
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router'; // Vue Router 훅을 가져옴
import senseApi from '@/api/senseApi'; // API 모듈

const router = useRouter(); // useRouter를 통해 router 객체 생성

// 상태 관리
const pieceSenseList = ref([]); // 여러 개의 pieceSense를 저장할 배열
const isLoading = ref(true);
const errorMessage = ref('');

// 현재 표시할 pieceSense와 관련된 상태 변수
const currentPieceSense = ref('');
const currentCommonSenseNo = ref('');
const currentCommonSenseTitle = ref('');
const currentCommonSenseContent = ref('');

// 무작위로 pieceSense를 선택하는 함수
const getRandomSense = () => {
  if (pieceSenseList.value.length > 0) {
    const randomIndex = Math.floor(Math.random() * pieceSenseList.value.length);
    currentPieceSense.value = pieceSenseList.value[randomIndex].pieceSense;
    currentCommonSenseNo.value =
      pieceSenseList.value[randomIndex].commonSenseNo;
    currentCommonSenseTitle.value =
      pieceSenseList.value[randomIndex].commonSenseTitle;
    currentCommonSenseContent.value =
      pieceSenseList.value[randomIndex].commonSenseContent;
  }
};

// 상세 페이지로 이동하는 함수
const detail = (no) => {
  router.push({
    name: 'senseDetailPage', // 라우트 이름이 'senseDetailPage'여야 합니다
    params: { no: no },
  });
};

// 데이터 로드 함수
const load = async () => {
  isLoading.value = true;
  errorMessage.value = '';
  try {
    const response = await senseApi.getList(); // API 호출
    console.log('API 응답:', response);

    // 받아온 데이터를 pieceSenseList에 할당
    if (response && Array.isArray(response.list) && response.list.length > 0) {
      pieceSenseList.value = response.list.map((item) => ({
        pieceSense: item.pieceSense, // pieceSense 필드 추출
        commonSenseTitle: item.commonSenseTitle, // commonSenseTitle 필드 추출
        commonSenseContent: item.commonSenseContent, // commonSenseContent 필드 추출
        commonSenseNo: item.commonSenseNo, // 상세 페이지로 이동할 때 사용할 ID
      }));
      getRandomSense(); // 무작위로 하나의 sense 선택
    } else {
      errorMessage.value = '유효하지 않은 데이터 형식입니다.';
    }
  } catch (error) {
    console.error('데이터 로드 실패:', error);
    errorMessage.value =
      '데이터를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  } finally {
    isLoading.value = false;
  }
};

// 컴포넌트가 마운트될 때 데이터 로드
onMounted(() => {
  load();
});
</script>

<style scoped>
.detail {
  margin-top: auto; /* 아래쪽으로 밀림 */
  font-size: 0.9rem; /* 글씨 크기를 작게 설정 */
  color: rgba(0, 0, 0, 0.6); /* 연한 색상으로 설정 */
  text-align: center; /* 가운데 정렬 */
  margin-top: 20px; /* 위쪽에 약간의 간격을 추가 */
  font-style: italic; /* 글씨체를 이탤릭체로 표시 (선택 사항) */
}

.custom-container {
  min-height: 70vh; /* 화면 전체 높이 */
  display: flex;
  align-items: center; /* 카드들이 화면 중앙에 위치하도록 설정 */
  justify-content: center;
  padding: 60px 20px; /* 헤더와의 간격 및 좌우 패딩 추가 */
}

.custom-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr; /* 왼쪽 카드가 더 넓도록 설정 */
  gap: 30px; /* 카드 간의 간격을 좀 더 크게 조정 */
  width: 100%;
  max-width: 1200px; /* 그리드 최대 너비 설정 */
}

.card {
  padding: 40px; /* 카드 내부 패딩 증가 */
  border-radius: 15px; /* 모서리 둥글기 증가 */
  height: 100%; /* 카드가 부모 요소의 전체 높이를 차지 */
  min-height: 500px; /* 카드의 최소 높이를 설정 */
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
  transition: transform 0.3s ease, background-color 0.3s ease, color 0.3s ease;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  box-sizing: border-box;
}

/* 각 카드의 기본 색상 설정 */
.real-estate-info {
  background-color: #e0f7fa; /* 색상 변경 */
  color: #00695c;
}

.price-check {
  background-color: #fce4ec; /* 색상 변경 */
  color: #880e4f;
}

.safety-check {
  background-color: #f3e5f5; /* 색상 변경 */
  color: #6a1b9a;
}

/* hover 상태에서 그라데이션 효과 */
.real-estate-info:hover {
  background: linear-gradient(135deg, #a5d6a7, #66bb6a);
}

.price-check:hover {
  background: linear-gradient(135deg, #ffab91, #ff7043);
}

.safety-check:hover {
  background: linear-gradient(135deg, #ce93d8, #ab47bc);
}

.card:hover {
  transform: scale(1.08); /* 호버 시 카드 확대 */
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15); /* 호버 시 그림자 강도 증가 */
}

/* 카드 제목 텍스트 크기 조정 */
.card-title {
  font-size: 1.2rem; /* 제목 크기 키움 */
  font-weight: bold;
  margin-bottom: 15px;
}

.card-body p {
  font-size: 1.3rem; /* 본문 텍스트 크기 조정 */
  line-height: 1.6; /* 텍스트 간격 추가 */
}

/* 반응형 디자인: 화면이 작은 경우 그리드 변경 */
@media (max-width: 768px) {
  .custom-grid {
    grid-template-columns: 1fr; /* 작은 화면에서는 세로로 쌓임 */
    gap: 20px; /* 카드 간의 간격 조정 */
  }

  .card {
    padding: 30px; /* 작은 화면에서는 카드 내부 패딩 감소 */
  }
}
</style>
