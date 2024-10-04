package org.scoula.codefapi.bml.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerDto;
import org.scoula.codefapi.bml.mapper.BuildingManagementLedgerMapper;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefClientInfo;
import org.scoula.codefapi.codef.EasyCodefServiceType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;

@Service
@Transactional
@RequiredArgsConstructor
public class BuildingManagementLedgerService {

    private final BuildingManagementLedgerMapper ledgerMapper;

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
            parameterMap.put("organization", "0001");
            parameterMap.put("loginType", "3");
            parameterMap.put("userName", ""); // 이름
            parameterMap.put("identity", ""); // 주민등록번호
            parameterMap.put("address", "서울시 서초구 신반포로 270");
            parameterMap.put("zipCode", "06544");
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

                List<Map<String, String>> resDetailList = (List<Map<String, String>>) dataMap.getOrDefault("resDetailList", new ArrayList<>());
                String resContents = getResContents(resDetailList);

                // DB에 저장
                ledgerMapper.insertBuildingData(new BuildingManagementLedgerDto(resUserAddr, resViolationStatus, resContents));

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

    private String getResContents(List<Map<String, String>> resDetailList) {
        for (Map<String, String> resDetail : resDetailList) {
            if ("주용도".equals(resDetail.get("resType"))) {
                return resDetail.get("resContents");
            }
        }
        return "";
    }

}
