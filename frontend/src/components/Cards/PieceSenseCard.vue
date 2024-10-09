<template>
  <div
    class="bg-green-300 w-64 h-32 m-8 static rounded-lg"
    @click="detail(currentCommonSenseNo)"
  >
    <div
      class="bg-white w-64 h-40 hover:-m-2 absolute rounded-lg shadow-lg hover:shadow-2xl transition-all duration-150 ease-out hover:ease-in"
    >
      <h1 class="m-4 text-sm font-bold">오늘의 토막 상식 🏡</h1>
      <hr class="m-4 rounded-2xl border-t-2" />
      <div class="m-4 text-2xl">
        <!-- 현재 pieceSense가 있으면 출력, 없으면 로딩 메시지 -->
        <div v-if="commonPieceSense">
          <p>{{ commonPieceSense }}</p>
        </div>
        <p v-else>로딩 중...</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
  commonSenseTitle: String,
  commonSenseNo: Number,
  commonPieceSense: String,
});

// const emits = defineEmits(['detail']);

// 카드 클릭 시 상세 페이지로 이동하는 함수
const detail = (no) => {
  router.push({
    name: 'senseDetailPage',
    params: { no: no },
  });
};

import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import senseApi from '@/api/senseApi'; // 백엔드 API를 가져오는 경로

const router = useRouter();

// 데이터 로드 관련 상태 변수
const currentPieceSense = ref('');
const currentCommonSenseNo = ref('');
const errorMessage = ref('');

// API로부터 데이터를 받아오는 함수
const loadPieceSense = async () => {
  try {
    const response = await senseApi.getList();
    if (response && Array.isArray(response.list) && response.list.length > 0) {
      // 랜덤으로 하나의 데이터를 선택
      const randomIndex = Math.floor(Math.random() * response.list.length);
      currentPieceSense.value = response.list[randomIndex].pieceSense;
      currentCommonSenseNo.value = response.list[randomIndex].commonSenseNo;
    } else {
      errorMessage.value = '유효한 데이터를 찾을 수 없습니다.';
    }
  } catch (error) {
    errorMessage.value =
      '데이터를 불러오는 데 실패했습니다. 다시 시도해 주세요.';
  }
};

// 컴포넌트가 마운트될 때 API 호출
onMounted(() => {
  loadPieceSense();
});
</script>

<style scoped>
.card-image {
  position: absolute;
  right: 20px;
  bottom: 20px;
  width: 120px;
  height: auto;
  opacity: 0.9;
}

/* hover 스타일 및 카드의 이동 효과 */
.bg-white:hover {
  transform: scale(1.08);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}
</style>
