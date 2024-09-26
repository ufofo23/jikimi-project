package org.scoula.faq.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.faq.domain.FaqDTO;
import org.scoula.faq.domain.FaqVO;
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
    public Page<FaqDTO> getPage(PageRequest pageRequest) {

        List<FaqVO> faq = mapper.getPage(pageRequest);
        int totalCount = mapper.getTotalCount();

        return Page.of(pageRequest, totalCount,
                faq.stream().map(FaqDTO::of).toList());
    }

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
