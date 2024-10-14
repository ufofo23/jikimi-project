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
  overlays = []; // 커스텀 오버레이를 저장할 배열

const selectedTradeType = ref('전체');
const selectedBuildingType = ref('전체');

// 데이터를 서버에서 페이징 처리해서 가져오는 함수
let isFetching = false;
let cancelPagination = false;

// Property Type 별 필터링
const handleBuildingTypeUpdate = (newBuildingType) => {
  selectedBuildingType.value = newBuildingType;
  console.log('Updated Building Type: ', selectedBuildingType.value);
};
// Trade Type 별 필터링
const handleTransactionTypeUpdate = (newTradeType) => {
  selectedTradeType.value = newTradeType;
  console.log('Updated Trade Type: ', selectedTradeType.value);
};

const selectedProperty = ref(null); // 클릭된 매물 데이터를 저장할 변수
const isPanelOpen = ref(true); // 패널 열림 상태
const isMapExpanded = ref(false);

// 버튼 문구를 상태에 따라 다르게 표시
const toggleButtonText = computed(() => {
  return isPanelOpen.value ? '지도 확대' : '지도 축소';
});

// 데이터를 서버에서 페이징 처리해서 가져오는 함수
const fetchAddressData = async (lat, lon, zoomLevel, page = 1, limit = 200) => {
  if (cancelPagination) {
    console.log('Pagination cancelled.');
    return;
  }
  if (zoomLevel < 5) {
    try {
      isFetching = true;
      const response = await addressApi.getAddressListMoveAll(
        lat,
        lon,
        zoomLevel
      ); // API 호출
      const newCoordinates = response.map((item) => ({
        id: item.locationNo,
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
    } finally {
      isFetching = false;
    }
  } else {
    try {
      isFetching = true;
      const response = await addressApi.getAddressListMoveClusterAll(
        lat,
        lon,
        zoomLevel,
        page,
        limit
      );
      overlays.forEach((overlay) => overlay.setMap(null));

      const newCoordinates = response.map((item) => ({
        id: item.locationNo,
        x: parseFloat(item.xcoordinate),
        y: parseFloat(item.ycoordinate),
        price: item.price,
      }));

      if (newCoordinates.length > 0) {
        // Update the cluster with new markers
        updateMarkersCluster(newCoordinates);

        // If the data length equals the limit, fetch the next page recursively
        if (newCoordinates.length === limit && !cancelPagination) {
          await fetchAddressData(lat, lon, zoomLevel, page + 1, limit);
        } else {
          console.log('All data has been loaded.');
        }
      } else {
        console.log('No more data to load.');
      }
    } catch (error) {
      console.error('Failed to fetch address data:', error);
    } finally {
      isFetching = false;
    }
  }
};

// 지도 및 마커 클러스터러 초기화
const initializeMap = () => {
  let mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
      center: new kakao.maps.LatLng(37.5538265102548, 126.968466927468), // 기본 좌표 : 서울역
      level: 2, // 지도 확대 레벨
    };

  map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

  map.setMaxLevel(12);
  // 마커 클러스터러 초기화
  clusterer = new kakao.maps.MarkerClusterer({
    map: map, // 클러스터러에 추가할 지도 객체
    averageCenter: true, // 클러스터 마커의 중심을 마커들의 평균 좌표로 설정
    minLevel: 5, // 클러스터 할 최소 줌 레벨
    minClusterSize: 2, // 클러스터링 할 최소 마커 수 (default: 2)
    disableClickZoom: false, // 클러스터 클릭할 때 확대 방지
    averageCenter: false, // 마커 중심을 계산하지 않도록 설정
  });

  // 클러스터 크기에 따른 문구 표시
  clusterer.setTexts(function (size) {
    if (size >= 1000) {
      return '1000+';
    } else if (size >= 500) {
      return '500+';
    } else if (size >= 200) {
      return '200+';
    } else if (size >= 100) {
      return '100+';
    } else if (size >= 50) {
      return '50+';
    } else {
      return size.toString(); // 그 이하일 때는 마커 개수 그대로 표시
    }
  });

  // 클러스터 크기를 구분하는 기준 설정
  clusterer.setCalculator(function (size) {
    if (size < 50) {
      return 0; // 스타일 배열의 첫 번째 인덱스
    } else if (size < 100) {
      return 1; // 스타일 배열의 두 번째 인덱스
    } else if (size < 200) {
      return 2; // 스타일 배열의 세 번째 인덱스
    } else if (size < 500) {
      return 3; // 스타일 배열의 네 번째 인덱스
    } else if (size < 1000) {
      return 4; // 스타일 배열의 다섯 번째 인덱스
    } else {
      return 5; // 스타일 배열의 여섯 번째 인덱스
    }
  });
  // 지도 이동 및 확대/축소 이벤트 리스너 등록
  kakao.maps.event.addListener(map, 'idle', function () {
    // 지도 이동 시 이전 요청 취소
    if (isFetching) {
      cancelPagination = true;
    }

    setTimeout(() => {
      if (map) {
        cancelPagination = false;
        // 지도의 레벨과 중심 좌표를 얻어옵니다
        clusterer.removeMarkers(markers); // Remove all existing markers
        markers = []; // Clear the marker array to prepare for new markers
        const level = map.getLevel();
        const center = map.getCenter();
        const lat = center.getLat();
        const lon = center.getLng();
        markers.forEach((marker) => marker.setMap(null));
        overlays.forEach((overlay) => overlay.setMap(null));
        // 새로운 데이터를 가져옵니다
        fetchAddressData(lat, lon, level);
      }
    }, 100);
  });

  // 초기 데이터 로드
  const initialCenter = map.getCenter();
  const initialLevel = map.getLevel();
  fetchAddressData(
    initialCenter.getLat(),
    initialCenter.getLng(),
    initialLevel
  );
  // 컨트롤러 관련!!!!!!!!
  // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
  map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

  // 초기 데이터 로드할 때 해당 좌표로 설정
  // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const currentLat = position.coords.latitude;
        const currentLon = position.coords.longitude;
        const currentPosition = new kakao.maps.LatLng(currentLat, currentLon);
        map.setCenter(currentPosition);
        map.setLevel(5);
      },
      (error) => {
        console.error('Geolocation failed: ', error);
      }
    );
  }
};
// 즐겨찾기 선택시 이동하는 함수
const moveToLikedProperty = async (wishlist) => {
  try {
    const data = await addressApi.getAddressDetails(wishlist.locationNo);
    selectedProperty.value = data; // 매물 정보 저장
    // 좌표가 올바른지 확인하고 setMapCoordinates에 전달
    if (data && data[0].xcoordinate && data[0].ycoordinate) {
      setMapCoordinates({
        x: data[0].xcoordinate, // x 좌표
        y: data[0].ycoordinate, // y 좌표
        buildingName: data[0].propertyAddrAptName, // 건물 이름
        doroJuso: data[0].doroJuso, // 도로명
      });
    } else {
      console.error('Invalid coordinates:', data);
    }
  } catch (error) {
    console.error('Failed to fetch address details:', error);
  }
};

// 검색을 통해 지도를 특정 좌표로 이동시키는 함수
let infoWindows = []; // InfoWindow 객체를 저장할 배열
const setMapCoordinates = ({ x, y, buildingName, doroJuso }) => {
  setTimeout(() => {
    if (map) {
      // markers.forEach((marker) => marker.setMap(null));
      infoWindows.forEach((infoWindow) => infoWindow.close());
      const coords = new kakao.maps.LatLng(y, x); // 좌표로 LatLng 객체 생성
      map.panTo(coords);
      // map.setCenter(coords); // 지도 중심을 변경
      if (marker) {
        marker.setPosition(coords); // 마커를 새 좌표로 이동
      } else {
        marker = new kakao.maps.Marker({
          position: coords,
          map: map,
          image: new kakao.maps.MarkerImage(
            '../../src/assets/marker.svg',
            new kakao.maps.Size(40, 40)
          ),
        });
      }
      if (buildingName.startsWith('(')) {
        buildingName = doroJuso;
      }
      if (buildingName) {
        var infowindow = new kakao.maps.InfoWindow({
          position: coords,
          content: `${buildingName}`,
        });
      } else {
        var infowindow = new kakao.maps.InfoWindow({
          position: coords,
          content: `${doroJuso}`,
        });
      }
      infowindow.open(map, marker);
      // InfoWindow 배열에 추가
      infoWindows.push(infowindow);

      map.setLevel(2, { animate: true });
    } else {
      console.error('Map is not initialized yet.');
    }
  }, 100);
};

const updateMarkers = (newCoords) => {
  // 마커 이미지 설정
  const markerImage = new kakao.maps.MarkerImage(
    '../../src/assets/image-2.svg',
    new kakao.maps.Size(75, 75)
  );
  const newMarkers = newCoords.map((coord) => {
    const markerPosition = new kakao.maps.LatLng(coord.y, coord.x);
    const marker = new kakao.maps.Marker({
      position: markerPosition,
      image: markerImage,
      zIndex: 2,
    });

    // 커스텀 오버레이 HTML
    const overlayContent = document.createElement('div');
    overlayContent.className = 'customoverlay';
    overlayContent.innerHTML = `<div class="pricePopup"
                                     style="position:relative;
                                            top: 5px;
                                            font-size: 11px;
                                            font-weight: bold;
                                            right: 6px;"
                                    >${coord.price}억
                                </div>`;

    overlayContent.addEventListener('click', (event) => {
      event.stopPropagation(); // 이벤트 전파 방지
      handleClick();
    });

    // 커스텀 오버레이 생성
    const customOverlay = new kakao.maps.CustomOverlay({
      position: markerPosition, // 마커와 동일한 위치에 오버레이 표시
      content: overlayContent, // 커스텀 오버레이 내용
      clickable: false, // 오버레이 클릭을 비활성화
      yAnchor: 3,
      zIndex: 3,
    });

    // 지도에 오버레이 추가
    overlays.push(customOverlay); // 오버레이 배열에 추가
    customOverlay.setMap(map);

    // 마커 클릭 이벤트에서 매물 세부 정보를 표시하도록 함
    const handleClick = async () => {
      try {
        const data = await addressApi.getAddressDetails(coord.id);
        selectedProperty.value = data; // 매물 정보 저장
      } catch (error) {
        console.error('Failed to fetch address details:', error);
      }
    };
    // 마커에 클릭 이벤트 등록
    kakao.maps.event.addListener(marker, 'click', handleClick);
    kakao.maps.event.addListener(map, 'click', () => {
      if (!isPanelOpen.value) {
        togglePanel();
      }
    });
    return marker;
  });

  markers.push(...newMarkers); // 마커 배열에 추가
  clusterer.addMarkers(newMarkers); // 클러스터에 마커 추가

  kakao.maps.event.addListener(clusterer, 'clustered', function (clusters) {
    overlays.forEach((overlay) => overlay.setMap(null));
  });
};

// 클러스터 마커 업데이트 함수
const updateMarkersCluster = (newCoords) => {
  const markerImageSVG = new kakao.maps.MarkerImage(
    '../../src/assets/marker.svg',
    new kakao.maps.Size(0, 0)
  );

  // Batch adding markers
  const batchSize = 200;
  let currentIndex = 0;

  const addMarkersBatch = () => {
    const batchMarkers = newCoords
      .slice(currentIndex, currentIndex + batchSize)
      .map((coord) => {
        const markerPosition = new kakao.maps.LatLng(coord.y, coord.x);
        const marker = new kakao.maps.Marker({
          position: markerPosition,
          image: markerImageSVG,
        });

        markers.push(marker); // Add the new marker to the markers array
        return marker;
      });

    clusterer.addMarkers(batchMarkers); // Add new markers to the clusterer
    currentIndex += batchSize;

    if (currentIndex < newCoords.length) {
      requestAnimationFrame(addMarkersBatch); // Asynchronously process the next batch
    }
  };

  addMarkersBatch(); // Start processing the first batch of markers
};

const togglePanel = () => {
  isPanelOpen.value = !isPanelOpen.value;
  isMapExpanded.value = !isPanelOpen.value;

  // 패널이 열리고 닫힌 후 지도의 크기를 재설정하여 좌표와 마커가 정상적으로 보이게 함
  setTimeout(() => {
    if (map) {
      map.relayout(); // 패널 상태가 바뀐 후 지도의 크기를 다시 설정
    }
  }, 100);
};

// 지도 컨트롤러 관련 기능
// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
let mapTypeControl = new kakao.maps.MapTypeControl();

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
let zoomControl = new kakao.maps.ZoomControl();

// 지도 타입 정보를 가지고 있을 객체입니다
let mapTypes = {
  useDistrict: kakao.maps.MapTypeId.USE_DISTRICT,
  terrain: kakao.maps.MapTypeId.TERRAIN,
  traffic: kakao.maps.MapTypeId.TRAFFIC,
};

// 체크 박스를 선택하면 호출되는 함수입니다
// 전역 스코프에서 함수 선언
window.setOverlayMapTypeId = function () {
  var chkUseDistrict = document.getElementById('chkUseDistrict'),
    chkTerrain = document.getElementById('chkTerrain'),
    chkTraffic = document.getElementById('chkTraffic');

  // 지도 타입을 제거합니다
  for (var type in mapTypes) {
    map.removeOverlayMapTypeId(mapTypes[type]);
  }

  // 지적편집도정보 체크박스가 체크되어있으면 지도에 지적편집도정보 지도타입을 추가합니다
  if (chkUseDistrict.checked) {
    map.addOverlayMapTypeId(mapTypes.useDistrict);
  }

  // 지형정보 체크박스가 체크되어있으면 지도에 지형정보 지도타입을 추가합니다
  if (chkTerrain.checked) {
    map.addOverlayMapTypeId(mapTypes.terrain);
  }

  // 교통정보 체크박스가 체크되어있으면 지도에 교통정보 지도타입을 추가합니다
  if (chkTraffic.checked) {
    map.addOverlayMapTypeId(mapTypes.traffic);
  }
};

// 현재 위치로 이동하는 함수
window.moveToCurrentLocation = function () {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const currentLat = position.coords.latitude;
        const currentLon = position.coords.longitude;
        const currentPosition = new kakao.maps.LatLng(currentLat, currentLon);

        // var marker = new kakao.maps.Marker({
        //   map: map,
        //   position: currentPosition,
        // });
        // var infowindow = new kakao.maps.InfoWindow({
        //   position: currentPosition,
        //   content: '현재위치',
        // });
        // infowindow.open(map, marker);
        // marker.setOpacity(0);

        // 지도 중심을 현재 위치로 이동
        map.setCenter(currentPosition);
        map.setLevel(5);
      },
      (error) => {
        console.error('Geolocation failed: ', error);
        alert('현재 위치를 가져올 수 없습니다.');
      }
    );
  } else {
    // Geolocation을 지원하지 않는 경우 처리
    alert('현재 위치 기능을 사용할 수 없습니다.');
  }
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
      @move-map-to-coordinates="setMapCoordinates"
      @updateTransactionType="handleTransactionTypeUpdate"
      @updateBuildingType="handleBuildingTypeUpdate"
      @favoriteItem="moveToLikedProperty"
    />
    <div
      :class="{
        'right-panel-full': !isPanelOpen,
        'right-panel': isPanelOpen,
      }"
    >
      <!-- 수정 1: 지도 좌측 상단에 버튼 추가 -->
      <button class="toggle-panel-btn" @click="togglePanel">
        {{ toggleButtonText }}
      </button>

      <!-- 지도가 보여지는 지점 -->
      <div
        id="map"
        ref="mapContainer"
        :style="{
          width: isPanelOpen ? '100%' : '100%',
          height: '100%',
        }"
      ></div>
      <!-- 지도 아래쪽에 새로운 버튼 컨트롤러 추가 -->
      <div class="custom_maptypecontrol">
        <input
          type="checkbox"
          id="chkUseDistrict"
          onclick="setOverlayMapTypeId()"
        />지적편집도
        <input
          type="checkbox"
          id="chkTerrain"
          onclick="setOverlayMapTypeId()"
        />지형정보
        <input
          type="checkbox"
          id="chkTraffic"
          onclick="setOverlayMapTypeId()"
        />교통정보
      </div>
      <!-- 현재 위치로 이동하는 버튼 추가 -->
      <button class="location-btn" onclick="moveToCurrentLocation()">
        <i class="fa-solid fa-location-crosshairs"></i>
      </button>
    </div>
  </div>
</template>

<style scoped>
body {
  margin: 0;
  padding: 0;
}

.container {
  display: flex;
  height: 100vh;
  max-width: 100vw;
  margin: 0;
  padding: 0;
}

.container div {
  border-bottom: none;
}

.left-panel {
  width: 25%;
  padding: 20px;
  background-color: white;
  position: relative;
  border: 1px black;
  height: 90vh;
}

.right-panel {
  width: 75%;
  position: relative;
  height: 90vh;
}

.right-panel-full {
  width: 100%;
  position: relative;
}

/* 수정 1: 지도 좌측 상단에 추가된 버튼 스타일 */
.toggle-panel-btn {
  position: absolute;
  top: 15px;
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
  z-index: 100;
}

/* 지도 아래쪽에 지적편집도, 지형정보, 교통정보 버튼 컨트롤 */
.custom_maptypecontrol {
  position: absolute;
  background-color: white;
  padding: 20px;
  bottom: 20px;
  left: 38%;
  width: auto;
  z-index: 1000;
  justify-content: space-between;
  font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
  font-size: 18px;
  cursor: pointer;
  opacity: 0.5;
}

.custom_maptypecontrol:hover {
  border-color: grey;
  opacity: 1;
}
.custom_maptypecontrol input {
  margin-left: 15px;
  border-radius: 5px;
  /* background-color: #fff; */
}

.location-btn {
  position: absolute;
  bottom: 20px; /* 원하는 위치로 조정 가능 */
  right: 15px; /* 원하는 위치로 조정 가능 */
  z-index: 1000;
  background-color: #007bff;
  opacity: 0.3;
  color: white;
  border: none;
  padding: 15px;
  cursor: pointer;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.location-btn:hover {
  background-color: #0056b3;
  opacity: 1;
}

.font-awesome-icon {
  font-size: 20px;
}
</style>
