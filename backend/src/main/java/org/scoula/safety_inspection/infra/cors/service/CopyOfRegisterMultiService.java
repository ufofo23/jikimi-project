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
//            String result = easyCodef.requestProduct(productUrl, EasyCodefServiceType.DEMO, parameterMap);
            String result = "{\"result\":{\"code\":\"CF-00000\",\"extraMessage\":\"\",\"message\":\"성공\",\"transactionId\":\"67035b86ec82eab8491ac16f\"},\"data\":{\"resRegisterEntriesList\":[{\"resDocTitle\":\"등기사항전부증명서(말소사항포함)-집합건물\",\"resRealty\":\"[집합건물]강원특별자치도원주시단구동1478-4유승아파트제101동제1층제101호\",\"commUniqueNo\":\"14122003004603\",\"resRegistrationHisList\":[{\"resType\":\"표제부\",\"resType1\":\"1동의건물의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"소재지번,건물명칭및번호\"},{\"resNumber\":\"3\",\"resContents\":\"건물내역\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&2003년7월1일&\"},{\"resNumber\":\"2\",\"resContents\":\"&강원도원주시단구동&\\n&1478-4&\\n&유승아파트제101동&\"},{\"resNumber\":\"3\",\"resContents\":\"&철근콘크리트구조&\\n&철근콘크리트조지붕&\\n&18층공동주택&\\n&1층840.9206㎡&\\n&2층840.9206㎡&\\n&3층840.9206㎡&\\n&4층840.9206㎡&\\n&5층840.9206㎡&\\n&6층827.4806㎡&\\n&7층827.4806㎡&\\n&8층827.4806㎡&\\n&9층827.4806㎡&\\n&10층827.4806㎡&\\n&11층827.4806㎡&\\n&12층827.4806㎡&\\n&13층827.4806㎡&\\n&14층827.4806㎡&\\n&15층827.4806㎡&\\n&16층827.4806㎡&\\n&17층735.4548㎡&\\n&18층611.991㎡&\"},{\"resNumber\":\"4\",\"resContents\":\"&도면편철장제1책제184호&\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&2&\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"&강원도원주시단구동&\\n&1478-4&\\n&유승아파트제101동&\\n&[도로명주소]&\\n&강원도원주시강변로119&\"},{\"resNumber\":\"3\",\"resContents\":\"&철근콘크리트구조&\\n&철근콘크리트조지붕&\\n&18층공동주택&\\n&1층840.9206㎡&\\n&2층840.9206㎡&\\n&3층840.9206㎡&\\n&4층840.9206㎡&\\n&5층840.9206㎡&\\n&6층827.4806㎡&\\n&7층827.4806㎡&\\n&8층827.4806㎡&\\n&9층827.4806㎡&\\n&10층827.4806㎡&\\n&11층827.4806㎡&\\n&12층827.4806㎡&\\n&13층827.4806㎡&\\n&14층827.4806㎡&\\n&15층827.4806㎡&\\n&16층827.4806㎡&\\n&17층735.4548㎡&\\n&18층611.991㎡&\"},{\"resNumber\":\"4\",\"resContents\":\"&도로명주소&\\n&2012년2월7일등기&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"강원특별자치도원주시\\n단구동1478-4\\n유승아파트제101동\\n[도로명주소]\\n강원특별자치도원주시\\n강변로119\"},{\"resNumber\":\"3\",\"resContents\":\"철근콘크리트구조\\n철근콘크리트조지붕\\n18층공동주택\\n1층840.9206㎡\\n2층840.9206㎡\\n3층840.9206㎡\\n4층840.9206㎡\\n5층840.9206㎡\\n6층827.4806㎡\\n7층827.4806㎡\\n8층827.4806㎡\\n9층827.4806㎡\\n10층827.4806㎡\\n11층827.4806㎡\\n12층827.4806㎡\\n13층827.4806㎡\\n14층827.4806㎡\\n15층827.4806㎡\\n16층827.4806㎡\\n17층735.4548㎡\\n18층611.991㎡\"},{\"resNumber\":\"4\",\"resContents\":\"2023년6월12일\\n행정구역명칭변경으로\\n인하여\\n2023년6월12일등기\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"대지권의목적인토지의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"소재지번\"},{\"resNumber\":\"2\",\"resContents\":\"지목\"},{\"resNumber\":\"3\",\"resContents\":\"면적\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"1.강원도원주시단구동1478-4\"},{\"resNumber\":\"2\",\"resContents\":\"대\"},{\"resNumber\":\"3\",\"resContents\":\"28197.1㎡\"},{\"resNumber\":\"4\",\"resContents\":\"2003년7월1일\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"전유부분의건물의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"접수\"},{\"resNumber\":\"2\",\"resContents\":\"건물번호\"},{\"resNumber\":\"3\",\"resContents\":\"건물내역\"},{\"resNumber\":\"4\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"2003년7월1일\"},{\"resNumber\":\"2\",\"resContents\":\"제1층제101호\"},{\"resNumber\":\"3\",\"resContents\":\"철근콘크리트구조\\n84.4687㎡\"},{\"resNumber\":\"4\",\"resContents\":\"도면편철장제1책제184호\"}]}]},{\"resType\":\"표제부\",\"resType1\":\"대지권의표시\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"표시번호\"},{\"resNumber\":\"1\",\"resContents\":\"대지권종류\"},{\"resNumber\":\"2\",\"resContents\":\"대지권비율\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"1소유권대지권\"},{\"resNumber\":\"2\",\"resContents\":\"2^28197.1분의\\n2^44.1521\"},{\"resNumber\":\"3\",\"resContents\":\"2003년6월30일대지권\\n2003년7월1일\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&2&\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"&별도등기있음&\\n&1토지(을구1번근저당권설정등기)&\\n&2003년7월1일&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"\"},{\"resNumber\":\"2\",\"resContents\":\"\"},{\"resNumber\":\"3\",\"resContents\":\"2번별도등기말소\\n2010년7월4일\"}]}]},{\"resType\":\"갑구\",\"resType1\":\"소유권에관한사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"1\"},{\"resNumber\":\"1\",\"resContents\":\"소유권보존\"},{\"resNumber\":\"2\",\"resContents\":\"2003년7월1일\\n제34184호\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"소유자주식회사유승종합건설120111-0018730\\n4^인천계양구계산동1081-6\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|&신탁&\"},{\"resNumber\":\"2\",\"resContents\":\"2006년12월7일\\n제74663호\"},{\"resNumber\":\"3\",\"resContents\":\"2006년12월5일\\n신탁\"},{\"resNumber\":\"4\",\"resContents\":\"수탁자대한주택보증주식회사110111-1708473\\n4^서울영등포구여의도동15-23|&신탁원부제1402호&\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&2-1&\"},{\"resNumber\":\"1\",\"resContents\":\"&금지사항등기&\"},{\"resNumber\":\"2\",\"resContents\":\"&2006년12월12일&\\n&제75766호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2002년6월25일&\\n&주택건설사업계&\\n&획승인&\"},{\"resNumber\":\"4\",\"resContents\":\"&이주택은국민주택기금을위한제한물권설정을&\\n&제외하고는임차인의동의없이는제한물권을&\\n&설정하거나압류,가압류,가처분등소유권에&\\n&제한을가하는일체의행위를할수없음&\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"2-1번금지사항등기\\n말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36696호\"},{\"resNumber\":\"3\",\"resContents\":\"\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|2번신탁등기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36696호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년7월20일\\n신탁재산의귀속|신탁재산의\\n귀속\"},{\"resNumber\":\"4\",\"resContents\":\"소유자주식회사유승홀딩스120111-0018730\\n4^인천광역시계양구계산동1081-6\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"5\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36700호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년6월1일\\n회사분할\"},{\"resNumber\":\"4\",\"resContents\":\"소유자주식회사유승종합건설120111-0497778\\n4^인천광역시계양구계산동1081-6\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"6\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|&신탁&\"},{\"resNumber\":\"2\",\"resContents\":\"2009년7월31일\\n제36704호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년6월1일\\n신탁\"},{\"resNumber\":\"4\",\"resContents\":\"수탁자대한주택보증주식회사110111-1708473\\n4^서울특별시영등포구여의도동15-23|&신탁원부제2608호&\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"7\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전|6번신탁등기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40436호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월17일\\n신탁재산의귀속|신탁재산의\\n귀속\"},{\"resNumber\":\"4\",\"resContents\":\"소유자주식회사유승종합건설120111-0497778\\n4^인천광역시계양구계산동1081-6\"}]},{\"resNumber\":\"9\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"8\"},{\"resNumber\":\"1\",\"resContents\":\"소유권이전\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40451호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월7일\\n매매\"},{\"resNumber\":\"4\",\"resContents\":\"소유자강상구601115-\\n4^강원도원주시단구동1478-4유승아파트\\n4^101-101\\n거래가액금93,521,079원\"}]},{\"resNumber\":\"10\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&9&\"},{\"resNumber\":\"1\",\"resContents\":\"&소유권일부이전&\"},{\"resNumber\":\"2\",\"resContents\":\"&2015년4월7일&\\n&제20944호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2015년4월6일&\\n&증여&\"},{\"resNumber\":\"4\",\"resContents\":\"&공유자&\\n2^&지분10분의5&\\n2^&김순란&&&&600609-&\\n4^&강원도원주시천매봉길20(단구동)&\\n2^&지분10분의2&\\n2^&강모제&&&&940130-&\\n4^&강원도원주시강변로119,101동&\\n4^&101호(단구동,유승아파트)&\"}]},{\"resNumber\":\"11\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"10\"},{\"resNumber\":\"1\",\"resContents\":\"9번소유권이전등기\\n말소\"},{\"resNumber\":\"2\",\"resContents\":\"2015년7월17일\\n제45030호\"},{\"resNumber\":\"3\",\"resContents\":\"2015년7월16일\\n합의해제\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]}]},{\"resType\":\"을구\",\"resType1\":\"소유권이외의권리에관한사항\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수\"},{\"resNumber\":\"3\",\"resContents\":\"등기원인\"},{\"resNumber\":\"4\",\"resContents\":\"권리자및기타사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"&1&\"},{\"resNumber\":\"1\",\"resContents\":\"&근저당권설정&\"},{\"resNumber\":\"2\",\"resContents\":\"&2003년7월1일&\\n&제34188호&\"},{\"resNumber\":\"3\",\"resContents\":\"&2003년6월30일&\\n&추가설정계약&\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액금36,866,700,000원&\\n&채무자&&주식회사유승종합건설&\\n4^&인천계양구계산동1081-6&\\n&근저당권자&&주식회사국민은행&&&&110111-2365321&\\n4^&서울중구남대문로2가9-1&\\n4^&(부평기업금융지점)&\\n&공동담보목록제2003-263호&\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"2\"},{\"resNumber\":\"1\",\"resContents\":\"1번근저당권설정등\\n기말소\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40444호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월25일\\n일부포기\"},{\"resNumber\":\"4\",\"resContents\":\"\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40452호\"},{\"resNumber\":\"3\",\"resContents\":\"2009년8월25일\\n설정계약\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액금77,090,000원&\\n채무자강상구\\n4^강원도원주시단구동1478-4유승아파트\\n4^101-101\\n근저당권자주식회사우리은행110111-0023393\\n4^서울특별시중구회현동1가203\\n4^&(원주지점)&\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-1\"},{\"resNumber\":\"1\",\"resContents\":\"3번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월28일\\n제72875호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월28일\\n취급지점변경\"},{\"resNumber\":\"4\",\"resContents\":\"주식회사우리은행의취급지점본점\"}]},{\"resNumber\":\"5\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-2\"},{\"resNumber\":\"1\",\"resContents\":\"3번근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월28일\\n제72876호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월28일\\n변경계약\"},{\"resNumber\":\"4\",\"resContents\":\"채권최고액금41,800,000원\"}]},{\"resNumber\":\"6\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2015년7월28일\\n제47792호\"},{\"resNumber\":\"3\",\"resContents\":\"2015년7월28일\\n설정계약\"},{\"resNumber\":\"4\",\"resContents\":\"&채권최고액금53,900,000원&\\n채무자강상구\\n4^강원도원주시강변로119,101동\\n4^101호(단구동,유승아파트)\\n근저당권자주식회사우리은행110111-0023393\\n4^서울특별시중구소공로51(회현동1가)\\n4^&(원주지점)&\"}]},{\"resNumber\":\"7\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4-1\"},{\"resNumber\":\"1\",\"resContents\":\"4번등기명의인표시\\n변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월14일\\n제69760호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월14일\\n취급지점변경\"},{\"resNumber\":\"4\",\"resContents\":\"주식회사우리은행의취급지점본점\"}]},{\"resNumber\":\"8\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4-2\"},{\"resNumber\":\"1\",\"resContents\":\"4번근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월14일\\n제69761호\"},{\"resNumber\":\"3\",\"resContents\":\"2019년11월14일\\n변경계약\"},{\"resNumber\":\"4\",\"resContents\":\"채권최고액금42,900,000원\"}]}]}],\"commCompetentRegistryOffice\":\"춘천지방법원원주지원등기과\",\"resPublishNo\":\"\",\"resIssueNo\":\"\",\"resPublishDate\":\"20241007\",\"resPublishRegistryOffice\":\"\",\"resRegistrationSumList\":[{\"resType\":\"소유지분현황(갑구)\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"등기명의인\"},{\"resNumber\":\"1\",\"resContents\":\"(주민)등록번호\"},{\"resNumber\":\"2\",\"resContents\":\"최종지분\"},{\"resNumber\":\"3\",\"resContents\":\"주소\"},{\"resNumber\":\"4\",\"resContents\":\"순위번호\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"강상구(소유자)\"},{\"resNumber\":\"1\",\"resContents\":\"601115-\"},{\"resNumber\":\"2\",\"resContents\":\"단독소유\"},{\"resNumber\":\"3\",\"resContents\":\"강원도원주시단구동1478-4유승아파트101-101\"},{\"resNumber\":\"4\",\"resContents\":\"8\"}]}]},{\"resType\":\"(근)저당권및전세권등(을구)\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"순위번호\"},{\"resNumber\":\"1\",\"resContents\":\"등기목적\"},{\"resNumber\":\"2\",\"resContents\":\"접수정보\"},{\"resNumber\":\"3\",\"resContents\":\"주요등기사항\"},{\"resNumber\":\"4\",\"resContents\":\"대상소유자\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2009년8월25일\\n제40452호\"},{\"resNumber\":\"3\",\"resContents\":\"&채권최고액금77,090,000원&\\n근저당권자주식회사우리은행\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]},{\"resNumber\":\"2\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"3-2\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월28일\\n제72876호\"},{\"resNumber\":\"3\",\"resContents\":\"채권최고액금41,800,000원\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]},{\"resNumber\":\"3\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권설정\"},{\"resNumber\":\"2\",\"resContents\":\"2015년7월28일\\n제47792호\"},{\"resNumber\":\"3\",\"resContents\":\"&채권최고액금53,900,000원&\\n근저당권자주식회사우리은행\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]},{\"resNumber\":\"4\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"4-2\"},{\"resNumber\":\"1\",\"resContents\":\"근저당권변경\"},{\"resNumber\":\"2\",\"resContents\":\"2019년11월14일\\n제69761호\"},{\"resNumber\":\"3\",\"resContents\":\"채권최고액금42,900,000원\"},{\"resNumber\":\"4\",\"resContents\":\"강상구\"}]}]},{\"resType\":\"토지이용계획\",\"resType1\":\"\",\"resContentsList\":[{\"resNumber\":\"0\",\"resType2\":\"1\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"「국토의계획및이용에관한법률」에따른지역·지구등\"},{\"resNumber\":\"1\",\"resContents\":\"다른볍령등에따른지역·지구등\"},{\"resNumber\":\"2\",\"resContents\":\"「토지이용규제기본법시행령」제9조제4항각호에해당되는사항\"}]},{\"resNumber\":\"1\",\"resType2\":\"2\",\"resDetailList\":[{\"resNumber\":\"0\",\"resContents\":\"제3종일반주거지역,지구단위계획구역,소로1류(폭10m~12m)(접합),소로2류(폭8m~10m)(접합),소로3류(폭8m미만)(접합),중로1류(폭20m~25m)(접합),중로3류(폭12m~15m)(접합)\"},{\"resNumber\":\"1\",\"resContents\":\"가축사육제한구역(전부제한모든축종제한)<가축분뇨의관리및이용에관한법률>,상대보호구역<교육환경보호에관한법률>\"},{\"resNumber\":\"2\",\"resContents\":\"\"}]}]}],\"resPrecautionsList\":[]}],\"resSearchList\":[],\"resAddrList\":[],\"resImageList\":[],\"resOriGinalData\":\"\",\"resIssueYN\":\"1\",\"commIssueCode\":\"2.443746375E9\",\"resTotalPageCount\":\"\",\"commStartPageNo\":\"\",\"resEndPageNo\":\"\",\"resWarningMessage\":\"\"}}";
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
            if ("전유부분의건물의표시".equals(registration.getResType1())) {
                return extractOwnerState(registration);
            }
        }
        return null;
    }

    private static String extractOwnerState(ResRegistrationList registration) {
        return registration.getResContentsList()[1].getResDetailList()[3].getResContents()
                .split("㎡")[0].replaceAll(".*?\\s+", "");
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
        return null;
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
        return null;
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
        return null;
    }

    private static String extractMaximumBond(String maximum) {
        Pattern pattern = Pattern.compile("최고액\\s*금([0-9,]+)원");
        Matcher matcher = pattern.matcher(maximum);
        if (matcher.find()) {
            return matcher.group(1).replace(",", "");
        }
        return null;
    }

}
