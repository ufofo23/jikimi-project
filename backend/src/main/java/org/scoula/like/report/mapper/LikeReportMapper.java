package org.scoula.like.report.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.scoula.common.pagination.PageRequest;
import org.scoula.like.report.domain.LikeReportVO;
import org.scoula.report.domain.ReportVO;

import java.util.List;

@Mapper
public interface LikeReportMapper {

    int getTotalCount();

    List<LikeReportVO> getPage(@Param("userId") String userId, @Param("pageRequest") PageRequest pageRequest);

    public int create(@Param("reportNo") int reportNo, @Param("userId") String userId);

    public List<ReportVO> getList(String userId);

    public int delete(int memberReportNo);
}
