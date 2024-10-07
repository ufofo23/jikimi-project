package org.scoula.safety_inspection.infra.cors.service;

import lombok.RequiredArgsConstructor;
import org.scoula.safety_inspection.infra.cors.dto.CopyOfRegisterDto;
import org.scoula.safety_inspection.codef.EasyCodef;
import org.scoula.safety_inspection.codef.EasyCodefServiceType;
import org.scoula.safety_inspection.infra.cors.mapper.CopyOfRegisterMapper;
import org.scoula.safety_inspection.infra.cors.jsontoclass.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.scoula.safety_inspection.codef.EasyCodefClientInfo.PUBLIC_KEY;
import static org.scoula.safety_inspection.codef.EasyCodefUtil.encryptRSA;

@Service
@Transactional
@RequiredArgsConstructor
public class CopyOfRegisterService {

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

    public void getCopyOfRegister(Map<String, Object> payload, Integer analysisNo) throws Exception {

        String password = encryptRSA(userPass, PUBLIC_KEY);
        HashMap<String, Object> parameterMap = createParameterMap(payload, password);

        String productUrl = "/v1/kr/public/ck/real-estate-register/status";
//        String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
        String result= "{\"result\":{\"code\":\"CF-00000\",\"extraMessage\":\"\",\"message\":\"성공\",\"transactionId\":\"67035b86ec82eab8491ac16f\"},\"data\":{\"resRegisterEntriesList\":[{\"resDocTitle\":\"등기사항전부증명서(말소사항 포함) - 집합건물\",\"resRealty\":\"[집합건물] 강원특별자치도 원주시 단구동 1478-4 유승아파트 제101동 제1층 제101호\",\"commUniqueNo\":\"14122003004603\",\"resRegistrationHisList\":[{\"resType\":\"표제부\",\"resType1\":\"1동의 건물의 표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"소재지번,건물명칭 및 번호\"},{\"resNumber\":\"3\",\"resContents\":\"건물내역\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인 및 기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&2003년7월1일&\"},{\"resNumber\":\"2\",\"resContents\":\"&강원도 원주시 단구동&\\n&1478-4&\\n&유승아파트 제101동&\"},{\"resNumber\":\"3\",\"resContents\":\"&철근콘크리트구조&\\n&철근콘크리트조 지붕&\\n&18층 공동주택&\\n&1층  840.9206㎡&\\n&2층  840.9206㎡&\\n&3층  840.9206㎡&\\n&4층  840.9206㎡&\\n&5층  840.9206㎡&\\n&6층  827.4806㎡&\\n&7층  827.4806㎡&\\n&8층  827.4806㎡&\\n&9층  827.4806㎡&\\n&10층 827.4806㎡&\\n&11층 827.4806㎡&\\n&12층 827.4806㎡&\\n&13층 827.4806㎡&\\n&14층 827.4806㎡&\\n&15층 827.4806㎡&\\n&16층 827.4806㎡&\\n&17층 735.4548㎡&\\n&18층 611.991㎡&\"},{\"resNumber\":\"4\",\"resContents\":\"&도면편철장제1책 제184호&\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&2&\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"&강원도 원주시 단구동&\\n&1478-4&\\n&유승아파트 제101동&\\n&[도로명주소]&\\n&강원도 원주시 강변로 119&\"},{\"resNumber\":\"3\",\"resContents\":\"&철근콘크리트구조&\\n&철근콘크리트조 지붕&\\n&18층 공동주택&\\n&1층  840.9206㎡&\\n&2층  840.9206㎡&\\n&3층  840.9206㎡&\\n&4층  840.9206㎡&\\n&5층  840.9206㎡&\\n&6층  827.4806㎡&\\n&7층  827.4806㎡&\\n&8층  827.4806㎡&\\n&9층  827.4806㎡&\\n&10층 827.4806㎡&\\n&11층 827.4806㎡&\\n&12층 827.4806㎡&\\n&13층 827.4806㎡&\\n&14층 827.4806㎡&\\n&15층 827.4806㎡&\\n&16층 827.4806㎡&\\n&17층 735.4548㎡&\\n&18층 611.991㎡&\"},{\"resNumber\":\"4\",\"resContents\":\"&도로명주소&\\n&2012년2월7일  등기&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"강원특별자치도 원주시\\n단구동 1478-4\\n유승아파트 제101동\\n[도로명주소]\\n강원특별자치도 원주시\\n강변로 119\"},{\"resNumber\":\"3\",\"resContents\":\"철근콘크리트구조\\n철근콘크리트조 지붕\\n18층 공동주택\\n1층  840.9206㎡\\n2층  840.9206㎡\\n3층  840.9206㎡\\n4층  840.9206㎡\\n5층  840.9206㎡\\n6층  827.4806㎡\\n7층  827.4806㎡\\n8층  827.4806㎡\\n9층  827.4806㎡\\n10층 827.4806㎡\\n11층 827.4806㎡\\n12층 827.4806㎡\\n13층 827.4806㎡\\n14층 827.4806㎡\\n15층 827.4806㎡\\n16층 827.4806㎡\\n17층 735.4548㎡\\n18층 611.991㎡\"},{\"resNumber\":\"4\",\"resContents\":\"2023년6월12일\\n행정구역명칭변경으로\\n인하여\\n2023년6월12일  등기\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"대지권의 목적인 토지의 표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"소재지번\"},{\"resNumber\":\"2\",\"resContents\":\"지목\"},{\"resNumber\":\"3\",\"resContents\":\"면적\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인 및 기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"1. 강원도 원주시 단구동 1478-4\"},{\"resNumber\":\"2\",\"resContents\":\"대\"},{\"resNumber\":\"3\",\"resContents\":\"28197.1㎡\"},{\"resNumber\":\"4\",\"resContents\":\"2003년7월1일\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"전유부분의 건물의 표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"건물번호\"},{\"resNumber\":\"3\",\"resContents\":\"건물내역\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인 및 기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"2003년7월1일\"},{\"resNumber\":\"2\",\"resContents\":\"제1층 제101호\"},{\"resNumber\":\"3\",\"resContents\":\"철근콘크리트구조\\n     84.4687㎡\"},{\"resNumber\":\"4\",\"resContents\":\"도면편철장제1책 제184호\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"대지권의 표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"대지권종류\"},{\"resNumber\":\"2\",\"resContents\":\"대지권비율\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인 및 기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"1 소유권대지권\"},{\"resNumber\":\"2\",\"resContents\":\"2^28197.1분의\\n2^44.1521\"},{\"resNumber\":\"3\",\"resContents\":\"2003년6월30일 대지권\\n2003년7월1일\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&2&\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"&별도등기 있음&\\n&1토지(을구1번 근저당권설정등기)&\\n&2003년7월1일&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"2번 별도등기 말소\\n2010년7월4일\"}]}]},{\"resType\":\"갑구\",\"resType1\":\"소유권에 관한 사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자 및 기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"소유권보존\"},{\"resNumber\":\"2\",\"resContents\":\"2003년7월1일\\n제34184호\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"소유자  주식회사유승종합건설  120111-0018730\\n4^인천 계양구 계산동 1081-6\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|&신탁&\"},{\"resNumber\":\"2\",\"resContents\":\"2006년12월7일\\n제74663호\"},{\"resNumber\":\"3\",\"resContents\":\"2006년12월5일\\n신탁\"},{\"resNumber\":\"4\",\"resContents\":\"수탁자  대한주택보증주식회사  110111-1708473\\n4^서울 영등포구 여의도동 15-23|&신탁원부  제1402호&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&2-1&\"},{\"resNumber\":\"1\",\"resContents\":\"&금지사항등기&\"},{\"resNumber\":\"2\",\"resContents\":\"&2006년12월12일&\\n&제75766호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2002년6월25일&\\n&주택건설사업계&\\n&획승인&\"},{\"resNumber\":\"4\",\"resContents\":\"&이 주택은 국민주택기금을 위한 제한물권설정을&\\n&제외하고는임차인의 동의 없이는 제한물권을&\\n&설정하거나 압류, 가압류, 가처분 등 소유권에&\\n&제한을 가하는 일체의 행위를 할 수 없음&\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"2-1번금지사항등기\\n말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36696호\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|2번 신탁등기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36696호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년7월20일\\n신탁재산의귀속|신탁재산의\\n귀속\"},{\"resNumber\":\"4\",\"resContents\":\"소유자  주식회사유승홀딩스  120111-0018730\\n4^인천광역시 계양구 계산동 1081-6\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"5\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36700호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년6월1일\\n회사분할\"},{\"resNumber\":\"4\",\"resContents\":\"소유자  주식회사유승종합건설  120111-0497778\\n4^인천광역시 계양구 계산동 1081-6\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"6\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|&신탁&\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36704호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년6월1일\\n신탁\"},{\"resNumber\":\"4\",\"resContents\":\"수탁자  대한주택보증주식회사  110111-1708473\\n4^서울특별시 영등포구 여의도동 15-23|&신탁원부  제2608호&\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"7\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|6번 신탁등기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40436호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월17일\\n신탁재산의귀속|신탁재산의\\n귀속\"},{\"resNumber\":\"4\",\"resContents\":\"소유자  주식회사유승종합건설  120111-0497778\\n4^인천광역시 계양구 계산동 1081-6\"}]},{\"resNumber\":\"9\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"8\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40451호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월7일\\n매매\"},{\"resNumber\":\"4\",\"resContents\":\"소유자  강상구  601115-\\n4^강원도 원주시 단구동 1478-4 유승아파트\\n4^101-101\\n거래가액 금93,521,079원\"}]},{\"resNumber\":\"10\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&9&\"},{\"resNumber\":\"1\",\"resContents\":\"&소유권일부이전&\"},{\"resNumber\":\"2\",\"resContents\":\"&2015년4월7일&\\n&제20944호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2015년4월6일&\\n&증여&\"},{\"resNumber\":\"4\",\"resContents\":\"&공유자  &\\n2^&지분 10분의 5&\\n2^&김순란&&  &&600609-&\\n4^&강원도 원주시 천매봉길 20(단구동)&\\n2^&지분 10분의 2&\\n2^&강모제&&  &&940130-&\\n4^&강원도 원주시 강변로 119,101동&\\n4^&101호(단구동,유승아파트)&\"}]},{\"resNumber\":\"11\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"10\"},{\"resNumber\":\"1\",\"resContents\":\"9번소유권이전등기\\n말소\"},{\"resNumber\":\"2\",\"resContents\":\"2015년7월17일\\n제45030호\"},{\"resNumber\":\"3\",\"resContents\":\"2015년7월16일\\n합의해제\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]}]},{\"resType\":\"을구\",\"resType1\":\"소유권 이외의 권리에 관한 사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자 및 기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&근저당권설정&\"},{\"resNumber\":\"2\",\"resContents\":\"&2003년7월1일&\\n&제34188호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2003년6월30일&\\n&추가설정계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액  금36,866,700,000원&\\n&채무자  &&주식회사유승종합건설&\\n4^&인천 계양구 계산동 1081-6&\\n&근저당권자  &&주식회사국민은행&&  &&110111-2365321&\\n4^&서울 중구 남대문로2가 9-1&\\n4^&( 부평기업금융지점 )&\\n&공동담보목록  제2003-263호&\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"1번근저당권설정등\\n기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40444호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월25일\\n일부포기\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40452호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월25일\\n설정계약\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액  금77,090,000원&\\n채무자  강상구\\n4^강원도 원주시 단구동 1478-4 유승아파트\\n4^101-101\\n근저당권자  주식회사우리은행  110111-0023393\\n4^서울특별시 중구 회현동1가 203\\n4^&( 원주지점 )&\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-1\"},{\"resNumber\":\"1\",\"resContents\":\"3번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월28일\\n제72875호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월28일\\n취급지점변경\"},{\"resNumber\":\"4\",\"resContents\":\"주식회사우리은행의 취급지점  본점\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-2\"},{\"resNumber\":\"1\",\"resContents\":\"3번근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월28일\\n제72876호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월28일\\n변경계약\"},{\"resNumber\":\"4\",\"resContents\":\"채권최고액  금41,800,000원\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2015년7월28일\\n제47792호\"},{\"resNumber\":\"3\",\"resContents\":\"2015년7월28일\\n설정계약\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액  금53,900,000원&\\n채무자  강상구\\n4^강원도 원주시 강변로 119,101동\\n4^101호(단구동,유승아파트)\\n근저당권자  주식회사우리은행  110111-0023393\\n4^서울특별시 중구 소공로 51 (회현동1가)\\n4^&( 원주지점 )&\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4-1\"},{\"resNumber\":\"1\",\"resContents\":\"4번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월14일\\n제69760호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월14일\\n취급지점변경\"},{\"resNumber\":\"4\",\"resContents\":\"주식회사우리은행의 취급지점  본점\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4-2\"},{\"resNumber\":\"1\",\"resContents\":\"4번근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월14일\\n제69761호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월14일\\n변경계약\"},{\"resNumber\":\"4\",\"resContents\":\"채권최고액  금42,900,000원\"}]}]}],\"commCompetentRegistryOffice\":\"춘천지방법원 원주지원 등기과\",\"resPublishNo\":\"\",\"resIssueNo\":\"\",\"resPublishDate\":\"20241007\",\"resPublishRegistryOffice\":\"\",\"resRegistrationSumList\":[{\"resType\":\"소유지분현황 (갑구)\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"등기명의인\"},{\"resNumber\":\"1\",\"resContents\":\"(주민)등록번호\"},{\"resNumber\":\"2\",\"resContents\":\"최종지분\"},{\"resNumber\":\"3\",\"resContents\":\"주소\"},{\"resNumber\":\"4\",\"resContents\":\"순위번호\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"강상구 (소유자)\"},{\"resNumber\":\"1\",\"resContents\":\"601115-\"},{\"resNumber\":\"2\",\"resContents\":\"단독소유\"},{\"resNumber\":\"3\",\"resContents\":\"강원도 원주시 단구동 1478-4 유승아파트 101-101\"},{\"resNumber\":\"4\",\"resContents\":\"8\"}]}]},{\"resType\":\"(근)저당권 및 전세권 등 (을구)\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수정보\"},{\"resNumber\":\"3\",\"resContents\":\"주요등기사항\"},{\"resNumber\":\"4\",\"resContents\":\"대상소유자\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40452호\"},{\"resNumber\":\"3\",\"resContents\":\"&채권최고액  금77,090,000원&\\n근저당권자  주식회사우리은행\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-2\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월28일\\n제72876호\"},{\"resNumber\":\"3\",\"resContents\":\"채권최고액  금41,800,000원\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2015년7월28일\\n제47792호\"},{\"resNumber\":\"3\",\"resContents\":\"&채권최고액  금53,900,000원&\\n근저당권자  주식회사우리은행\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4-2\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월14일\\n제69761호\"},{\"resNumber\":\"3\",\"resContents\":\"채권최고액  금42,900,000원\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]}]},{\"resType\":\"토지이용계획\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"「국토의 계획 및 이용에 관한 법률」 에 따른 지역·지구 등\"},{\"resNumber\":\"1\",\"resContents\":\"다른 볍령 등에 따른 지역·지구 등\"},{\"resNumber\":\"2\",\"resContents\":\"「토지이용규제 기본법 시행령」 제9조제4항 각 호에 해당되는 사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"제3종일반주거지역, 지구단위계획구역, 소로1류(폭 10m~12m)(접합), 소로2류(폭 8m~10m)(접합), 소로3류(폭 8m 미만)(접합), 중로1류(폭 20m~25m)(접합), 중로3류(폭 12m~15m)(접합)\"},{\"resNumber\":\"1\",\"resContents\":\"가축사육제한구역(전부제한 모든축종제한)<가축분뇨의 관리 및 이용에 관한 법률>, 상대보호구역<교육환경 보호에 관한 법률>\"},{\"resNumber\":\"2\",\"resContents\":\"\"}]}]}],\"resPrecautionsList\":[]}],\"resSearchList\":[],\"resAddrList\":[],\"resImageList\":[],\"resOriGinalData\":\"\",\"resIssueYN\":\"1\",\"commIssueCode\":\"2.443746375E9\",\"resTotalPageCount\":\"\",\"commStartPageNo\":\"\",\"resEndPageNo\":\"\",\"resWarningMessage\":\"\"}}";
        System.out.println("result = " + result);

        processRegisterResult(result, analysisNo);
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

//    private static String getAddress(ResRegisterEntriesList entry) {
//        return entry.getResRealty();
//    }

    private void processRegisterResult(String result, Integer analysisNo) throws IOException {
        O obj = Converter.fromJsonString(result);
        ResRegisterEntriesList firstEntry = obj.getData().getResRegisterEntriesList()[0];

        String ownerState = getOwnerState(firstEntry);
        String ownership = getOwnership(firstEntry);
        String commonOwner = getCommonOwner(firstEntry);
        String changeOwnerCount = getChangeOwnerCount(firstEntry);
        String maximumOfBond = getMaximumOfBond(firstEntry);
        String deposit = getJunsae(firstEntry);

        CopyOfRegisterDto registerDto = new CopyOfRegisterDto(
                analysisNo, ownerState, ownership,
                commonOwner, changeOwnerCount, maximumOfBond, deposit
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
