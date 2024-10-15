package org.scoula.faq.service;

import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.faq.domain.FaqDTO;

import java.util.List;

public interface FaqService {

    Page<FaqDTO> getPage(PageRequest pageRequest);

    public List<FaqDTO> getList();

    public FaqDTO get(int no);
}
