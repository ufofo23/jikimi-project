package org.scoula.dictionary.mapper;

import org.scoula.dictionary.domain.DictionaryDTO;
import org.scoula.dictionary.domain.DictionaryVO;

import java.util.List;

public interface DictionaryMapper {

    public List<DictionaryVO> getList();

    public DictionaryVO get(int no);
}
