package org.scoula.codefapi.bml.dto;

import lombok.Getter;

@Getter
public class BuildingManagementLedgerMultiDto {

    private final String resViolationStatus;
    private final String resUseType;

    public BuildingManagementLedgerMultiDto(String resViolationStatus, String resUseType) {
        this.resViolationStatus = resViolationStatus;
        this.resUseType = resUseType;
    }

}
