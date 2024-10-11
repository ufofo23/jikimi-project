package org.scoula.report.mapper;

import org.apache.ibatis.annotations.Param;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.domain.ReportVO;

public interface ReportMapper {

    // 특정 레코드 가져오기
    public ReportVO get(@Param("reportNo") int reportNo, @Param("userId") String userId);

    // 레포트 저장
    public int create(ReportVO reportVO);

    // 레포트 삭제
    public int delete(int analysisNo);

    public int getReportNo(int analysisNo);

}
