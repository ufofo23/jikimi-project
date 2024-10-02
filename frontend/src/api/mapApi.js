// src/api/mapApi.js
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
  async getAddressDetails(id) {
    try {
      const { data } = await axiosInstance.get(`${BASE_URL}/${id}`);
      console.log(data);
      return data;
    } catch (error) {
      throw error;
    }
  },
};
