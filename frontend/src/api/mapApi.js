import axiosInstance from '@/axiosInstance'; // axiosInstance 가져오기

const BASE_URL = '/api/map';

export default {
  // 주소 리스트를 가져오는 함수
  async getAddressList() {
    try {
      const { data } = await axiosInstance.get(BASE_URL, {
        headers: { 'Content-Type': 'application/json' },
      });
      return data;
    } catch (error) {
      throw error; // 에러 전파
    }
  },

  // 지도 이동 시 중심 좌표와 줌 레벨을 기준으로 주소 리스트를 가져오는 함수
  async getAddressListMove(lat, lon, zoomLevel) {
    try {
      console.log('API call with params:', {
        lat,
        lon,
        zoomLevel,
      });

      const { data } = await axiosInstance.get(
        `${BASE_URL}/move`,
        {
          headers: { 'Content-Type': 'application/json' },
          params: { lat, lon, zoomLevel }, // 위도, 경도, 줌 레벨을 파라미터로 전달
        }
      );
      return data;
    } catch (error) {
      throw error; // 에러 전파
    }
  },

  // 지도 이동 시 중심 좌표와 줌 레벨을 기준으로 주소 리스트를 가져오는 함수
  async getAddressListMoveCluster(lat, lon, zoomLevel) {
    try {
      console.log('API call with params:', {
        lat,
        lon,
        zoomLevel,
      });
      const { data } = await axiosInstance.get(
        `${BASE_URL}/movecluster`,
        {
          headers: { 'Content-Type': 'application/json' },
          params: { lat, lon, zoomLevel }, // 위도, 경도, 줌 레벨을 파라미터로 전달
        }
      );
      return data;
    } catch (error) {
      throw error; // 에러 전파
    }
  },

  async getAddressDetails(id) {
    try {
      const { data } = await axiosInstance.get(
        `${BASE_URL}/${id}`
      );
      return data;
    } catch (error) {
      throw error;
    }
  },
};
