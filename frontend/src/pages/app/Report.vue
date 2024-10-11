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
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.totalScore < 50
                  ? 'red'
                  : sampleReportData.totalScore < 70
                  ? 'orange'
                  : 'green',
            }"
            >{{
              sampleReportData.totalScore < 50
                ? '위험'
                : sampleReportData.totalScore < 70
                ? '경고'
                : '안전'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[1]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.totalScore !== null
                ? sampleReportData.totalScore < 50
                  ? `안전진단 점수가 ${sampleReportData.totalScore}으로 매우 낮습니다. 이 물건은 상당한 위험이 있을 수 있으므로 계약 전에 철저한 검토가 필요합니다.`
                  : sampleReportData.totalScore < 70
                  ? `안전진단 점수가 ${sampleReportData.totalScore}으로 경고 수준입니다. 이 물건은 안전하지 않을 가능성이 있으며, 신중한 선택이 필요합니다.`
                  : `안전진단 점수가 ${sampleReportData.totalScore}으로 안전하다고 판단됩니다. \n
                  그래도 집 계약때까지 신중함을 잃지마세요!`
                : '해당 물건에 대한 데이터가 부족합니다. 내용을 분석할 수 없습니다.'
            }}
          </p>
        </div>

        <!-- Section 2: 전세가율 - 80% -->
        <button @click="togglePanel(2)" class="sec">
          2. 전세가율
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.jeonseRate !== null
                  ? sampleReportData.jeonseRate < 70
                    ? 'green'
                    : sampleReportData.jeonseRate < 90
                    ? 'orange'
                    : 'red'
                  : 'black',
            }"
            >{{
              sampleReportData.jeonseRate !== null
                ? sampleReportData.jeonseRate < 60
                  ? '안전'
                  : sampleReportData.jeonseRate < 80
                  ? '경고'
                  : '위험'
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[2]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.jeonseRate !== null
                ? sampleReportData.jeonseRate < 60
                  ? `전세가율이 ${sampleReportData.jeonseRate}%로 안전합니다.`
                  : sampleReportData.jeonseRate < 80
                  ? `전세가율이 ${sampleReportData.jeonseRate}%로 경고 수준입니다. 전세가율이 적절하지 않아 리스크가 있을 수 있습니다.`
                  : `전세가율이 ${sampleReportData.jeonseRate}%로 매우 위험합니다. 전세가율이 낮을수록 보증금 회수의 위험이 커집니다. 계약에 신중을 기하세요.`
                : '해당 물건에 대한 데이터 부족합니다. 내용을 분석할 수 없습니다.'
            }}
          </p>
        </div>

        <!-- Section 3: 소유자 = 계약자 여부 - 동일 -->
        <button @click="togglePanel(3)" class="sec">
          3. 소유자와 계약자의 일치 여부
          <span
            class="summary"
            :style="{
              color: !sampleReportData.accordOwner
                ? 'red'
                : 'green',
            }"
            >{{
              !sampleReportData.accordOwner
                ? '다름'
                : '동일'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[3]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.accordOwner == null
                ? sampleReportData.accordOwner != null &&
                  !sampleReportData.accordOwner
                  ? `소유자 ${sampleReportData.ownership}와 계약자 ${sampleReportData.contractName}은 일치하지 않습니다. 계약을 진행하기 전에 반드시
                      등기부등본을 다시 확인하고 소유자의 동의 여부를확인하세요.`
                  : `소유자 ${sampleReportData.ownership}와 계약자 ${sampleReportData.contractName}은 일치합니다.`
                : '해당 물건에 대한 데이터 부족합니다. 내용을 분석할 수 없습니다'
            }}
          </p>
        </div>

        <!-- Section 4: 근저당권 채권 최고액 - 5억 -->
        <button @click="togglePanel(4)" class="sec">
          4. 근저당권 채권 최고액
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.maximumOfBond !== null
                  ? sampleReportData.maximumOfBond > 0
                    ? 'red'
                    : 'green'
                  : 'black',
            }"
          >
            {{
              sampleReportData.maximumOfBond !== null
                ? sampleReportData.maximumOfBond >= 10000
                  ? `${Math.floor(
                      sampleReportData.maximumOfBond / 10000
                    )}억 ${
                      sampleReportData.maximumOfBond % 10000
                    }만원`
                  : `안전`
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[4]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.maximumOfBond !== null
                ? sampleReportData.maximumOfBond > 0
                  ? `근저당권 채권 최고액이 ${sampleReportData.maximumOfBond}만원으로 위험 수준입니다. 보증금 반환에 대한 리스크를 고려하여 계약에 신중하세요.`
                  : `근저당권으로 잡힌 채권이 없어 안전합니다.`
                : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
            }}
          </p>
          <p>
            근저당권 설정 금액을 꼭 확인하여 임대인이 빚을
            갚지 못할 경우 보증금 보호가 가능한지
            판단하세요.
          </p>
        </div>

        <!-- Section 5: 건물의 주용도 (거주 등등) - 거주 -->
        <button @click="togglePanel(5)" class="sec">
          5. 건물의 주용도
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.useType !== null
                  ? sampleReportData.useType > 0
                    ? 'green'
                    : 'red'
                  : 'black',
            }"
            >{{
              sampleReportData.useType !== null
                ? sampleReportData.useType > 0
                  ? '안전'
                  : '위험'
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[5]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            전세자금 대출 가능 여부는 주용도에 따라 달라질
            수 있습니다.
          </p>
          <p>
            {{
              sampleReportData.useType !== null
                ? sampleReportData.useType == '주거'
                  ? '해당 건물은 주거용 건물입니다.'
                  : `해당 건물은 ${sampleReportData.useType}용 건물입니다. \n 근린생활시설 같은 경우 주거용 건물이 아니기 때문에 전세자금 대출이 어려울 수 있으니, 집 알아볼 때 유의하세요!`
                : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
            }}
          </p>
        </div>

        <!-- Section 6: 대지권등기 - 있음 -->
        <button @click="togglePanel(6)" class="sec">
          6. 대지권등기
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.kindOfLandrights !== null
                  ? sampleReportData.kindOfLandrights ==
                    '주거'
                    ? 'green'
                    : 'orange'
                  : 'black',
            }"
            >{{
              sampleReportData.kindOfLandrights !== null
                ? sampleReportData.kindOfLandrights > 0
                  ? '안전'
                  : '주의'
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[6]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.kindOfLandrights !== null
                ? sampleReportData.kindOfLandrights > 0
                  ? `해당 물건에 대한 대지권은 ${sampleReportData.kindOfLandrights}㎡ 입니다.`
                  : '해당 물건은 대지에 대한 권리가 없습니다. 대지권이 없다면 주택의 가치가 하락할 수 있으니 주의하세요.'
                : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
            }}
          </p>
        </div>

        <!-- Section 7: 공동소유/ 단독소유 여부 - 단독 -->
        <button @click="togglePanel(7)" class="sec">
          7. 공동소유 단독소유 여부
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.commonOwner !== null
                  ? sampleReportData.commonOwner.length == 1
                    ? 'green'
                    : 'orange'
                  : 'black',
            }"
            >{{
              sampleReportData.commonOwner !== null
                ? sampleReportData.commonOwner.length == 1
                  ? '안전'
                  : '주의'
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[7]"
          class="panel bg-blue-100 p-4"
        >
          <div v-if="sampleReportData.commonOwner === null">
            해당 물건에 대한 데이터 부족합니다. 내용을
            분석할 수 없습니다
          </div>

          <div
            v-if="sampleReportData.commonOwner === '단독'"
          >
            <p>해당 물건은 단독 소유입니다.</p>
          </div>
          <div v-else>
            <p>
              해당 물건은 공동 소유입니다. 계약 시 소유자
              전원의 동의를 확인하세요.
            </p>
          </div>
        </div>

        <!-- Section 8: 소유권 변경 횟수 - 2회 (압류/가압류) -->
        <button @click="togglePanel(8)" class="sec">
          8. 소유권 변경 횟수
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.changeOwnerCount !== null
                  ? sampleReportData.changeOwnerCount < 3
                    ? 'green'
                    : 'orange'
                  : 'black',
            }"
            >{{
              sampleReportData.changeOwnerCount !== null
                ? sampleReportData.changeOwnerCount < 3
                  ? '안전'
                  : `${sampleReportData.changeOwnerCount}회`
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[8]"
          class="panel bg-blue-100 p-4"
        >
          <div
            v-if="
              sampleReportData.changeOwnerCount === null
            "
          >
            해당 물건에 대한 데이터 부족합니다. 내용을
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

        <!-- Section 9: 위반건축물 여부 - true-->
        <button @click="togglePanel(9)" class="sec">
          9. 위반건축물 여부
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.violationStructure != null
                  ? !sampleReportData.violationStructure
                    ? 'green'
                    : 'red'
                  : 'black',
            }"
            >{{
              sampleReportData.violationStructure != null
                ? !sampleReportData.violationStructure
                  ? '안전'
                  : '위험'
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[9]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.violationStructure != null
                ? !sampleReportData.violationStructure
                  ? '위반건축물과 관련된 내용이 없습니다.'
                  : '위반건축물과 관련된 사항이 있습니다. 위반 건축물은 주택임대차보호법 적용을 받지 않아 전입신고를 할 수 없으며 보증금 보호가 어렵습니다. '
                : '해당 물건에 대한 데이터가 부족합니다. 내용을 분석할 수 없습니다'
            }}
          </p>
        </div>
        <!-- Section 10: 전유 부분 (건물 소유 면적) - 85㎡ -->
        <button @click="togglePanel(10)" class="sec">
          10. 전유 부분 (건물 소유 면적)
          <span
            class="summary"
            :style="{
              color:
                sampleReportData.ownerState != null
                  ? 'blue'
                  : 'black',
            }"
            >{{
              sampleReportData.ownerState != null
                ? `${sampleReportData.ownerState}㎡`
                : '해당없음'
            }}</span
          >
        </button>
        <div
          v-show="openPanels[10]"
          class="panel bg-blue-100 p-4"
        >
          <p>
            {{
              sampleReportData.ownerState != null
                ? `해당 물건에서 전유 부분의 건물 소유에 대한 면적은 총 ${sampleReportData.ownerState}㎡ 입니다.`
                : '해당 물건에 대한 데이터가 부족합니다. 내용을 분석할 수 없습니다'
            }}
          </p>
        </div>
      </div>
      <div class="d-flex justify-content-end mt-3">
        <button
          class="btn btn-danger p-3 px-4"
          style="font: 20px bold"
          @click="deleteSelected(sampleNo)"
        >
          삭제
        </button>

        <button
          class="btn btn-primary ml-4 p-3 px-4"
          style="font: 20px bold"
          @click="back"
        >
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
