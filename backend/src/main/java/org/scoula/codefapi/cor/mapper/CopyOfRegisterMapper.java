package org.scoula.codefapi.cor.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.codefapi.cor.dto.CopyOfRegisterDto;

@Mapper
public interface CopyOfRegisterMapper {

    void insertCopyOfRegister(CopyOfRegisterDto copyOfRegisterDto);

}

