package org.scoula.codefapi.bml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerMultiDto;

@Mapper
public interface BuildingManagementLedgerMultiMapper {

    void insertBuildingData(BuildingManagementLedgerMultiDto buildingManagementLedgerMultiDto);

}
