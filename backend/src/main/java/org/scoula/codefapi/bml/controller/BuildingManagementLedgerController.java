package org.scoula.codefapi.bml.controller;

import org.scoula.codefapi.bml.service.BuildingManagementLedgerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BuildingManagementLedgerController {

    @Autowired
    private BuildingManagementLedgerService ledgerService;


    // /api/building-ledger?organization=0001&loginType=3&userName=&identity=&address=%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C%20%EC%9A%A9%EC%82%B0%EA%B5%AC%20%ED%95%9C%EB%82%A8%EB%8C%80%EB%A1%9C36%EA%B8%B8%2054&zipCode=04417
    @GetMapping("/api/building-ledger")
    public String getBuildingLedger(
            @RequestParam("organization") String organization,
            @RequestParam("loginType") String loginType,
            @RequestParam("userName") String userName,
            @RequestParam("identity") String identity,
            @RequestParam("address") String address,
            @RequestParam("zipCode") String zipCode
    ) {
        return ledgerService.getBuildingLedger(organization, loginType, userName, identity, address, zipCode);
    }
}
