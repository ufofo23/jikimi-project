package org.scoula.safety_inspection.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefServiceType;
import org.springframework.beans.factory.annotation.Autowired;
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

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.codefapi.codef.EasyCodefUtil.encryptRSA;


@Service
@Transactional
public class ExtractUnicodeService {

    private final EasyCodef easyCodef;
    private final ObjectMapper objectMapper;

    @Autowired
    public ExtractUnicodeService(EasyCodef easyCodef, ObjectMapper objectMapper) {
        this.easyCodef = easyCodef;
        this.objectMapper = objectMapper;
    }


    public List<Map<String, String>> getUniqueCode(Map<String,Object> payload) throws UnsupportedEncodingException, JsonProcessingException, InterruptedException, NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException {

        System.out.println(payload);
        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", "0002"); // 기관코드
        parameterMap.put("inquiryType", "2"); // 조회구분 (2: 소재지번으로 찾기)
        parameterMap.put("realtyType", payload.get("realtyType")); // 부동산 구분 [0: 토지+건물, 1: 집합건물, 2: 토지, 3: 건물]
        String password = encryptRSA("1234", PUBLIC_KEY); // 임의의 비밀번호를 RSA로 암호화
        parameterMap.put("password", password); // 암호화된 비밀번호
        parameterMap.put("phoneNo", "01000000000"); // 전화번호
        parameterMap.put("addr_sido", payload.get("addr_sido")); // 주소 시/도
        parameterMap.put("addr_dong", payload.get("addr_dong")); // 주소 읍/면/동
        parameterMap.put("addr_lotNumber", payload.get("addr_lotNumber")); // 주소 지번
        parameterMap.put("inputSelect", "0"); // 입력선택 [0: 지번, 1: 건물명칭]
        parameterMap.put("buildingName", payload.get("buildingName")); // 건물명칭
        parameterMap.put("dong", payload.get("dong")); // 동
        parameterMap.put("ho", payload.get("ho")); // 호
        parameterMap.put("jointMortgageJeonseYN", "1"); // 공동담보/전세목록 포함여부 - 0:미포함 1:포함 (default='0')
        parameterMap.put("tradingYN", "1"); // 매매 목록 포함 여부 - 0:미포함 1:포함 (default='0')
        parameterMap.put("listNumber", null); // 목록 전체 선택 (다건 선택시 '|' 로 구분 ex) '2007123|2017134')
        parameterMap.put("electronicClosedYN", "0"); // 전산 폐쇄 조회 여부 [0:미포함 1:포함 (default='0')]
        parameterMap.put("ePrepayNo", "J77887546198"); // 선불 전자 지급 수단 번호
        parameterMap.put("ePrepayPass", "aa1234"); // 선불 전자 지급 수단 비밀번호
        parameterMap.put("issueType", "2"); // 발행구분 [0: 발급, 1: 열람, 2: 고유번호조회, 3: 원문데이터 결과처리]
        parameterMap.put("registerSummaryYN", "1"); // 등기사항요약 출력 여부 [0: 미출력, 1: 출력 (default='0')]

        String productUrl = "/v1/kr/public/ck/real-estate-register/status";
//        String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
        String result = "{\n" +
                "  \"result\": {\n" +
                "    \"code\": \"CF-00000\",\n" +
                "    \"extraMessage\": \"\",\n" +
                "    \"message\": \"성공\",\n" +
                "    \"transactionId\": \"66fb928aec82eab8491a19dd\"\n" +
                "  },\n" +
                "  \"data\": {\n" +
                "    \"resRegisterEntriesList\": [],\n" +
                "    \"resSearchList\": [],\n" +
                "    \"resAddrList\": [\n" +
                "      {\n" +
                "        \"commUniqueNo\": \"19132020004723\",\n" +
                "        \"commAddrLotNumber\": \"경상남도 밀양시 중앙로 114 [가곡동 613-42외 2필지 제나동호\",\n" +
                "        \"resType\": \"\",\n" +
                "        \"resUserNm\": \"의***~\",\n" +
                "        \"resState\": \"현행\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"commUniqueNo\": \"19132022002898\",\n" +
                "        \"commAddrLotNumber\": \"경상남도 밀양시 중앙로 114 [가곡동 613-19 제나동호\",\n" +
                "        \"resType\": \"\",\n" +
                "        \"resUserNm\": \"의***~\",\n" +
                "        \"resState\": \"현행\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"commUniqueNo\": \"19132022002943\",\n" +
                "        \"commAddrLotNumber\": \"경상남도 밀양시 중앙로 114 [가곡동 613-19 제가동호\",\n" +
                "        \"resType\": \"\",\n" +
                "        \"resUserNm\": \"의***~\",\n" +
                "        \"resState\": \"현행\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"commUniqueNo\": \"19132022002946\",\n" +
                "        \"commAddrLotNumber\": \"경상남도 밀양시 중앙로 114 [가곡동 613-19 제다동호\",\n" +
                "        \"resType\": \"\",\n" +
                "        \"resUserNm\": \"의***~\",\n" +
                "        \"resState\": \"현행\"\n" +
                "      }\n" +
                "    ],\n" +
                "    \"resImageList\": [],\n" +
                "    \"resOriGinalData\": \"\",\n" +
                "    \"resIssueYN\": \"0\",\n" +
                "    \"commIssueCode\": \"\",\n" +
                "    \"resTotalPageCount\": \"\",\n" +
                "    \"commStartPageNo\": \"\",\n" +
                "    \"resEndPageNo\": \"\"\n" +
                "  }\n" +
                "}";
//        System.out.println("result = " + result);

        JsonNode jsonNode = objectMapper.readTree(result);
        System.out.println(jsonNode);

        JsonNode resAddrList = jsonNode.get("data").path("resAddrList");
        List<Map<String,String>> extractedValues = new ArrayList<>();

        for(JsonNode addr : resAddrList){
            Map<String,String> addrMap = new HashMap<>();
            addrMap.put("commonUniqueNo", addr.path("commUniqueNo").asText());
            addrMap.put("commAddrLotNumber", addr.path("commAddrLotNumber").asText());
            addrMap.put("resState", addr.path("resState").asText());
            extractedValues.add(addrMap);
        }

        // 결과 반환 (필요에 따라 수정)
        return extractedValues;
    }
}
