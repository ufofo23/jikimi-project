package org.scoula.map.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapDetailDTO {
    private int locationNo;
    private int propertyNo;
    private String doroJuso;
    private String jibunJuso;
    private int zipcode;
    private int price;
    private String date;
    private String propertyArea;
    private String propertyAddrFloor;
    private String propertyAddrAptName;
    private String buildingYear;
    private String contractType;
    private String propertyType;

}
