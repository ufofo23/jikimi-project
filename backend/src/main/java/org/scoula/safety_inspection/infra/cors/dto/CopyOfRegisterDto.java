package org.scoula.safety_inspection.infra.cors.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CopyOfRegisterDto {

    private Integer analysisNo;
    private final Double ownerState;
    private final String ownership;
    private final String commonOwner;
    private final String changeOwnerCount;
    private final Integer maximumOfBond;

    public CopyOfRegisterDto(Integer analysisNo,Double ownerState, String ownership, String commonOwner, String changeOwnerCount, Integer maximumOfBond) {
        this.analysisNo = analysisNo;
        this.ownerState = ownerState;
        this.ownership = ownership;
        this.commonOwner = commonOwner;
        this.changeOwnerCount = changeOwnerCount;
        this.maximumOfBond = maximumOfBond;
    }

}
