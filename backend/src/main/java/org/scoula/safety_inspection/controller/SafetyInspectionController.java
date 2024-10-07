package org.scoula.safety_inspection.controller;

import org.scoula.safety_inspection.infra.analysis.service.AnalysisService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerGeneralService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerMultiService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerService;
import org.scoula.safety_inspection.infra.bml.service.BuildingManagementLedgerServiceFactory;
import org.scoula.safety_inspection.infra.cors.service.CopyOfRegisterService;
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
public class SafetyInspectionController {
    private ExtractUnicodeService extractUnicodeService;
    private CopyOfRegisterService copyOfRegisterService;
    private AnalysisService analysisService;
    private BuildingManagementLedgerServiceFactory buildingManagementLedgerServiceFactory;

    @Autowired
    public SafetyInspectionController(ExtractUnicodeService extractUnicodeService, CopyOfRegisterService copyOfRegisterService, AnalysisService analysisService, BuildingManagementLedgerServiceFactory buildingManagementLedgerServiceFactory) {
        this.extractUnicodeService = extractUnicodeService;
        this.copyOfRegisterService = copyOfRegisterService;
        this.analysisService = analysisService;
        this.buildingManagementLedgerServiceFactory = buildingManagementLedgerServiceFactory;
    }

    // 유니크 코드 관련
    @PostMapping("/address")
    public ResponseEntity<List<Map<String, String>>> handleAccess(@RequestBody Map<String, Object> payload) {
        try {
            List<Map<String,String>> response = extractUnicodeService.getUniqueCode(payload);
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

            String realtyType = (String) payload.get("realtyType");
            String propertyNo =  (String) payload.get("propertyNo");
            Integer analysisNo = analysisService.processPropertyAnalysis(propertyNo, payload);
            System.out.println("analysisNo = " + analysisNo);

            copyOfRegisterService.getCopyOfRegister(payload,analysisNo);


            BuildingManagementLedgerService service = buildingManagementLedgerServiceFactory.getService(realtyType);

            service.getBuildingLedger(payload, analysisNo);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}