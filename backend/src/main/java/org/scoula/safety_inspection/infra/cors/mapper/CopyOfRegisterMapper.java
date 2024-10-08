package org.scoula.safety_inspection.infra.cors.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.safety_inspection.infra.cors.dto.CopyOfRegisterDto;

@Mapper
public interface CopyOfRegisterMapper {

    void insertCopyOfRegister(CopyOfRegisterDto copyOfRegisterDto);

    CopyOfRegisterDto selectCopyOfRegister(Integer analysisNo);

}

