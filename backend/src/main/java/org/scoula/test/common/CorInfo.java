package org.scoula.test.common;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class CorInfo {

    private Integer analysisNo;
    private Double ownerState;
    private String ownership;
    private String commonOwner;
    private Integer changeOwnerCount;
    private Integer maximumOfBond;
}
