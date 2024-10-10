package org.scoula.report.service;

import org.scoula.report.domain.ReportDTO;

import java.util.Map;

public interface ReportService {

    /* GET */
    // 특정 레코드 가져오기
    public ReportDTO get(int analysisNo);

    /* CREATE */
    public int create(ReportDTO report, Integer analysisNo);

    /* Algorithm */
    public ReportDTO analysis(int analysisNo, String propertyNo, Map<String, Object> payload);

}
