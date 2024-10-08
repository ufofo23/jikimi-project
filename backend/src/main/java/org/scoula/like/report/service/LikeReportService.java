package org.scoula.like.report.service;

import org.scoula.report.domain.ReportDTO;

import java.util.List;

public interface LikeReportService {

    public int create(int reportNo, String token);

    public List<ReportDTO> getList(String token);

    public int delete(int memberReportNo);
}
