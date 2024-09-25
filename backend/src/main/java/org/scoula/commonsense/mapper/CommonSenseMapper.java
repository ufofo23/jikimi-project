package org.scoula.commonsense.mapper;

import org.scoula.common.pagination.PageRequest;
import org.scoula.commonsense.domain.CommonSenseVO;

import java.util.List;

public interface CommonSenseMapper {

    int getTotalCount();

    List<CommonSenseVO> getPage(PageRequest pageRequest);

    public List<CommonSenseVO> getList();

    public CommonSenseVO get(int no);

}
