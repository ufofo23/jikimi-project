package org.scoula.codefapi.bml.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerMultiRequest;
import org.scoula.codefapi.bml.dto.BuildingManagementLedgerMultiDto;
import org.scoula.codefapi.bml.mapper.BuildingManagementLedgerMultiMapper;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefClientInfo;
import org.scoula.codefapi.codef.EasyCodefServiceType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.*;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;

@Service
@Transactional
@RequiredArgsConstructor
public class BuildingManagementLedgerMultiService {

    private final BuildingManagementLedgerMultiMapper ledgerMultiMapper;

    @SuppressWarnings("unchecked")
    public String getBuildingLedgerMulti(BuildingManagementLedgerMultiRequest request) {
        try {
            // 1. 코드에프 객체 생성
            EasyCodef codef = new EasyCodef();

            // 2. 데모 클라이언트 정보 설정
            codef.setClientInfoForDemo(EasyCodefClientInfo.DEMO_CLIENT_ID, EasyCodefClientInfo.DEMO_CLIENT_SECRET);

            // 3. 퍼블릭키 설정
            codef.setPublicKey(PUBLIC_KEY);

            // 4. 입력 파라미터 설정
            HashMap<String, Object> parameterMap = new HashMap<>();
            // 고정 입력 파라미터
            parameterMap.put("organization", "0001"); // 기관코드
            parameterMap.put("loginType", "3"); // 로그인 구분 (비회원 본인인증)
            parameterMap.put("type", "0"); // ("0":지상, "1":지하, "2":공중)
            
            parameterMap.put("userName", ""); // 이름
            parameterMap.put("birthDate", ""); // 주민등록번호 앞자리
            parameterMap.put("identity", ""); // 주민등록번호 뒷자리

            // 프론트에서 받아와야하는 파라미터
            parameterMap.put("address", request.getAddress()); // 주소
            parameterMap.put("dong", request.getDong()); // 동
            parameterMap.put("ho", request.getHo()); // 호
            parameterMap.put("zipCode", request.getZipCode()); // 우편번호 (도로명으로 검색했을 시)
            parameterMap.put("dongNum", request.getDongNum()); // 동번호 (특수한 경우)
            parameterMap.put("hoNum", request.getHoNum()); // 호번호 (특수한 경우)

            // 기타 파라미터 (설정 불필요)
            parameterMap.put("originDataYN", ""); // 원문 DATA 포함 여부 (값이 명시되지 않음)
            parameterMap.put("timeout", ""); // 제한시간 (값이 명시되지 않음)
            parameterMap.put("secureNoTimeout", ""); // 보안숫자 제한시간 (값이 명시되지 않음)

            // 5. 코드에프 정보 조회 요청
            String productUrl = "/v1/kr/public/mw/multiowned-buildings/possession-ledger";
            String result = codef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);

            // 6. JSON 파싱 및 결과 확인
            Map<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
            Map<String, Object> dataMap = (Map<String, Object>) responseMap.get("data");
            System.out.println(result);

            if (dataMap != null) {
                String resViolationStatus = (String) dataMap.getOrDefault("resViolationStatus", "");

                List<Map<String, Object>> resOwnedList = (List<Map<String, Object>>) dataMap.get("resOwnedList");
                String resUseType = getResUseType(resOwnedList);

                // DB에 저장
                ledgerMultiMapper.insertBuildingData(new BuildingManagementLedgerMultiDto(resViolationStatus, resUseType));

                return "저장 성공";
            } else {
                return "데이터 없음";
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt(); // 스레드 상태를 복원
            return "요청이 중단되었습니다: " + e.getMessage();
        } catch (JsonProcessingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        }
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