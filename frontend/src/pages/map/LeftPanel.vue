<template>
  <div class="left-panel">
    <!-- SearchBar 컴포넌트 추가 -->
    <div class="search">
      <SearchBar @address-selected="handleAddressSelected" />
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
            {{ item }}
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
        <div v-if="selectedProperty && selectedProperty.length">
          <h2 class="apart-name">
            {{ selectedProperty[0].propertyAddrAptName }}
            <font-awesome-icon
              class="favorite-icon"
              :icon="isFavorite ? ['fas', 'star'] : ['far', 'star']"
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
              <tr v-for="(property, index) in selectedProperty" :key="index">
                <td>{{ property.date }}</td>
                <td>{{ property.contractType }}</td>
                <td>{{ property.price }}만원</td>
                <td>{{ property.propertyArea }} m²</td>
                <td>{{ property.propertyAddrFloor }}</td>
              </tr>
            </tbody>
          </table>
          <div class="analyze-button-container">
            <button @click="analyzeProperty">매물 분석하기</button>
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
  'toggle-panel',
  'update:selectedProperty',
  'move-map-to-coordinates', // 상위 컴포넌트로 좌표 전달을 위한 이벤트 추가
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
      );
    } else {
      isFavorite.value = false; // 선택된 아파트가 없으면 기본값 false
    }
  },
  { immediate: true }
);

// 즐겨찾기 아이템 토글 함수
const toggleWishlistItem = (itemName) => {
  if (wishlist.value.includes(itemName)) {
    wishlist.value = wishlist.value.filter((item) => item !== itemName);
  } else {
    wishlist.value.push(itemName);
  }
};

// 즐겨찾기에서 아이템 삭제 함수
const removeFromWishlist = (itemName) => {
  toggleWishlistItem(itemName);
  // 아이콘 상태 업데이트
  if (props.selectedProperty[0]?.propertyAddrAptName === itemName) {
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
  if (!props.selectedProperty || props.selectedProperty.length === 0) return;

  const apartmentName = props.selectedProperty[0].propertyAddrAptName;
  toggleWishlistItem(apartmentName);
  isFavorite.value = wishlist.value.includes(apartmentName);
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
  if (props.selectedProperty.length > 0 && props.selectedProperty[0].roadName) {
    // selectedProperty 배열의 첫 번째 객체의 doro 값을 추출
    const doroValue = props.selectedProperty[0].roadName;
    const buildingName = props.selectedProperty[0].propertyAddrAptName;
    router.push({
      name: 'mapAnalyzing',
      query: {
        doro: doroValue,
        buildingName: buildingName,
        
      },
    });
  }
};
</script>

<style scoped>
.left-panel {
  width: 30%;
  height: 100%;
  padding: 20px;
  position: relative;
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
</style>
