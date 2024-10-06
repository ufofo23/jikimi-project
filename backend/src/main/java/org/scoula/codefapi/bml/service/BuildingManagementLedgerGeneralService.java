package org.scoula.codefapi.bml.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerGeneralDto;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerGeneralRequest;
import org.scoula.codefapi.bml.mapper.BuildingManagementLedgerGeneralMapper;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefClientInfo;
import org.scoula.codefapi.codef.EasyCodefServiceType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;

@Service
@Transactional
@RequiredArgsConstructor
public class BuildingManagementLedgerGeneralService {

    private final BuildingManagementLedgerGeneralMapper ledgerGeneralMapper;


    public String getBuildingLedgerGeneral(BuildingManagementLedgerGeneralRequest request) {
        try {
            // 1. Codef 객체 생성
            EasyCodef codef = new EasyCodef();

            // 2. 데모 클라이언트 정보 설정
            codef.setClientInfoForDemo(EasyCodefClientInfo.DEMO_CLIENT_ID, EasyCodefClientInfo.DEMO_CLIENT_SECRET);

            // 3. RSA 암호화를 위한 퍼블릭 키 설정
            codef.setPublicKey(PUBLIC_KEY);

            // 4. 파라미터 설정 (address 제외)
            HashMap<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("organization", "0001"); // 기관코드 (고정값: 0001)
            parameterMap.put("loginType", "3"); // 로그인 구분 (3: 비회원 본인인증)
            parameterMap.put("type", "0"); // 구분 ("0": 지상, "1": 지하, "2": 공중)

            parameterMap.put("userName", ""); // 이름 (loginType이 3 또는 5일 때 필수)
            parameterMap.put("birthDate", ""); // 주민등록번호 앞자리 (identityEncYn이 "Y"인 경우 필수, yymmdd 형식)
            parameterMap.put("identity", ""); // 주민등록번호 뒷자리 (loginType이 3 또는 5일 때 필수, 암호화 여부에 따라 값 달라짐)


            // 프론트에서 받아와야하는 파라미터
            parameterMap.put("address", request.getAddress()); // 주소 (필수)
            parameterMap.put("zipCode", request.getZipCode()); // 우편번호 (5자리, 도로명 검색 결과 재검색 시 사용 가능)
            parameterMap.put("dong", request.getDong()); // 동명칭 (없는 경우 미입력)

            // 설정 불필요
            parameterMap.put("timeout", "60"); // 제한 시간 (초 단위)
            parameterMap.put("originDataYN", "0"); // 원문 데이터 포함 여부 ("0": 미포함, "1": 포함, 기본값: "0")
            parameterMap.put("secureNoTimeout", "60"); // 보안 숫자 제한 시간 (초 단위, 기본값: 60초)
            String identityEncYn = "Y";
            if (identityEncYn.equals("N")) {
                parameterMap.put("identityEncYn", "Y");
            } else {
                parameterMap.put("identityEncYn", "N");
            }

            // 5. 코드에프 API 호출
            String productUrl = "/v1/kr/public/mw/building-register/general";
            String result = codef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);

            // 6. 응답 처리 및 JSON 파싱
            Map<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
            Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");

            if (dataMap != null) {
                String resViolationStatus = (String) dataMap.getOrDefault("resViolationStatus", "");
                String mainUse = extractMainUse(dataMap);

                // DB에 데이터 저장 (address 제외)
                BuildingManagementLedgerGeneralDto ledgerData = new BuildingManagementLedgerGeneralDto(resViolationStatus, mainUse);
                ledgerGeneralMapper.insertBuildingData(ledgerData);

                return "저장 성공";
            } else {
                return "데이터가 없습니다";
            }
        } catch (UnsupportedEncodingException | JsonProcessingException e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
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

