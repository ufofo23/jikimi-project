package org.scoula.safety_inspection.infra.analysis.service;

import org.scoula.safety_inspection.infra.analysis.dto.AnalysisDTO;
import org.scoula.safety_inspection.infra.analysis.mapper.AnalysisMapper;
import org.scoula.safety_inspection.infra.analysis.vo.AnalysisVO;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterMultiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
public class AnalysisService {

    private final AnalysisMapper analysisMapper;
    private final CopyOfRegisterMultiService copyOfRegisterMultiService;

    @Autowired
    public AnalysisService(AnalysisMapper analysisMapper, CopyOfRegisterMultiService copyOfRegisterMultiService) {
        this.analysisMapper = analysisMapper;
        this.copyOfRegisterMultiService = copyOfRegisterMultiService;
    }

    @Transactional(propagation = Propagation.MANDATORY)
    public Integer processPropertyAnalysis(String propertyNumber, Map<String, Object> payload) {
        // Analysis 생성
        Integer propertyNo = Integer.parseInt(propertyNumber);
        System.out.println("propertyNo = " + propertyNo);

        AnalysisDTO analysisDTO = new AnalysisDTO();
        analysisDTO.setPropertyNo(propertyNo);

        AnalysisVO analysisVO = analysisDTO.toVO();
        analysisMapper.insertAnalysis(analysisVO);

        Integer analysisNo = analysisVO.getAnalysisNo();

        return analysisNo;
    }
}