package org.scoula.dictionary.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DictionaryVO {

    private int dictionaryNo;

    private String dictionaryTitle;

    private String dictionaryContent;
}
