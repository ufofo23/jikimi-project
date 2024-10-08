package org.scoula.like.report.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeReportVO {

    private int memberReportNo;

    private int reportNo;

    private int memberNo;
}
