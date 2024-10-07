package org.scoula.map.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapVO {
    private int locationNo; // pl pk
    private int propertyNo; // property_no
    private String sigungu;
    private String doroJuso;
    private String roadName;
    private String xCoordinate;
    private String yCoordinate;
    private String price;
    private String recentPrice;
    private String spacial;
    private String conMonth;
    private String conDate;
    private String floor;
    private String buildYear;
    private String typeBuild;
    private String apartName;
}