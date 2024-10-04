<script setup>
import { ref, onMounted, computed } from 'vue';
import addressApi from '@/api/mapApi'; // addressApi.js 임포트
import LeftPanel from './LeftPanel.vue';

const mapContainer = ref(null); // 지도 컨테이너
const coordinates = ref([]); // API로부터 받아온 좌표 데이터를 저장할 변수
const selectedProperty = ref(null); // 클릭된 매물 데이터를 저장할 변수
let map, marker, clusterer;

const isPanelOpen = ref(true); // 패널 열림 상태
const isMapExpanded = ref(false);
const someValue = ref(10);
const doubleValue = computed(() => someValue.value * 2);

// 버튼 문구를 상태에 따라 다르게 표시
const toggleButtonText = computed(() => {
  return isPanelOpen.value ? '지도 확대' : '지도 축소';
});

const fetchAddressData = async () => {
  try {
    const response = await addressApi.getAddressList(); // API 호출
    coordinates.value = response.map((item) => ({
      id: item.id,
      doroJuso: item.doroJuso,
      x: parseFloat(item.xcoordinate), // 데이터 필드 이름을 정확히 맞춤
      y: parseFloat(item.ycoordinate), // 데이터 필드 이름을 정확히 맞춤
      price: item.price,
    }));

    initializeMap(); // 데이터를 로드한 후 지도를 초기화합니다.
  } catch (error) {
    console.error('Failed to fetch address data:', error);
  }
};

// 검색을 통해 지도를 특정 좌표로 이동시키는 함수
const setMapCoordinates = ({ x, y }) => {
  if (map) {
    const coords = new kakao.maps.LatLng(y, x); // 좌표로 LatLng 객체 생성
    map.setCenter(coords); // 지도 중심을 변경
    if (marker) {
      marker.setPosition(coords); // 마커를 새 좌표로 이동
    } else {
      marker = new kakao.maps.Marker({
        position: coords,
        map: map,
      });
    }
  } else {
    console.error('Map is not initialized yet.');
  }
};

const toggleMapSize = () => {
  isMapExpanded.value = !isMapExpanded.value;
  isPanelOpen.value = !isMapExpanded.value;

  if (map) {
    map.relayout();
  }
};

const toggleLeftPanel = () => {
  isPanelOpen.value = !isPanelOpen.value;
  if (map) {
    map.relayout();
  }
};

const initializeMap = () => {
  if (!coordinates.value.length) {
    console.error(
      'No coordinates available to initialize the map'
    );
    return;
  }

  // 지도 초기화 옵션
  const mapOption = {
    center: new kakao.maps.LatLng(
      37.4704921415939,
    126.86576788731625
    ), // 기본 지도 중심좌표
    level: 4, // 지도 확대 레벨
  };

  // 지도 초기화
  map = new kakao.maps.Map(mapContainer.value, mapOption);

  // // 마커 클러스터러 생성
  // clusterer = new kakao.maps.MarkerClusterer({
  //   map: map, // 클러스터를 적용할 지도
  //   averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
  //   minLevel: 8, // 클러스터 할 최소 지도 레벨
  //   disableClickZoom: true, // 클러스터 클릭 시 확대하지 않도록 설정
  // });

  // 마커 이미지 설정
  const imageSrc = '../../src/assets/image (2).png';
  const imageSize = new kakao.maps.Size(80, 80);
  const markerImage = new kakao.maps.MarkerImage(
    imageSrc, 
    imageSize
  );

  // 좌표 데이터를 기반으로 마커 표시 + 클러스터
  const markers = coordinates.value.map((coord) => {
  const markerPosition = new kakao.maps.LatLng(
    coord.y,
    coord.x
  );
    
    // 마커 생성
    const marker = new kakao.maps.Marker({
      map: map,
      position: markerPosition,
      image: markerImage,
    });

    // 커스텀 오버레이 HTML
    const overlayContent = document.createElement('div');
    overlayContent.className = 'customoverlay';
    overlayContent.innerHTML = `<span class="price">${coord.price}억</span><br/>`;

    overlayContent.addEventListener('click', (event) => {
      event.stopPropagation(); // 이벤트 전파 방지
      handleClick();
    });
    // 커스텀 오버레이 생성
    const customOverlay = new kakao.maps.CustomOverlay({
      position: markerPosition, // 마커와 동일한 위치에 오버레이 표시
      content: overlayContent, // 커스텀 오버레이 내용
      clickable: false, // 오버레이 클릭을 비활성화
      yAnchor: 1,
    });

    // 초기에는 오버레이를 숨김
    customOverlay.setMap(map);

    //클러스터에 마커 추가
  // clusterer.addMarkers(markers);
  // // 마커 클러스터에 클릭 이벤트 등록
  // kakao.maps.event.addListener(
  //   clusterer,
  //   'clusterclick',
  //   function (cluster) {
  //     const level = map.getLevel() - 1;
  //     map.setLevel(level, { anchor: cluster.getCenter() });
  //   }
  // );

    // 마커 클릭 이벤트에서 매물 세부 정보를 표시하도록 함
    const handleClick = async () => {
      try {
        const data = await addressApi.getAddressDetails(
          coord.id
        );
        selectedProperty.value = data; // Assuming data is a list
      } catch (error) {
        console.error(
          'Failed to fetch address details:',
          error
        );
      }
    };

    // 마커에 클릭 이벤트 등록
    kakao.maps.event.addListener(
      marker,
      'click',
      handleClick
    );

    return marker;
  });

  kakao.maps.event.addListener(map, 'click', (event) => {
    if (!isPanelOpen.value) {
      toggleMapSize();
    }
  });
};

const handleClick = async (coord) => {
  try {
    const data = await addressApi.getAddressDetails(coord.id);
    selectedProperty.value = data; // 클릭한 마커의 정보를 업데이트
  } catch (error) {
    console.error('Failed to fetch address details:', error);
  }
};

const togglePanel = () => {
  isPanelOpen.value = !isPanelOpen.value;
};

onMounted(() => {
  fetchAddressData(); // 데이터를 로드하고 나서 지도 초기화 호출
});
</script>

<template>
  <div class="container">
    <LeftPanel
      v-if="isPanelOpen"
      :selectedProperty="selectedProperty"
      @toggle-panel="togglePanel"
    />

    <div
      :class="{
        'right-panel-full': !isPanelOpen,
        'right-panel': isPanelOpen,
      }"
    >
      <!-- 수정 1: 지도 좌측 상단에 버튼 추가 -->
      <button class="toggle-panel-btn" @click="toggleLeftPanel">
        {{ toggleButtonText }}
      </button>

      <div
        id="map"
        ref="mapContainer"
        :style="{
          width: isPanelOpen ? '100%' : '100%',
          height: '100vh'
        }"
      ></div>
    </div>
  </div>
</template>

<style scoped>
.container {
  display: flex;
  height: 100vh;
}

.container div {
  border-bottom: none;
}

.left-panel {
  width: 30%;
  padding: 20px;
  background-color: white;
  position: relative;
  border: 1px black;
  height: 95vh;
}

.right-panel {
  width: 70%;
  position: relative;
  height: 95vh;
}

.right-panel-full {
  width: 100%;
  position: relative;
  height: 95vh;
}

/* 수정 1: 지도 좌측 상단에 추가된 버튼 스타일 */
.toggle-panel-btn {
  position: absolute;
  top: 10px;
  left: 10px;
  z-index: 1000;
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px;
  cursor: pointer;
  border-radius: 5px;
}

.toggle-panel-btn:hover {
  background-color: #0056b3;
}

#map {
  position: relative;
}

/* 버튼을 헤더가 아닌 지도 위에 정확히 위치시킴 */
#map .toggle-panel-btn {
  position: absolute;
  top: 10px;
  left: 10px;
  z-index: 1000;
}
</style>
