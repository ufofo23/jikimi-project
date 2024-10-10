package org.scoula.safety_inspection.service;

import lombok.RequiredArgsConstructor;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerGeneralService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerMultiService;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterGeneralService;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterMultiService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.scoula.safety_inspection.infra.analysis.service.AnalysisService;
import org.scoula.report.service.ReportService;
import org.scoula.report.domain.ReportDTO;

import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
public class SafetyInspectionService {

    private final AnalysisService analysisService;
    private final CopyOfRegisterMultiService copyOfRegisterMultiService;
    private final CopyOfRegisterGeneralService copyOfRegisterGeneralService;
    private final BuildingManagementLedgerMultiService buildingManagementLedgerMultiService;
    private final BuildingManagementLedgerGeneralService buildingManagementLedgerGeneralService;
    private final ReportService reportService;
    private final ExtractUnicodeService extractUnicodeService;

    /**
     * API 추출 및 DB 저장 트랜잭션 관리를 위한 서비스
     * @param payload
     */
    public void processSafetyInspection(Map<String, Object> payload) {

        String propertyNo = (String) payload.get("propertyNo");
        Integer analysisNo = analysisService.processPropertyAnalysis(propertyNo, payload);
        try {

            copyOfRegisterGeneralService.getCopyOfRegister(payload,analysisNo);
            buildingManagementLedgerGeneralService.getBuildingLedger(payload,analysisNo);

//            List<Map<String, String>> uniqueCodes = extractUnicodeService.getUniqueCode(payload);
//            if (!uniqueCodes.isEmpty()) {
//                String realtyType = uniqueCodes.get(0).get("realtyType");
//                System.out.println("realtyType = " + realtyType);
//
//                if (realtyType != null && !realtyType.equals("-1")) {  // 에러 상태가 아닌 경우에만 처리
//                    if ("1".equals(realtyType)) {
//                        copyOfRegisterMultiService.getCopyOfRegister(payload, analysisNo);
//                        buildingManagementLedgerMultiService.getBuildingLedger(payload, analysisNo);
//                        System.out.println("SafetyInspectionService.processSafetyInspection");
//                    } else if ("0".equals(realtyType)) {
//                        copyOfRegisterGeneralService.getCopyOfRegister(payload, analysisNo);
//                        buildingManagementLedgerGeneralService.getBuildingLedger(payload, analysisNo);
//                    }
//                }
//            }

            // 보고서 생성 및 저장
            ReportDTO reportDTO = reportService.analysis(analysisNo, propertyNo, payload);
            reportService.create(reportDTO);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
