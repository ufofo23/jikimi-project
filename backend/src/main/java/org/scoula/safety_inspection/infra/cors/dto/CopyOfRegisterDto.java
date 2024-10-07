package org.scoula.safety_inspection.infra.cors.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CopyOfRegisterDto {

    private Integer analysisNo;
    private final String ownerState;
    private final String ownership;
    private final String commonOwner;
    private final String changeOwnerCount;
    private final String maximumOfBond;
    private final String deposit;

    public CopyOfRegisterDto(Integer analysisNo,String ownerState, String ownership, String commonOwner, String changeOwnerCount, String maximumOfBond, String deposit) {
        this.analysisNo = analysisNo;
        this.ownerState = ownerState;
        this.ownership = ownership;
        this.commonOwner = commonOwner;
        this.changeOwnerCount = changeOwnerCount;
        this.maximumOfBond = maximumOfBond;
        this.deposit = deposit;
    }

}
