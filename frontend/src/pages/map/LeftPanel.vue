<template>
  <div class="left-panel">
    <!-- SearchBar 컴포넌트 추가 -->
    <div class="search">
      <SearchBar
        @address-selected="handleAddressSelected"
      />
    </div>

    <!-- 매매전월세 건물유형 관련 -->
    <div class="filter-container">
      <!-- 거래유형 -->
      <div class="filter-buttons">
        <button @click="toggleFilter('transactionType')">
          매매/전월세
        </button>
        <button @click="toggleFilter('buildingType')">
          건물유형
        </button>
      </div>

      <!-- 매매/전월세 -->
      <div
        v-if="activeFilter === 'transactionType'"
        class="dropdown"
      >
        <button
          :class="{
            active: selectedTransaction === '전체',
          }"
          @click="selectTransaction('전체')"
        >
          전체
        </button>
        <button
          :class="{
            active: selectedTransaction === '1',
          }"
          @click="selectTransaction('1')"
        >
          매매
        </button>
        <button
          :class="{
            active: selectedTransaction === '2',
          }"
          @click="selectTransaction('2')"
        >
          전세
        </button>
        <button
          :class="{
            active: selectedTransaction === '3',
          }"
          @click="selectTransaction('3')"
        >
          월세
        </button>
      </div>
      <div
        v-if="activeFilter === 'buildingType'"
        class="dropdown"
      >
        <button
          :class="{
            active: selectedBuilding === '전체',
          }"
          @click="selectBuilding('전체')"
        >
          전체
        </button>
        <button
          :class="{
            active: selectedBuilding === '3',
          }"
          @click="selectBuilding('3')"
        >
          연립다세대
        </button>
        <button
          :class="{
            active: selectedBuilding === '2',
          }"
          @click="selectBuilding('2')"
        >
          오피스텔
        </button>
        <button
          :class="{ active: selectedBuilding === '1' }"
          @click="selectBuilding('1')"
        >
          아파트
        </button>
        <button
          :class="{
            active: selectedBuilding === '4',
          }"
          @click="selectBuilding('4')"
        >
          단독다가구
        </button>
      </div>
    </div>

    <!-- 즐겨찾기 토글 -->
    <div class="wishlist-toggle">
      <h2 @click="toggleWishlist">
        즐겨찾기
        <span>{{ wishlistVisible ? '▲' : '▼' }}</span>
      </h2>
      <div v-if="wishlistVisible">
        <ul v-if="wishlist.length">
          <li
            v-for="(item, index) in wishlist"
            :key="index"
            @click="selectApartment(item)"
          >
            <span @click="favoriteClick(item)">{{
              item.apartmentName
            }}</span>

            <font-awesome-icon
              class="favorite-icon"
              :icon="['fas', 'star']"
              @click.stop="removeFromWishlist(item)"
              style="color: #ffd43b"
            />
          </li>
        </ul>
        <p v-else>즐겨찾기가 비어있습니다.</p>
      </div>
    </div>

    <!-- 상세보기 토글 -->
    <div class="detail-toggle">
      <h2 @click="toggleDetails">
        상세보기
        <span>{{ detailsVisible ? '▲' : '▼' }}</span>
      </h2>
      <div v-if="detailsVisible">
        <div
          v-if="selectedProperty && selectedProperty.length"
        >
          <h2 class="apart-name">
            {{ selectedProperty[0].propertyAddrAptName }}
            <font-awesome-icon
              class="favorite-icon"
              :icon="
                isFavorite
                  ? ['fas', 'star']
                  : ['far', 'star']
              "
              :style="{
                color: isFavorite ? '#FFD43B' : 'black',
              }"
              @click="toggleFavorite"
            />
          </h2>
          <h4>
            {{ selectedProperty[0].doroJuso }} (건축년도:
            {{ selectedProperty[0].buildingYear }})
          </h4>

          <!-- 실거래가 표 -->
          <table>
            <thead>
              <tr>
                <th>계약일자</th>
                <th>거래</th>
                <th>가격</th>
                <th>면적</th>
                <th>층</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(
                  property, index
                ) in selectedProperty"
                :key="index"
              >
                <td>{{ property.date }}</td>
                <td>{{ property.contractType }}</td>
                <td>{{ property.price }}억 원</td>
                <td>{{ property.propertyArea }} m²</td>
                <td>{{ property.propertyAddrFloor }}</td>
              </tr>
            </tbody>
          </table>
          <div class="analyze-button-container">
            <button @click="analyzeProperty">
              매물 분석하기
            </button>
          </div>
        </div>
        <p v-else>매물을 골라주세요.</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import SearchBar from './SearchBar.vue';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { useRouter } from 'vue-router';

const props = defineProps({
  selectedProperty: Array,
});

const emit = defineEmits([
  'update:selectedProperty',
  'move-map-to-coordinates', // 상위 컴포넌트로 좌표 전달을 위한 이벤트 추가
  'updateTransactionType',
  'updateBuildingType',
  'favoriteItem',
]);

// 즐겨찾기와 상세보기 토글 상태 관리
const wishlistVisible = ref(true);
const detailsVisible = ref(true);

// 즐겨찾기 데이터
const wishlist = ref([]); // 초기값을 비어있는 배열로 설정

// 즐겨찾기 상태 관리
const isFavorite = ref(false);

// watch를 사용해 selectedProperty가 변경될 때마다 isFavorite 업데이트
watch(
  () => props.selectedProperty,
  (newValue) => {
    if (newValue && newValue.length > 0) {
      isFavorite.value = wishlist.value.includes(
        newValue[0].propertyAddrAptName
        // newValue[0].locationNo
      );
    } else {
      isFavorite.value = false; // 선택된 아파트가 없으면 기본값 false
    }
  },
  { immediate: true }
);

// 즐겨찾기에서 상세보기
const favoriteClick = (wishlist) => {
  emit('favoriteItem', wishlist);
  console.log(wishlist);
};

// 즐겨찾기 아이템 토글 함수
const toggleWishlistItem = (item) => {
  // 아파트 이름과 locationNo가 모두 포함된 객체를 찾아서 비교
  if (item.apartmentName.startsWith('(')) {
    item.apartmentName = item.doroJuso;
  }
  console.log(item);
  const existingItemIndex = wishlist.value.findIndex(
    (wishlistItem) =>
      wishlistItem.doroJuso === item.doroJuso &&
      wishlistItem.apartmentName === item.apartmentName &&
      wishlistItem.locationNo === item.locationNo
  );

  if (existingItemIndex !== -1) {
    // 이미 있는 경우 삭제
    wishlist.value.splice(existingItemIndex, 1);
  } else {
    // 없는 경우 추가
    wishlist.value.push({
      apartmentName: item.apartmentName,
      doroJuso: item.doroJuso,
      locationNo: item.locationNo,
    });
  }
};

// 즐겨찾기에서 아이템 삭제 함수
const removeFromWishlist = (itemName) => {
  toggleWishlistItem(itemName);
  //} 아이콘 상태 업데이트
  if (
    props.selectedProperty[0]?.propertyAddrAptName ===
    itemName.apartmentName
  ) {
    isFavorite.value = false; // 상세보기에서 해당 아이콘 상태 변경
  }
};

// 토글 함수
const toggleWishlist = () => {
  wishlistVisible.value = !wishlistVisible.value;
};

const toggleDetails = () => {
  detailsVisible.value = !detailsVisible.value;
};

// 즐겨찾기 상태 토글
const toggleFavorite = () => {
  if (
    !props.selectedProperty ||
    props.selectedProperty.length === 0
  )
    return;

  const apartmentName =
    props.selectedProperty[0].propertyAddrAptName;
  const locationNo = props.selectedProperty[0].locationNo;
  const doroJuso = props.selectedProperty[0].doroJuso;
  toggleWishlistItem({
    apartmentName,
    locationNo,
    doroJuso,
  });
  // 즐겨찾기 여부 상태 업데이트
  isFavorite.value = wishlist.value.some(
    (item) =>
      item.apartmentName === apartmentName &&
      item.doroJuso === doroJuso &&
      item.locationNo === locationNo
  );
};

// 아파트 선택 함수
const selectApartment = (apartmentName) => {
  const selected = props.selectedProperty.find(
    (prop) => prop.propertyAddrAptName === apartmentName
  );
  if (selected) {
    emit('update:selectedProperty', [selected]);
  }
};

// 선택된 주소에 따른 좌표 처리
const handleAddressSelected = (coordinates) => {
  console.log('선택된 좌표:', coordinates);
  // 좌표를 상위 컴포넌트로 전달
  emit('move-map-to-coordinates', coordinates);
};

const router = useRouter();

const analyzeProperty = () => {
  if (
    props.selectedProperty.length > 0 &&
    props.selectedProperty[0].doroJuso
  ) {
    // selectedProperty 배열의 첫 번째 객체의 doro 값을 추출
    const jibunJuso = props.selectedProperty[0].jibunJuso;
    const buildingName =
      props.selectedProperty[0].propertyAddrAptName;
    const propertyNo = props.selectedProperty[0].propertyNo;
    const zipcode = props.selectedProperty[0].zipcode;
    const price = props.selectedProperty[0].price;
    
    router.push({
      name: 'mapAnalyzing',
      query: {
        jibunJuso: jibunJuso,
        buildingName: buildingName,
        propertyNo: propertyNo,
        zipcode: zipcode,
        price: price
      },
    });
  }
};

// 매매전월세 건물유형 관련
const activeFilter = ref(null); // 필터 toggle 관련
const selectedTransaction = ref('전체'); // 매매전월세 유형 디폴트값
const selectedBuilding = ref('전체'); // 건물유형 디폴트값

const toggleFilter = (filterType) => {
  activeFilter.value =
    activeFilter.value === filterType ? null : filterType;
};

const selectTransaction = (type) => {
  selectedTransaction.value = type;
  // activeFilter.value = null; // 선택이후 닫기
  emit('updateTransactionType', selectedTransaction.value);
};
const selectBuilding = (type) => {
  selectedBuilding.value = type;
  // activeFilter.value = null; // 선택이후 닫기
  emit('updateBuildingType', selectedBuilding.value);
};
</script>

<style scoped>
.left-panel {
  width: 30%;
  height: 100%;
  padding: 20px;
  position: relative;
  overflow-y: auto;
  align-content: baseline;
}

.search {
  border-bottom-width: 0px;
}

.search div {
  border-bottom: none;
}

.wishlist-toggle,
.detail-toggle {
  margin-bottom: 20px;
  cursor: pointer;
  border-bottom-width: 0px;
}

.detail-toggle div {
  border-bottom: none;
}

h2 {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 1.2em;
}

.apart-name {
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 1.5em;
}

.favorite-icon {
  margin-left: 15px;
}

h4 {
  text-align: center;
}

table {
  width: 100%;
  border-collapse: collapse;
}

table th,
table td {
  border: 1px solid #ccc;
  padding: 8px;
  text-align: center;
}

table th {
  background-color: #f4f4f4;
}

.analyze-button-container {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.analyze-button-container button {
  padding: 10px 20px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.analyze-button-container button:hover {
  background-color: #45a049;
}

/* 매매전월세 건물유형 관련 CSS */
.filter-container {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.filter-buttons {
  display: flex;
  gap: 10px;
}

.filter-buttons button {
  padding: 10px;
  background-color: #f7f7f7;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.dropdown {
  display: flex;
  gap: 8px;
  padding: 10px;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.dropdown button {
  padding: 4px;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.dropdown button.active {
  background-color: mediumaquamarine;
  color: white;
  border: 1px solid mediumaquamarine;
}
</style>
