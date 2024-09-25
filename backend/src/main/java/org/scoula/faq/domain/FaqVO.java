package org.scoula.faq.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FaqVO {

    private int faqNo;

    private String faqQuestion;

    private String faqAnswer;
}
