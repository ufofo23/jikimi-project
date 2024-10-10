package org.scoula.report.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.service.ReportService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @DeleteMapping("{analysisNo}")
    public ResponseEntity<Integer> delete(@PathVariable int analysisNo) {
        return ResponseEntity.ok(service.delete(analysisNo));
    }
}
