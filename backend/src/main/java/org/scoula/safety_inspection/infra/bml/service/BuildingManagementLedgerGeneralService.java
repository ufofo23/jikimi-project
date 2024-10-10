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
public class BuildingManagementLedgerGeneralService{

    private final BuildingManagementLedgerMapper buildingManagementLedgerMapper;
    private final EasyCodef easyCodef;

    @Value("${codef.userName}")
    private String userName;

    @Value("${codef.birthDate}")
    private String birthDate;

    @Value("${codef.identity}")
    private String identity;

    private static final String PRODUCT_URL = "/v1/kr/public/mw/building-register/general";
    private static final String ORGANIZATION = "0001";
    private static final String LOGIN_TYPE = "3";
    private static final String TYPE = "0";
    private static final String TIMEOUT = "60";
    private static final String ORIGIN_DATA_YN = "0";

    public void getBuildingLedger(Map<String, Object> payload, Integer analysisNo) {

        try{

            HashMap<String, Object> parameterMap = createParameterMap(payload);

//            String result = easyCodef.requestProduct(PRODUCT_URL, EasyCodefServiceType.DEMO, parameterMap);
            String result = "{\"result\":{\"code\":\"CF-00000\",\"extraMessage\":\"\",\"message\":\"성공\",\"transactionId\":\"67038d37ec82a6aefd7f2283\"},\"data\":{\"resOriGinalData\":\"\",\"resDocNo\":\"1728-2860-1572-2623\",\"commUniqeNo\":\"5113010700-1-16440002\",\"resReceiptNo\":\"2024100760075791\",\"resAddrDong\":\"\",\"resAddrHo\":\"0호/4가구/0세대\",\"resUserAddr\":\"강원특별자치도원주시단구동\",\"commAddrLotNumber\":\"1644-2\",\"commAddrRoadName\":\"강원특별자치도원주시토지길63-10(단구동)\",\"resNote\":\"구역:가축사육제한구역\",\"resIssueDate\":\"20241007\",\"resIssueOgzNm\":\"원주시장\",\"resViolationStatus\":\"\",\"resDetailList\":[{\"resType\":\"대지위치-도로명주소\",\"resContents\":\"강원특별자치도원주시토지길63-10(단구동)\"},{\"resType\":\"대지위치\",\"resContents\":\"강원특별자치도원주시단구동\"},{\"resType\":\"지번\",\"resContents\":\"1644-2\"},{\"resType\":\"도로명코드\",\"resContents\":\"511304457612\"},{\"resType\":\"지하구분\",\"resContents\":\"\"},{\"resType\":\"도로명건물번호\",\"resContents\":\"63-10\"},{\"resType\":\"도로명\",\"resContents\":\"강원특별자치도원주시토지길63-10(단구동)\"},{\"resType\":\"명칭및번호\",\"resContents\":\"\"},{\"resType\":\"특이사항\",\"resContents\":\"\"},{\"resType\":\"대지면적\",\"resContents\":\"216\"},{\"resType\":\"연면적\",\"resContents\":\"431.13\"},{\"resType\":\"건축면적\",\"resContents\":\"123.6\"},{\"resType\":\"용적률산정용면적\",\"resContents\":\"429.81\"},{\"resType\":\"주구조\",\"resContents\":\"철근콘크리트구조\"},{\"resType\":\"주용도\",\"resContents\":\"단독주택,제1.2종근린생활시설\"},{\"resType\":\"층수\",\"resContents\":\"지하:층,지상:4층\"},{\"resType\":\"건폐율\",\"resContents\":\"57.22\"},{\"resType\":\"용적율\",\"resContents\":\"199\"},{\"resType\":\"높이\",\"resContents\":\"14.5\"},{\"resType\":\"지붕\",\"resContents\":\"(철근)콘크리트\"},{\"resType\":\"부속건축물\",\"resContents\":\"동㎡\"},{\"resType\":\"위반건축물여부\",\"resContents\":\"\"},{\"resType\":\"호가구세대수\",\"resContents\":\"0호/4가구/0세대\"},{\"resType\":\"승강기|승용\",\"resContents\":\"\"},{\"resType\":\"승강기|비상용\",\"resContents\":\"\"},{\"resType\":\"하수종말처리장연결\",\"resContents\":\"\"},{\"resType\":\"허가일자\",\"resContents\":\"20160719\"},{\"resType\":\"착공일자\",\"resContents\":\"20160816\"},{\"resType\":\"사용승인일자\",\"resContents\":\"20171108\"},{\"resType\":\"내진설계적용여부\",\"resContents\":\"적용\"},{\"resType\":\"내진능력\",\"resContents\":\"\"},{\"resType\":\"특수구조건축물\",\"resContents\":\"\"},{\"resType\":\"지하수위\",\"resContents\":\"\"},{\"resType\":\"기초형식\",\"resContents\":\"\"},{\"resType\":\"구조설계해석법\",\"resContents\":\"동적해석법\"},{\"resType\":\"관련주소|지번\",\"resContents\":\"\"},{\"resType\":\"관련주소|도로명\",\"resContents\":\"\"}],\"resBuildingStatusList\":[{\"resType\":\"주1\",\"resFloor\":\"1층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"소매점\",\"resArea\":\"100.23\"},{\"resType\":\"주1\",\"resFloor\":\"2층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"다가구주택(1가구)\",\"resArea\":\"62.9\"},{\"resType\":\"주1\",\"resFloor\":\"2층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"사무소\",\"resArea\":\"52.96\"},{\"resType\":\"주1\",\"resFloor\":\"3층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"다가구주택(2가구)\",\"resArea\":\"115.86\"},{\"resType\":\"주1\",\"resFloor\":\"4층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"다가구주택(1가구)\",\"resArea\":\"99.18\"},{\"resType\":\"주1\",\"resFloor\":\"옥탑층\",\"resStructure\":\"철근콘크리트구조\",\"resUseType\":\"다락(연면적제외)\",\"resArea\":\"44\"}],\"resLicenseClassList\":[{\"resType\":\"건축주\",\"resUserNm\":\"고봉진\",\"resLicenseNo\":\"19640205******\"},{\"resType\":\"설계자\",\"resUserNm\":\"안병준(주)아키원건축사사무소\",\"resLicenseNo\":\"강원도-건축사사무소-292\"},{\"resType\":\"공사감리자\",\"resUserNm\":\"이기찬라인종합건축사사무소\",\"resLicenseNo\":\"강원도-건축사사무소-351\"},{\"resType\":\"공사시공자\",\"resUserNm\":\"고봉진\",\"resLicenseNo\":\"\"}],\"resParkingLotStatusList\":[{\"resType\":\"옥내|자주식\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"옥내|기계식\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"옥내|전기차\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"옥외|자주식\",\"resNumber\":\"5\",\"resArea\":\"58\"},{\"resType\":\"옥외|기계식\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"옥외|전기차\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"인근|자주식\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"인근|기계식\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"인근|전기차\",\"resNumber\":\"\",\"resArea\":\"\"},{\"resType\":\"면제\",\"resNumber\":\"\",\"resArea\":\"\"}],\"resAuthStatusList\":[],\"resChangeList\":[{\"resChangeDate\":\"20171108\",\"resChangeReason\":\"ㅇ[2016-건축과-신축허가-378(2016-07-19),사용승인(2017-11-08)]신규작성\"},{\"resChangeDate\":\"20230611\",\"resChangeReason\":\"법률제18994호(2023.6.11.)강원특별자치도설치\"}],\"resOwnerList\":[{\"resOwner\":\"채미자\",\"resUserAddr\":\"경기도용인시기흥구보정로87,202동1904호(보정동,죽현마을아이파크)\",\"resOwnershipStake\":\"1/2\",\"resChangeDate\":\"20171113\",\"resChangeReason\":\"소유권보존\",\"resIdentityNo\":\"6305022******\"},{\"resOwner\":\"고봉진\",\"resUserAddr\":\"경기도용인시기흥구보정로87,202동1904호(보정동,죽현마을아이파크))\",\"resOwnershipStake\":\"1/2\",\"resChangeDate\":\"20171113\",\"resChangeReason\":\"소유권보존\",\"resIdentityNo\":\"6402051******\"}]}}F";
            System.out.println("첫 번째 응답: " + result);

            processBMLResult(result, payload, analysisNo);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
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

        String identityEncYn = "Y";
        if ("N".equals(identityEncYn)) {
            parameterMap.put("identityEncYn", "Y");
        } else {
            parameterMap.put("identityEncYn", "N");
        }
        return parameterMap;
    }

    private void processBMLResult(String result, Map<String, Object> payload, Integer analysisNo) throws IOException {
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
        String mainUse = extractMainUse(dataMap);
        String resViolationStatusStr = (String) dataMap.getOrDefault("resViolationStatus", "");
        boolean resViolationStatus = extractResViolationStatus(resViolationStatusStr);


        BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, resViolationStatus, mainUse);
        buildingManagementLedgerMapper.insertBuildingData(ledgerData);
    }

    private void extractAndSaveDataFromResult2(String result2, Integer analysisNo) throws IOException {
        Map<String, Object> responseMap = new ObjectMapper().readValue(result2, HashMap.class);
        Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");

        String mainUse = extractMainUse(dataMap);
        String resViolationStatusStr = (String) dataMap.getOrDefault("resViolationStatus", "");
        boolean resViolationStatus = extractResViolationStatus(resViolationStatusStr);

        BuildingManagementLedgerDto ledgerData = new BuildingManagementLedgerDto(analysisNo, resViolationStatus, mainUse);
        buildingManagementLedgerMapper.insertBuildingData(ledgerData);
    }

    private boolean extractResViolationStatus(String resViolationStatusStr) {
        return !resViolationStatusStr.isEmpty();
    }

    private String extractMainUse(Map<String, Object> dataMap) {
        if (dataMap.get("resDetailList") instanceof Iterable) {
            for (Map<String, Object> detail : (Iterable<Map<String, Object>>) dataMap.get("resDetailList")) {
                if ("주용도".equals(detail.get("resType"))) {
                    return (String) detail.get("resContents");
                }
            }
        }
        return "";
    }
}
