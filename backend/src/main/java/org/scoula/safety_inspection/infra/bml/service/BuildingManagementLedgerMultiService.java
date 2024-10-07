package org.scoula.safety_inspection.infra.bml.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.scoula.safety_inspection.codef.EasyCodef;
import org.scoula.safety_inspection.codef.EasyCodefServiceType;
import org.scoula.safety_inspection.infra.bml.dto.BuildingManagementLedgerDto;
import org.scoula.safety_inspection.infra.bml.mapper.BuildingManagementLedgerMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.scoula.safety_inspection.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.safety_inspection.codef.EasyCodefUtil.encryptRSA;

@Service
@RequiredArgsConstructor
public class BuildingManagementLedgerMultiService implements BuildingManagementLedgerService{

    private final BuildingManagementLedgerMapper ledgerMultiMapper;
    private final EasyCodef easyCodef;

    @Value("${codef.userName}")
    private String userName;

    @Value("${codef.birthDate}")
    private String birthDate;

    @Value("${codef.identity}")
    private String identity;

    @Override
    public void getBuildingLedger(Map<String, Object> payload, Integer analysisNo) throws Exception {

        HashMap<String, Object> parameterMap = createParameterMap(payload);
        String url = "/v1/kr/public/mw/multiowned-buildings/possession-ledger";
        String result = easyCodef.requestProduct(url, EasyCodefServiceType.DEMO, parameterMap);
        System.out.println("result = " + result);

        processMultiResult(result, analysisNo);
    }

    private HashMap<String, Object> createParameterMap(Map<String, Object> payload) {
        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", "0001");
        parameterMap.put("loginType", "3");
        parameterMap.put("type", "0");
        parameterMap.put("userName", userName);
        parameterMap.put("birthDate", birthDate);
        parameterMap.put("identity", identity);
        parameterMap.put("address", payload.get("addr-jibun-address"));
        parameterMap.put("dong", payload.get("dong"));
        parameterMap.put("ho", payload.get("ho"));
        parameterMap.put("zipCode",payload.get("zipCode"));
        parameterMap.put("originDataYN", ""); // 원문 DATA 포함 여부 (값이 명시되지 않음)
        parameterMap.put("timeout", ""); // 제한시간 (값이 명시되지 않음)
        parameterMap.put("secureNoTimeout", ""); // 보안숫자 제한시간 (값이 명시되지 않음)
        return parameterMap;
    }

    private void processMultiResult(String result, Integer analysisNo) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> responseMap = objectMapper.readValue(result, HashMap.class);
        Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");

        if (dataMap != null) {
            String resViolationStatusStr = (String) dataMap.getOrDefault("resViolationStatus", "");
            String mainUse = getResUseType((List<Map<String, Object>>) dataMap.get("resOwnedList"));

            boolean resViolationStatus = !resViolationStatusStr.equals("");

            BuildingManagementLedgerDto ledgerDto = new BuildingManagementLedgerDto(analysisNo,resViolationStatus,mainUse);
            ledgerMultiMapper.insertBuildingData(ledgerDto);
        }
    }

    private String getResUseType(List<Map<String, Object>> resOwnedList) {
        if (resOwnedList != null && !resOwnedList.isEmpty()) {
            return (String) resOwnedList.get(0).getOrDefault("resUseType", "No result.");
        }
        return "No result.";
    }
}
