package org.scoula.safety_inspection.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.scoula.safety_inspection.codef.EasyCodef;
import org.scoula.safety_inspection.codef.EasyCodefServiceType;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.scoula.safety_inspection.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.safety_inspection.codef.EasyCodefUtil.encryptRSA;

@Service
@RequiredArgsConstructor
public class ExtractUnicodeService {

    private final EasyCodef easyCodef;
    private final ObjectMapper objectMapper;

    @Value("${codef.eprepayNo}")
    private String ePrepayNo;

    @Value("${codef.eprepayPass}")
    private String ePrepayPass;

    @Value("${codef.userPass}")
    private String userPass;

    private static final String ORGANIZATION_CODE = "0002"; // 기관코드
    private static final String INQUIRY_TYPE = "2"; // 조회구분
    private static final String INPUT_SELECT = "0"; // 입력선택
    private static final String JOINT_MORTGAGE_YN = "1"; // 공동담보/전세목록 포함 여부
    private static final String TRADING_YN = "1"; // 매매 목록 포함 여부
    private static final String ELECTRONIC_CLOSED_YN = "0"; // 전산 폐쇄 조회 여부
    private static final String ISSUE_TYPE = "2"; // 발행구분
    private static final String REGISTER_SUMMARY_YN = "1"; // 등기사항요약 출력 여부
    private static final String DEFAULT_PHONE_NO = "01000000000"; // 기본 전화번호

    public List<Map<String, String>> getUniqueCode(Map<String, Object> payload)
            throws UnsupportedEncodingException, JsonProcessingException, InterruptedException,
            NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException,
            InvalidKeySpecException, BadPaddingException, InvalidKeyException {

        String password = encryptRSA(userPass, PUBLIC_KEY);
        HashMap<String, Object> parameterMap = createParameterMap(payload, password);
        List<Map<String, String>> extractedValues;

        // 첫 번째 조회: realtyType을 "0"으로 설정
        parameterMap.put("realtyType", "0");
        String productUrl = "/v1/kr/public/ck/real-estate-register/status";
        String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
        System.out.println("result = " + result);

        // 결과 처리
        extractedValues = processResult(result,"0");
        String responseCode = getResponseCode(result);

        // 첫 번째 요청에서 실패 시 realtyType을 "1"로 변경하여 다시 요청
        if (!responseCode.equals("CF-00000")) {
            parameterMap.put("realtyType", "1");
            result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
            System.out.println("result = " + result);

            // 결과 처리
            extractedValues = processResult(result,"1");
            responseCode = getResponseCode(result);

            // 두 번째 요청에서도 실패 시 오류 메시지 반환
            if (!responseCode.equals("CF-00000")) {
                Map<String, String> errorMap = new HashMap<>();
                errorMap.put("resState", "조회 실패: 서버 응답 코드가 CF-00000이 아닙니다.");
                errorMap.put("realtyType", "-1");
                extractedValues.add(errorMap);
            }
        }

        return extractedValues;
    }

    // 응답 코드 추출 메서드
    private String getResponseCode(String result) throws JsonProcessingException {
        JsonNode jsonNode = objectMapper.readTree(result);
        return jsonNode.get("result").get("code").asText();
    }

    private HashMap<String, Object> createParameterMap(Map<String, Object> payload, String password)
            throws InvalidKeyException {
        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", ORGANIZATION_CODE); // 기관코드
        parameterMap.put("inquiryType", INQUIRY_TYPE); // 조회구분
        parameterMap.put("password", password);
        parameterMap.put("phoneNo", DEFAULT_PHONE_NO); // 기본 전화번호
        parameterMap.put("addr_sido", payload.get("addr_sido")); // 시/도
        parameterMap.put("addr_dong", payload.get("addr_dong")); // 읍/면/동
        parameterMap.put("addr_lotNumber", payload.get("addr_lotNumber")); // 지번
        parameterMap.put("inputSelect", INPUT_SELECT); // 입력선택
        parameterMap.put("buildingName", payload.get("buildingName")); // 건물명칭
        parameterMap.put("dong", payload.get("dong")); // 동
        parameterMap.put("ho", payload.get("ho")); // 호
        parameterMap.put("jointMortgageJeonseYN", JOINT_MORTGAGE_YN); // 공동담보/전세목록 포함 여부
        parameterMap.put("tradingYN", TRADING_YN); // 매매 목록 포함 여부
        parameterMap.put("listNumber", null); // 목록 전체 선택
        parameterMap.put("electronicClosedYN", ELECTRONIC_CLOSED_YN); // 전산 폐쇄 조회 여부
        parameterMap.put("ePrepayNo", ePrepayNo); // 선불 전자 지급 수단 번호
        parameterMap.put("ePrepayPass", ePrepayPass); // 선불 전자 지급 수단 비밀번호
        parameterMap.put("issueType", ISSUE_TYPE); // 발행구분
        parameterMap.put("registerSummaryYN", REGISTER_SUMMARY_YN); // 등기사항요약 출력 여부

        return parameterMap;
    }

    private List<Map<String, String>> processResult(String result, String realtyType) throws JsonProcessingException {
        JsonNode jsonNode = objectMapper.readTree(result);
        String responseCode = jsonNode.get("result").get("code").asText();
        List<Map<String, String>> extractedValues = new ArrayList<>();


        if (responseCode.equals("CF-00000")) {
            JsonNode resAddrList = jsonNode.get("data").path("resAddrList");

            for (JsonNode addr : resAddrList) {
                Map<String, String> addrMap = new HashMap<>();
                addrMap.put("commonUniqueNo", addr.path("commUniqueNo").asText());
                addrMap.put("commAddrLotNumber", addr.path("commAddrLotNumber").asText());
                addrMap.put("resState", addr.path("resState").asText());
                addrMap.put("realtyType",realtyType);
                extractedValues.add(addrMap);
            }
        } else {
            Map<String, String> noResultsMap = new HashMap<>();
            noResultsMap.put("resState", "검색 결과가 없습니다. 검색어에 잘못된 철자가 없는지, 정확한 주소인지 다시 한번 확인해 주세요.");
            extractedValues.add(noResultsMap);
        }
        return extractedValues;
    }
}