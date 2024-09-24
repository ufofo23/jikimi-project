package org.scoula.commonsense.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommonSenseDTO {

    private int commonSenseNo;

    private String commonSenseTitle;

    private String commonSenseContent;

    private String pieceSense;

    // VO -> DTO
    public static CommonSenseDTO of(CommonSenseVO vo) {
        return vo == null ? null : CommonSenseDTO.builder()
                .commonSenseNo(vo.getCommonSenseNo())
                .commonSenseTitle(vo.getCommonSenseTitle())
                .commonSenseContent(vo.getCommonSenseContent())
                .pieceSense(vo.getPieceSense())
                .build();
    }
}
