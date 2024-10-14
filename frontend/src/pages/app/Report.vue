<template>
  <div class="report-container">
    <div class="report-content">
      <!-- 리포트 제목 -->
      <div class="report-title">
        <h2>REPORT</h2>
        <div class="jusoo">
          <span class="highlight">{{ sampleReportData.address }}</span>
          에 대한 리포트가 도착했어요!
        </div>
      </div>

      <!-- 지도 및 도넛 차트 -->
      <div class="map-chart-container">
        <div class="map-container">
          <div id="map" ref="mapContainer"></div>
        </div>
        <div class="chart-container">
          <DonutChart :score="sampleReportData.totalScore" />
        </div>
      </div>

      <!-- 아코디언 메뉴 -->
      <div class="accordion-menu">
        <!-- Section 1: 안전진단 점수 - 안전 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-danger': sampleReportData.totalScore < 70,
            'faq-card-warning':
              sampleReportData.totalScore >= 70 &&
              sampleReportData.totalScore < 85,
            'faq-card-success': sampleReportData.totalScore >= 85,
          }"
        >
          <button @click="togglePanel(1)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(1) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                1. 안전진단 점수
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.totalScore < 70
                        ? 'red'
                        : sampleReportData.totalScore < 85
                        ? 'orange'
                        : 'green',
                  }"
                >
                  {{
                    sampleReportData.totalScore < 70
                      ? '위험'
                      : sampleReportData.totalScore < 85
                      ? '경고'
                      : '안전'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(1)" class="faq-answer">
            {{ sampleReportData.totalScore !== null ?
            sampleReportData.totalScore < 50 ? `안전진단 점수가
            <strong>${sampleReportData.totalScore}</strong>으로 매우 낮습니다.`
            : sampleReportData.totalScore < 70 ? `안전진단 점수가
            <strong>${sampleReportData.totalScore}</strong>으로 경고
            수준입니다.` : `안전진단 점수가
            <strong>${sampleReportData.totalScore}</strong>으로 안전하다고
            판단됩니다.` : '해당 물건에 대한 데이터가 부족합니다.' }}
          </div>
        </div>

        <!-- Section 2: 전세가율 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-null': sampleReportData.jeonseRate === null,
            'faq-card-danger': sampleReportData.jeonseRate > 90,
            'faq-card-warning':
              sampleReportData.jeonseRate > 80 &&
              sampleReportData.jeonseRate <= 90,
            'faq-card-success': sampleReportData.jeonseRate <= 80,
          }"
        >
          <button @click="togglePanel(2)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(2) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
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
                >
                  {{
                    sampleReportData.jeonseRate !== null
                      ? sampleReportData.jeonseRate < 60
                        ? '안전'
                        : sampleReportData.jeonseRate < 80
                        ? '경고'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(2)" class="faq-answer">
            {{ sampleReportData.jeonseRate !== null ?
            sampleReportData.jeonseRate < 60 ? `전세가율이
            <strong>${sampleReportData.jeonseRate}%</strong>로 안전합니다.` :
            sampleReportData.jeonseRate < 80 ? `전세가율이
            <strong>${sampleReportData.jeonseRate}%</strong>로 경고 수준입니다.`
            : `전세가율이 <strong>${sampleReportData.jeonseRate}%</strong>로
            매우 위험합니다.` : '해당 물건에 대한 데이터가 부족합니다.' }}
          </div>
        </div>

        <!-- Section 3: 소유자 = 계약자 여부 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-danger': sampleReportData.accordOwner === false,
            'faq-card-success': sampleReportData.accordOwner === true,
          }"
        >
          <button @click="togglePanel(3)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(3) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                3. 소유자와 계약자의 일치 여부
                <span
                  class="summary"
                  :style="{
                    color: !sampleReportData.accordOwner ? 'red' : 'green',
                  }"
                >
                  {{
                    sampleReportData.accordOwner !== null
                      ? sampleReportData.accordOwner
                        ? '동일'
                        : '다름'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(3)" class="faq-answer">
            {{ sampleReportData.accordOwner !== null ?
            sampleReportData.accordOwner != null &&
            !sampleReportData.accordOwner ? `소유자와 계약자가
            <strong>일치하지 않습니다</strong>.` : `소유자와 계약자가
            <strong>일치합니다</strong>.` : `해당 물건에 대한 데이터가
            부족합니다.` }}
          </div>
        </div>

        <!-- Section 4: 근저당권 채권 최고액 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-null': sampleReportData.maximumOfBond === null,
            'faq-card-danger':
              sampleReportData.maximumOfBond !== null &&
              (sampleReportData.maximumOfBond * 100) / sampleReportData.price >=
                50,
            'faq-card-warning':
              sampleReportData.maximumOfBond !== null &&
              (sampleReportData.maximumOfBond * 100) / sampleReportData.price <
                50 &&
              (sampleReportData.maximumOfBond * 100) / sampleReportData.price >
                30,
            'faq-card-success':
              sampleReportData.maximumOfBond !== null &&
              (sampleReportData.maximumOfBond * 100) / sampleReportData.price <=
                30,
          }"
        >
          <button @click="togglePanel(4)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(4) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                4. 근저당권 채권 최고액
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.maximumOfBond !== null
                        ? (sampleReportData.maximumOfBond * 100) /
                            sampleReportData.price <
                          50
                          ? (sampleReportData.maximumOfBond * 100) /
                              sampleReportData.price <=
                            30
                            ? 'green'
                            : 'orange'
                          : 'red'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.maximumOfBond !== null
                      ? `${Math.floor(
                          sampleReportData.maximumOfBond / 100000000
                        )}억 ${
                          (sampleReportData.maximumOfBond % 100000000) / 10000
                        }만원`
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(4)" class="faq-answer">
            {{ sampleReportData.maximumOfBond !== null ?
            (sampleReportData.maximumOfBond * 100) / sampleReportData.price <=
            30 ? `근저당권으로 잡힌 채권이 <strong>없어 안전</strong>합니다.` :
            (sampleReportData.maximumOfBond * 100) / sampleReportData.price < 50
            ? `근저당권 채권 최고액이 <strong>주의 수준</strong>입니다.` :
            `근저당권 채권 최고액이 <strong>위험 수준</strong>입니다.` : `해당
            물건에 대한 데이터를 불러올 수 없습니다.` }}
          </div>
        </div>

        <!-- Section 5: 건물의 주용도 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-success':
              sampleReportData.useType &&
              (sampleReportData.useType.includes('주택') ||
                sampleReportData.useType.includes('아파트') ||
                sampleReportData.useType.includes('주거') ||
                sampleReportData.useType.includes('오피스텔')),
            'faq-card-danger': sampleReportData.useType == null,
          }"
        >
          <button @click="togglePanel(5)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(5) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                5. 건물의 주용도
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.useType !== null
                        ? sampleReportData.useType.indexOf('주택') >= 0 ||
                          sampleReportData.useType.indexOf('아파트') >= 0 ||
                          sampleReportData.useType.indexOf('주거') >= 0 ||
                          sampleReportData.useType.indexOf('오피스텔') >= 0
                          ? 'green'
                          : 'red'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.useType !== null
                      ? sampleReportData.useType.includes('주택') ||
                        sampleReportData.useType.includes('아파트') ||
                        sampleReportData.useType.includes('주거') ||
                        sampleReportData.useType.includes('오피스텔')
                        ? '안전'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(5)" class="faq-answer">
            {{
              sampleReportData.useType !== null
                ? sampleReportData.useType === '주거'
                  ? '해당 건물은 주거용 건물입니다.'
                  : `해당 건물은 ${sampleReportData.useType}용 건물입니다.`
                : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
            }}
          </div>
        </div>

        <!-- Section 6: 공동소유/단독소유 여부 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-warning': sampleReportData.commonOwner === '공동소유',
            'faq-card-success': sampleReportData.commonOwner === '단독소유',
          }"
        >
          <button @click="togglePanel(6)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(6) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                6. 공동소유/단독소유 여부
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.commonOwner === '단독소유'
                        ? 'green'
                        : 'orange',
                  }"
                >
                  {{
                    sampleReportData.commonOwner !== null
                      ? sampleReportData.commonOwner === '단독소유'
                        ? '안전'
                        : '주의'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(6)" class="faq-answer">
            {{
              sampleReportData.commonOwner !== null
                ? sampleReportData.commonOwner === '단독소유'
                  ? '해당 물건은 단독 소유입니다.'
                  : '해당 물건은 공동 소유입니다.'
                : '해당 물건에 대한 데이터가 부족합니다.'
            }}
          </div>
        </div>

        <!-- Section 7: 소유권 변경 횟수 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-null': sampleReportData.changeOwnerCount === null,
            'faq-card-danger': sampleReportData.changeOwnerCount > 5,
            'faq-card-warning':
              sampleReportData.changeOwnerCount >= 3 &&
              sampleReportData.changeOwnerCount < 5,
            'faq-card-success': sampleReportData.changeOwnerCount < 3,
          }"
        >
          <button @click="togglePanel(7)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(7) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                7. 소유권 변경 횟수
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.changeOwnerCount !== null
                        ? sampleReportData.changeOwnerCount < 3
                          ? 'green'
                          : sampleReportData.changeOwnerCount >= 3 &&
                            sampleReportData.changeOwnerCount < 5
                          ? 'orange'
                          : 'red'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.changeOwnerCount !== null
                      ? sampleReportData.changeOwnerCount < 3
                        ? '안전'
                        : sampleReportData.changeOwnerCount < 5
                        ? '주의'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(7)" class="faq-answer">
            {{ sampleReportData.changeOwnerCount !== null ? `해당 물건은 총
            <strong>${sampleReportData.changeOwnerCount}</strong> 회 소유자가
            변경되었습니다.` : '해당 물건에 대한 데이터가 부족합니다.' }}
          </div>
        </div>

        <!-- Section 8: 위반건축물 여부 -->
        <div
          class="faq-card"
          :class="{
            'faq-card-null': sampleReportData.violationStructure === null,
            'faq-card-danger': sampleReportData.violationStructure === true,
            'faq-card-success': sampleReportData.violationStructure === false,
          }"
        >
          <button @click="togglePanel(8)" class="faq-btn">
            <div
              class="faq-icon"
              :class="{ 'rotate-180': openPanels.includes(8) }"
            >
              <svg
                width="20"
                height="12"
                viewBox="0 0 20 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2 2L10 10L18 2"
                  stroke="#333"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                8. 위반건축물 여부
                <span
                  class="summary"
                  :style="{
                    color: !sampleReportData.violationStructure
                      ? 'green'
                      : 'red',
                  }"
                >
                  {{
                    sampleReportData.violationStructure !== null
                      ? !sampleReportData.violationStructure
                        ? '안전'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels.includes(8)" class="faq-answer">
            {{
              sampleReportData.violationStructure !== null
                ? !sampleReportData.violationStructure
                  ? '해당 건물은 위반 건축물이 아닙니다.'
                  : '해당 건물은 위반 건축물입니다.'
                : '해당 물건에 대한 데이터가 부족합니다.'
            }}
          </div>
        </div>
      </div>
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
  openPanels.value[panelNumber] = !openPanels.value[panelNumber]; // 해당 패널의 상태만 토글
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
  ownership: null,
  price: null,
  // 다른 필드들도 여기에 추가
});

// 서버에서 데이터를 가져오는 함수
const fetchReportData = async () => {
  try {
    const data = await reportApi.getReportData(sampleNo);
    sampleReportData.value = data; // 가져온 데이터를 상태에 저장
    console.log('sampleReportData.value：', sampleReportData.value);
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

// 상세 보기 토글을 위한 변수 (여러 섹션을 열 수 있도록 배열로 설정)
const openSections = ref([]);

// 토글 함수
const toggleDetails = (no) => {
  const index = openSections.value.indexOf(no);
  if (index === -1) {
    openSections.value.push(no);
  } else {
    openSections.value.splice(index, 1);
  }
};

const moveToSelectedProperty = async () => {
  try {
    const data = await addressApi.getAddressDetails(
      // sampleReportData.value.propertyNo
      sampleNo
    );
    console.log(sampleReportData.value.reportNo);

    if (data && data[0].xcoordinate && data[0].ycoordinate) {
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
    console.error('Failed to fetch address details:', error);
  }
};

// 컴포넌트가 마운트될 때 데이터를 가져옴
onMounted(async () => {
  await fetchReportData(); // 데이터를 먼저 가져옴
  moveToSelectedProperty(); // 데이터가 로드된 후 좌표 이동
});
</script>

<style scoped>
.jusoo {
  font-size: 40px;
}

.highlight {
  font-size: 40px;
  color: blue;
}

body {
  font-size: 18px;
  line-height: 1.6;
}

.report-container {
  display: flex;
  justify-content: center;
  font-family: Arial, sans-serif;
}

.report-content {
  width: 100%;
  max-width: 1200px;
  padding: 40px;
}

.report-title {
  text-align: center;
  margin-bottom: 40px;
}

.report-title h2 {
  font-size: 48px;
  font-weight: bold;
  color: #333;
  margin-bottom: 20px;
}

.report-title p {
  font-size: 24px;
  color: #666;
}

.map-chart-container {
  display: flex;
  justify-content: center;
  gap: 40px;
  margin-bottom: 40px;
}

.map-container,
.chart-container {
  flex-basis: 45%;
  min-height: 300px;
  background-color: #f0f8ff;
  border-radius: 10px;
  padding: 20px;
  justify-content: center;
  display: flex;
}

#map {
  width: 100%;
  height: 100%;
  position: relative;
}

.accordion-menu {
  margin-bottom: 40px;
}

.faq-card {
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
  overflow: hidden;
}

.faq-btn {
  display: flex;
  align-items: center;
  width: 100%;
  padding: 20px;
  background: none;
  border: none;
  cursor: pointer;
  text-align: left;
  font-size: 22px;
}

.faq-icon {
  margin-right: 20px;
  transition: transform 0.3s ease;
}

.rotate-180 {
  transform: rotate(180deg);
}

.faq-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.summary {
  margin-left: 20px;
  font-size: 20px;
  font-weight: bold;
}

.faq-answer {
  padding: 0 20px 20px;
  font-size: 24px;
  color: #666;
}

.button-container {
  display: flex;
  justify-content: flex-end;
  gap: 20px;
}

/* 위험, 경고, 안전 등급에 따른 스타일 */
.faq-card-danger {
  background-color: #ffebeb;
  border-left: 5px solid red;
}

.faq-card-null {
  background-color: #f7f7f7;
  border-left: 5px solid #d9d9d9;
}

.faq-card-warning {
  background-color: #fff4e5;
  border-left: 5px solid orange;
}

.faq-card-success {
  background-color: #e6f7ff;
  border-left: 5px solid green;
}

.delete-btn,
.list-btn {
  padding: 15px 30px;
  font-size: 20px;
  font-weight: bold;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.delete-btn {
  background-color: #ff4d4d;
  color: white;
}

.list-btn {
  background-color: #4d79ff;
  color: white;
}

@media (max-width: 768px) {
  .map-chart-container {
    flex-direction: column;
  }

  .map-container,
  .chart-container {
    flex-basis: 100%;
  }

  .report-title h2 {
    font-size: 36px;
  }

  .faq-btn {
    font-size: 20px;
    padding: 15px;
  }

  .faq-title {
    font-size: 20px;
  }

  .summary {
    font-size: 18px;
  }

  .faq-answer {
    font-size: 20px;
  }
}
</style>
