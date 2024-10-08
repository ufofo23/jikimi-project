package org.scoula.like.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.like.report.domain.LikeReportDTO;
import org.scoula.like.report.mapper.LikeReportMapper;
import org.scoula.oauth.jwt.JwtUtil;
import org.scoula.report.domain.ReportDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class LikeReportImpl implements LikeReportService {

    private final LikeReportMapper mapper;

    private final JwtUtil jwtUtil;

    @Override
    public int create(int reportNo, String token) {
        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);

        return mapper.create(reportNo, userId);
    }

    @Override
    public List<ReportDTO> getList(String token) {
        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);

        return mapper.getList(userId).stream()
                .map(ReportDTO::of)
                .toList();
    }

    @Override
    public int delete(int memberReportNo) {
        return mapper.delete(memberReportNo);
    }
}
