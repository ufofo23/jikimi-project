package org.scoula.like.property.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikePropertyVO {

    private int likePropertyNo;

    private int memberNo;

    private int propertyNo;

}
