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
public class CopyOfRegisterGeneralService {

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
        try {
            String password = encryptRSA(userPass, PUBLIC_KEY);
            HashMap<String, Object> parameterMap = createParameterMap(payload, password);
            String productUrl = "/v1/kr/public/ck/real-estate-register/status";
//            String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
            String result = "{\"result\":{\"code\":\"CF-00000\",\"extraMessage\":\"\",\"message\":\"성공\",\"transactionId\":\"67035204ec82eab8491ac164\"},\"data\":{\"resRegisterEntriesList\":[{\"resDocTitle\":\"등기사항전부증명서(말소사항포함)-토지\",\"resRealty\":\"[토지]강원특별자치도원주시문막읍포진리662-17\",\"commUniqueNo\":\"14122007005209\",\"resRegistrationHisList\":[{\"resType\":\"표제부\",\"resType1\":\"토지의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"소재지번\"},{\"resNumber\":\"3\",\"resContents\":\"지목\"},{\"resNumber\":\"4\",\"resContents\":\"면적\"},{\"resNumber\":\"5\",\"resContents\":\"등기원인및기타사항\"}]},{\"resType2\":\"2\",\"resNumber\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&2007년6월13일&\"},{\"resNumber\":\"2\",\"resContents\":\"&강원도원주시문막읍&\\n&포진리662-17&\"},{\"resNumber\":\"3\",\"resContents\":\"&답&\"},{\"resNumber\":\"4\",\"resContents\":\"&19㎡&\"},{\"resNumber\":\"5\",\"resContents\":\"&분할로인하여강원도&\\n&원주시문막읍포진리&\\n&662-6에서이기&|&대위자&&국&\\n&대위원인2007년5월29&\\n10^&일&\\n10^&공공용지협의취득&\\n10^&에인한&\\n10^&소유권이전등기&\\n10^&청구권&\"}]},{\"resType2\":\"2\",\"resNumber\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"강원특별자치도원주시\\n문막읍포진리662-17\"},{\"resNumber\":\"3\",\"resContents\":\"답\"},{\"resNumber\":\"4\",\"resContents\":\"19㎡\"},{\"resNumber\":\"5\",\"resContents\":\"2023년6월12일\\n행정구역명칭변경으로\\n인하여\\n2023년6월12일등기\"}]}]},{\"resType\":\"갑구\",\"resType1\":\"소유권에관한사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\\n(전1)\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"1974년9월17일\\n제11228호\"},{\"resNumber\":\"3\",\"resContents\":\"1974년9월16일\\n매매\"},{\"resNumber\":\"4\",\"resContents\":\"소유자김세훈\\n4^원주시문막읍포진리640|분할로인하여순위제1번등기를강원도\\n원주시문막읍포진리662-6에서전사\\n접수2007년6월13일\\n6^제32915호\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"2007년6월13일\\n제32916호\"},{\"resNumber\":\"3\",\"resContents\":\"2007년5월29일\\n공공용지의\\n협의취득\"},{\"resNumber\":\"4\",\"resContents\":\"소유자국232\\n2^관리청건설교통부\"}]}]}],\"commCompetentRegistryOffice\":\"춘천지방법원원주지원등기과\",\"resPublishNo\":\"\",\"resIssueNo\":\"\",\"resPublishDate\":\"20241007\",\"resPublishRegistryOffice\":\"\",\"resRegistrationSumList\":[{\"resType\":\"소유지분현황(갑구)\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"등기명의인\"},{\"resNumber\":\"1\",\"resContents\":\"(주민)등록번호\"},{\"resNumber\":\"2\",\"resContents\":\"최종지분\"},{\"resNumber\":\"3\",\"resContents\":\"주소\"},{\"resNumber\":\"4\",\"resContents\":\"순위번호\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"국(소유자)\"},{\"resNumber\":\"1\",\"resContents\":\"232\"},{\"resNumber\":\"2\",\"resContents\":\"단독소유\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"2\"}]}]},{\"resType\":\"개별공시지가\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"신청대상토지|가격기준년도\"},{\"resNumber\":\"1\",\"resContents\":\"신청대상토지|토지소재지\"},{\"resNumber\":\"2\",\"resContents\":\"신청대상토지|지번\"},{\"resNumber\":\"3\",\"resContents\":\"확인내용|개별공시지가\"},{\"resNumber\":\"4\",\"resContents\":\"확인내용|기준일자\"},{\"resNumber\":\"5\",\"resContents\":\"확인내용|공시일자\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2024\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"17700\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20240430\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2023\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"17600\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20230428\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2022\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"18800\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20220429\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2021\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"17800\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20210531\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2020\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"16500\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20200529\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2019\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"15500\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20190531\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2018\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"15100\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20180531\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2017\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"14000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20170531\"}]},{\"resNumber\":\"9\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2016\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"12800\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20160531\"}]},{\"resNumber\":\"10\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2015\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"12200\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20150529\"}]},{\"resNumber\":\"11\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2014\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"10500\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20140530\"}]},{\"resNumber\":\"12\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2013\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"9900\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20130531\"}]},{\"resNumber\":\"13\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2012\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"9570\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20120531\"}]},{\"resNumber\":\"14\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2011\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"8910\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20110531\"}]},{\"resNumber\":\"15\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2010\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"8910\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20100531\"}]},{\"resNumber\":\"16\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2009\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"7920\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20090529\"}]},{\"resNumber\":\"17\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2008\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"7920\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20080531\"}]},{\"resNumber\":\"18\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2007\"},{\"resNumber\":\"1\",\"resContents\":\"강원특별자치도원주시문막읍포진리\"},{\"resNumber\":\"2\",\"resContents\":\"662-17\"},{\"resNumber\":\"3\",\"resContents\":\"6710\"},{\"resNumber\":\"4\",\"resContents\":\"07월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20071031\"}]}]},{\"resType\":\"토지이용계획\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"「국토의계획및이용에관한법률」에따른지역·지구등\"},{\"resNumber\":\"1\",\"resContents\":\"다른볍령등에따른지역·지구등\"},{\"resNumber\":\"2\",\"resContents\":\"「토지이용규제기본법시행령」제9조제4항각호에해당되는사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"농림지역\"},{\"resNumber\":\"1\",\"resContents\":\"가축사육제한구역(전부제한모든축종제한)<가축분뇨의관리및이용에관한법률>,농업진흥구역<농지법>,배출시설설치제한지역<물환경보전법>,소하천구역(2018-06-15)<소하천정비법>\"},{\"resNumber\":\"2\",\"resContents\":\"\"}]}]}],\"resPrecautionsList\":[]}],\"resSearchList\":[],\"resAddrList\":[],\"resImageList\":[],\"resOriGinalData\":\"\",\"resIssueYN\":\"1\",\"commIssueCode\":\"2.44373013E9\",\"resTotalPageCount\":\"\",\"commStartPageNo\":\"\",\"resEndPageNo\":\"\",\"resWarningMessage\":\"\"}}";

            System.out.println("result = " + result);

            processRegisterResult(result, analysisNo);
        } catch (Exception e) {
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

        Double ownerState = 0.0;
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

    private static List<String> getOwnership(ResRegisterEntriesList entry) {
        List<String> ownershipList = new ArrayList<>();
        if ("소유지분현황(갑구)".equals(entry.getResRegistrationSumList()[0].getResType())) {
            ResContentsList[] resContentsList = entry.getResRegistrationSumList()[0].getResContentsList();
            for (int i = 1; i < resContentsList.length; i++) {
                ownershipList.add(resContentsList[i].getResDetailList()[0].getResContents());
            }
        }
        return ownershipList;
    }

    private static String getCommonOwner(ResRegisterEntriesList entry) {
        ResContentsList[] resContentsList = entry.getResRegistrationSumList()[0].getResContentsList();
        if ("소유지분현황(갑구)".equals(entry.getResRegistrationSumList()[0].getResType())) {
            return (resContentsList.length >= 3) ? "공동소유" : "단독소유";
        }
        return "";
    }

    private static String getChangeOwnerCount(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        for (ResRegistrationList registration : resRegistrationHisList) {
            if ("소유권에관한사항".equals(registration.getResType1())) {
                ResContentsList[] resContentsList = registration.getResContentsList();
                String owner = resContentsList[resContentsList.length - 1].getResDetailList()[0].getResContents();
                return owner.split("-")[0];
            }
        }
        return "";
    }

    private static String getMaximumOfBond(ResRegisterEntriesList entry) {
        ResRegistrationList[] resRegistrationHisList = entry.getResRegistrationHisList();
        for (int i = resRegistrationHisList.length - 1; i >= 0; i--) {
            if ("소유권이외의권리에관한사항".equals(resRegistrationHisList[i].getResType1())) {
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
