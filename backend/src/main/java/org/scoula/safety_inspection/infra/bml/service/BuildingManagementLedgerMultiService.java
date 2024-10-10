package org.scoula.safety_inspection.infra.bml.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.scoula.exception.CustomException;
import org.scoula.safety_inspection.codef.EasyCodef;
import org.scoula.safety_inspection.codef.EasyCodefServiceType;
import org.scoula.safety_inspection.infra.bml.dto.BuildingManagementLedgerDto;
import org.scoula.safety_inspection.infra.bml.mapper.BuildingManagementLedgerMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BuildingManagementLedgerMultiService{

    private final BuildingManagementLedgerMapper buildingManagementLedgerMapper;
    private final EasyCodef easyCodef;

    @Value("${codef.userName}")
    private String userName;

    @Value("${codef.birthDate}")
    private String birthDate;

    @Value("${codef.identity}")
    private String identity;

    private static final String PRODUCT_URL = "/v1/kr/public/mw/multiowned-buildings/possession-ledger";
    private static final String ORGANIZATION = "0001";
    private static final String LOGIN_TYPE = "3";
    private static final String TYPE = "0";
    private static final String TIMEOUT = "60";
    private static final String ORIGIN_DATA_YN = "0";

    public void getBuildingLedger(Map<String, Object> payload, Integer analysisNo) throws Exception {
        HashMap<String, Object> parameterMap = createParameterMap(payload);

        String result = easyCodef.requestProduct(PRODUCT_URL, EasyCodefServiceType.DEMO, parameterMap);
        System.out.println("첫 번째 응답: " + result);


        processBMLResult(result, payload, analysisNo);
    }

    private HashMap<String, Object> createParameterMap(Map<String, Object> payload) {
        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", ORGANIZATION);
        parameterMap.put("loginType", LOGIN_TYPE);
        parameterMap.put("type", TYPE);
        parameterMap.put("userName", userName);
        parameterMap.put("birthDate", birthDate);
        parameterMap.put("identity", identity);
        parameterMap.put("address", payload.get("addr-jibun-address"));
        parameterMap.put("zipCode", payload.get("zipCode"));
        parameterMap.put("timeout", TIMEOUT);
        parameterMap.put("originDataYN", ORIGIN_DATA_YN);
        parameterMap.put("secureNoTimeout", TIMEOUT);
        parameterMap.put("dong",payload.get("dong"));
        parameterMap.put("ho",payload.get("ho"));

        String identityEncYn = "Y";
        if (identityEncYn.equals("N")) {
            parameterMap.put("identityEncYn", "Y");
        } else {
            parameterMap.put("identityEncYn", "N");
        }

        return parameterMap;
    }

    private void processBMLResult(String result, Map<String, Object> payload, Integer analysisNo) throws IOException{
        try {
            Map<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
            Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");
            Map<String, Object> resultMap = (Map<String, Object>) responseMap.get("result");

            String responseCode = (String) resultMap.get("code");

            if ("CF-00000".equals(responseCode)) {
                if (dataMap != null) {
                    extractAndSaveDataFromDataMap(dataMap, analysisNo);
                }
            }

            if ("CF-03002".equals(responseCode)) {
                handleTwoWayCertification(dataMap, payload, analysisNo);
            }

            else{
//                BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, null, null);
//                buildingManagementLedgerMapper.insertBuildingData(ledgerData);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleTwoWayCertification(Map<String, Object> dataMap, Map<String, Object> payload, Integer analysisNo) throws Exception {
        String jti = dataMap.get("jti").toString();
        long twoWayTimestamp = Long.parseLong(dataMap.get("twoWayTimestamp").toString());
        Map<String, Object> extraInfo = (Map<String, Object>) dataMap.get("extraInfo");

        String commDongNum = "";
        List<Map<String, Object>> reqDongNumList = (List<Map<String, Object>>) extraInfo.get("reqDongNumList");
        if (reqDongNumList != null && !reqDongNumList.isEmpty()) {
            commDongNum = reqDongNumList.get(0).get("commDongNum").toString();
        }

        String commHoNum = "";
        List<Map<String,Object>> reqHoNumList = (List<Map<String,Object>>) extraInfo.get("reqHoNumList");
        if (reqHoNumList != null && !reqHoNumList.isEmpty()) {
            commHoNum = reqHoNumList.get(0).get("commHoNum").toString();
        }

        HashMap<String, Object> parameterMap2 = createParameterMap(payload);
        parameterMap2.put("dongNum", commDongNum);
        parameterMap2.put("hoNum",commHoNum);
        parameterMap2.put("signedData", "{\"certSeqNum\":12345678,\"signedVals\":[\"bhEd4...-lc07xew\"],\"rValue\":\"l9JqioQn-uQ\"}");
        parameterMap2.put("is2Way", true);

        HashMap<String, Object> twoWayInfo = new HashMap<>();
        twoWayInfo.put("jobIndex", 0);
        twoWayInfo.put("threadIndex", 0);
        twoWayInfo.put("jti", jti);
        twoWayInfo.put("twoWayTimestamp", twoWayTimestamp);
        parameterMap2.put("twoWayInfo", twoWayInfo);

        String result2 = easyCodef.requestCertification(PRODUCT_URL, EasyCodefServiceType.DEMO, parameterMap2);
        System.out.println("두 번째 응답: " + result2);

        extractAndSaveDataFromResult2(result2, analysisNo);
    }

    private void extractAndSaveDataFromDataMap(Map<String, Object> dataMap, Integer analysisNo) {

        List<Map<String, Object>> resOwnedList = (List<Map<String, Object>>) dataMap.get("resOwnedList");
        String mainUse = getResUseType(resOwnedList);
        String resViolationStatusStr = (String) dataMap.getOrDefault("resViolationStatus", "");
        boolean resViolationStatus = extractResViolationStatus(resViolationStatusStr);


        BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, resViolationStatus, mainUse);
        buildingManagementLedgerMapper.insertBuildingData(ledgerData);
    }

    private void extractAndSaveDataFromResult2(String result2, Integer analysisNo) throws IOException {
        Map<String, Object> responseMap = new ObjectMapper().readValue(result2, HashMap.class);
        Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");

        List<Map<String, Object>> resOwnedList = (List<Map<String, Object>>) dataMap.get("resOwnedList");
        String mainUse = getResUseType(resOwnedList);
        String resViolationStatusStr = (String) dataMap.getOrDefault("resViolationStatus", "");
        boolean resViolationStatus = extractResViolationStatus(resViolationStatusStr);

        BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, resViolationStatus, mainUse);
        buildingManagementLedgerMapper.insertBuildingData(ledgerData);

    }

    private boolean extractResViolationStatus(String resViolationStatusStr) {
        return !resViolationStatusStr.isEmpty();
    }

    private String getResUseType(List<Map<String, Object>> resOwnedList) {
        if (resOwnedList != null && !resOwnedList.isEmpty()) {
            Map<String, Object> firstItem = resOwnedList.get(0);
            if (firstItem != null) {
                return (String) firstItem.getOrDefault("resUseType", "결과값이 없습니다.");
            }
        }
        return "결과값이 없습니다.";
    }

}