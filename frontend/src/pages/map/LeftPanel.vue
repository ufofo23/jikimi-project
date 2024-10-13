<template>
  <div class="left-panel">
    <div class="search">
      <SearchBar @address-selected="handleAddressSelected" />
    </div>

    <div class="panel-section wishlist-toggle">
      <div class="section-header" @click="toggleWishlist">
        <span class="header-text">즐겨찾기</span>
        <span class="hamburger-menu" :class="{ active: wishlistVisible }">
          <div class="bar"></div>
          <div class="bar"></div>
          <div class="bar"></div>
        </span>
      </div>
      <div v-if="wishlistVisible" class="section-content">
        <ul v-if="wishlist.length" class="wishlist">
          <li
            v-for="wish in wishlist"
            :key="wish.propertyNo"
            @click="selectApartment(wish.propertyAddrAptName)"
            class="wishlist-item"
          >
            <span @click="favoriteClick(wish)">{{ wish.doroJuso }}</span>
            <font-awesome-icon
              class="favorite-icon"
              :icon="['fas', 'star']"
              @click.stop="removeFromWishlist(wish.propertyNo)"
              style="color: #ffd43b"
            />
          </li>
        </ul>
        <p v-else class="empty-message">즐겨찾기가 비어있습니다.</p>
      </div>
    </div>

    <div class="panel-section detail-toggle">
      <div class="section-header" @click="toggleDetails">
        <span class="header-text">상세보기</span>
        <span class="hamburger-menu" :class="{ active: detailsVisible }">
          <div class="bar"></div>
          <div class="bar"></div>
          <div class="bar"></div>
        </span>
      </div>
      <div v-if="detailsVisible" class="section-content">
        <div
          v-if="selectedProperty && selectedProperty.length"
          class="property-details"
        >
          <div class="property-header">
            <h2 class="apart-name">
              {{ selectedProperty[0].propertyAddrAptName }}
              <font-awesome-icon
                class="favorite-icon"
                :icon="isFavorite ? ['fas', 'star'] : ['far', 'star']"
                :style="{
                  color: isFavorite ? '#FFD43B' : '#8E8E8E',
                }"
                @click="toggleFavorite"
              />
            </h2>
            <h4 class="address">
              {{ selectedProperty[0].doroJuso }}
              <span class="year"
                >(건축년도: {{ selectedProperty[0].buildingYear }})</span
              >
            </h4>
          </div>

          <div class="table-container">
            <table class="property-table">
              <thead>
                <tr>
                  <th>계약일자</th>
                  <th>가격</th>
                  <th>면적</th>
                  <th>층</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(property, index) in selectedProperty" :key="index">
                  <td>{{ property.date }}</td>
                  <td>{{ property.price }} 억</td>
                  <td>{{ property.propertyArea }} m²</td>
                  <td>{{ property.propertyAddrFloor }}</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="analyze-button-container">
            <button class="analyze-button" @click="analyzeProperty">
              매물 분석하기
            </button>
          </div>
        </div>
        <p v-else class="empty-message">매물을 골라주세요.</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import SearchBar from './SearchBar.vue';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { useRouter } from 'vue-router';
import api from '@/api/like/likePropertyApi';

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
const wishlist = ref([]);

const reloadWishlist = async () => {
  try {
    const response = await api.getList();
    wishlist.value = response;
  } catch (e) {
    console.log(e);
  }
};

// 즐겨찾기 상태 관리
const isFavorite = ref(false);

// watch를 사용해 selectedProperty가 변경될 때마다 isFavorite 업데이트
watch(
  () => props.selectedProperty,
  (newValue) => {
    if (newValue && newValue.length > 0) {
      let check = false;
      for (let wish of wishlist.value) {
        if (wish.locationNo === newValue[0].locationNo) {
          check = true;
        }
      }
      isFavorite.value = check;
    } else {
      isFavorite.value = false; // 선택된 아파트가 없으면 기본값 false
    }
  },
  { immediate: true }
);

// 즐겨찾기에서 상세보기
const favoriteClick = (wish) => {
  emit('favoriteItem', wish);
  console.log(wish);
};

// 즐겨찾기에서 아이템 삭제 함수
const removeFromWishlist = async (proNo) => {
  for (let wish of wishlist.value) {
    if (wish.propertyNo === proNo) {
      await api.delete(proNo);
      reloadWishlist();
    }
  }

  // 아이콘 상태 업데이트
  if (props.selectedProperty[0]?.propertyNo === proNo) {
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
const toggleFavorite = async () => {
  if (!props.selectedProperty || props.selectedProperty.length === 0) return;

  if (isFavorite.value) {
    // 즐겨찾기 O -> X
    await api.delete(props.selectedProperty[0].propertyNo);
    reloadWishlist();
  } else {
    // 즐겨찾기 X -> O
    await api.create(props.selectedProperty[0].propertyNo);
    reloadWishlist();
  }
  isFavorite.value = !isFavorite.value;
};

// 아파트 선택 함수
const selectApartment = (propertyAddrAptName) => {
  const selected = props.selectedProperty.find(
    (prop) => prop.propertyAddrAptName === propertyAddrAptName
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
  if (props.selectedProperty.length > 0 && props.selectedProperty[0].doroJuso) {
    // selectedProperty 배열의 첫 번째 객체의 doro 값을 추출
    const jibunJuso = props.selectedProperty[0].jibunJuso;
    const buildingName = props.selectedProperty[0].propertyAddrAptName;
    const propertyNo = props.selectedProperty[0].propertyNo;
    const zipCode = props.selectedProperty[0].zipCode;
    const price = props.selectedProperty[0].price;

    router.push({
      name: 'mapAnalyzing',
      query: {
        jibunJuso: jibunJuso,
        buildingName: buildingName,
        propertyNo: propertyNo,
        zipCode: zipCode,
        price: price,
      },
    });
  }
};

// 매매전월세 건물유형 관련
const activeFilter = ref(null); // 필터 toggle 관련
const selectedTransaction = ref('전체'); // 매매전월세 유형 디폴트값
const selectedBuilding = ref('전체'); // 건물유형 디폴트값

const toggleFilter = (filterType) => {
  activeFilter.value = activeFilter.value === filterType ? null : filterType;
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

onMounted(() => {
  reloadWishlist();
});
</script>

<style scoped>
.left-panel {
  width: 30%;
  height: 100%;
  padding: 24px;
  position: relative;
  overflow-y: auto;
  background-color: #ffffff;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
}

.panel-section {
  margin-bottom: 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #1a73e8;
  color: white;
  border-radius: 12px 12px 0 0;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.section-header:hover {
  background: #1557b0;
}

.header-text {
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 0.5px;
}

.section-content {
  padding: 20px;
  background: #fff;
  border-radius: 0 0 12px 12px;
}

.hamburger-menu {
  width: 24px;
  height: 18px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.hamburger-menu .bar {
  width: 100%;
  height: 2px;
  background-color: #fff;
  transition: all 0.3s ease;
  border-radius: 2px;
}

.hamburger-menu.active .bar:nth-child(1) {
  transform: translateY(8px) rotate(45deg);
}

.hamburger-menu.active .bar:nth-child(2) {
  opacity: 0;
}

.hamburger-menu.active .bar:nth-child(3) {
  transform: translateY(-8px) rotate(-45deg);
}

.wishlist {
  list-style: none;
  padding: 0;
  margin: 0;
}

.wishlist-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  margin-bottom: 8px;
  background: #f8f9fa;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.wishlist-item:hover {
  background: #e9ecef;
  transform: translateX(4px);
}

.property-header {
  text-align: center;
  margin-bottom: 24px;
}

.apart-name {
  font-size: 24px;
  color: #1a73e8;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
}

.address {
  font-size: 14px;
  color: #666;
  margin: 0;
}

.year {
  color: #888;
  font-size: 13px;
}

.table-container {
  margin: 20px 0;
  border-radius: 8px;
  overflow: auto;
}

.property-table {
  width: 100%;

  border-collapse: separate;
  border-spacing: 0;
  background: white;
}

.property-table th {
  background: #1a73e8;
  color: white;
  padding: 12px;
  font-weight: 500;
  text-align: center;
}

.property-table td {
  padding: 12px;
  text-align: center;
  border-bottom: 1px solid #e0e0e0;
  color: #333;
}
.property-table tbody tr:hover {
  background-color: #f8f9fa;
}

.empty-message {
  text-align: center;
  color: #666;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.analyze-button-container {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

.analyze-button {
  background: #1a73e8;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 2px 4px rgba(26, 115, 232, 0.2);
}

.analyze-button:hover {
  background: #1557b0;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(26, 115, 232, 0.3);
}

.favorite-icon {
  cursor: pointer;
  transition: transform 0.2s ease;
}

.favorite-icon:hover {
  transform: scale(1.2);
}

.search {
  margin-bottom: 24px;
}

@media (max-width: 768px) {
  .left-panel {
    width: 100%;
    max-width: none;
    height: auto;
    padding: 16px;
  }

  .section-header {
    padding: 12px 16px;
  }

  .header-text {
    font-size: 16px;
  }

  .apart-name {
    font-size: 20px;
  }

  .address {
    font-size: 12px;
  }

  .property-table th,
  .property-table td {
    padding: 8px;
    font-size: 14px;
  }

  .analyze-button {
    padding: 10px 20px;
    font-size: 14px;
  }
}
</style>
