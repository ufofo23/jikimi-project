package org.scoula.faq.service;

import org.scoula.faq.domain.FaqDTO;

import java.util.List;

public interface FaqService {

    public List<FaqDTO> getList();

    public FaqDTO get(int no);
}
