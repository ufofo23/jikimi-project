package org.scoula.safety_inspection.controller;

import lombok.RequiredArgsConstructor;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.service.ReportService;
import org.scoula.safety_inspection.infra.analysis.service.AnalysisService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerGeneralService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerMultiService;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterGeneralService;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterMultiService;
import org.scoula.safety_inspection.service.ExtractUnicodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/safety-inspection")
@RequiredArgsConstructor
public class SafetyInspectionController {
    final private ExtractUnicodeService extractUnicodeService;
    final private AnalysisService analysisService;
    final private CopyOfRegisterMultiService copyOfRegisterMultiService;
    final private CopyOfRegisterGeneralService copyOfRegisterGeneralService;
    final private BuildingManagementLedgerMultiService buildingManagementLedgerMultiService;
    final private BuildingManagementLedgerGeneralService buildingManagementLedgerGeneralService;
    final private ReportService reportService;

//    @Autowired
//    public SafetyInspectionController(ExtractUnicodeService extractUnicodeService, AnalysisService analysisService, CopyOfRegisterMultiService copyOfRegisterMultiService, CopyOfRegisterGeneralService copyOfRegisterGeneralService, BuildingManagementLedgerMultiService buildingManagementLedgerMultiService, BuildingManagementLedgerGeneralService buildingManagementLedgerGeneralService, ReportService reportService) {
//        this.extractUnicodeService = extractUnicodeService;
//        this.analysisService = analysisService;
//        this.copyOfRegisterMultiService = copyOfRegisterMultiService;
//        this.copyOfRegisterGeneralService = copyOfRegisterGeneralService;
//        this.buildingManagementLedgerMultiService = buildingManagementLedgerMultiService;
//        this.buildingManagementLedgerGeneralService = buildingManagementLedgerGeneralService;
//        this.reportService = reportService;
//    }

    // 유니크 코드 관련
    @PostMapping("/address")
    public ResponseEntity<List<Map<String, String>>> handleAccess(@RequestBody Map<String, Object> payload) {
        try {
            System.out.println("SafetyInspectionController.handleAccess");
            for (Map.Entry<String, Object> entry : payload.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                System.out.println("address: " + key + ", address: " + value);
            }
            List<Map<String,String>> response = extractUnicodeService.getUniqueCode(payload);
            System.out.println("response = " + response);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(List.of(Map.of("error", "An error occurred while processing the request.")), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 등기부 등본 관련
    @Transactional
    @PostMapping("/cors")
    public void handleUniqueCode(@RequestBody Map<String, Object> payload){

        try{
            for (Map.Entry<String, Object> entry : payload.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                System.out.println("cors: " + key + ", cors: " + value);
            }

            String realtyType = (String) payload.get("realtyType");
            String propertyNo =  (String) payload.get("propertyNo");
            Integer analysisNo = analysisService.processPropertyAnalysis(propertyNo, payload);
            System.out.println("analysisNo = " + analysisNo);


            if ("1".equals(realtyType)) {
                copyOfRegisterMultiService.getCopyOfRegister(payload, analysisNo);
                buildingManagementLedgerMultiService.getBuildingLedger(payload,analysisNo);
            } else if("0".equals(realtyType)) {
                copyOfRegisterGeneralService.getCopyOfRegister(payload, analysisNo);
                buildingManagementLedgerGeneralService.getBuildingLedger(payload,analysisNo);
            }

            // reportDTO 생성
            ReportDTO reportDTO = reportService.analysis(analysisNo, propertyNo, payload);

            // report_tbl에 저장
            reportService.create(reportDTO);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}