package org.scoula.prevention.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PreventionDTO {

    private int preventionNo;

    private String preventionTitle;

    private String preventionContent;

    // VO -> DTO
    public static PreventionDTO of(PreventionVO vo) {
        return vo == null ? null : PreventionDTO.builder()
                .preventionNo(vo.getPreventionNo())
                .preventionTitle(vo.getPreventionTitle())
                .preventionContent(vo.getPreventionContent())
                .build();
    }
}
