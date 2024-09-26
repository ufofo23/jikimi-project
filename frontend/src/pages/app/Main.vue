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
              <div
                @click="detail(currentCommonSenseNo)"
                v-if="currentPieceSense"
                style="cursor: pointer"
              >
                {{ currentPieceSense }}
              </div>
              <p v-else>로딩 중...</p>
              <!-- 데이터를 로드 중일 때 표시 -->
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
          <h3 class="card-title">주변 시세 확인📍</h3>
          <p>(대략적 주소)</p>
        </div>
      </router-link>

      <!-- 오른쪽 카드 -->
      <router-link
        :to="{ name: 'fraudchecklist' }"
        class="card small-card safety-check text-center"
      >
        <div class="card-body">
          <h3 class="card-title">이 집은 안전한가?🕵🏻‍♂️</h3>
          <p>바로 안전진단 받기!</p>
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
.custom-container {
  min-height: 100vh; /* 화면 전체 높이를 차지 */
  display: flex;
  align-items: stretch; /* 카드들이 화면을 꽉 채우도록 설정 */
  padding-top: 60px; /* 헤더와의 간격 */
  padding-bottom: 60px; /* 푸터와의 간격 */
}

.custom-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr; /* 왼쪽 카드가 더 넓도록 설정 */
  gap: 20px; /* 카드 간의 간격 */
  flex-grow: 1; /* 그리드가 전체 화면을 차지하도록 */
}

.card {
  padding: 30px;
  border-radius: 10px;
  height: 100%; /* 카드가 부모 요소의 전체 높이를 차지 */
  transition: transform 0.3s, background-color 0.3s, color 0.3s;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  box-sizing: border-box;
}

/* 각 카드의 기본 색상 설정 */
.real-estate-info {
  background-color: #ffffd1;
  color: #000;
}

.price-check {
  background-color: #d6fff5;
  color: #000;
}

.safety-check {
  background-color: #ffffd7;
  color: #000;
}

/* hover 상태에서 그라데이션 효과 */
.real-estate-info:hover {
  background: linear-gradient(135deg, #cbecc5, #a4eb77);
}

.price-check:hover {
  background: linear-gradient(135deg, #f7cac9, #92a8d1);
}

.safety-check:hover {
  background: linear-gradient(135deg, #cbecc5, #a4eb77);
}

.card:hover {
  transform: scale(1.05);
}

/* 카드 안의 텍스트 크기 조정 */
.card-title {
  font-size: 1.8rem; /* 제목 크기 키움 */
  margin-bottom: 10px;
}

.card-body p {
  font-size: 1.2rem; /* 본문 텍스트 크기 키움 */
}

.button-container {
  margin-top: 20px;
}
</style>
