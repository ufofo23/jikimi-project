package org.scoula.codefapi.bml;

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

// 집합/일반건축물대장 총괄 API
public class BuildingManagementLedger {

    public static void main(String[] args) {
        try {
            String result = usageExample();
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("unchecked")
    public static String usageExample() throws UnsupportedEncodingException, JsonProcessingException, InterruptedException, NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException {
        // 1. 코드에프 객체 생성
        EasyCodef codef = new EasyCodef();

        // 2. 데모 클라이언트 정보 설정
        codef.setClientInfoForDemo(EasyCodefClientInfo.DEMO_CLIENT_ID, EasyCodefClientInfo.DEMO_CLIENT_SECRET);

        // 3. RSA 암호화를 위한 퍼블릭키 설정
        codef.setPublicKey(PUBLIC_KEY);

        // 4. 입력 파라미터 설정
        HashMap<String, Object> parameterMap = new HashMap<>();
        // 고정 입력 파라미터
        parameterMap.put("organization", "0001"); // 기관코드 (고정값 : 0001)
        parameterMap.put("loginType", "3"); // 로그인 구분 ("0" : 회원(공동/금융)인증서, "1" : 아이디 로그인, "3" : 비회원 본인인증, "5" : 회원 간편인증)
        parameterMap.put("userName", ""); // 이름
        parameterMap.put("identity", ""); // 주민등록번호
        parameterMap.put("type", "0"); // "0":지상, "1":지하, "2":공중 - 0으로 값 고정 (반지하는 고려 x)

        // 필수 입력 파라미터
        parameterMap.put("inquiryType", "1"); // [대장구분] 0:일반, 1:집합
        parameterMap.put("address", "서울특별시 용산구 한남대로36길 54"); // 도로명주소 또는 번지주송 <다만 등기부등본 고려해서 도로명주소 권장>
        parameterMap.put("zipCode", "04417"); // 5자리, 도로명 검색하여 여러건 나올 경우 재검색시 사용

        // 기타 파라미터 (설정 불필요)
        parameterMap.put("birthDate", "");
        parameterMap.put("timeout", "");
        parameterMap.put("originDataYN", "0");

        String identityEncYn = "N";
        if (identityEncYn.equals("Y")) {
            parameterMap.put("identityEncYn", "Y");
        } else {
            parameterMap.put("identityEncYn", "N");
        }

        // 5. 코드에프 정보 조회 요청
        String productUrl = "/v1/kr/public/mw/building-register/colligation";
        String result = codef.requestProduct(productUrl, EasyCodefServiceType.SANDBOX, parameterMap); // 테스트 : SANDBOX, 실데이터 : DEMO

        // 6. JSON 파싱 및 결과 확인
        HashMap<String, Object> responseMap = new ObjectMapper().readValue(result, HashMap.class);
        HashMap<String, Object> resultMap = (HashMap<String, Object>) responseMap.get("result");

        // 결과 코드가 "CF-00000"일 경우 정상 처리
        if (resultMap != null) {
            System.out.println("결과 코드: " + resultMap.get("code"));
        } else {
            System.out.println("결과 없음");
        }

        return result; // 결과 반환
    }
}

