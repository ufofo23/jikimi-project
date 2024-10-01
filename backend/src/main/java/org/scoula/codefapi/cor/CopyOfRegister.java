package org.scoula.codefapi.cor;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.scoula.codefapi.codef.*;
import org.scoula.codefapi.cor.jsontoclass.*;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.IOException;
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
        parameterMap.put("ho", ""); // 집합건물의 호 번호
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
//        String result = "{\"result\":{\"code\":\"CF-00000\",\"extraMessage\":\"\",\"message\":\"성공\",\"transactionId\":\"66f3b220ec8222ffe62a69a4\"},\"data\":{\"resRegisterEntriesList\":[{\"resDocTitle\":\"등기사항전부증명서(말소사항포함)-집합건물\",\"resRealty\":\"[집합건물]서울특별시서초구반포동20-43반포자이제117동제15층제1501호\",\"commUniqueNo\":\"11022009002162\",\"resRegistrationHisList\":[{\"resType\":\"표제부\",\"resType1\":\"1동의건물의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"소재지번,건물명칭및번호\"},{\"resNumber\":\"3\",\"resContents\":\"건물내역\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&2009년4월17일&\"},{\"resNumber\":\"2\",\"resContents\":\"&서울특별시서초구반포동&\\n&20-43&\\n&반포자이제117동&\"},{\"resNumber\":\"3\",\"resContents\":\"&철근콘크리트구조&\\n&(철근)콘크리트지붕28층&\\n&공동주택(아파트)&\\n&1층357.536㎡&\\n&2층296.375㎡&\\n&3층524.826㎡&\\n&4층524.826㎡&\\n&5층524.826㎡&\\n&6층524.826㎡&\\n&7층524.826㎡&\\n&8층524.826㎡&\\n&9층524.826㎡&\\n&10층524.826㎡&\\n&11층524.826㎡&\\n&12층524.826㎡&\\n&13층524.826㎡&\\n&14층524.826㎡&\\n&15층524.826㎡&\\n&16층524.826㎡&\\n&17층524.826㎡&\\n&18층524.826㎡&\\n&19층524.826㎡&\\n&20층524.826㎡&\\n&21층524.826㎡&\\n&22층524.826㎡&\\n&23층524.826㎡&\\n&24층524.826㎡&\\n&25층524.826㎡&\\n&26층524.826㎡&\\n&27층524.826㎡&\\n&28층524.826㎡&\"},{\"resNumber\":\"4\",\"resContents\":\"&도면편철장제1책제188장&\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"서울특별시서초구반포동\\n20-43\\n반포자이제117동\\n[도로명주소]\\n서울특별시서초구신반포로\\n270\"},{\"resNumber\":\"3\",\"resContents\":\"철근콘크리트구조\\n(철근)콘크리트지붕28층\\n공동주택(아파트)\\n1층357.536㎡\\n2층296.375㎡\\n3층524.826㎡\\n4층524.826㎡\\n5층524.826㎡\\n6층524.826㎡\\n7층524.826㎡\\n8층524.826㎡\\n9층524.826㎡\\n10층524.826㎡\\n11층524.826㎡\\n12층524.826㎡\\n13층524.826㎡\\n14층524.826㎡\\n15층524.826㎡\\n16층524.826㎡\\n17층524.826㎡\\n18층524.826㎡\\n19층524.826㎡\\n20층524.826㎡\\n21층524.826㎡\\n22층524.826㎡\\n23층524.826㎡\\n24층524.826㎡\\n25층524.826㎡\\n26층524.826㎡\\n27층524.826㎡\\n28층524.826㎡\"},{\"resNumber\":\"4\",\"resContents\":\"도로명주소\\n2016년5월4일등기\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"대지권의목적인토지의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"소재지번\"},{\"resNumber\":\"2\",\"resContents\":\"지목\"},{\"resNumber\":\"3\",\"resContents\":\"면적\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"1.서울특별시서초구반포동\\n3^20-43\"},{\"resNumber\":\"2\",\"resContents\":\"대\"},{\"resNumber\":\"3\",\"resContents\":\"194458.3㎡\"},{\"resNumber\":\"4\",\"resContents\":\"2009년4월17일\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"전유부분의건물의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"건물번호\"},{\"resNumber\":\"3\",\"resContents\":\"건물내역\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"2009년4월17일\"},{\"resNumber\":\"2\",\"resContents\":\"제15층제1501호\"},{\"resNumber\":\"3\",\"resContents\":\"철근콘크리트구조\\n216.49㎡\"},{\"resNumber\":\"4\",\"resContents\":\"도면편철장제1책제188장\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"대지권의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"대지권종류\"},{\"resNumber\":\"2\",\"resContents\":\"대지권비율\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"1소유권대지권\"},{\"resNumber\":\"2\",\"resContents\":\"2^194458.3분의\\n2^98.7366\"},{\"resNumber\":\"3\",\"resContents\":\"2009년3월14일대지권\\n2009년4월17일\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"별도등기있음\\n1토지(을구7번내지15번\\n구분지상권설정등기)\\n2009년4월17일\"}]}]},{\"resType\":\"갑구\",\"resType1\":\"소유권에관한사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"소유권보존\"},{\"resNumber\":\"2\",\"resContents\":\"2009년4월17일\\n제22582호\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"소유자김대윤480622-*******\\n4^서울특별시서초구반포동60-4\\n4^반포미도아파트306-102\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"2014년11월26일\\n제275055호\"},{\"resNumber\":\"3\",\"resContents\":\"2014년5월23일\\n협의분할에\\n의한상속\"},{\"resNumber\":\"4\",\"resContents\":\"공유자\\n2^지분100분의58\\n2^김진훈760926-*******\\n4^&서울특별시서초구서초중앙로29길&\\n4^&28,306동102호(반포동,반포미도아파트)&\\n2^지분100분의42\\n2^김성훈781113-*******\\n4^&서울특별시서초구서초중앙로29길&\\n4^&28,306동102호(반포동,반포미도아파트)&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2-1\"},{\"resNumber\":\"1\",\"resContents\":\"2번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2015년6월30일\\n제181365호\"},{\"resNumber\":\"3\",\"resContents\":\"2015년2월12일\\n전거\"},{\"resNumber\":\"4\",\"resContents\":\"김진훈의주소서울특별시서초구\\n6^서초중앙로29길28,306동\\n6^103호(반포동,반포미도아파트)\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2-2\"},{\"resNumber\":\"1\",\"resContents\":\"2번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2015년6월30일\\n제181366호\"},{\"resNumber\":\"3\",\"resContents\":\"2015년1월22일\\n전거\"},{\"resNumber\":\"4\",\"resContents\":\"김성훈의주소서울특별시서초구\\n6^서초중앙로29길28,308동\\n6^303호(반포동,반포미도아파트)\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"공유자전원지분전부\\n이전\"},{\"resNumber\":\"2\",\"resContents\":\"2016년12월5일\\n제256181호\"},{\"resNumber\":\"3\",\"resContents\":\"2016년10월23일\\n매매\"},{\"resNumber\":\"4\",\"resContents\":\"소유자이봉희750605-*******\\n4^&서울특별시서초구신반포로270,102동&\\n4^&1403호(반포동,반포자이아파트)&\\n거래가액금2,370,000,000원\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-1\"},{\"resNumber\":\"1\",\"resContents\":\"3번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2018년5월14일\\n제90762호\"},{\"resNumber\":\"3\",\"resContents\":\"2017년8월22일\\n전거\"},{\"resNumber\":\"4\",\"resContents\":\"이봉희의주소서울특별시강남구도곡로93길\\n6^12,201동1402호(대치동,래미안대치\\n6^하이스턴아파트)\"}]}]},{\"resType\":\"을구\",\"resType1\":\"소유권이외의권리에관한사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&근저당권설정&\"},{\"resNumber\":\"2\",\"resContents\":\"&2009년4월17일&\\n&제22619호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2005년8월29일&\\n&설정계약및&\\n&2009년3월14일&\\n&정비사업에&\\n&인한분양&\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액금588,000,000원&\\n&채무자&&김대윤&\\n4^&서울특별시서초구반포동60-4&\\n4^&반포미도아파트306-102&\\n&근저당권자&&주식회사우리은행&&&&110111-0023393&\\n4^&서울특별시중구회현동1가203&\\n4^&(신반포지점)&\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"1번근저당권설정등\\n기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년6월25일\\n제41026호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년6월25일\\n해지\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&3&\"},{\"resNumber\":\"1\",\"resContents\":\"&전세권설정&\"},{\"resNumber\":\"2\",\"resContents\":\"&2015년6월30일&\\n&제181367호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2015년6월3일&\\n&설정계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&전세금금1,700,000,000원&\\n&범위주거용건물의전부&\\n&존속기간2018년6월29일까지&\\n&전세권자&&최정윤&&&&700803-*******&\\n4^&서울특별시서초구신반포로270,111동&\\n4^&501호(반포동,반포자이아파트)&\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&3-1&\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"&3번등기는건물만에관한것임&\\n&2015년6월30일부기&\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"3번전세권설정등기\\n말소\"},{\"resNumber\":\"2\",\"resContents\":\"2018년5월14일\\n제90663호\"},{\"resNumber\":\"3\",\"resContents\":\"2018년5월14일\\n해지\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&5&\"},{\"resNumber\":\"1\",\"resContents\":\"&전세권설정&\"},{\"resNumber\":\"2\",\"resContents\":\"&2018년5월14일&\\n&제90763호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2018년4월1일&\\n&설정계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&전세금금2,200,000,000원&\\n&범위구분건물의전부&\\n&존속기간2018년5월14일부터2020년5월&\\n10^&13일까지&\\n&전세권자&\\n2^&김형진&&&&720923-*******&\\n4^&서울특별시서초구신반포로270,127동&\\n4^&2102호(반포동,반포자이아파트)&\\n2^&유경&&&&810728-*******&\\n4^&서울특별시서초구신반포로270,127동&\\n4^&2102호(반포동,반포자이아파트)&\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&5-1&\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"&5번등기는건물만에관한것임&\\n&2018년5월14일부기&\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&5-2&\"},{\"resNumber\":\"1\",\"resContents\":\"&5번전세권근저당권&\\n&설정&\"},{\"resNumber\":\"2\",\"resContents\":\"&2018년5월14일&\\n&제90764호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2018년5월14일&\\n&설정계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액금840,000,000원&\\n&채무자&&김형진&\\n4^&서울특별시서초구신반포로270,127동&\\n4^&2102호(반포동,반포자이아파트)&\\n&근저당권자&&주식회사전북은행&&&&210111-0000043&\\n4^&전라북도전주시덕진구백제대로&\\n4^&566(금암동)&\\n4^&(반포지점)&\"}]},{\"resNumber\":\"9\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&5-3&\"},{\"resNumber\":\"1\",\"resContents\":\"&5번전세권변경&\"},{\"resNumber\":\"2\",\"resContents\":\"&2020년6월3일&\\n&제95671호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2020년4월8일&\\n&변경계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&존속기간2020년5월14일부터&\\n10^&2022년5월13일까지&\"}]},{\"resNumber\":\"10\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&6&\"},{\"resNumber\":\"1\",\"resContents\":\"&5번전세권변경&\"},{\"resNumber\":\"2\",\"resContents\":\"&2022년5월13일&\\n&제71330호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2022년3월23일&\\n&변경계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&존속기간2022년5월14일부터&\\n10^&2024년5월13일까지&\"}]},{\"resNumber\":\"11\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"7\"},{\"resNumber\":\"1\",\"resContents\":\"5-2번근저당권설정\\n등기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2023년4월14일\\n제50113호\"},{\"resNumber\":\"3\",\"resContents\":\"2023년4월14일\\n해지\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"12\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"8\"},{\"resNumber\":\"1\",\"resContents\":\"5번전세권설정등기\\n말소\"},{\"resNumber\":\"2\",\"resContents\":\"2023년4월14일\\n제50275호\"},{\"resNumber\":\"3\",\"resContents\":\"2023년4월14일\\n해지\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]}]}],\"commCompetentRegistryOffice\":\"서울중앙지방법원등기국\",\"resPublishNo\":\"\",\"resIssueNo\":\"\",\"resPublishDate\":\"20240925\",\"resPublishRegistryOffice\":\"\",\"resRegistrationSumList\":[{\"resType\":\"소유지분현황(갑구)\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"등기명의인\"},{\"resNumber\":\"1\",\"resContents\":\"(주민)등록번호\"},{\"resNumber\":\"2\",\"resContents\":\"최종지분\"},{\"resNumber\":\"3\",\"resContents\":\"주소\"},{\"resNumber\":\"4\",\"resContents\":\"순위번호\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"이봉희(소유자)\"},{\"resNumber\":\"1\",\"resContents\":\"750605-*******\"},{\"resNumber\":\"2\",\"resContents\":\"단독소유\"},{\"resNumber\":\"3\",\"resContents\":\"서울특별시강남구도곡로93길12,201동\\n1402호(대치동,래미안대치하이스턴아파트)\"},{\"resNumber\":\"4\",\"resContents\":\"3\"}]}]},{\"resType\":\"개별공시지가\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"신청대상토지|가격기준년도\"},{\"resNumber\":\"1\",\"resContents\":\"신청대상토지|토지소재지\"},{\"resNumber\":\"2\",\"resContents\":\"신청대상토지|지번\"},{\"resNumber\":\"3\",\"resContents\":\"확인내용|개별공시지가\"},{\"resNumber\":\"4\",\"resContents\":\"확인내용|기준일자\"},{\"resNumber\":\"5\",\"resContents\":\"확인내용|공시일자\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2024\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"26280000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20240430\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2023\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"26080000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20230428\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2022\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"27450000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20220429\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2021\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"24500000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20210531\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2020\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"21300000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20200529\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2019\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"14600000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20190531\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2018\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"11130000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20180531\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2017\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"9918000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20170531\"}]},{\"resNumber\":\"9\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2016\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"9485000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20160531\"}]},{\"resNumber\":\"10\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2015\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"9072000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20150529\"}]},{\"resNumber\":\"11\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2014\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"8341000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20140530\"}]},{\"resNumber\":\"12\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2013\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"8090000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20130531\"}]},{\"resNumber\":\"13\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2012\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"8080000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20120531\"}]},{\"resNumber\":\"14\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2011\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"7840000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20110531\"}]},{\"resNumber\":\"15\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2010\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"7910000\"},{\"resNumber\":\"4\",\"resContents\":\"01월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20100531\"}]},{\"resNumber\":\"16\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2009\"},{\"resNumber\":\"1\",\"resContents\":\"서울특별시서초구반포동\"},{\"resNumber\":\"2\",\"resContents\":\"20-43\"},{\"resNumber\":\"3\",\"resContents\":\"7580000\"},{\"resNumber\":\"4\",\"resContents\":\"07월01일\"},{\"resNumber\":\"5\",\"resContents\":\"20091030\"}]}]},{\"resType\":\"토지이용계획\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"「국토의계획및이용에관한법률」에따른지역·지구등\"},{\"resNumber\":\"1\",\"resContents\":\"다른볍령등에따른지역·지구등\"},{\"resNumber\":\"2\",\"resContents\":\"「토지이용규제기본법시행령」제9조제4항각호에해당되는사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"도시지역,제3종일반주거지역,광장(저촉),도로(2014-08-14)(접합),도로(저촉),도시철도(저촉)\"},{\"resNumber\":\"1\",\"resContents\":\"상대보호구역<교육환경보호에관한법률>,상대보호구역(2014-05-19)<교육환경보호에관한법률>,상대보호구역(토지전산망의내용은참고사항일뿐교육청에반드시확인요망)<교육환경보호에관한법률>,절대보호구역<교육환경보호에관한법률>,절대보호구역(2014-05-19)<교육환경보호에관한법률>,대공방어협조구역(위탁고도:77-257m)<군사기지및군사시설보호법>,과밀억제권역<수도권정비계획법>,(한강)폐기물매립시설설치제한지역<한강수계상수원수질개선및주민지원등에관한법률>\"},{\"resNumber\":\"2\",\"resContents\":\"건축선(도로경계선에서3m후퇴)\"}]}]}],\"resPrecautionsList\":[]}],\"resSearchList\":[],\"resAddrList\":[],\"resImageList\":[],\"resOriGinalData\":\"\",\"resIssueYN\":\"1\",\"commIssueCode\":\"2.441459468E9\",\"resTotalPageCount\":\"\",\"commStartPageNo\":\"\",\"resEndPageNo\":\"\",\"resWarningMessage\":\"\"}}";

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

    private static String getCommonOwner(ResRegisterEntriesList entry){
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
            String[] parts = maximum.split("최고액금");
            return parts[1].split("원")[0].trim().replace(",", "");
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
            String[] partJunsae = junsae.split("전세금금");
            return partJunsae[1].split("원")[0].trim().replace(",", "");
        }

        return "전세 기록 없음";
    }
}
