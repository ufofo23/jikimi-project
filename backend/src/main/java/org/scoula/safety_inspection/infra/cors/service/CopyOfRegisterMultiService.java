package org.scoula.safety_inspection.infra.cors.service;

import lombok.RequiredArgsConstructor;
import org.scoula.safety_inspection.codef.EasyCodefServiceType;
import org.scoula.safety_inspection.infra.cors.dto.CopyOfRegisterDto;
import org.scoula.safety_inspection.codef.EasyCodef;
import org.scoula.safety_inspection.infra.cors.mapper.CopyOfRegisterMapper;
import org.scoula.safety_inspection.infra.cors.jsontoclass.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.scoula.safety_inspection.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.safety_inspection.codef.EasyCodefUtil.encryptRSA;

@Service
@RequiredArgsConstructor
public class CopyOfRegisterMultiService {

    private final CopyOfRegisterMapper registerMapper;

    private final EasyCodef easyCodef;

    @Value("${codef.eprepayNo}")
    private String ePrepayNo;

    @Value("${codef.eprepayPass}")
    private String ePrepayPass;

    @Value("${codef.userPass}")
    private String userPass;

    private static final String ORGANIZATION = "0002";
    private static final String INQUIRY_TYPE = "0";
    private static final String JOINT_MORTGAGE_YN = "1";
    private static final String TRADING_YN = "0";
    private static final String ISSUE_TYPE = "1";
    private static final String PHONE_NO = "01000000000";
    private static final String REGISTER_SUMMARY_YN = "1";

    @Transactional(propagation = Propagation.MANDATORY)
    public void getCopyOfRegister(Map<String, Object> payload, Integer analysisNo) {

        try{

            String password = encryptRSA(userPass, PUBLIC_KEY);
            HashMap<String, Object> parameterMap = createParameterMap(payload, password);

            String productUrl = "/v1/kr/public/ck/real-estate-register/status";
            String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
            System.out.println("result = " + result);


            processRegisterResult(result, analysisNo);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private HashMap<String, Object> createParameterMap(Map<String, Object> payload, String password) {
        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("uniqueNo", payload.get("uniqueCode"));
        parameterMap.put("realtyType", payload.get("realtyType"));
        parameterMap.put("ePrepayNo", ePrepayNo);
        parameterMap.put("ePrepayPass", ePrepayPass);
        parameterMap.put("password", password);
        parameterMap.put("organization", ORGANIZATION);
        parameterMap.put("inquiryType", INQUIRY_TYPE);
        parameterMap.put("jointMortgageJeonseYN", JOINT_MORTGAGE_YN);
        parameterMap.put("tradingYN", TRADING_YN);
        parameterMap.put("listNumber", null);
        parameterMap.put("electronicClosedYN", "0");
        parameterMap.put("issueType", ISSUE_TYPE);
        parameterMap.put("phoneNo", PHONE_NO);
        parameterMap.put("registerSummaryYN", REGISTER_SUMMARY_YN);
        return parameterMap;
    }

    private void processRegisterResult(String result, Integer analysisNo) throws IOException {
        O obj = Converter.fromJsonString(result);
        ResRegisterEntriesList firstEntry = obj.getData().getResRegisterEntriesList()[0];

        String ownerStateStr = getOwnerState(firstEntry);
        Double ownerState = Double.parseDouble(ownerStateStr);

        String ownership = getOwnership(firstEntry);

        String commonOwner = getCommonOwner(firstEntry);

        String changeOwnerCount = getChangeOwnerCount(firstEntry);

        String maximumOfBondStr = getMaximumOfBond(firstEntry);
        Integer maximumOfBond = Integer.parseInt(maximumOfBondStr);


        CopyOfRegisterDto registerDto = new CopyOfRegisterDto(
                analysisNo, ownerState, ownership,
                commonOwner, changeOwnerCount, maximumOfBond
        );

        registerMapper.insertCopyOfRegister(registerDto);
    }

    private static String getOwnerState(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        return resRegistrationHisList[2].getResContentsList()[1].getResDetailList()[3].getResContents()
                .split("㎡")[0].replaceAll(".*?\\s+", "");
    }

    private static String getOwnership(ResRegisterEntriesList entry) {
        ResContentsList[] resContentsList = entry.getResRegistrationSumList()[0].getResContentsList();
        return resContentsList[resContentsList.length - 1].getResDetailList()[0].getResContents();
    }

    private static String getCommonOwner(ResRegisterEntriesList entry) {
        ResContentsList[] resContentsList = entry.getResRegistrationSumList()[0].getResContentsList();
        return resContentsList[resContentsList.length - 1].getResDetailList()[2].getResContents();
    }

    private static String getChangeOwnerCount(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        ResContentsList[] resContentsList = resRegistrationHisList[4].getResContentsList();
        String owner = resContentsList[resContentsList.length - 1].getResDetailList()[0].getResContents();
        return owner.split("-")[0];
    }

    private static String getMaximumOfBond(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        // 갑구 - 소유권에 관한 사항
        ResContentsList[] resContentsList = resRegistrationHisList[resRegistrationHisList.length-1].getResContentsList();
        String maximum = null;

        for (int i = resContentsList.length - 1; i >= 0; i--) {
            if (resContentsList[i].getResDetailList()[4].getResContents().contains("채권최고액")) {
                maximum = resContentsList[i].getResDetailList()[4].getResContents();
                break;
            }
        }

        if (maximum != null) {
            Pattern pattern = Pattern.compile("최고액\\s*금([0-9,]+)원");
            Matcher matcher = pattern.matcher(maximum);

            if (matcher.find()) {
                return matcher.group(1).replace(",", "");
            }
        }
        return "0";
    }

    private static String getJunsae(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        ResContentsList[] resContentsList = resRegistrationHisList[5].getResContentsList();
        String junsae = null;

        for (int i = resContentsList.length - 1; i >= 0; i--) {
            if (resContentsList[i].getResDetailList()[4].getResContents().contains("전세금")) {
                junsae = resContentsList[i].getResDetailList()[4].getResContents();
                break;
            }
        }

        if (junsae != null) {
            Pattern pattern = Pattern.compile("전세금\\s*금([0-9,]+)원");
            Matcher matcher = pattern.matcher(junsae);

            if (matcher.find()) {
                return matcher.group(1).replace(",", "");
            }
        }

        return "전세 기록 없음";
    }

}
