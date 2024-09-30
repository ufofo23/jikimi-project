package org.scoula.codefapi.bml.dto;

public class BuildingManagementLedgerDto {
    private String resUserAddr;
    private String resViolationStatus;

    // Getters and Setters
    public String getResUserAddr() {
        return resUserAddr;
    }

    public void setResUserAddr(String resUserAddr) {
        this.resUserAddr = resUserAddr;
    }

    public String getResViolationStatus() {
        return resViolationStatus;
    }

    public void setResViolationStatus(String resViolationStatus) {
        this.resViolationStatus = resViolationStatus;
    }
}
