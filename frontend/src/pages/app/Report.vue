<template>
  <div class="flex justify-center">
    <div
      class="mx-auto w-full max-w-screen-xl px-4 py-8 sm:px-6 sm:py-12 lg:px-8"
    >
      <!-- 리포트 제목 -->
      <div class="mx-auto max-w-3xl text-center">
        <h2
          class="text-3xl font-bold text-gray-900 sm:text-4xl"
        >
          리포트
        </h2>

        <p class="mt-4 text-gray-500 sm:text-xl">
          연경동화아이위시 108동 108호에 대한 리포트가
          도착했어요!
        </p>
        <p>
          {{ sampleReportData.address }}에 대한 리포트가
          도착했어요!
        </p>
      </div>

      <!-- 지도 및 도넛 차트 -->
      <div class="flex justify-center mt-6 sm:mt-8 gap-4">
        <div
          class="flex flex-col justify-center items-center rounded-lg bg-blue-50 px-4 py-8 text-center flex-grow basis-1/3 min-h-[250px]"
        >
          <dt
            class="order-last text-lg font-medium text-gray-500"
          >
            <!-- 지도가 보여지는 지점 현위치 -->
          </dt>
          <div
            id="map"
            ref="mapContainer"
            style="
              width: 100%;
              height: 100%;
              position: relative;
            "
          ></div>
          <dd
            class="text-4xl font-extrabold text-blue-600 md:text-5xl"
          >
            <!-- 지도 -->
          </dd>
        </div>

        <div
          class="flex flex-col justify-center items-center rounded-lg bg-blue-50 px-4 py-8 text-center flex-grow basis-1/3 min-h-[250px]"
        >
          <dt
            class="order-last text-lg font-medium text-gray-500"
          ></dt>
          <dd
            class="text-4xl font-extrabold text-blue-600 md:text-5xl"
          >
            <!-- DonutChart에 score prop 전달 -->
            <DonutChart
              :score="sampleReportData.totalScore"
            />
            <!-- sampleReportData.totalScore  -->
          </dd>
        </div>
      </div>

      <!-- 아코디언 메뉴 -->
      <div class="mx-auto max-w-screen-xl mt-8">
        <!-- Section 1: 안전진단 점수 - 안전 -->
        <button @click="togglePanel(1)" class="sec">
          1. 안전진단 점수
          <span class="summary">{{
            sampleReportData.totalScore !== null
              ? sampleReportData.totalScore
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[1]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.totalScore !== null
                ? `안전진단 점수: ${sampleReportData.totalScore}`
                : '해당 물건에 대한 세부정보가 부족합니다. 내용을 분석할 수 없습니다'
            }}
          </p>
        </div>

        <!-- Section 2: 전세가율 - 80% -->
        <button @click="togglePanel(2)" class="sec">
          2. 전세가율
          <span class="summary">{{
            sampleReportData.jeonseRate !== null
              ? sampleReportData.jeonseRate + '%'
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[2]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.jeonseRate !== null
                ? `전세가율: ${sampleReportData.jeonseRate}`
                : '해당 물건에 대한 세부정보가 부족합니다. 내용을 분석할 수 없습니다'
            }}
          </p>
        </div>

        <!-- Section 3: 소유자 = 계약자 여부 - 동일 -->
        <button @click="togglePanel(3)" class="sec">
          3. 소유자와 계약자의 일치 여부
          <span class="summary">{{
            sampleReportData.accordOwner ? '동일' : '다름'
          }}</span>
        </button>
        <div
          v-show="openPanels[3]"
          class="panel bg-blue-100 p-4"
        >
          <div
            v-if="
              sampleReportData.accordOwner &&
              sampleReportData.ownership ==
                sampleReportData.contractName
            "
          >
            <p>
              소유자 {{ sampleReportData.ownership }}와
              계약자 {{ sampleReportData.contractName }}은
              같습니다.
            </p>
            <p>
              소유자의 이름과 주민등록번호, 거주지를 잘
              확인하고 내가 지금 계약하려는 집의 임대인의
              인적사항과 비교해보세요. 당연히 계약서에도
              동일한 사람의 인적사항이 적혀 있어야 해요.
            </p>
          </div>

          <div
            v-else-if="
              sampleReportData.ownership !=
              sampleReportData.contractName
            "
          >
            <p>
              소유자 {{ sampleReportData.ownership }}와
              계약자 {{ sampleReportData.contractName }}은
              동일하지 않습니다.
            </p>
            <p>
              소유자의 이름과 주민등록번호, 거주지를 잘
              확인하세요! 계약할 때 계약서에 내가 지금
              계약하려는 집의 임대인이
              {{ sampleReportData.ownership }}이 맞는지
              확인하세요!
            </p>
          </div>
          <p v-else>
            해당 물건에 대한 세부정보가 부족합니다. 내용을
            분석할 수 없습니다
          </p>
        </div>

        <!-- Section 4: 근저당권 채권 최고액 - 5억 -->
        <button @click="togglePanel(4)" class="sec">
          4. 근저당권 채권 최고액
          <span class="summary">{{
            sampleReportData.maximumOfBond !== null
              ? sampleReportData.maximumOfBond + '억'
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[4]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.maximumOfBond !== null
                ? `근저당권 채권 최고액: ${sampleReportData.maximumOfBond}억`
                : '해당 물건에 대한 세부정보가 부족합니다. 내용을 분석할 수 없습니다'
            }}
          </p>
        </div>

        <!-- Section 5: 건물의 주용도 (거주 등등) - 거주 -->
        <button @click="togglePanel(5)" class="sec">
          5. 건물의 주용도
          <span class="summary">{{
            sampleReportData.useType !== null
              ? sampleReportData.useType
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[5]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.useType !== '주거'
                ? `해당 건물은 ${sampleReportData.useType}용 건물입니다.`
                : '건축물의 용도를 확인하세요. 근린생활시설 같은 경우 주거용 건물이 아니기 때문에 전세자금 대출이 어려울 수 있으니, 집 알아볼 때 유의하세요!'
            }}
          </p>
        </div>

        <!-- Section 6: 대지권등기 - 있음 -->
        <button @click="togglePanel(6)" class="sec">
          6. 대지권등기
          <span class="summary">{{
            sampleReportData.kindOfLandrights !== null
              ? sampleReportData.kindOfLandrights
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[6]"
          class="panel bg-blue-100 p-4"
        >
          <p>대지권등기에 관한 세부 정보.</p>
          <p>
            {{
              sampleReportData.kindOfLandrights !== null
                ? `해당 물건에 대한 대지권은 ${sampleReportData.kindOfLandrights}㎡입니다.`
                : '대지권은 임대인이 땅에 대해 가지는 권리를 말해요.대지권이 없다고 해서 위험한건 아니지만, 대지권이 없다면 주택의 가치가 하락할 수 있으니 주의하세요.'
            }}
          </p>
        </div>

        <!-- Section 7: 공동소유/ 단독소유 여부 - 단독 -->
        <button @click="togglePanel(7)" class="sec">
          7. 공동소유 단독소유 여부
          <span class="summary">{{
            sampleReportData.commonOwner !== null
              ? sampleReportData.commonOwner
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[7]"
          class="panel bg-blue-100 p-4"
        >
          <div v-if="sampleReportData.commonOwner === null">
            해당 물건에 대한 세부정보가 부족합니다. 내용을
            분석할 수 없습니다
          </div>

          <div
            v-else-if="
              sampleReportData.commonOwner == '단독'
            "
          >
            <p>
              해당 물건은
              {{ sampleReportData.commonOwner }} 소유
              물건입니다.
            </p>
          </div>
          <div v-else>
            <p>
              해당 물건은
              {{ sampleReportData.commonOwner }} 소유
              물건입니다.
            </p>
            <p>
              {{ sampleReportData.commonOwner }} 소유라고
              해서 위험한건 아니지만, 계약할 때 꼭
              확인하세요!
            </p>
          </div>
        </div>

        <!-- Section 8: 소유권 변경 횟수 - 2회 (압류/가압류) -->
        <button @click="togglePanel(8)" class="sec">
          8. 소유권 변경 횟수
          <span class="summary">{{
            sampleReportData.changeOwnerCount !== null
              ? sampleReportData.changeOwnerCount
              : '분석불가'
          }}</span>
        </button>
        <div
          v-show="openPanels[8]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            소유권 변경 횟수 및 그 원인(압류/가압류 등)에
            관한 세부 정보.
          </p>
          <div
            v-if="
              sampleReportData.changeOwnerCount === null
            "
          >
            해당 물건에 대한 세부정보가 부족합니다. 내용을
            분석할 수 없습니다
          </div>

          <div
            v-else-if="
              sampleReportData.changeOwnerCount < 3
            "
          >
            <p>
              해당 물건은 총
              {{ sampleReportData.changeOwnerCount }} 회
              소유자가 변경되었습니다.
            </p>
          </div>
          <div v-else>
            <p>
              해당 물건은 총
              {{ sampleReportData.changeOwnerCount }} 회
              소유자가 변경되었습니다.
            </p>
            <p>
              {{ sampleReportData.changeOwnerCount }}
              회 변경되었다고 위험하진 않지만, 계약할 때 꼭
              확인하세요!
            </p>
          </div>
        </div>

        <!-- Section 9: 전유 부분 (건물 소유 면적) - 85㎡ -->
        <button @click="togglePanel(9)" class="sec">
          9. 전유 부분 (건물 소유 면적)
          <span class="summary">85㎡</span>
        </button>
        <div
          v-show="openPanels[9]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            전유 부분의 건물 소유 면적에 관한 세부 정보.
          </p>
        </div>
      </div>
      <div class="d-flex flex-row-revers">
        <button
          class="btn btn-danger ml-9"
          @click="deleteSelected(sampleNo)"
        >
          삭제
        </button>

        <button class="btn btn-primary ml-9" @click="back">
          목록
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import DonutChart from '@/components/DonutChart.vue';
import reportApi from '@/api/reportApi';
import addressApi from '@/api/mapApi';
import { useRouter } from 'vue-router';

// report페이지로 넘어오기
const cr = useRoute();
const router = useRouter();

// MyReport 페이지에서 reportNo 받아오기!!!!!
const sampleNo = cr.params.no;
// 샘플 데이터 <-- reportNo로 바꿔버리자!!!!!!

// 여러 패널의 상태를 관리하는 배열 (각 패널의 열림 상태를 저장)
const openPanels = ref([]);
// 점수 상태를 저장 (필요시 점수 값을 동적으로 변경 가능)
const score = ref(75); // 예: 65점

// 패널을 토글하는 함수 (패널의 인덱스 번호로 제어)
function togglePanel(panelNumber) {
  openPanels.value[panelNumber] =
    !openPanels.value[panelNumber]; // 해당 패널의 상태만 토글
}

// 3. 소유자와 계약자의 일치 여부

//  서버에서 데이터 가져오는 함수
// 상태 관리
const sampleReportData = ref({
  totalScore: null,
  jeonseRate: null,
  accordOwner: null,
  commonOwner: null,
  contractName: null,
  maximumOfBond: null,
  // 다른 필드들도 여기에 추가
});

// 서버에서 데이터를 가져오는 함수
const fetchReportData = async () => {
  try {
    const data = await reportApi.getReportData(sampleNo);
    sampleReportData.value = data; // 가져온 데이터를 상태에 저장
    console.log(
      'sampleReportData.value：',
      sampleReportData.value
    );
  } catch (error) {
    console.error('Failed to fetch analysis data:', error);
  }
};

// 선택된 항목 삭제 핸들러
const deleteSelected = async (sampleNo) => {
  if (sampleNo != null) {
    try {
      // 선택된 항목 삭제 로직 추가
      console.log('삭제할 항목:', sampleNo);
      await reportApi.deleteReportData(sampleNo);
      alert('삭제가 완료되었습니다.');

      // 삭제 후 목록 페이지로 이동
      router.push('/myreport');
    } catch (error) {
      console.error('삭제 중 오류 발생:', error);
      alert('삭제 중 오류가 발생했습니다.');
    }
  } else {
    alert('삭제할 항목이 선택되지 않았습니다.');
  }
};

// 목록으로 돌아 가기
const back = () => {
  router.push('/myreport');
};

// 지도 관련된 함수
let map = null;
let marker = null;
const initializeMap = (x, y, doroJuso) => {
  const mapContainer = document.getElementById('map');
  const coords = new kakao.maps.LatLng(y, x);
  const mapOption = {
    center: coords,
    level: 6,
  };

  // 지도 생성
  map = new kakao.maps.Map(mapContainer, mapOption);
  // 마커 생성 및 표시
  marker = new kakao.maps.Marker({
    position: coords,
    map: map,
    image: new kakao.maps.MarkerImage(
      '../../src/assets/marker.svg',
      new kakao.maps.Size(40, 40)
    ),
  });
  const overlayContent = document.createElement('div');
  overlayContent.className = 'customoverlay';
  overlayContent.innerHTML = `<div class="overlayContent"
                                     style="position:relative;
                                            font-size: 18px;
                                            font-weight: bold;
                                            bottom:15px;
                                            background-color:white;"
                                    >${doroJuso}
                                </div>`;
  // 커스텀 오버레이 생성
  const customOverlay = new kakao.maps.CustomOverlay({
    position: coords,
    content: overlayContent,
    clickable: false,
    yAnchor: 2,
    zIndex: 3,
  });
  customOverlay.setMap(map);
  map.setMaxLevel(9);
};

const moveToSelectedProperty = async () => {
  try {
    const data = await addressApi.getAddressDetails(
      // sampleReportData.value.propertyNo
      sampleNo
    );
    console.log(sampleReportData.value.reportNo);

    if (
      data &&
      data[0].xcoordinate &&
      data[0].ycoordinate
    ) {
      // 가져온 좌표로 지도 초기화
      initializeMap(
        data[0].xcoordinate, // x 좌표
        data[0].ycoordinate, // y 좌표
        data[0].doroJuso // 도로명 주소
      );
    } else {
      console.error('Invalid coordinates:', data);
    }
  } catch (error) {
    console.error(
      'Failed to fetch address details:',
      error
    );
  }
};

// 컴포넌트가 마운트될 때 데이터를 가져옴
onMounted(() => {
  fetchReportData();
  moveToSelectedProperty();
});
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
/* .button {
  margin-top: 10px;
  position: absolute;
  left: 46%;
} */
</style>
