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

    @GetMapping("/")
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
