package org.scoula.codefapi.bml.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.scoula.codefapi.bml.mapper.BuildingManagementLedgerMapper;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefClientInfo;
import org.scoula.codefapi.codef.EasyCodefServiceType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;

@Service
public class BuildingManagementLedgerService {

    @Autowired
    private BuildingManagementLedgerMapper ledgerMapper;

    @SuppressWarnings("unchecked")
    public String getBuildingLedger(String organization, String loginType, String userName, String identity, String address, String zipCode) {
        try {
            // 1. 코드에프 객체 생성
            EasyCodef codef = new EasyCodef();

            // 2. 데모 클라이언트 정보 설정
            codef.setClientInfoForDemo(EasyCodefClientInfo.DEMO_CLIENT_ID, EasyCodefClientInfo.DEMO_CLIENT_SECRET);

            // 3. RSA 암호화를 위한 퍼블릭키 설정
            codef.setPublicKey(PUBLIC_KEY);

            // 4. 입력 파라미터 설정
            HashMap<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("organization", organization);
            parameterMap.put("loginType", loginType);
            parameterMap.put("userName", userName);
            parameterMap.put("identity", identity);
            parameterMap.put("address", address);
            parameterMap.put("zipCode", zipCode);
            parameterMap.put("type", "0");
            parameterMap.put("inquiryType", "1");

            // 5. 코드에프 정보 조회 요청
            String productUrl = "/v1/kr/public/mw/building-register/colligation";
            String result = codef.requestProduct(productUrl, EasyCodefServiceType.SANDBOX, parameterMap);

            // 6. JSON 파싱 및 결과 확인
            Map<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
            Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");

            if (dataMap != null) {
                String resUserAddr = (String) dataMap.get("resUserAddr");
                String resViolationStatus = (String) dataMap.getOrDefault("resViolationStatus", "");

                // DB에 저장
                ledgerMapper.insertBuildingData(resUserAddr, resViolationStatus);

                return "저장 성공";
            } else {
                return "데이터 없음";
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt(); // 스레드 상태를 다시 복원
            return "요청이 중단되었습니다: " + e.getMessage();
        } catch (JsonProcessingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        }
    }
}
