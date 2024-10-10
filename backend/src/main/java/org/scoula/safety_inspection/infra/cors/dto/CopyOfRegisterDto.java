package org.scoula.safety_inspection.infra.cors.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CopyOfRegisterDto {

    private Integer analysisNo;
    private Double ownerState;
    private String ownership;
    private String commonOwner;
    private Integer changeOwnerCount;
    private Integer maximumOfBond;

    public CopyOfRegisterDto(Integer analysisNo,Double ownerState, String ownership, String commonOwner, Integer changeOwnerCount, Integer maximumOfBond) {
        this.analysisNo = analysisNo;
        this.ownerState = ownerState;
        this.ownership = ownership;
        this.commonOwner = commonOwner;
        this.changeOwnerCount = changeOwnerCount;
        this.maximumOfBond = maximumOfBond;
    }

}
