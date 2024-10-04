package org.scoula.prevention.service;

import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.commonsense.domain.CommonSenseDTO;
import org.scoula.prevention.domain.PreventionDTO;

import java.util.List;

public interface PreventionService {

    Page<PreventionDTO> getPage(PageRequest pageRequest);

    public List<PreventionDTO> getList();

    public PreventionDTO get(int no);
}
