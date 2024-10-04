<script setup>
import { ref, onMounted } from 'vue';
import addressApi from '@/api/mapApi'; // addressApi.js 임포트
import HouseSearchBar from './SearchBar.vue'; // HouseSearchBar 임포트
import LeftPanel from './LeftPanel.vue';

const mapContainer = ref(null); // 지도 컨테이너
const coordinates = ref([]); // API로부터 받아온 좌표 데이터를 저장할 변수
const selectedProperty = ref(null); // 클릭된 매물 데이터를 저장할 변수
let map, marker, clusterer;

const isPanelOpen = ref(true); // 패널 열림 상태

const fetchAddressData = async () => {
  try {
    const response = await addressApi.getAddressList(); // API 호출
    coordinates.value = response.map((item) => ({
      id: item.locationNo,
      doroJuso: item.roadName,
      x: parseFloat(item.xcoordinate), // 데이터 필드 이름을 정확히 맞춤
      y: parseFloat(item.ycoordinate), // 데이터 필드 이름을 정확히 맞춤
      price: item.recentPrice,
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

const initializeMap = () => {
  if (!coordinates.value.length) {
    console.error('No coordinates available to initialize the map');
    return;
  }

  // 지도 초기화 옵션
  const mapOption = {
    center: new kakao.maps.LatLng(37.4704921415939, 126.86576788731625), // 기본 지도 중심좌표
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
  const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

  // 좌표 데이터를 기반으로 마커 표시 + 클러스터
  const markers = coordinates.value.map((coord) => {
    const markerPosition = new kakao.maps.LatLng(coord.y, coord.x);

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

    // 마커 클릭 이벤트에서 매물 세부 정보를 표시하도록 함
    const handleClick = async () => {
      try {
        const data = await addressApi.getAddressDetails(coord.id);
        selectedProperty.value = data; // Assuming data is a list
      } catch (error) {
        console.error('Failed to fetch address details:', error);
      }
    };

    // 마커에 클릭 이벤트 등록
    kakao.maps.event.addListener(marker, 'click', handleClick);

    return marker;
  });

  // //클러스터에 마커 추가
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
};

const togglePanel = () => {
  isPanelOpen.value = !isPanelOpen.value;
};

onMounted(() => {
  fetchAddressData(); // 데이터를 로드하고 나서 지도 초기화 호출
});
</script>

<template>
  <HouseSearchBar @address-selected="setMapCoordinates" />
  <!-- HouseSearchBar 컴포넌트 추가 -->
  <div class="container">
    <!-- LeftPanel 컴포넌트 추가 -->
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
      <button v-if="!isPanelOpen" @click="togglePanel" class="toggle-btn-open">
        목록 열기
      </button>
      <div id="map" ref="mapContainer" style="width: 100%; height: 600px"></div>
    </div>
  </div>
</template>

<style scoped>
.container {
  display: flex;
  /* height: 100vh; 전체 높이를 사용 */
}

.left-panel {
  width: 30%;
  padding: 20px;
  background-color: white;
  position: relative;
  border: 1px black;
}

.right-panel {
  width: 70%;
  position: relative;
}

.right-panel-full {
  width: 100%;
  position: relative;
}

.toggle-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: blue;
  color: white;
  padding: 5px;
  cursor: pointer;
  border-radius: 5px;
}

.toggle-btn-open {
  position: absolute;
  z-index: 200;
  top: 10px;
  left: 10px;
  background-color: blue;
  color: white;
  padding: 5px;
  cursor: pointer;
  border-radius: 5px;
}

.customoverlay {
  position: absolute;
  float: left;
  text-align: center;
}
.customoverlay .price {
  font-size: 14px;
  bottom: 10px;

  font-weight: bold;
  color: blueviolet;
  margin-left: -14px;
}
</style>
