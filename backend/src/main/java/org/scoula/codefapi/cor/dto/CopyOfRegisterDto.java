package org.scoula.codefapi.cor.dto;

import lombok.Getter;

@Getter
public class CopyOfRegisterDto {

    private final String address;
    private final String ownerState;
    private final String ownership;
    private final String commonOwner;
    private final String changeOwnerCount;
    private final String maximumOfBond;
    private final String deposit;

    public CopyOfRegisterDto(String address, String ownerState, String ownership, String commonOwner, String changeOwnerCount, String maximumOfBond, String deposit) {
        this.address = address;
        this.ownerState = ownerState;
        this.ownership = ownership;
        this.commonOwner = commonOwner;
        this.changeOwnerCount = changeOwnerCount;
        this.maximumOfBond = maximumOfBond;
        this.deposit = deposit;
    }

}
