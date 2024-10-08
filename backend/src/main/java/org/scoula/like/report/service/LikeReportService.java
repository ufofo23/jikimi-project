package org.scoula.like.report.service;

import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.like.report.domain.LikeReportDTO;
import org.scoula.report.domain.ReportDTO;

import java.util.List;

public interface LikeReportService {

    public int create(int reportNo, String token);

    public Page<LikeReportDTO> getPage(String token, PageRequest pageRequest);

    public List<ReportDTO> getList(String token);

    public int delete(int memberReportNo);
}
