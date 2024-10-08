package org.scoula.commonsense.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommonSenseVO {

    private int commonSenseNo;

    private String commonSenseTitle;

    private String commonSenseContent;

    private String pieceSense;
}
