package org.scoula.like.dictionary.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.scoula.like.dictionary.service.LikeDictionaryService;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeDictionaryDTO {

    private int likeDictionaryNo;

    private int memberNo;

    private int dictionaryNo;

    // VO -> DTO
    public static LikeDictionaryDTO of(LikeDictionaryVO vo) {
        return vo == null ? null : LikeDictionaryDTO.builder()
                .likeDictionaryNo(vo.getLikeDictionaryNo())
                .memberNo(vo.getMemberNo())
                .dictionaryNo(vo.getDictionaryNo())
                .build();
    }
}
