package org.scoula.codefapi.bml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerGeneralDto;

@Mapper
public interface BuildingManagementLedgerGeneralMapper {

    void insertBuildingData(BuildingManagementLedgerGeneralDto buildingManagementLedgerGeneralDto);

}
