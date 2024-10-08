package org.scoula.safety_inspection.infra.bml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.safety_inspection.infra.bml.dto.BuildingManagementLedgerDto;

@Mapper
public interface BuildingManagementLedgerMapper {

    void insertBuildingData(BuildingManagementLedgerDto buildingManagementLedgerDto);

    BuildingManagementLedgerDto selectBuildingData(Integer analysisNo);

}
