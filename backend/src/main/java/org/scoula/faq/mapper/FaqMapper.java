package org.scoula.faq.mapper;

import org.scoula.faq.domain.FaqVO;

import java.util.List;

public interface FaqMapper {

    public List<FaqVO> getList();

    public FaqVO get(int no);
}
