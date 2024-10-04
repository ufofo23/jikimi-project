package org.scoula.codefapi.cor.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefClientInfo;
import org.scoula.codefapi.codef.EasyCodefServiceType;
import org.scoula.codefapi.cor.dto.CopyOfRegisterDto;
import org.scoula.codefapi.cor.jsontoclass.*;
import org.scoula.codefapi.cor.mapper.CopyOfRegisterMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.codefapi.codef.EasyCodefUtil.encryptRSA;

@Service
@Transactional
@RequiredArgsConstructor
public class CopyOfRegisterService {

    private final CopyOfRegisterMapper registerMapper;

    public void getCopyOfRegister() throws UnsupportedEncodingException, JsonProcessingException, InterruptedException, NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException {
        EasyCodef codef = new EasyCodef();
        codef.setClientInfoForDemo(EasyCodefClientInfo.DEMO_CLIENT_ID, EasyCodefClientInfo.DEMO_CLIENT_SECRET);
        codef.setPublicKey(PUBLIC_KEY);

        HashMap<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("organization", "0002");
        parameterMap.put("inquiryType", "3"); // 조회구분 (3: 도로명주소로 찾기)
        parameterMap.put("jointMortgageJeonseYN", "1"); // 공동담보/전세목록 포함여부 - 0:미포함 1:포함 (default='0')
        parameterMap.put("tradingYN", "0"); // 매매 목록 포함 여부 - 0:미포함 1:포함 (default='0')
        parameterMap.put("listNumber", null); // default: 목록전체, 다건 선택시 '|' 로구분 ex) '2007123|2017134'
        parameterMap.put("electronicClosedYN", null); // 전산 폐쇄 조회 여부 	inquiryType='2' or '3'[0:미포함 1:포함 (default='0')]
        parameterMap.put("ePrepayNo", ""); // 선불 전자 지급 수단 번호
        parameterMap.put("ePrepayPass", ""); // 선불 전자 지급 수단 비밀번호
        // 비밀번호는 RSA로 암호화된 값으로 넣어야 합니다.
        String password = encryptRSA("1234", PUBLIC_KEY); // 임의의 비밀번호를 RSA로 암호화
        parameterMap.put("password", password); // 암호화된 비밀번호
        // 주의) 특수 파라미터 - 0,1 코드 입력 시 유료임. 데모 외에는 2번으로 고정할 것!
        parameterMap.put("issueType", "0"); // '0':발급 '1':열람 '2':고유번호조회 '3': 원문데이타로 결과처리 (default : '0')
        // 필수 입력 파라미터
        parameterMap.put("realtyType", "0"); // inquiryType ='1' or '2' or '3'[0:토지+건물(inquiryType ="1" 불가) 1: 집합건물 2:토지 3:건물]inquiryType='1'인 경우 미입력시 전체, 아파트1, 나머지0
        parameterMap.put("addr_sido", "서울시"); // 시/도 주소
        parameterMap.put("addr_sigungu", "서초구"); // 시군구 주소
        parameterMap.put("addr_roadName", "신반포로"); // 도로명 주소 (선택 값)
        parameterMap.put("addr_buildingNumber", "270"); // 건물 번호
        parameterMap.put("dong", "105"); // 집합건물의 동 번호
        parameterMap.put("ho", "1901"); // 집합건물의 호 번호
        // 기타 파라미터 (설정 불필요)
        parameterMap.put("phoneNo", "01000000000"); // 전화번호
        parameterMap.put("buildingName", ""); // 건물 명칭
        parameterMap.put("startPageNo", null); // 시작 페이지 번호 (선택 값)
        parameterMap.put("pageCount", null); // 조회 페이지 수 (선택 값)
        parameterMap.put("originData", null); // 원문 데이터 (선택 값)
        parameterMap.put("originDataYN", null); // 원문 데이터 포함 여부 (선택 값)
        parameterMap.put("warningSkipYN", null); // 경고 무시 여부 (선택 값)
        parameterMap.put("registerSummaryYN", "1"); // 등기 사항 요약 출력 여부
        parameterMap.put("applicationType", null); // 신청 구분 (선택 값)
        parameterMap.put("selectAddress", ""); // 주소 리스트 선택 여부
        parameterMap.put("isIdentityViewYn", "0"); // 주민등록번호 공개 여부


        String productUrl = "/v1/kr/public/ck/real-estate-register/status";
        String result = codef.requestProduct(productUrl, EasyCodefServiceType.SANDBOX, parameterMap);

        try {
            O obj = Converter.fromJsonString(result);
            ResRegisterEntriesList firstEntry = obj.getData().getResRegisterEntriesList()[0];

            // 건물 주소
            String address = getAddress(firstEntry);
            System.out.println("address = " + address);

            // 전유 부분
            String ownerState = getOwnerState(firstEntry);
            System.out.println("owner_state = " + ownerState);

            // 소유자 ex."이봉희 (소유자)"
            String ownership = getOwnership(firstEntry);
            System.out.println("ownership = " + ownership);

            // 단독 소유 여부
            String commonOwner = getCommonOwner(firstEntry);
            System.out.println("commonOwner = " + commonOwner);

            // 소유권 변경 횟수 ex."12-2" << 12회 (경매 등 포함 )
            String changeOwnerCount = getChangeOwnerCount(firstEntry);
            System.out.println("changeOwnerCNT = " + changeOwnerCount);

            // 채권 최고액과 근저당권 설정 여부
            String maximumOfBond = getMaximumOfBond(firstEntry);
            System.out.println("maximumOfBond = " + maximumOfBond);

            // 전세금 정보 ex."&전세금금2,200,000,000원&\n&범  위  구분건물의 전부&\n&존속기간  2018년 5월 14일부터 2020년 5월&\n10^&13일까지&\n&전세권자&\n2^&김형진&&  &&720923-*******&\n4^&서울특별시 서초구 신반포로 270, 127동&\n4^&2102호(반포동, 반포자이아파트)&\n2^&유경&&  &&810728-*******&\n4^&서울특별시 서초구 신반포로 270, 127동&\n4^&2102호(반포동, 반포자이아파트)&"
            String deposit = getJunsae(firstEntry);
            System.out.println("deposit = " + deposit);


            registerMapper.insertCopyOfRegister(new CopyOfRegisterDto(address, ownerState, ownership, commonOwner, changeOwnerCount, maximumOfBond, deposit));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String getAddress(ResRegisterEntriesList entry) {
        return entry.getResRealty();
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
        ResContentsList[] resContentsList = resRegistrationHisList[5].getResContentsList();
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
        return "X";
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
