package org.scoula.map.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapVO {
    private int id;
    private int no;
    private String sigungu;
    private String doroJuso;
    private String xCoordinate;
    private String yCoordinate;
    private String price;
    private String spacial;
    private String conMonth;
    private String conDate;
    private String floor;
    private String buildYear;
    private String typeBuild;
    private String apartName;
}