package org.scoula.codefapi.bml.controller;

import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerMultiRequest;
import org.scoula.codefapi.bml.service.BuildingManagementLedgerMultiService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class BuildingManagementLedgerMultiController {

    private final BuildingManagementLedgerMultiService ledgerMultiService;


    @PostMapping("/api/building-ledger-multi")
    public String getBuildingLedgerGeneral(
            @RequestBody BuildingManagementLedgerMultiRequest request
    ) {

        return ledgerMultiService.getBuildingLedgerMulti(request);

    }
}
