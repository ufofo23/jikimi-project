package org.scoula.safety_inspection.infra.bml.service;

import org.springframework.stereotype.Component;

@Component
public class BuildingManagementLedgerServiceFactory {

    private final BuildingManagementLedgerGeneralService buildingManagementLedgerGeneralService;
    private final BuildingManagementLedgerMultiService buildingManagementLedgerMultiService;

    public BuildingManagementLedgerServiceFactory(BuildingManagementLedgerGeneralService buildingManagementLedgerGeneralService, BuildingManagementLedgerMultiService buildingManagementLedgerMultiService) {
        this.buildingManagementLedgerGeneralService = buildingManagementLedgerGeneralService;
        this.buildingManagementLedgerMultiService = buildingManagementLedgerMultiService;
    }

    public BuildingManagementLedgerService getService(String realtyType) {
        if (realtyType.equals("1")) {
            return buildingManagementLedgerMultiService;
        } else {
            return buildingManagementLedgerGeneralService;
        }
    }
}