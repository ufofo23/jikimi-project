package org.scoula.prevention.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PreventionVO {

    private int preventionNo;

    private String preventionTitle;

    private String preventionContent;
}
