package org.scoula.codefapi.bml.controller;

import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerGeneralRequest;
import org.scoula.codefapi.bml.service.BuildingManagementLedgerGeneralService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class BuildingManagementLedgerGeneralController {

    private final BuildingManagementLedgerGeneralService ledgerGeneralService;


    @PostMapping("/api/building-ledger-general")
    public String getBuildingLedgerGeneral(
            @RequestBody BuildingManagementLedgerGeneralRequest request
    ) {

        return ledgerGeneralService.getBuildingLedgerGeneral(request);

    }
}
