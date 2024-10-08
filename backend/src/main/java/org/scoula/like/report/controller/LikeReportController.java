package org.scoula.like.report.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.like.report.service.LikeReportService;
import org.scoula.report.domain.ReportDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/like/report")
public class LikeReportController {

    final LikeReportService service;

    @GetMapping("/{reportNo}")
    public ResponseEntity<Integer> create(@RequestHeader("Authorizaion") String token, @PathVariable int reportNo) {
        return ResponseEntity.ok(service.create(reportNo, token));
    }

    @GetMapping("")
    public ResponseEntity<List<ReportDTO>> getList(@RequestHeader("Authorizaition") String token) {
        return ResponseEntity.ok(service.getList(token));
    }

    @DeleteMapping("/{memberReportNo}")
    public ResponseEntity<Integer> delete(@PathVariable int memberReportNo) {
        return ResponseEntity.ok(service.delete(memberReportNo));
    }
}
