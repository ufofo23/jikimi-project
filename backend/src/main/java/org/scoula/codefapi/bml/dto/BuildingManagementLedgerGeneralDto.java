package org.scoula.codefapi.bml.dto;

import lombok.Getter;

@Getter
public class BuildingManagementLedgerGeneralDto {

    private final String resViolationStatus;
    private final String mainUse;

    public BuildingManagementLedgerGeneralDto(String resViolationStatus, String mainUse) {
        this.resViolationStatus = resViolationStatus;
        this.mainUse = mainUse;
    }

}
