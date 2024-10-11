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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
        List<String> ownershipList = getOwnership(firstEntry);
        String ownership = String.join("", ownershipList);
        String commonOwner = getCommonOwner(firstEntry);
        String changeOwnerCountStr = getChangeOwnerCount(firstEntry);
        Integer changeOwnerCount = Integer.parseInt(changeOwnerCountStr);
        Integer maximumOfBond = Integer.parseInt(getMaximumOfBond(firstEntry));


        CopyOfRegisterDto registerDto = new CopyOfRegisterDto(
                analysisNo, ownerState, ownership,
                commonOwner, changeOwnerCount, maximumOfBond
        );

        registerMapper.insertCopyOfRegister(registerDto);
    }

    private static String getOwnerState(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        for (ResRegistrationList registration : resRegistrationHisList) {
            if ("전유부분의 건물의 표시".equals(registration.getResType1())) {
                return extractOwnerState(registration);
            }
        }
        return "";
    }

    private static String extractOwnerState(ResRegistrationList registration) {
        return registration.getResContentsList()[1].getResDetailList()[3].getResContents()
                .split("㎡")[0].replaceAll(".*?\\s+", "");
    }

    private static List<String> getOwnership(ResRegisterEntriesList entry) {
        List<String> ownershipList = new ArrayList<>();
        if ("소유지분현황 (갑구)".equals(entry.getResRegistrationSumList()[0].getResType())) {
            ResContentsList[] resContentsList = entry.getResRegistrationSumList()[0].getResContentsList();
            for (int i = 1; i < resContentsList.length; i++) {
                ownershipList.add(resContentsList[i].getResDetailList()[0].getResContents());
            }
        }
        return ownershipList;
    }

    private static String getCommonOwner(ResRegisterEntriesList entry) {
        ResContentsList[] resContentsList = entry.getResRegistrationSumList()[0].getResContentsList();
        if ("소유지분현황 (갑구)".equals(entry.getResRegistrationSumList()[0].getResType())) {
            return (resContentsList.length >= 3) ? "공동소유" : "단독소유";
        }
        return "";
    }

    private static String getChangeOwnerCount(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        for (ResRegistrationList registration : resRegistrationHisList) {
            if ("소유권에 관한 사항".equals(registration.getResType1())) {
                ResContentsList[] resContentsList = registration.getResContentsList();
                String owner = resContentsList[resContentsList.length - 1].getResDetailList()[0].getResContents();

                return owner.split("[-\\n]")[0];
            }
        }
        return "";
    }

    private static String getMaximumOfBond(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        for (int i = resRegistrationHisList.length - 1; i >= 0; i--) {
            if ("소유권 이외의 권리에 관한 사항".equals(resRegistrationHisList[i].getResType1())) {
                ResContentsList[] resContentsList = resRegistrationHisList[i].getResContentsList();
                for (int j = resContentsList.length - 1; j >= 0; j--) {
                    if (resContentsList[j].getResDetailList()[4].getResContents().contains("채권최고액")) {
                        String maximum = resContentsList[j].getResDetailList()[4].getResContents();
                        return extractMaximumBond(maximum);
                    }
                }
                return "0";
            }
        }
        return "0";
    }

    private static String extractMaximumBond(String maximum) {
        Pattern pattern = Pattern.compile("최고액\\s*금([0-9,]+)원");
        Matcher matcher = pattern.matcher(maximum);
        if (matcher.find()) {
            return matcher.group(1).replace(",", "");
        }
        return "0";
    }

}
