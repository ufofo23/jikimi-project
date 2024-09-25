package org.scoula.commonsense.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.commonsense.domain.CommonSenseDTO;
import org.scoula.commonsense.domain.CommonSenseVO;
import org.scoula.commonsense.mapper.CommonSenseMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Log4j
@Service
@RequiredArgsConstructor
public class CommonSenseServiceImpl implements CommonSenseService {

    final private CommonSenseMapper mapper;

    @Override
    public Page<CommonSenseDTO> getPage(PageRequest pageRequest) {

        List<CommonSenseVO> commonSense = mapper.getPage(pageRequest);
        int totalCount = mapper.getTotalCount();

        return Page.of(pageRequest, totalCount,
                commonSense.stream().map(CommonSenseDTO::of).toList());
    }

    @Override
    public List<CommonSenseDTO> getList() {
        return mapper.getList().stream()
                .map(CommonSenseDTO::of)
                .toList();
    }

    @Override
    public CommonSenseDTO get(int no) {

        CommonSenseDTO commonsense = CommonSenseDTO.of(mapper.get(no));
        return Optional.ofNullable(commonsense)
                .orElseThrow(NoSuchElementException::new);
    }
}
