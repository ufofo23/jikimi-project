<template>
  <div class="left-panel">
    <div class="search">
      <SearchBar
        @address-selected="handleAddressSelected"
      />
    </div>
    <div class="panel-content">
      <!-- 즐겨찾기 섹션 -->
      <div class="panel-section wishlist-toggle">
        <div class="section-header" @click="toggleWishlist">
          <span class="header-text">즐겨찾기</span>
          <span
            class="hamburger-menu"
            :class="{ active: wishlistVisible }"
          >
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
              @click="
                selectApartment(wish.propertyAddrAptName)
              "
              class="wishlist-item"
            >
              <span @click="favoriteClick(wish)">{{
                wish.doroJuso
              }}</span>
              <font-awesome-icon
                class="favorite-icon"
                :icon="['fas', 'star']"
                @click.stop="
                  removeFromWishlist(wish.propertyNo)
                "
                style="color: #ffd43b"
              />
            </li>
          </ul>
          <p v-else class="empty-message">
            즐겨찾기가 비어있습니다.
          </p>
        </div>
      </div>
      <!-- 상세보기 섹션 -->
      <div class="panel-section detail-toggle">
        <div class="section-header" @click="toggleDetails">
          <span class="header-text">상세보기</span>
          <span
            class="hamburger-menu"
            :class="{ active: isDetailsVisible }"
          >
            <div class="bar"></div>
            <div class="bar"></div>
            <div class="bar"></div>
          </span>
        </div>
        <div
          v-if="isDetailsVisible"
          class="section-content"
        >
          <div
            v-if="
              selectedProperty && selectedProperty.length
            "
            class="property-details"
          >
            <div class="property-header">
              <h2 class="address">
                {{ selectedProperty[0].doroJuso }}
                <font-awesome-icon
                  class="favorite-icon"
                  :icon="
                    isFavorite
                      ? ['fas', 'star']
                      : ['far', 'star']
                  "
                  :style="{
                    color: isFavorite
                      ? '#FFD43B'
                      : '#8E8E8E',
                  }"
                  @click="toggleFavorite"
                />
              </h2>
              <h4 class="">
                <span>
                  {{ selectedProperty[0].propertyType }}
                </span>
                <span class="year"
                  >(건축년도:
                  {{
                    selectedProperty[0].buildingYear
                  }})</span
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
                  <tr
                    v-for="(
                      property, index
                    ) in selectedProperty"
                    :key="index"
                  >
                    <td>{{ property.date }}</td>
                    <td>{{ property.price }}억 원</td>
                    <td>{{ property.propertyArea }} m²</td>
                    <td>
                      {{ property.propertyAddrFloor }}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <p v-else class="empty-message">
            매물을 골라주세요.
          </p>
        </div>
      </div>
      <!-- 매물 분석 버튼 -->
      <div class="analyze-button-container">
        <button
          class="analyze-button"
          @click="analyzeProperty"
          :disabled="
            !selectedProperty || !selectedProperty.length
          "
        >
          매물 분석하기
        </button>
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
  isDetailsVisible: Boolean,
});

const emit = defineEmits([
  'update:selectedProperty',
  'move-map-to-coordinates', // 상위 컴포넌트로 좌표 전달을 위한 이벤트 추가
  'updateTransactionType',
  'updateBuildingType',
  'favoriteItem',
  'update:isDetailsVisible',
]);

// 즐겨찾기와 상세보기 토글 상태 관리
const wishlistVisible = ref(true);
const isDetailsVisible = ref(true);
// 즐겨찾기 데이터
const wishlist = ref([]);

const reloadWishlist = async () => {
  try {
    const response = await api.getList();
    wishlist.value = response;
    // wishlist 로드 후 selectedProperty와 즐겨찾기 동기화
    if (
      props.selectedProperty &&
      props.selectedProperty.length > 0
    ) {
      const isInWishlist = wishlist.value.some(
        (wish) =>
          wish.locationNo ===
          props.selectedProperty[0].locationNo
      );
      isFavorite.value = isInWishlist;
    }
  } catch (e) {
    console.error('Failed to load wishlist:', e);
  }
};

// 즐겨찾기 상태 관리
const isFavorite = ref(false);

// watch를 사용해 selectedProperty가 변경될 때마다 isFavorite 업데이트
watch(
  () => props.selectedProperty,
  (newValue) => {
    if (newValue && newValue.length > 0) {
      // selectedProperty에 해당하는 매물이 즐겨찾기에 있는지 확인
      const isInWishlist = wishlist.value.some(
        (wish) => wish.locationNo === newValue[0].locationNo
      );
      isFavorite.value = isInWishlist;
    } else {
      isFavorite.value = false; // 선택된 매물이 없으면 기본값 false
    }
  },
  { immediate: true }
);

// 즐겨찾기에서 상세보기
const favoriteClick = (wish) => {
  emit('favoriteItem', wish);
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

// Props 변경 시 로그를 찍기 위해 watch 사용
watch(
  () => props.isDetailsVisible,
  (newVal) => {
    if (!!newVal) {
      isDetailsVisible.value = true;
    } else {
      isDetailsVisible.value = false;
    }
  },
  { immediate: true } // 초기값도 감지
);

const toggleDetails = () => {
  isDetailsVisible.value = !isDetailsVisible.value;
  emit('update:isDetailsVisible', !props.isDetailsVisible);
};

// 즐겨찾기 상태 토글
const toggleFavorite = async () => {
  if (
    !props.selectedProperty ||
    props.selectedProperty.length === 0
  )
    return;

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
  // 즐겨찾기 토글이 닫혀있으면 열기
  if (!wishlistVisible.value) {
    wishlistVisible.value = true;
  }
};

// 아파트 선택 함수
const selectApartment = (propertyAddrAptName) => {
  setTimeout(() => {
    const selected = props.selectedProperty.find(
      (prop) =>
        prop.propertyAddrAptName === propertyAddrAptName
    );
    if (selected) {
      emit('update:selectedProperty', [selected]);
    }
    isDetailsVisible.value = true;
  }, 100);
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

onMounted(() => {
  reloadWishlist();
});
</script>

<style scoped>
.left-panel {
  width: 30%;
  height: 100%;
  padding: 24px;
  display: flex;
  flex-direction: column;
  /* position: relative;
  overflow-y: auto; */
  background-color: #ffffff;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
}
.panel-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  overflow-y: hidden; /* 전체 패널의 스크롤은 숨기고 각 섹션별로 스크롤 */
}

.panel-section {
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  overflow-y: auto;
  margin-bottom: 16px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  max-height: 100%; /* Ensure the section uses full available height */
}

.section-header {
  flex-shrink: 0;
  padding: 16px 20px;
  background: #1a73e8;
  color: white;
  border-radius: 12px 12px 0 0;
  cursor: pointer;
  transition: background-color 0.3s ease;
  display: flex;
  justify-content: space-between;
  align-items: center;
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
  flex: 1; /* Allow section content to take up remaining space */
  padding: 10px;
  overflow-y: auto; /* Make only the content scrollable */
  background: #fff;
  border-radius: 0 0 12px 12px;
}

/* Wishlist and Details Sections */
.wishlist-toggle {
  flex: 2.8; /* 20% */
  max-height: 28%; /* Fixed percentage height */
}

.detail-toggle {
  flex: 6.2; /* 70% */
  max-height: 62%; /* Fixed percentage height */
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
  padding: 12px;
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

.address {
  font-size: 22px;
  color: #1a73e8;
  margin: 8px 0 0 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
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
  padding: 5px;
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
  flex: 1;
  max-height: 8%;
  display: flex;
  justify-content: center;
  align-items: center;
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
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(26, 115, 232, 0.2);
}

.analyze-button:hover {
  background: #1557b0;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(26, 115, 232, 0.3);
}

.analyze-button:disabled {
  background: #c0c0c0; /* Grey color for disabled state */
  cursor: not-allowed;
}
.favorite-icon {
  cursor: pointer;
  transition: transform 0.2s ease;
}

.favorite-icon:hover {
  transform: scale(1.2);
}

.search {
  margin-bottom: 20px;
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
