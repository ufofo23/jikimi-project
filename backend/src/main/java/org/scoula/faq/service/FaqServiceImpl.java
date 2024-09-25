package org.scoula.faq.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.faq.domain.FaqDTO;
import org.scoula.faq.mapper.FaqMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Log4j
@Service
@RequiredArgsConstructor
public class FaqServiceImpl implements FaqService {

    final private FaqMapper mapper;

    @Override
    public List<FaqDTO> getList() {
        return mapper.getList().stream()
                .map(FaqDTO::of)
                .toList();
    }

    @Override
    public FaqDTO get(int no) {

        FaqDTO faq = FaqDTO.of(mapper.get(no));
        return Optional.ofNullable(faq)
                .orElseThrow(NoSuchFieldError::new);
    }
}
