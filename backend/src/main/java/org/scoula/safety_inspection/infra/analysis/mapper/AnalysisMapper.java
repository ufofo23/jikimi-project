package org.scoula.safety_inspection.infra.analysis.mapper;

import org.scoula.safety_inspection.infra.analysis.vo.AnalysisVO;

public interface AnalysisMapper {
    void insertAnalysis(AnalysisVO analysisVO);
    AnalysisVO selectAnalysis(Integer propertyNo);

}
