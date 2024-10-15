package org.scoula.map.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapClusterVO {
    private String xCoordinate;
    private String yCoordinate;
}