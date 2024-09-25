package org.scoula.commonsense.service;

import org.scoula.common.pagination.Page;
import org.scoula.common.pagination.PageRequest;
import org.scoula.commonsense.domain.CommonSenseDTO;

import java.util.List;

public interface CommonSenseService {

    Page<CommonSenseDTO> getPage(PageRequest pageRequest);

    public List<CommonSenseDTO> getList();

    public CommonSenseDTO get(int no);
}
