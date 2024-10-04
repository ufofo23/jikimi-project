package org.scoula.prevention.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.prevention.domain.PreventionDTO;
import org.scoula.prevention.domain.PreventionVO;
import org.scoula.prevention.mapper.PreventionMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Log4j
@Service
@RequiredArgsConstructor
public class PreventionServiceImpl implements PreventionService {

    final private PreventionMapper mapper;

    @Override
    public Page<PreventionDTO> getPage(PageRequest pageRequest) {
        List<PreventionVO> prevention = mapper.getPage(pageRequest);
        int totalCount = mapper.getTotalCount();

        return Page.of(pageRequest, totalCount,
                prevention.stream().map(PreventionDTO::of).toList());
    }

    @Override
    public List<PreventionDTO> getList() {
        return mapper.getList().stream()
                .map(PreventionDTO::of)
                .toList();
    }

    @Override
    public PreventionDTO get(int no) {
        PreventionDTO prevention = PreventionDTO.of(mapper.get(no));
        return Optional.ofNullable(prevention)
                .orElseThrow(NoSuchElementException::new);
    }
}
