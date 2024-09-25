package org.scoula.dictionary.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.dictionary.domain.DictionaryDTO;
import org.scoula.dictionary.mapper.DictionaryMapper;
import org.springframework.stereotype.Service;

import java.util.Dictionary;
import java.util.List;
import java.util.Optional;

@Log4j
@Service
@RequiredArgsConstructor
public class DictionaryServiceImpl implements DictionaryService {

    final private DictionaryMapper mapper;

    @Override
    public List<DictionaryDTO> getList() {
        return mapper.getList().stream()
                .map(DictionaryDTO::of)
                .toList();
    }

    @Override
    public DictionaryDTO get(int no) {

        DictionaryDTO dictionary = DictionaryDTO.of(mapper.get(no));
        return Optional.ofNullable(dictionary)
                .orElseThrow(NoSuchFieldError::new);

    }
}
