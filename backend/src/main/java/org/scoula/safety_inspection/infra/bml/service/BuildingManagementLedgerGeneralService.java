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

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import static org.scoula.safety_inspection.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.safety_inspection.codef.EasyCodefUtil.encryptRSA;

@Service
@RequiredArgsConstructor
public class BuildingManagementLedgerGeneralService implements BuildingManagementLedgerService{

    private final BuildingManagementLedgerMapper buildingManagementLedgerMapper;
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
        String productUrl = "/v1/kr/public/mw/building-register/general";
        String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
        System.out.println("result = " + result);

        processBMLResult(result,analysisNo);
    }

    private HashMap<String, Object> createParameterMap(Map<String,Object> payload) {

        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", "0001");
        parameterMap.put("loginType", "3");
        parameterMap.put("type", "0");
        parameterMap.put("userName", userName);
        parameterMap.put("birthDate", birthDate);
        parameterMap.put("identity", identity);
        parameterMap.put("address", payload.get("addr-jibun-address")); // 주소 (필수)
        parameterMap.put("zipCode",payload.get("zipCode"));
        parameterMap.put("timeout", "60"); // 제한 시간 (초 단위)
        parameterMap.put("originDataYN", "0"); // 원문 데이터 포함 여부 ("0": 미포함, "1": 포함, 기본값: "0")
        parameterMap.put("secureNoTimeout", "60"); // 보안 숫자 제한 시간 (초 단위, 기본값: 60초)
        String identityEncYn = "Y";
        if (identityEncYn.equals("N")) {
            parameterMap.put("identityEncYn", "Y");
        } else {
            parameterMap.put("identityEncYn", "N");
        }
        return parameterMap;
    }

    private void processBMLResult(String result, Integer analysisNo) throws IOException {
        try {
            Map<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
            Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");

            if (dataMap != null) {
                String resViolationStatusStr = (String) dataMap.getOrDefault("resViolationStatus", "");
                String mainUse = extractMainUse(dataMap);

                boolean resViolationStatus = !resViolationStatusStr.equals("");

                // DB에 데이터 저장 (address 제외)
                BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, resViolationStatus, mainUse);
                buildingManagementLedgerMapper.insertBuildingData(ledgerData);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String extractMainUse(Map<String, Object> dataMap) {
        if (dataMap.get("resDetailList") instanceof Iterable) {
            Iterable<Map<String, Object>> resDetailList = (Iterable<Map<String, Object>>) dataMap.get("resDetailList");
            for (Map<String, Object> detail : resDetailList) {
                if ("주용도".equals(detail.get("resType"))) {
                    return (String) detail.get("resContents");
                }
            }
        }
        return "";
    }

}