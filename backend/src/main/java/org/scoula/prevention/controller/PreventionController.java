package org.scoula.prevention.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.commonsense.domain.CommonSenseDTO;
import org.scoula.prevention.domain.PreventionDTO;
import org.scoula.prevention.service.PreventionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/prevention")
public class PreventionController {

    final PreventionService service;

    @GetMapping("")
    public ResponseEntity<Page> getList(PageRequest pageRequest) {
        return ResponseEntity.ok(service.getPage(pageRequest));
    }

    @GetMapping("/{no}")
    public ResponseEntity<PreventionDTO> get(@PathVariable int no) {
        return ResponseEntity.ok(service.get(no));
    }
}
