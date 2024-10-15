package org.scoula.dictionary.service;

import org.scoula.dictionary.domain.DictionaryDTO;

import java.util.List;

public interface DictionaryService {

    public List<DictionaryDTO> getList();

    public DictionaryDTO get(int no);
}
