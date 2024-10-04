package org.scoula.codefapi.bml.dto;

import lombok.Getter;

@Getter
public class BuildingManagementLedgerDto {

    private final String resUserAddr;
    private final String resViolationStatus;
    private final String resContents;

    public BuildingManagementLedgerDto(String resUserAddr, String resViolationStatus, String resContents) {
        this.resUserAddr = resUserAddr;
        this.resViolationStatus = resViolationStatus;
        this.resContents = resContents;
    }

}
