<template>
  <div>
    <h1>내 레포트</h1>
    <table class="report-table">
      <thead>
        <tr>
          <th>생성 날짜</th>
          <th>주소</th>
          <th>진단 결과</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="report in paginatedData" :key="report.id">
          <td>{{ report.creationDate }}</td> <!-- 생성 날짜 -->
          <td>{{ report.address }}</td> <!-- 주소 -->
          <td>{{ report.diagnosticResult }}</td> <!-- 진단 결과 -->
        </tr>
      </tbody>
    </table>
    <pagination
      :current-page="currentPage"
      :page-size="pageSize"
      :total="reports.length"
      @change="changePage"
    />
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue'; // Vue Composition API 가져오기
import likeReportApi from '@/api/like/likeReportApi'; // likeReportApi 가져오기

export default {
  setup() {
    const reports = ref([]); // 레포트 데이터
    const currentPage = ref(1);
    const pageSize = 10;

    const paginatedData = computed(() => {
      const start = (currentPage.value - 1) * pageSize;
      return reports.value.slice(start, start + pageSize); // 페이지에 맞는 데이터 반환
    });

    const fetchReports = async () => {
      try {
        const response = await likeReportApi.getList(); // 레포트 데이터 가져오기
        reports.value = response; // 데이터를 reports에 저장
      } catch (error) {
        console.error('레포트 데이터를 가져오는 중 오류 발생:', error); // 오류 처리
      }
    };

    const changePage = (page) => {
      currentPage.value = page; // 페이지 변경
    };

    onMounted(() => {
      fetchReports(); // 컴포넌트가 마운트될 때 레포트 데이터를 가져옵니다.
    });

    return {
      reports,
      currentPage,
      pageSize,
      paginatedData,
      fetchReports,
      changePage,
    };
  },
};
</script>

<style scoped>
h1 {
  text-align: center;
  margin-bottom: 20px;
}

.report-table {
  width: 100%;
  border-collapse: collapse;
  margin: 0 auto; /* 중앙 정렬 */
}

.report-table th,
.report-table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center; /* 중앙 정렬 */
}

.report-table th {
  background-color: #f2f2f2; /* 헤더 배경 색상 */
}

.report-table tr:hover {
  background-color: #f1f1f1; /* 마우스 호버 시 배경 색상 */
}
</style>
