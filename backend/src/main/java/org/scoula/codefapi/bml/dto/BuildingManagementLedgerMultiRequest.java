package org.scoula.codefapi.bml.dto;

import lombok.Data;

@Data
public class BuildingManagementLedgerMultiRequest {

    private String address;
    private String dong;
    private String ho;
    private String zipCode;
    private String dongNum;
    private String hoNum;

}
