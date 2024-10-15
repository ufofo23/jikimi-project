package org.scoula.like.property.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikePropertyDTO {

    private int likePropertyNo;

    private int memberNo;

    private int propertyNo;

    // VO -> DTO
    public static LikePropertyDTO of(LikePropertyVO vo) {
        return vo == null ? null : LikePropertyDTO.builder()
                .likePropertyNo(vo.getLikePropertyNo())
                .memberNo(vo.getMemberNo())
                .propertyNo(vo.getPropertyNo())
                .build();
    }
}
