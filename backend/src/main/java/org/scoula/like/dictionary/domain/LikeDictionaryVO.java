package org.scoula.like.dictionary.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeDictionaryVO {

    private int likeDictionaryNo;

    private int memberNo;

    private int dictionaryNo;
}
