package org.scoula.test.common;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BmlInfo {

    private Integer analysisNo;
    private Boolean resViolationStatus; // 위반건축물 여부
    private String resContents; // 주용도
}
