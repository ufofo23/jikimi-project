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

    private static final String ORGANIZATION_CODE = "0002";
    private static final String INQUIRY_TYPE = "2";
    private static final String INPUT_SELECT = "0";
    private static final String JOINT_MORTGAGE_YN = "1";
    private static final String TRADING_YN = "1";
    private static final String ELECTRONIC_CLOSED_YN = "0";
    private static final String ISSUE_TYPE = "2";
    private static final String REGISTER_SUMMARY_YN = "1";
    private static final String DEFAULT_PHONE_NO = "01000000000";

    public List<Map<String, String>> getUniqueCode(Map<String, Object> payload)
            throws UnsupportedEncodingException, JsonProcessingException, InterruptedException,
            NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException,
            InvalidKeySpecException, BadPaddingException, InvalidKeyException {

        String password = encryptRSA(userPass, PUBLIC_KEY);
        HashMap<String, Object> parameterMap = createParameterMap(payload, password);
        List<Map<String, String>> extractedValues = new ArrayList<>();

        String productUrl = "/v1/kr/public/ck/real-estate-register/status";

        // realtyType이 0인 경우의 요청
        parameterMap.put("realtyType", "0");
        String result0 = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
        System.out.println("result for realtyType 0 = " + result0);
        extractedValues.addAll(processResult(result0, "0"));

        // realtyType이 1인 경우의 요청
        parameterMap.put("realtyType", "1");
        String result1 = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
        System.out.println("result for realtyType 1 = " + result1);
        extractedValues.addAll(processResult(result1, "1"));

        return extractedValues;
    }

    private HashMap<String, Object> createParameterMap(Map<String, Object> payload, String password) {
        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", ORGANIZATION_CODE);
        parameterMap.put("inquiryType", INQUIRY_TYPE);
        parameterMap.put("password", password);
        parameterMap.put("phoneNo", DEFAULT_PHONE_NO);
        parameterMap.put("addr_sido", payload.get("addr_sido"));
        parameterMap.put("addr_dong", payload.get("addr_dong"));
        parameterMap.put("addr_lotNumber", payload.get("addr_lotNumber"));
        parameterMap.put("inputSelect", INPUT_SELECT);
        parameterMap.put("buildingName", payload.get("buildingName"));
        parameterMap.put("dong", payload.get("dong"));
        parameterMap.put("ho", payload.get("ho"));
        parameterMap.put("jointMortgageJeonseYN", JOINT_MORTGAGE_YN);
        parameterMap.put("tradingYN", TRADING_YN);
        parameterMap.put("listNumber", null);
        parameterMap.put("electronicClosedYN", ELECTRONIC_CLOSED_YN);
        parameterMap.put("ePrepayNo", ePrepayNo);
        parameterMap.put("ePrepayPass", ePrepayPass);
        parameterMap.put("issueType", ISSUE_TYPE);
        parameterMap.put("registerSummaryYN", REGISTER_SUMMARY_YN);

        return parameterMap;
    }

    private List<Map<String, String>> processResult(String result, String realtyType) throws JsonProcessingException {
        JsonNode jsonNode = objectMapper.readTree(result);
        List<Map<String, String>> extractedValues = new ArrayList<>();

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("realtyType", realtyType);
        resultMap.put("responseCode", jsonNode.get("result").get("code").asText());
        resultMap.put("responseMessage", jsonNode.get("result").get("message").asText());

        JsonNode dataNode = jsonNode.get("data");
        if (dataNode != null && dataNode.has("resAddrList")) {
            JsonNode resAddrList = dataNode.get("resAddrList");
            for (JsonNode addr : resAddrList) {
                Map<String, String> addrMap = new HashMap<>(resultMap);
                addrMap.put("commonUniqueNo", addr.path("commUniqueNo").asText());
                addrMap.put("commAddrLotNumber", addr.path("commAddrLotNumber").asText());
                addrMap.put("resState", addr.path("resState").asText());
                extractedValues.add(addrMap);
            }
        } else {
            extractedValues.add(resultMap);
        }

        return extractedValues;
    }
}