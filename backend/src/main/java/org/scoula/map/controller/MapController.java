package org.scoula.map.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;
import org.scoula.map.service.MapService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    // 중심 좌표와 레벨을 기반으로 해당 구역 안에 있는 주소 리스트를 반환하는 API
    @GetMapping("/move")
    public ResponseEntity<List<MapVO>> getAddressListMove(
            @RequestParam("lat") double lat,
            @RequestParam("lon") double lon,
            @RequestParam("zoomLevel") int zoomLevel
    ) {
        List<MapVO> addressList = addressService.getAddressListMove(lat, lon, zoomLevel);
        return ResponseEntity.ok(addressList);
    }

    @GetMapping("/movecluster")
    public ResponseEntity<List<MapVO>> getAddressListMoveCluster(
            @RequestParam("lat") double lat,
            @RequestParam("lon") double lon,
            @RequestParam("zoomLevel") int zoomLevel
    ) {
        List<MapVO> addressList = addressService.getAddressListMoveCluster(lat, lon, zoomLevel);
        return ResponseEntity.ok(addressList);
    }

    @GetMapping("/{id}")
    public ResponseEntity<List<MapDetailDTO>> getAddressDetails(@PathVariable Long id) {
        List<MapDetailDTO> addressDetails = addressService.getAddressDetails(id); // List로 변경
        return ResponseEntity.ok(addressDetails);
    }
}