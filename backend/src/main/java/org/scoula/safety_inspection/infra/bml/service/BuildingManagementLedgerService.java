package org.scoula.safety_inspection.infra.bml.service;


import java.util.Map;

public interface BuildingManagementLedgerService {
    void getBuildingLedger(Map<String, Object> payload, Integer analysisNo) throws Exception;
}
