package org.scoula.report.service;

import org.scoula.report.domain.ReportDTO;

public interface reportService {

    /* GET */
    // 특정 레코드 가져오기
    public ReportDTO get(int analysisNo);

    /* CREATE */
    public int create(ReportDTO report);

    /* Algorithm */
    public ReportDTO analysis(int analysisNo);

}
