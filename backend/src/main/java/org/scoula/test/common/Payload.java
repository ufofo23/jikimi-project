package org.scoula.test.common;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class Payload {

    private int analysisNo;
    private String addrSido;
    private String addrDong;
    private String addrLotNumber;
    private String buildingName;
    private String dong;
    private String ho;
    private String zipCode;
    private String jeonsePrice;
    private List<String> contractName;
    private String jibunAddress;
    private String propertyNo;
    private String price;
}
