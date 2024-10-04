<script setup>
import { ref, onMounted, computed } from 'vue';
import addressApi from '@/api/mapApi'; // addressApi.js 임포트
import LeftPanel from './LeftPanel.vue';

const mapContainer = ref(null); // 지도 컨테이너
const coordinates = ref([]); // API로부터 받아온 좌표 데이터를 저장할 변수
let map,
  clusterer,
  marker,
  markers = [], // 현재 지도에 표시된 마커들을 저장할 배열
  clustermarker,
  overlays = []; // 커스텀 오버레이를 저장할 배열

const selectedProperty = ref(null); // 클릭된 매물 데이터를 저장할 변수
const isPanelOpen = ref(true); // 패널 열림 상태
const isMapExpanded = ref(false);
const someValue = ref(10);
const doubleValue = computed(() => someValue.value * 2);

// 버튼 문구를 상태에 따라 다르게 표시
const toggleButtonText = computed(() => {
  return isPanelOpen.value ? '지도 확대' : '지도 축소';
});

// 데이터를 서버에서 페이징 처리해서 가져오는 함수
const fetchAddressData = async (lat, lon, zoomLevel) => {
  if (zoomLevel < 6) {
    try {
      const response = await addressApi.getAddressListMove(
        lat,
        lon,
        zoomLevel
      ); // API 호출
      const newCoordinates = response.map((item) => ({
        id: item.id,
        x: parseFloat(item.xcoordinate),
        y: parseFloat(item.ycoordinate),
        price: item.price,
      }));

      // 클러스터에 저장된 마커를 제거
      clusterer.clear();
      coordinates.value.push(...newCoordinates); // 새 데이터를 기존 데이터에 추가
      updateMarkers(newCoordinates); // 새로운 데이터만 마커 추가
    } catch (error) {
      console.error('Failed to fetch address data:', error);
    }
  } else {
    try {
      const response =
        await addressApi.getAddressListMoveCluster(
          lat,
          lon,
          zoomLevel
        ); // API 호출
      const newCoordinates = response.map((item) => ({
        x: parseFloat(item.xcoordinate),
        y: parseFloat(item.ycoordinate),
      }));

      // 클러스터에 저장된 마커를 제거
      clusterer.clear();
      markers.forEach((marker) => {
        marker.setMap(null); // 마커를 숨김
      });
      overlays.forEach((overlay) => {
        overlay.setVisible(false); // 오버레이를 숨김
      });
      updateMarkersCluster(newCoordinates); // 새로운 데이터만 마커 추가
    } catch (error) {
      console.error('Failed to fetch address data:', error);
    }
  }
};

// 지도 및 마커 클러스터러 초기화
const initializeMap = () => {
  // 지도 초기화
  map = new kakao.maps.Map(mapContainer.value, {
    center: new kakao.maps.LatLng(37.54699, 127.09598), // 기본 좌표
    level: 5, // 지도 확대 레벨
  });

  // 마커 클러스터러 초기화
  clusterer = new kakao.maps.MarkerClusterer({
    map: map, // 클러스터러에 추가할 지도 객체
    averageCenter: true, // 클러스터 마커의 중심을 마커들의 평균 좌표로 설정
    minLevel: 6, // 클러스터 할 최소 줌 레벨
    minClusterSize: 1, // 클러스터링 할 최소 마커 수 (default: 2)
    disableClickZoom: false, // 클러스터 클릭할 때 확대 방지
  });

  // 지도 이동 및 확대/축소 이벤트 리스너 등록
  kakao.maps.event.addListener(map, 'idle', function () {
    // 지도의 레벨과 중심 좌표를 얻어옵니다
    const level = map.getLevel();
    const center = map.getCenter();
    const lat = center.getLat();
    const lon = center.getLng();

    // 새로운 데이터를 가져옵니다
    fetchAddressData(lat, lon, level);
  });

  // 초기 데이터 로드
  const initialCenter = map.getCenter();
  const initialLevel = map.getLevel();
  fetchAddressData(
    initialCenter.getLat(),
    initialCenter.getLng(),
    initialLevel
  );
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

// 마커 이미지 설정
const imageSrc = '../../src/assets/image (2).png';
const imageSize = new kakao.maps.Size(80, 80);
const markerImage = new kakao.maps.MarkerImage(
  imageSrc,
  imageSize
);

const updateMarkers = (newCoords) => {
  markers.forEach((marker) => marker.setMap(null));
  overlays.forEach((overlay) => overlay.setMap(null));

  const newMarkers = newCoords.map((coord) => {
    const markerPosition = new kakao.maps.LatLng(
      coord.y,
      coord.x
    );
    const marker = new kakao.maps.Marker({
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
      zIndex: 3,
    });

    // 지도에 오버레이 추가
    overlays.push(customOverlay); // 오버레이 배열에 추가
    customOverlay.setMap(map);

    // 마커 클릭 이벤트에서 매물 세부 정보를 표시하도록 함
    const handleClick = async () => {
      try {
        const data = await addressApi.getAddressDetails(
          coord.id
        );
        selectedProperty.value = data; // 매물 정보 저장
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
    kakao.maps.event.addListener(map, 'click', (event) => {
      if (!isPanelOpen.value) {
        toggleMapSize();
      }
    });
    return marker;
  });

  markers.push(...newMarkers); // 마커 배열에 추가
  clusterer.addMarkers(newMarkers); // 클러스터에 마커 추가
};

const updateMarkersCluster = (newCoords) => {
  // 새로운 마커 추가
  const newClusterMarker = newCoords.map((coord) => {
    const markerPosition = new kakao.maps.LatLng(
      coord.y,
      coord.x
    );
    const clustermarker = new kakao.maps.Marker({
      position: markerPosition,
    });

    return clustermarker;
  });
  clusterer.addMarkers(newClusterMarker); // 클러스터에 마커 추가
};

const togglePanel = () => {
  isPanelOpen.value = !isPanelOpen.value;
  // 패널이 열리고 닫힌 후 지도의 크기를 재설정하여 좌표와 마커가 정상적으로 보이게 함
  setTimeout(() => {
    if (map) {
      map.relayout(); // 패널 상태가 바뀐 후 지도의 크기를 다시 설정
    }
  }, 0);
};
onMounted(() => {
  initializeMap(); // 지도 초기화 및 데이터 로드
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
      <button
        class="toggle-panel-btn"
        @click="toggleLeftPanel"
      >
        {{ toggleButtonText }}
      </button>

      <div
        id="map"
        ref="mapContainer"
        :style="{
          width: isPanelOpen ? '100%' : '100%',
          height: '100vh',
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
