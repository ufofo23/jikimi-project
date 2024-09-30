package org.scoula.codefapi.bml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BuildingManagementLedgerMapper {
    void insertBuildingData(@Param("resUserAddr") String resUserAddr, @Param("resViolationStatus") String resViolationStatus);
}
