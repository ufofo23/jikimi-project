package org.scoula.faq.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.faq.domain.FaqDTO;
import org.scoula.faq.service.FaqService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/faq")
public class FaqController {

    final FaqService service;

    @GetMapping("")
    public ResponseEntity<List<FaqDTO>> getList() {
        return ResponseEntity.ok(service.getList());
    }

    @GetMapping("/{no}")
    public ResponseEntity<FaqDTO> get(@PathVariable int no) {
        return ResponseEntity.ok(service.get(no));
    }
}
