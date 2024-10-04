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
    private String apartName;
    private String doroJuso;
    private String roadName;
    private String price;
    private String propertyArea;
    private String propertyAddrAptDong;
    private String propertyAddrFloor;
    private String propertyAddrAptName;
    private String buyer;
    private String seller;
    private String buildingYear;
    private String contractType;
    private String typeBuild;
    private String date;
    private String contractYearMonth;
    private String contractDate;
}
