package org.scoula.faq.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FaqDTO {

    private int faqNo;

    private String faqQuestion;

    private String faqAnswer;

    // VO -> DTO
    public static FaqDTO of(FaqVO vo) {
        return vo == null ? null : FaqDTO.builder()
                .faqNo(vo.getFaqNo())
                .faqQuestion(vo.getFaqQuestion())
                .faqAnswer(vo.getFaqAnswer())
                .build();
    }
}
