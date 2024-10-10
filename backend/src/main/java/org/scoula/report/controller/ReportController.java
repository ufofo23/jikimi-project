package org.scoula.report.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.service.ReportService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/report")
public class ReportController {

    private final ReportService service;

    @GetMapping("/{analysisNo}")
    public ResponseEntity<ReportDTO> get(@PathVariable("analysisNo") int analysisNo) {
        return ResponseEntity.ok(service.get(analysisNo));
    }
}
