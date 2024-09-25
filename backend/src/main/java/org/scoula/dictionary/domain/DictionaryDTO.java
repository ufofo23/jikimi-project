package org.scoula.dictionary.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DictionaryDTO {

    private int dictionaryNo;
    
    private String dictionaryTitle;
    
    private String dictionaryContent;

    // VO -> DTO
    public static DictionaryDTO of(DictionaryVO vo) {
        return vo == null ? null : DictionaryDTO.builder()
                .dictionaryNo(vo.getDictionaryNo())
                .dictionaryTitle(vo.getDictionaryTitle())
                .dictionaryContent(vo.getDictionaryContent())
                .build();
    }
}
