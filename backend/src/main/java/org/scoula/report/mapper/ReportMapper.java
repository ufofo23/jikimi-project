package org.scoula.report.mapper;

import org.scoula.report.domain.ReportDTO;
import org.scoula.report.domain.ReportVO;

public interface ReportMapper {

    // 특정 레코드 가져오기
    public ReportVO get(int analysisNo);

    // 레포트 저장
    public int create(ReportVO reportVO);

}
