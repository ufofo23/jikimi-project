package org.scoula.like.dictionary.service;

import org.scoula.dictionary.domain.DictionaryDTO;

import java.util.List;

public interface LikeDictionaryService {

    public int create(int dicNo, String token);

    public List<DictionaryDTO> getList(String token);

    public int delete(int dicNo);
}
