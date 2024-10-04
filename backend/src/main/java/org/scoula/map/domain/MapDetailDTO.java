package org.scoula.map.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapDetailDTO {
    private int id;
    private int no;
    private String apartName;
    private String doroJuso;
    private String price;
    private String spacial;
    private String dong;
    private String floor;
    private String buyer;
    private String seller;
    private String buildYear;
    private String typeTrade;
    private String typeBuild;
    private String date;
    private String conMonth;
    private String conDate;
}
