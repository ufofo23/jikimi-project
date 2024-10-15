package org.scoula.report.service;

import org.scoula.report.domain.ReportDTO;

import java.util.Map;

public interface ReportService {

    /* GET */
    // 특정 레코드 가져오기
    public ReportDTO get(int reportNo, String token);

    /* CREATE */
    public int create(ReportDTO report, Integer analysisNo, String token);

    /* Algorithm */
    public ReportDTO analysis(int analysisNo, String propertyNo, Map<String, Object> payload);

    public int delete(int analysisNo);

}
