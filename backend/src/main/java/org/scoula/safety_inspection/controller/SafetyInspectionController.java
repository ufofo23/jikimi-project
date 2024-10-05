package org.scoula.safety_inspection.controller;

import org.scoula.safety_inspection.service.ExtractUnicodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    @Autowired
    public SafetyInspectionController(ExtractUnicodeService extractUnicodeService) {
        this.extractUnicodeService = extractUnicodeService;
    }

    @PostMapping("/address")
    public ResponseEntity<List<Map<String, String>>> handleAccess(@RequestBody Map<String, Object> payload) {
        System.out.println("SafetyInspectionController.handleAccess");
        try {
            List<Map<String,String>> response = extractUnicodeService.getUniqueCode(payload);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(List.of(Map.of("error", "An error occurred while processing the request.")), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/cors")
    public ResponseEntity<Map<String,Object>> handleUniqueCode(@RequestBody Map<String, String> payload){
        String uniqueCode = payload.get("uniqueCode");
        System.out.println("uniqueCode = " + uniqueCode);
        return new ResponseEntity<>(Map.of("message","성공적으로 유니크 코드 받았음"),HttpStatus.OK);
    }
}