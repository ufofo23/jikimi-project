package org.scoula.safety_inspection.infra.analysis.dto;

import lombok.Getter;
import lombok.Setter;
import org.scoula.safety_inspection.infra.analysis.vo.AnalysisVO;

@Getter
@Setter
public class AnalysisDTO {
    private Integer propertyNo;

    public AnalysisVO toVO() {
        AnalysisVO analysisVO = new AnalysisVO();
        analysisVO.setPropertyNo(this.propertyNo);
        return analysisVO;
    }

}
