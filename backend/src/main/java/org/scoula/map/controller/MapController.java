package org.scoula.map.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.address.domain.AddressVO;
import org.scoula.address.service.AddressService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/address")
@RequiredArgsConstructor
@Slf4j
public class AddressController {

    private final AddressService addressService;

    @GetMapping("")
    public ResponseEntity<List<AddressVO>> getAddressList() {
        List<AddressVO> addresses = addressService.getAllAddress();
        return ResponseEntity.ok(addresses);
    }
}