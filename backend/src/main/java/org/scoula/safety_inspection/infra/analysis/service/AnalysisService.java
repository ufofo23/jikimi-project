package org.scoula.safety_inspection.infra.analysis.service;

import org.scoula.safety_inspection.infra.analysis.dto.AnalysisDTO;
import org.scoula.safety_inspection.infra.analysis.mapper.AnalysisMapper;
import org.scoula.safety_inspection.infra.analysis.vo.AnalysisVO;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class AnalysisService {

    private final AnalysisMapper analysisMapper;
    private final CopyOfRegisterService copyOfRegisterService;

    @Autowired
    public AnalysisService(AnalysisMapper analysisMapper, CopyOfRegisterService copyOfRegisterService) {
        this.analysisMapper = analysisMapper;
        this.copyOfRegisterService = copyOfRegisterService;
    }

    public Integer processPropertyAnalysis(String propertyNumber, Map<String, Object> payload) {
        // Analysis 생성
        Integer propertyNo = Integer.parseInt(propertyNumber);
        System.out.println("propertyNo = " + propertyNo);

        AnalysisDTO analysisDTO = new AnalysisDTO();
        analysisDTO.setPropertyNo(propertyNo);

        AnalysisVO analysisVO = analysisDTO.toVO();
        analysisMapper.insertAnalysis(analysisVO);

        Integer analysisNo = analysisVO.getAnalysisNo();

        // 등기부 등본 처리
        try {
            copyOfRegisterService.getCopyOfRegister(payload, analysisNo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return analysisNo;
    }
}