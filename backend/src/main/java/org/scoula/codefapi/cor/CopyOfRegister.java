package org.scoula.codefapi.cor;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.scoula.codefapi.codef.EasyCodef;
import org.scoula.codefapi.codef.EasyCodefClientInfo;
import org.scoula.codefapi.codef.EasyCodefServiceType;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;

import static org.scoula.codefapi.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.codefapi.codef.EasyCodefUtil.encryptRSA;


// 부동산등기부등본 API
public class CopyOfRegister {

    public static void main(String[] args) {
        try {
            usageExample();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("unchecked")
    public static void usageExample() throws UnsupportedEncodingException, JsonProcessingException, InterruptedException, NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException {
        /**
         * #1. 코드에프 객체 생성
         */
        EasyCodef codef = new EasyCodef();

        /**
         * #2. 데모 클라이언트 정보 설정 (데모 아이디, 데모 시크릿 코드 )
         */
        codef.setClientInfoForDemo(EasyCodefClientInfo.DEMO_CLIENT_ID, EasyCodefClientInfo.DEMO_CLIENT_SECRET);

        /**
         * #3. RSA암호화를 위한 퍼블릭키 설정
         */
        codef.setPublicKey(PUBLIC_KEY);

        /**
         * #4. 입력부 파라미터 입력
         */
        HashMap<String, Object> parameterMap = new HashMap<>();

        // 고정 입력 파라미터
        parameterMap.put("organization", "0002"); // 기관코드
        parameterMap.put("inquiryType", "3"); // 조회구분 (3: 도로명주소로 찾기)
        parameterMap.put("jointMortgageJeonseYN", "1"); // 공동담보/전세목록 포함여부 - 0:미포함 1:포함 (default='0')
        parameterMap.put("tradingYN", "0"); // 매매 목록 포함 여부 - 0:미포함 1:포함 (default='0')
        parameterMap.put("listNumber", null); // default: 목록전체, 다건 선택시 '|' 로구분 ex) '2007123|2017134'
        parameterMap.put("electronicClosedYN", null); // 전산 폐쇄 조회 여부 	inquiryType='2' or '3'[0:미포함 1:포함 (default='0')]
        parameterMap.put("ePrepayNo", "J77887546198"); // 선불 전자 지급 수단 번호
        parameterMap.put("ePrepayPass", "aa1234"); // 선불 전자 지급 수단 비밀번호

        // 비밀번호는 RSA로 암호화된 값으로 넣어야 합니다.
        String password = encryptRSA("1234", PUBLIC_KEY); // 임의의 비밀번호를 RSA로 암호화
        parameterMap.put("password", password); // 암호화된 비밀번호


        // 주의) 특수 파라미터 - 0,1 코드 입력 시 유료임. 데모 외에는 2번으로 고정할 것!
        parameterMap.put("issueType", "2"); // '0':발급 '1':열람 '2':고유번호조회 '3': 원문데이타로 결과처리 (default : '0')

        // 필수 입력 파라미터
        parameterMap.put("realtyType", "0"); // inquiryType ='1' or '2' or '3'[0:토지+건물(inquiryType ="1" 불가) 1: 집합건물 2:토지 3:건물]inquiryType='1'인 경우 미입력시 전체, 아파트1, 나머지0
        parameterMap.put("addr_sido", "서울특별시"); // 시/도 주소
        parameterMap.put("addr_sigungu", "관악구"); // 시군구 주소
        parameterMap.put("addr_roadName", "낙성대역10길"); // 도로명 주소 (선택 값)
        parameterMap.put("addr_buildingNumber", "15"); // 건물 번호
        parameterMap.put("dong", ""); // 집합건물의 동 번호
        parameterMap.put("ho",""); // 집합건물의 호 번호

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

        // 미사용 파라미터
        // parameterMap.put("uniqueNo", null); // 선택 값
		// parameterMap.put("address", null); // 선택 값
		// parameterMap.put("recordStatus", "0"); // 등기 기록 상태 (0: 현행)
	    // parameterMap.put("addr_dong", null); // 선택 값 (읍면동로)
		// parameterMap.put("addr_lotNumber", null); // 선택 값 (지번)
		// parameterMap.put("inputSelect", null); // 선택 값


        /**
         * #5.코드에프 정보 조회 요청
         */
        String productUrl = "/v1/kr/public/ck/real-estate-register/status"; // 부동산등기부등본 열람/발급 URL
        String result = codef.requestProduct(productUrl, EasyCodefServiceType.SANDBOX, parameterMap);

        /** #6.코드에프 정보 결과 확인 */
        System.out.println(result);

        HashMap<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
        HashMap<String, Object> resultMap = (HashMap<String, Object>) responseMap.get("result");

        // 결과 코드가 : CF-00000일 경우 정상적으로 출력된 값임.
        if (resultMap != null) {
            System.out.println("결과 코드: " + resultMap.get("code"));
        } else {
            System.out.println("결과 없음");
        }
    }
}
