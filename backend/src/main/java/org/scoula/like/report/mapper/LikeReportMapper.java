package org.scoula.like.report.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.scoula.report.domain.ReportVO;

import java.util.List;

@Mapper
public interface LikeReportMapper {

    public int create(@Param("reportNo") int reportNo, @Param("userId") String userId);

    public List<ReportVO> getList(String userId);

    public int delete(int memberReportNo);
}
