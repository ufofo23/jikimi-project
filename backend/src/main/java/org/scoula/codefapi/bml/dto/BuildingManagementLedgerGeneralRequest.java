package org.scoula.codefapi.bml.dto;

import lombok.Data;

@Data
public class BuildingManagementLedgerGeneralRequest {

    private String address;
    private String zipCode;
    private String dong;

}
