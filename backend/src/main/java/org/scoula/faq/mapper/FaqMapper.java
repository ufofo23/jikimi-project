package org.scoula.faq.mapper;

import org.scoula.common.pagination.PageRequest;
import org.scoula.commonsense.domain.CommonSenseVO;
import org.scoula.faq.domain.FaqVO;

import java.util.List;

public interface FaqMapper {

    int getTotalCount();

    List<FaqVO> getPage(PageRequest pageRequest);

    public List<FaqVO> getList();

    public FaqVO get(int no);
}
