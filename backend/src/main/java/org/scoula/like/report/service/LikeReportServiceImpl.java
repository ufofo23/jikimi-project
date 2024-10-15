package org.scoula.like.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.like.report.domain.LikeReportDTO;
import org.scoula.like.report.domain.LikeReportVO;
import org.scoula.like.report.mapper.LikeReportMapper;
import org.scoula.oauth.jwt.JwtUtil;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.domain.ReportVO;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class LikeReportServiceImpl implements LikeReportService {

    private final LikeReportMapper mapper;

    private final JwtUtil jwtUtil;

    @Override
    public int create(int reportNo, String token) {
        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);

        return mapper.create(reportNo, userId);
    }

    @Override
    public Page<ReportDTO> getPage(String token, PageRequest pageRequest) {

        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);
        System.out.println("userId: " + userId);
        System.out.println("pageRequest: " + pageRequest);
        List<ReportVO> report = mapper.getPage(userId, pageRequest);

        int totalCount = mapper.getTotalCount();

        return Page.of(pageRequest, totalCount,
                report.stream().map(ReportDTO::of).toList());
    }

    @Override
    public List<ReportDTO> getList(String token) {
        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);
        System.out.println("userId = " + userId);
        return mapper.getList(userId).stream()
                .map(ReportDTO::of)
                .toList();
    }

    @Override
    public int delete(int memberReportNo) {
        return mapper.delete(memberReportNo);
    }
}
