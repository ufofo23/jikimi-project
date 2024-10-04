package org.scoula.prevention.mapper;

import org.scoula.common.pagination.PageRequest;
import org.scoula.prevention.domain.PreventionVO;

import java.util.List;

public interface PreventionMapper {

    int getTotalCount();

    List<PreventionVO> getPage(PageRequest pageRequest);

    public List<PreventionVO> getList();

    public PreventionVO get(int no);
}
