package org.scoula.like.report.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.scoula.like.dictionary.domain.LikeDictionaryDTO;
import org.scoula.like.dictionary.domain.LikeDictionaryVO;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeReportDTO {

    private int memberReportNo;

    private int reportNo;

    private int memberNo;

    // VO -> DTO
    public static LikeReportDTO of(LikeReportVO vo) {
        return vo == null ? null : LikeReportDTO.builder()
                .memberReportNo(vo.getMemberReportNo())
                .reportNo(vo.getReportNo())
                .memberNo(vo.getMemberNo())
                .build();
    }
}
