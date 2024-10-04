package org.scoula.codefapi.bml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerDto;

@Mapper
public interface BuildingManagementLedgerMapper {

    void insertBuildingData(BuildingManagementLedgerDto buildingManagementLedgerDto);

}
