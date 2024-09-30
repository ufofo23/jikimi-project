package org.scoula.map.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;
import org.scoula.map.service.MapService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/map")
@RequiredArgsConstructor
@Slf4j
public class MapController {

    private final MapService addressService;

    @GetMapping("")
    public ResponseEntity<List<MapVO>> getAddressList() {
        List<MapVO> addresses = addressService.getAllAddress();
        return ResponseEntity.ok(addresses);
    }
    @GetMapping("/{id}")
    public ResponseEntity<List<MapDetailDTO>> getAddressDetails(@PathVariable Long id) {
        List<MapDetailDTO> addressDetails = addressService.getAddressDetails(id); // List로 변경
        return ResponseEntity.ok(addressDetails);
    }
}