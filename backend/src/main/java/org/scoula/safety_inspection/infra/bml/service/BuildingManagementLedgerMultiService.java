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

//        String result = easyCodef.requestProduct(PRODUCT_URL, EasyCodefServiceType.DEMO, parameterMap);
        String result = "{\"result\":{\"code\":\"CF-00000\",\"extraMessage\":\"\",\"message\":\"성공\",\"transactionId\":\"67038695ec82eab8491ac1e7\"},\"data\":{\"resOriGinalData\":\"\",\"resDocNo\":\"1728-2843-1909-6691\",\"commUniqeNo\":\"5113011700-3-20490008\",\"resReceiptNo\":\"2024092748501084\",\"resAddrDong\":\"원주혁신도시1단지사랑으로부영아파트105동\",\"resAddrHo\":\"101\",\"resUserAddr\":\"강원특별자치도원주시반곡동\",\"commAddrLotNumber\":\"2049-8\",\"commAddrRoadName\":\"강원특별자치도원주시배울로49(반곡동)\",\"resOwnedList\":[{\"resType\":\"0\",\"resType1\":\"주\",\"resFloor\":\"1층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"아파트\",\"resArea\":\"84.9933\"},{\"resType\":\"1\",\"resType1\":\"부\",\"resFloor\":\"지1\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"지하주차장\",\"resArea\":\"31.366\"},{\"resType\":\"1\",\"resType1\":\"주\",\"resFloor\":\"지1\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"지하주차장연결통로\",\"resArea\":\"6.0588\"},{\"resType\":\"1\",\"resType1\":\"부\",\"resFloor\":\"지1\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"기계실,전기실,발전기실\",\"resArea\":\"0.6613\"},{\"resType\":\"1\",\"resType1\":\"부\",\"resFloor\":\"1-3층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"경로당,관리사무소,방재실,MDF실,작은도서관,헬스장,탁구장,입주자회의소\",\"resArea\":\"1.1173\"},{\"resType\":\"1\",\"resType1\":\"주\",\"resFloor\":\"각층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"계단실,승강기,홀\",\"resArea\":\"23.8508\"},{\"resType\":\"1\",\"resType1\":\"주\",\"resFloor\":\"1층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"벽체\",\"resArea\":\"5.8993\"},{\"resType\":\"1\",\"resType1\":\"부\",\"resFloor\":\"1층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"어린이집\",\"resArea\":\"0.2988\"},{\"resType\":\"1\",\"resType1\":\"부\",\"resFloor\":\"1층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"경비실\",\"resArea\":\"0.0711\"}],\"resOwnerList\":[{\"resOwner\":\"주식회사부영주택\",\"resUserAddr\":\"서울특별시중구세종대로9길42,(서소문동)\",\"resOwnershipStake\":\"1/1\",\"resChangeDate\":\"20151223\",\"resChangeReason\":\"소유권보존\",\"resIdentityNo\":\"1101114******\"}],\"resPriceList\":[{\"resReferenceDate\":\"20240101\",\"resBasePrice\":\"154000000\"},{\"resReferenceDate\":\"20230101\",\"resBasePrice\":\"154000000\"},{\"resReferenceDate\":\"20220101\",\"resBasePrice\":\"187000000\"},{\"resReferenceDate\":\"20210101\",\"resBasePrice\":\"149000000\"},{\"resReferenceDate\":\"20200101\",\"resBasePrice\":\"145000000\"},{\"resReferenceDate\":\"20190101\",\"resBasePrice\":\"156000000\"},{\"resReferenceDate\":\"20180101\",\"resBasePrice\":\"164000000\"},{\"resReferenceDate\":\"20170101\",\"resBasePrice\":\"160000000\"},{\"resReferenceDate\":\"20160101\",\"resBasePrice\":\"147000000\"}],\"resChangeList\":[{\"resChangeDate\":\"20151222\",\"resChangeReason\":\"신규작성(신축)\"},{\"resChangeDate\":\"20230611\",\"resChangeReason\":\"법률제18994호(2023.6.11.)강원특별자치도설치\"}],\"resViolationStatus\":\"\",\"resNote\":\"\",\"resIssueDate\":\"20241007\",\"resIssueOgzNm\":\"원주시장\"}}";
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
                BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, null, null);
                buildingManagementLedgerMapper.insertBuildingData(ledgerData);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleTwoWayCertification(Map<String, Object> dataMap, Map<String, Object> payload, Integer analysisNo) throws Exception {
        String jti = dataMap.get("jti").toString();
        long twoWayTimestamp = Long.parseLong(dataMap.get("twoWayTimestamp").toString());
        Map<String, Object> extraInfo = (Map<String, Object>) dataMap.get("extraInfo");
        List<Map<String, Object>> reqDongNumList = (List<Map<String, Object>>) extraInfo.get("reqDongNumList");
        String commDongNum = reqDongNumList.get(0).get("commDongNum").toString();

        HashMap<String, Object> parameterMap2 = createParameterMap(payload);
        parameterMap2.put("dongNum", commDongNum);
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
//        buildingManagementLedgerMapper.insertBuildingData(ledgerData);

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