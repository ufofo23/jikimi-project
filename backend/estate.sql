# DataBase 생성
DROP DATABASE IF EXISTS estate;
CREATE DATABASE estate;

# DataBase 사용
use estate;

# 테이블 생성
DROP TABLE IF EXISTS member_tbl;
CREATE TABLE member_tbl (
    member_no int PRIMARY KEY AUTO_INCREMENT,
    member_id varchar(50) NOT NULL,
    member_email varchar(50) NOT NULL,
    member_name varchar(50) NOT NULL,
    member_sex tinyint ,
    member_birthday date ,
    member_phone varchar(50) ,
    member_role varchar(50) ,
    UNIQUE KEY id_email (member_id, member_email)
);



DROP TABLE IF EXISTS property_tbl;
CREATE TABLE property_tbl (
    property_no int PRIMARY KEY AUTO_INCREMENT,
    property_addr_city varchar(50) NOT NULL,
    property_addr_gu varchar(50) NOT NULL,
    property_addr_dong varchar(50) NOT NULL,
    property_addr_ji int NOT NULL,
    property_addr_bun int NOT NULL,
    property_addr_apt_name varchar(50),
    property_addr_apt_dong int,
    property_addr_apt_ho int,
    building_type varchar(50) NOT NULL,
    property_code varchar(50) NOT NULL,
    contract_type int NOT NULL,
    deposit int,
    rent int,
    price int
);

DROP TABLE IF EXISTS like_property_tbl;
CREATE TABLE like_property_tbl (
    like_property_no int PRIMARY KEY AUTO_INCREMENT,
    member_no int NOT NULL,
    property_no int NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member_tbl(member_no) ON DELETE CASCADE,
    FOREIGN KEY (property_no) REFERENCES property_tbl(property_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS analysis_tbl;
CREATE TABLE analysis_tbl (
    analysis_no int PRIMARY KEY AUTO_INCREMENT,
    property_no int NOT NULL,
    FOREIGN KEY (property_no) REFERENCES property_tbl(property_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS cor_tbl;
CREATE TABLE cor_tbl (
    cor_no int PRIMARY KEY AUTO_INCREMENT,
    analysis_no int NOT NULL,
    cor_addr_city varchar(50) NOT NULL,
    cor_addr_gu varchar(50) NOT NULL,
    cor_addr_dong varchar(50) NOT NULL,
    cor_addr_ji int NOT NULL,
    cor_addr_bun int NOT NULL,
    cor_addr_apt_name varchar(50),
    cor_addr_apt_dong int,
    cor_addr_apt_ho int,
    use_of_building varchar(50) NOT NULL,
    part_of_ownership varchar(50) NOT NULL,
    kind_of_landrights varchar(50) NOT NULL,
    ownership varchar(50) NOT NULL,
    change_ownership_cnt int NOT NULL,
    mortgage tinyint NOT NULL,
    maximum_of_bond int NOT NULL,
    FOREIGN KEY (analysis_no) REFERENCES analysis_tbl(analysis_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS bml_tbl;
CREATE TABLE bml_tbl (
    bml_no int PRIMARY KEY AUTO_INCREMENT,
    analysis_no int NOT NULL,
    bml_property_code varchar(50) NOT NULL,
    bml_addr_city varchar(50) NOT NULL,
    bml_addr_gu varchar(50) NOT NULL,
    bml_addr_dong varchar(50) NOT NULL,
    bml_addr_ji int NOT NULL,
    bml_addr_bun int NOT NULL,
    bml_addr_apt_name varchar(50),
    bml_addr_apt_dong int,
    bml_addr_apt_ho int,
    bml_use_type varchar(50) NOT NULL,
    bml_area int NOT NULL,
    bml_floor int NOT NULL,
    bml_structure varchar(50) NOT NULL,
    bml_owner varchar(50) NOT NULL,
    bml_owner_identity_no int NOT NULL,
    bml_owner_addr varchar(50) NOT NULL,
    bml_ownership_stake int NOT NULL,
    bml_violation_structure tinyint NOT NULL,
    FOREIGN KEY (analysis_no) REFERENCES analysis_tbl(analysis_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS report_tbl;
CREATE TABLE report_tbl (
    report_no int PRIMARY KEY AUTO_INCREMENT,
    analysis_no int NOT NULL,
    mortgage tinyint NOT NULL,
    violation_structure tinyint NOT NULL,
    deposit int,
    rent int,
    price int,
    contract_start_date date NOT NULL,
    change_ownership_cnt int NOT NULL,
    accord_owner tinyint NOT NULL,
    main_use varchar(50) NOT NULL,
    FOREIGN KEY (analysis_no) REFERENCES analysis_tbl(analysis_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS member_report_tbl;
CREATE TABLE member_report_tbl (
    member_report_no int PRIMARY KEY AUTO_INCREMENT,
    member_no int NOT NULL,
    report_no int NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member_tbl(member_no) ON DELETE CASCADE,
    FOREIGN KEY (report_no) REFERENCES report_tbl(report_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS common_sense_tbl;
CREATE TABLE common_sense_tbl (
    common_sense_no int PRIMARY KEY AUTO_INCREMENT,
    common_sense_title varchar(50) NOT NULL,
    common_sense_content mediumtext NOT NULL,
    piece_sense mediumtext NOT NULL
);

DROP TABLE IF EXISTS like_common_sense_tbl;
CREATE TABLE like_common_sense_tbl (
    like_common_sense_no int PRIMARY KEY AUTO_INCREMENT,
    member_no int NOT NULL,
    common_sense_no int NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member_tbl(member_no) ON DELETE CASCADE,
    FOREIGN KEY (common_sense_no) REFERENCES common_sense_tbl(common_sense_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS scenario_tbl;
CREATE TABLE scenario_tbl (
    scenario_no int PRIMARY KEY AUTO_INCREMENT,
    scenario_title varchar(50) NOT NULL,
    scenario_content mediumtext NOT NULL,
    scenario_preventive mediumtext NOT NULL
);

DROP TABLE IF EXISTS like_scenario_tbl;
CREATE TABLE like_scenario_tbl (
    like_scenario_no int PRIMARY KEY AUTO_INCREMENT,
    member_no int NOT NULL,
    scenario_no int NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member_tbl(member_no) ON DELETE CASCADE,
    FOREIGN KEY (scenario_no) REFERENCES scenario_tbl(scenario_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS dictionary_tbl;
CREATE TABLE dictionary_tbl (
  dictionary_no int PRIMARY KEY AUTO_INCREMENT,
  dictionary_title varchar(50) NOT NULL,
  dictionary_content mediumtext NOT NULL
);

DROP TABLE IF EXISTS like_dictionary_tbl;
CREATE TABLE like_dictionary_tbl (
    like_dictionary_no int PRIMARY KEY AUTO_INCREMENT,
    member_no int NOT NULL,
    dictionary_no int NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member_tbl(member_no) ON DELETE CASCADE,
    FOREIGN KEY (dictionary_no) REFERENCES dictionary_tbl(dictionary_no) ON DELETE CASCADE
);

DROP TABLE IF EXISTS faq_tbl;
CREATE TABLE faq_tbl (
    faq_no int PRIMARY KEY AUTO_INCREMENT,
    faq_question mediumtext NOT NULL,
    faq_answer mediumtext NOT NULL
);

show tables;

# 샘플 데이터
# 회원 샘플
INSERT INTO member_tbl (member_id, member_email, member_name, member_sex, member_birthday, member_phone, member_role)
VALUES
    (
        'N11111', 'one@naver.com', '김일번', 0, '2000-01-01', '010-1111-1111', 'MEMBER'
    ),
    (
        'G22222', 'two@gmail.com', '정이번', 1, '1999-02-02', '010-2222-2222', 'MEMBER'
    ),
    (
        'N33333', 'three@naver.com', '이삼번', 1, '1998-03-03', '010-3333-3333', 'MEMBER'
    );


# 부동산 매물
INSERT INTO property_tbl (property_addr_city, property_addr_gu, property_addr_dong, property_addr_ji, property_addr_bun, property_addr_apt_name, property_addr_apt_dong, property_addr_apt_ho, building_type, property_code, contract_type, deposit, rent, price)
VALUES
    (
        '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 203, '아파트', '11022009007223', 0, null, null, 700000
    ),
    (
        '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 204, '아파트', '11022009007223', 1, 320000, null, null
    ),
    (
        '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 205, '아파트', '11022009007223', 2, 240000, 120, null
    );

#부동산 매물 찜 목록
INSERT INTO like_property_tbl (member_no, property_no)
VALUES
    (
        1, 1
    ),
    (
        2, 2
    ),
    (
        3, 3
    );

# 분석
INSERT INTO analysis_tbl (property_no)
VALUES
    (
        1
    ),
    (
        2
    ),
    (
        3
    );

# 등기부등본
INSERT INTO cor_tbl (analysis_no, cor_addr_city, cor_addr_gu, cor_addr_dong, cor_addr_ji, cor_addr_bun, cor_addr_apt_name, cor_addr_apt_dong, cor_addr_apt_ho, use_of_building, part_of_ownership, kind_of_landrights, ownership, change_ownership_cnt, mortgage, maximum_of_bond)
VALUES
    (
        1, '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 203, '공동주택(아파트)', '135.92', '소유권대지권', '소유자  김재연  741115-*******', 1, 0, 0
    ),
    (
        2, '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 204, '공동주택(아파트)', '135.92', '소유권대지권', '소유자  박영순  460228-*******', 0, 1, 54000
    ),
    (
        3, '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 205, '공동주택(아파트)', '135.92', '소유권대지권', '소유자 홍길동 640101-*******', 0, 1, 60000
    );

# 건축물 관리 대장
INSERT INTO bml_tbl (analysis_no, bml_property_code, bml_addr_city, bml_addr_gu, bml_addr_dong, bml_addr_ji, bml_addr_bun, bml_addr_apt_name, bml_addr_apt_dong, bml_addr_apt_ho, bml_use_type, bml_area, bml_floor, bml_structure, bml_owner, bml_owner_identity_no, bml_owner_addr, bml_ownership_stake, bml_violation_structure)
VALUES
    (
        1, '11022009007223', '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 203, '공동주택(아파트)', '135.92', 2, '철근콘크리트구조', '김재연', 741115, '서울특별시 서초구 반포동 래미안퍼스티지 112동 303호', 100, 0
    ),
    (
        2, '11022009007223', '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 204, '공동주택(아파트)', '135.92', 2, '철근콘크리트구조', '박영순', 460228, '서울특별시 서초구 반포동 래미안퍼스티지 112동 304호', 100, 0
    ),
    (
        3, '11022009007223', '서울특별시', '서초구', '반포동', 18, 1, '래미안퍼스티지', 112, 205, '공동주택(아파트)', '135.92', 2, '철근콘크리트구조', '홍길동', 640101, '서울특별시 서초구 반포동 래미안퍼스티지 112동 305호', 100, 0
    );

# 레포트
INSERT INTO report_tbl (analysis_no, mortgage, violation_structure, deposit, rent, price, contract_start_date, change_ownership_cnt, accord_owner, main_use)
VALUES
    (
        1, 0, 0, null, null, 700000, '2024-09-19', 1, 1, '공동주택(아파트)'
    ),
    (
        2, 1, 0, 320000, null, null, '2024-09-19', 0, 1, '공동주택(아파트)'
    ),
    (
        3, 1, 0, 240000, 120, null, '2024-09-19', 0, 1, '공동주택(아파트)'
    );

# 회원 레포트 목록
INSERT INTO member_report_tbl (member_no, report_no)
VALUES
    (
        1, 1
    ),
    (
        2, 2
    ),
    (
        3, 3
    );

# 부동산 상식
INSERT INTO common_sense_tbl (common_sense_title, common_sense_content, piece_sense)
VALUES
    (
        '전세 재계약 시 계약서', '전세보증금이 오르지 않았다면 새로이 계약을 체결하지 않아도 상관 없다. 그러나 전세금을 올려주고 재계약을 할 때는 계약서를 다시 써야한다. 기존 계약서의 전세보증금을 올린 내용을 부기하는 방법도 있지만 기왕이면 새로 계약서를 작성하는 것이 좋다. 이때는 등기부등본을 떼어 계약기간 동안 권리변동은 없는지 근저당과 가압류 등이 추가 설정되지 않았는지 꼭 확인해야한다. 또 전세보증금을 올려주었다면 금액에 대해서는 확정일자도 새로 받아야한다. 다만 이 경우 재계약 전 집주인이 근저당을 설정했다면 올려준 보증금의 변제순위는 뒤로 밀리게 된다.', '재계약하는데 계약서 꼭 다시 써야하나?'
    ),
    (
        '확정일자와 전입신고', '임차인으로 부동산을 거래한다면, 확정일자를 받고 전입신고를 해야 보증금을 보호받을 수 있다. 확정일자는 임차인의 구너리를 보호해주는 중요한 절차로, 만약 건물이 경매로 넘어가더라도 보증금을 우선 변제받을 수 있다.', '확정일자, 전입신고 뭐가 먼저일까?'
    ),
    (
        '중개수수료', '부동산 거래 시 공인중개사에게 지불하는 중개수수료(중개보수)는 법적으로 정해져 있으며, 거래 금액에 따라 상한선이 다르다. 사전에 중개 수수료를 계산하고, 과다하게 청구되지 않도록 확인하자.', '중개수수료 얼마나 줘야할까?'
    );

# 부동산 상식 찜 목록
INSERT INTO like_common_sense_tbl (member_no, common_sense_no)
VALUES
    (
        1, 1
    ),
    (
        2, 2
    ),
    (
        3, 3
    );

# 부동산 사기 시나리오
INSERT INTO scenario_tbl (scenario_title, scenario_content, scenario_preventive)
VALUES
    (
        '유령 부동산 사기',
        '존재하지 않는 부동산을 매물로 내놓고, 계약금이나 중도금을 받은 후 사라지는 경우입니다. 사기꾼은 허위 부동산 광고나 가짜 계약서를 통해 피해자에게 접근합니다.',
        '등기부등본을 확인하여 해당 부동산이 실제 존재하는지, 소유자가 맞는지 확인하는 것이 중요합니다.'
    ),
    (
        '이중 계약 사기',
        '같은 부동산을 여러 사람과 동시에 계약하거나, 기존 계약자를 속여 계약을 파기하고 새로운 계약자를 찾아 더 높은 가격으로 판매하는 경우입니다. 특히 시세가 급등하는 지역에서 자주 발생합니다.',
        '계약서 작성 후 신속하게 등기 절차를 진행해 소유권을 확보하고, 중도금과 잔금 지급 시 각 단계에서 계약 진행 상황을 확인해야합니다.'
    ),
    (
        '전세 사기',
        '집주인이 아닌 제3자가 집주인인 척하면서 전세 계약을 체결하거나, 실제 집주인이 대출로 인한 과다 근저당 설정을 숨기고 전세 계약을 체결하는 경우입니다. 전세금 반환 능력이 없는 상태에서 전세 계약이 이루어져 피해자가 전세금을 돌려받지 못하게 됩니다.',
        '계약 전 등기부등본에서 근저당 설정 여부와 대출 상태를 반드시 확인하고, 임차인으로서 보증금을 보호받기 위한 전세보증보험 가입을 고려해야합니다.'
    );

# 부동산 사기 시나리오 찜 목록
INSERT INTO like_scenario_tbl (member_no, scenario_no)
VALUES
    (
        1, 1
    ),
    (
        2, 2
    ),
    (
        3, 3
    );

# 부동산 용어 사전
INSERT INTO dictionary_tbl (dictionary_title, dictionary_content)
VALUES
    (
        '근저당권',
        '근저당권은 대출을 받을 때 담보로 제공된 부동산에 대해 설정되는 권리입니다. 채권자가 채무자가 대출금을 갚지 못할 경우 해당 부동산을 경매로 넘겨 채권을 회수할 수 있는 권리를 가집니다. 근저당은 원금뿐 아니라 이자를 포함한 추가 비용까지도 담보로 설정할 수 있기 때문에, 매매나 임대 계약 시 반드시 확인해야합니다. 부동산에 근저당이 설정되어 있다면, 대출 상환이 완료되기 전까지 해당 부동산은 완전한 소유권을 주장하기 어렵습니다.'
    ),
    (
        '지분경매',
        '지분경매는 부동산의 소유권이 여러 사람에게 나뉘어 있을 때, 한 사람의 지분에 대해 경매를 진행하는 방식입니다. 전체 부동산을 대상으로 하는 경매가 아니라, 공유자의 지분만 경매로 넘기는 것입니다. 지분을 매수한 사람은 해당 부동산의 일부 소유권을 가지지만, 다른 소유자와 협의 없이 단독으로 처분하거나 사용할 수 없는 경우가 많습니다. 따라서 지분경매는 소유권 분쟁이 있거나 불안정한 권리 관계를 동반할 수 있습니다.'
    ),
    (
        '환매조건부 매매',
        '환매조건부 매매는 부동산을 매도한 후 일정 기간 내에 다시 매수할 수 있는 권리가 부여된 매매 계약입니다. 즉, 매도인이 일정 기간 내에 매도 대금을 돌려주고 부동산을 다시 사들일 수 있는 조건이 포함된 거래입니다. 환매권이 행사되지 않으면 매수인이 부동산의 완전한 소유권을 유지하게 됩니다. 주로 부동산 매도자가 일시적으로 자금이 필요할 때 활용되는 방식입니다.'
    );

# 부동산 용어 사전 찜 목록
INSERT INTO like_dictionary_tbl (member_no, dictionary_no)
VALUES
    (
        1, 1
    ),
    (
        2, 2
    ),
    (
        3, 3
    );

# FAQ
INSERT INTO faq_tbl (faq_question, faq_answer)
VALUES
    (
        '지키미 서비스는 유료인가요?',
        '내 집 분석 기능을 제외한 실거래가 조회, 부동산 스터디 등의 기능은 무료로 제공됩니다.'
    ),
    (
        '한 번 분석한 집은 지속 조회가 가능한가요?',
        '한 번 분석을 마친 집에 대해서는 지속 조회가 가능하나, 최신화된 정보를 갖기 위해선 재분석을 하는 것이 좋습니다.'
    );

select * from faq_tbl;

# 실거래가 샘플 데이터입니다.

DROP TABLE IF EXISTS address_price;
CREATE TABLE address_price(
          no		INTEGER AUTO_INCREMENT PRIMARY KEY,
          sigungu	VARCHAR(200) NOT NULL,
          bunji		VARCHAR(50),
          bonbun	INTEGER,
          bubun	 	INTEGER,
          apart_name	VARCHAR(50),
          spacial	float,
          con_month	INTEGER,
          con_date 	INTEGER,
          price		VARCHAR(50),
          dong		VARCHAR(50),
          floor		VARCHAR(50),
          buyer		VARCHAR(50),
          seller		VARCHAR(50),
          build_year	VARCHAR(50),
          doro_juso	VARCHAR(50),
          type_trade	VARCHAR(50),
          type_build	VARCHAR(50),
          x_coordinate VARCHAR(50),
          y_coordinate VARCHAR(50)
);

INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26084, '전북특별자치도 전주시 덕진구 금암동', '628-1', 628, 1, '(동남)우정맨션', 132.28, 202408, 14, '12,000', '-', '5', '개인', '개인', '1989', '삼송3길 21', '중개거래', '아파트', '127.135568555121', '35.8432371108302');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18632, '전북특별자치도 전주시 덕진구 금암동', '628-1', 628, 1, '(동남)우정맨션', 132.28, 202408, 19, '12,000', '1', '5', '개인', '개인', '1989', '삼송3길 21', '중개거래', '아파트', '127.135568555121', '35.8432371108302');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18107, '경상남도 김해시 지내동', '67', 67, 0, '1차동원', 84.93, 202408, 20, '16,700', '103', '14', '개인', '개인', '2000', '분성로727번길 16', '중개거래', '아파트', '128.923946231359', '35.231412203614');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18108, '경상남도 김해시 지내동', '67', 67, 0, '1차동원', 84.93, 202408, 20, '16,600', '101', '3', '개인', '개인', '2000', '분성로727번길 16', '중개거래', '아파트', '128.923946231359', '35.231412203614');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19817, '경상남도 김해시 지내동', '67', 67, 0, '1차동원', 84.93, 202408, 18, '16,400', '-', '12', '개인', '개인', '2000', '분성로727번길 16', '중개거래', '아파트', '128.923946231359', '35.231412203614');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16208, '경상남도 김해시 지내동', '67', 67, 0, '1차동원', 84.99, 202408, 21, '16,500', '-', '1', '개인', '개인', '2000', '분성로727번길 16', '중개거래', '아파트', '128.923946231359', '35.231412203614');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12312, '충청북도 청주시 흥덕구 가경동', '1550', 1550, 0, '2단지주공', 49.8, 202408, 24, '16,000', '-', '15', '개인', '개인', '2002', '가경로 26', '중개거래', '아파트', '127.443712584957', '36.6182180026967');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21804, '충청북도 청주시 흥덕구 가경동', '1550', 1550, 0, '2단지주공', 59.92, 202408, 17, '18,900', '-', '14', '개인', '개인', '2002', '가경로 26', '중개거래', '아파트', '127.443712584957', '36.6182180026967');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3788, '전북특별자치도 전주시 덕진구 송천동2가', '536', 536, 0, '2차쌍용', 84.97, 202409, 2, '17,200', '-', '9', '개인', '개인', '1998', '와룡로 50', '중개거래', '아파트', '127.112336427254', '35.8639273074227');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10440, '전북특별자치도 전주시 덕진구 송천동2가', '536', 536, 0, '2차쌍용', 76.81, 202408, 26, '17,300', '202', '8', '개인', '법인', '1998', '와룡로 50', '직거래', '아파트', '127.112336427254', '35.8639273074227');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15601, '서울특별시 송파구 송파동', '151', 151, 0, '2차한양아파트', 84.92, 202408, 22, '153,500', '-', '2', '개인', '개인', '1984', '가락로 192', '중개거래', '아파트', '127.115946879188', '37.5047253336291');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16626, '서울특별시 송파구 송파동', '151', 151, 0, '2차한양아파트', 108.68, 202408, 21, '161,000', '-', '1', '개인', '개인', '1984', '가락로 192', '중개거래', '아파트', '127.115946879188', '37.5047253336291');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22870, '서울특별시 서대문구 남가좌동', '396', 396, 0, 'DMC금호리첸시아', 84.99, 202408, 16, '126,500', '-', '10', '개인', '개인', '2022', '수색로2길 39', '중개거래', '아파트', '126.915904667901', '37.5713138623931');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22869, '서울특별시 서대문구 남가좌동', '396', 396, 0, 'DMC금호리첸시아', 59.98, 202408, 16, '106,500', '-', '12', '개인', '개인', '2022', '수색로2길 39', '중개거래', '아파트', '126.915904667901', '37.5713138623931');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6402, '서울특별시 서대문구 남가좌동', '396', 396, 0, 'DMC금호리첸시아', 59.83, 202408, 30, '108,300', '-', '11', '개인', '개인', '2022', '수색로2길 39', '중개거래', '아파트', '126.915904667901', '37.5713138623931');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7109, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202408, 29, '59,500', '-', '4', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7112, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202408, 29, '59,500', '-', '4', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (946, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202409, 7, '57,500', '-', '3', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1719, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202409, 5, '57,500', '-', '9', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8049, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202408, 28, '55,000', '-', '9', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13774, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202408, 23, '58,300', '-', '10', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11586, '경기도 고양시 덕양구 향동동', '405', 405, 0, 'DMC두산위브더퍼스트', 59.94, 202408, 24, '57,500', '-', '21', '개인', '개인', '2020', '향기5로 66', '중개거래', '아파트', '126.897207944888', '37.6103615654136');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9319, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 120.95, 202408, 27, '151,500', '-', '5', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12956, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 84.95, 202408, 24, '120,000', '-', '2', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13616, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 59.97, 202408, 23, '98,000', '-', '8', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2202, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 59.97, 202409, 4, '105,000', '-', '11', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22871, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 84.95, 202408, 16, '114,500', '-', '4', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24324, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 84.92, 202408, 15, '114,000', '-', '4', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24325, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 84.94, 202408, 15, '124,000', '-', '10', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24877, '서울특별시 서대문구 북가좌동', '481', 481, 0, 'DMC래미안e편한세상', 84.95, 202408, 15, '108,500', '-', '1', '개인', '개인', '2012', '수색로 100', '중개거래', '아파트', '126.907916083955', '37.5747334832097');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12951, '서울특별시 서대문구 남가좌동', '377', 377, 0, 'DMC래미안클라시스', 59.59, 202408, 24, '79,000', '-', '9', '개인', '개인', '2000', '증가로 191', '중개거래', '아파트', '126.917392296871', '37.5784968293823');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6732, '서울특별시 서대문구 남가좌동', '377', 377, 0, 'DMC래미안클라시스', 114.93, 202408, 29, '108,000', '-', '9', '개인', '개인', '2000', '증가로 191', '중개거래', '아파트', '126.917392296871', '37.5784968293823');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8364, '서울특별시 은평구 수색동', '417', 417, 0, 'DMC롯데캐슬더퍼스트', 114.95, 202408, 28, '156,000', '-', '10', '개인', '개인', '2021', '수색로 300', '중개거래', '아파트', '126.890441915048', '37.5850903459468');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24491, '서울특별시 은평구 수색동', '417', 417, 0, 'DMC롯데캐슬더퍼스트', 84.93, 202408, 15, '115,000', '-', '9', '개인', '개인', '2021', '수색로 300', '중개거래', '아파트', '126.890441915048', '37.5850903459468');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13044, '서울특별시 은평구 수색동', '417', 417, 0, 'DMC롯데캐슬더퍼스트', 59.96, 202408, 24, '103,000', '-', '11', '개인', '개인', '2021', '수색로 300', '중개거래', '아파트', '126.890441915048', '37.5850903459468');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11609, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 84.9982, 202408, 24, '81,000', '-', '10', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11608, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 74.4654, 202408, 24, '76,000', '-', '6', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13878, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 84.9887, 202408, 23, '85,000', '-', '10', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15309, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 74.4654, 202408, 22, '76,500', '-', '14', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15316, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 74.4654, 202408, 22, '76,500', '-', '14', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2352, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 74.4654, 202409, 4, '77,000', '-', '6', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7037, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 74.4654, 202408, 29, '69,000', '105동', '12', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23681, '경기도 고양시 덕양구 향동동', '570', 570, 0, 'DMC리슈빌더포레스트', 84.9982, 202408, 15, '84,000', '-', '17', '개인', '개인', '2019', '향기로 30', '중개거래', '아파트', '126.887923188959', '37.5937482263661');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24547, '서울특별시 마포구 중동', '390', 390, 0, 'DMC마포청구아파트', 84.9, 202408, 15, '82,000', '-', '1', '개인', '개인', '1994', '성암로11길 60', '중개거래', '아파트', '126.901749100281', '37.5744277597669');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9332, '서울특별시 마포구 중동', '390', 390, 0, 'DMC마포청구아파트', 84.9, 202408, 27, '92,000', '-', '14', '개인', '개인', '1994', '성암로11길 60', '중개거래', '아파트', '126.901749100281', '37.5744277597669');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22851, '서울특별시 마포구 상암동', '1630', 1630, 0, 'DMC상암센트럴파크1단지', 84.91, 202408, 16, '106,500', '-', '3', '개인', '개인', '2009', '월드컵북로43길 11', '중개거래', '아파트', '126.895705587776', '37.5746681863017');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25209, '서울특별시 마포구 상암동', '1630', 1630, 0, 'DMC상암센트럴파크1단지', 84.91, 202408, 14, '110,000', '-', '6', '개인', '개인', '2009', '월드컵북로43길 11', '중개거래', '아파트', '126.895705587776', '37.5746681863017');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20102, '서울특별시 은평구 증산동', '244', 244, 0, 'DMC우방', 59.91, 202408, 17, '72,500', '-', '7', '개인', '개인', '2000', '증산로3길 26-1', '중개거래', '아파트', '126.902347326188', '37.5814851103662');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16552, '서울특별시 은평구 증산동', '244', 244, 0, 'DMC우방', 59.91, 202408, 21, '67,500', '-', '8', '개인', '개인', '2000', '증산로3길 26-1', '중개거래', '아파트', '126.902347326188', '37.5814851103662');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8339, '서울특별시 은평구 증산동', '244', 244, 0, 'DMC우방', 59.91, 202408, 28, '71,700', '-', '7', '개인', '개인', '2000', '증산로3길 26-1', '중개거래', '아파트', '126.902347326188', '37.5814851103662');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5622, '서울특별시 은평구 증산동', '244', 244, 0, 'DMC우방', 59.91, 202408, 31, '67,000', '-', '6', '개인', '개인', '2000', '증산로3길 26-1', '중개거래', '아파트', '126.902347326188', '37.5814851103662');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2102, '서울특별시 은평구 증산동', '244', 244, 0, 'DMC우방', 114.97, 202409, 5, '73,000', '-', '9', '개인', '개인', '2000', '증산로3길 26-1', '직거래', '아파트', '126.902347326188', '37.5814851103662');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1539, '서울특별시 은평구 증산동', '244', 244, 0, 'DMC우방', 59.91, 202409, 6, '68,000', '-', '3', '개인', '개인', '2000', '증산로3길 26-1', '중개거래', '아파트', '126.902347326188', '37.5814851103662');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4973, '경기도 고양시 덕양구 향동동', '501', 501, 0, 'DMC중흥S-클래스더센트럴', 59.8179, 202408, 31, '64,000', '-', '7', '개인', '개인', '2020', '향동1로 20', '중개거래', '아파트', '126.893781237705', '37.60304817321');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21195, '경기도 고양시 덕양구 향동동', '501', 501, 0, 'DMC중흥S-클래스더센트럴', 59.9234, 202408, 17, '69,500', '205동', '22', '개인', '개인', '2020', '향동1로 20', '중개거래', '아파트', '126.893781237705', '37.60304817321');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10230, '경기도 고양시 덕양구 향동동', '501', 501, 0, 'DMC중흥S-클래스더센트럴', 59.9234, 202408, 26, '70,000', '-', '19', '개인', '개인', '2020', '향동1로 20', '중개거래', '아파트', '126.893781237705', '37.60304817321');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13608, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이1단지', 84.98, 202408, 23, '133,500', '-', '2', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15361, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이1단지', 84.971, 202408, 22, '127,000', '-', '10', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2204, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이1단지', 120.492, 202409, 4, '169,000', '-', '19', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8284, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이1단지', 84.971, 202408, 28, '127,000', '-', '15', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5287, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이1단지', 121.614, 202408, 31, '162,500', '-', '4', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12954, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이2단지', 84.968, 202408, 24, '127,000', '-', '8', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19113, '서울특별시 서대문구 남가좌동', '385', 385, 0, 'DMC파크뷰자이2단지', 84.99, 202408, 19, '127,000', '-', '9', '개인', '개인', '2015', '가재울미래로 2', '중개거래', '아파트', '126.917907814167', '37.5744019902031');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22680, '경기도 고양시 덕양구 향동동', '571', 571, 0, 'DMC호반베르디움더포레2단지', 84.9313, 202408, 16, '82,000', '202동', '18', '개인', '개인', '2019', '향기2로 22', '중개거래', '아파트', '126.891795501058', '37.5930245595355');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13795, '경기도 고양시 덕양구 향동동', '571', 571, 0, 'DMC호반베르디움더포레2단지', 70.8787, 202408, 23, '73,000', '-', '2', '개인', '개인', '2019', '향기2로 22', '중개거래', '아파트', '126.891795501058', '37.5930245595355');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11597, '경기도 고양시 덕양구 향동동', '552', 552, 0, 'DMC호반베르디움더포레4단지', 70.9637, 202408, 24, '78,000', '-', '4', '개인', '개인', '2019', '향기로 77', '중개거래', '아파트', '126.892356102574', '37.597427404978');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4977, '경기도 고양시 덕양구 향동동', '552', 552, 0, 'DMC호반베르디움더포레4단지', 84.8984, 202408, 31, '87,700', '-', '4', '개인', '개인', '2019', '향기로 77', '중개거래', '아파트', '126.892356102574', '37.597427404978');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3341, '경기도 안양시 동안구 호계동', '971-1', 971, 1, 'DYtown', 18.9685, 202409, 2, '8,930', '101', '4', '개인', '개인', '2014', '경수대로519번길 47', '직거래', '아파트', '126.955438002695', '37.3681991239342');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3340, '경기도 안양시 동안구 호계동', '971-1', 971, 1, 'DYtown', 18.9685, 202409, 2, '8,930', '101', '3', '개인', '개인', '2014', '경수대로519번길 47', '직거래', '아파트', '126.955438002695', '37.3681991239342');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (46, '경기도 수원시 영통구 매탄동', '1209', 1209, 0, 'e-편한세상', 101.709, 202409, 10, '56,000', '-', '23', '개인', '개인', '2010', '매봉로 20', '직거래', '아파트', '127.052622384357', '37.2693936820941');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26126, '경상남도 양산시 남부동', '553-1', 553, 1, 'e-편한세상', 113.91, 202408, 14, '39,000', '-', '8', '개인', '개인', '2006', '양주로 33', '중개거래', '아파트', '127.275744887983', '37.2355774149187');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26285, '경상남도 양산시 남부동', '553-1', 553, 1, 'e-편한세상', 83.18, 202408, 13, '30,000', '109', '7', '개인', '개인', '2006', '양주로 33', '직거래', '아파트', '127.275744887983', '37.2355774149187');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25695, '경기도 수원시 영통구 매탄동', '1209', 1209, 0, 'e-편한세상', 59.9535, 202408, 14, '61,500', '-', '20', '개인', '개인', '2010', '매봉로 20', '중개거래', '아파트', '127.052622384357', '37.2693936820941');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21810, '경상남도 양산시 남부동', '553-1', 553, 1, 'e-편한세상', 83.18, 202408, 17, '31,500', '-', '21', '개인', '개인', '2006', '양주로 33', '중개거래', '아파트', '127.275744887983', '37.2355774149187');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26187, '경상북도 안동시 태화동', '923', 923, 0, 'e-편한세상안동2단지', 59.587, 202408, 14, '25,400', '-', '5', '개인', '개인', '2016', '경동로 404-7', '중개거래', '아파트', '128.704672174978', '36.5698545549583');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14855, '경상북도 안동시 태화동', '923', 923, 0, 'e-편한세상안동2단지', 59.587, 202408, 22, '24,500', '-', '4', '개인', '개인', '2016', '경동로 404-7', '중개거래', '아파트', '128.704672174978', '36.5698545549583');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1031, '경상남도 창원시 마산회원구 회원동', '313', 313, 0, 'e-편한세상창원파크센트럴', 84.9798, 202409, 7, '49,400', '-', '22', '개인', '개인', '2020', '회원남로 65', '중개거래', '아파트', '128.569503435739', '35.2194026917238');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4425, '경상남도 창원시 마산회원구 회원동', '313', 313, 0, 'e-편한세상창원파크센트럴', 72.9738, 202408, 31, '42,500', '-', '10', '개인', '개인', '2020', '회원남로 65', '중개거래', '아파트', '128.569503435739', '35.2194026917238');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1212, '강원특별자치도 원주시 지정면 가곡리', '1453', 1453, 0, 'EG-the1아파트', 84.9822, 202409, 6, '28,700', '-', '6', '개인', '개인', '2019', '신지정로 325', '중개거래', '아파트', '127.872381749626', '37.3838542419853');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21683, '강원특별자치도 원주시 지정면 가곡리', '1453', 1453, 0, 'EG-the1아파트', 84.9822, 202408, 17, '29,000', '-', '13', '개인', '개인', '2019', '신지정로 325', '중개거래', '아파트', '127.872381749626', '37.3838542419853');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21682, '강원특별자치도 원주시 지정면 가곡리', '1453', 1453, 0, 'EG-the1아파트', 59.9473, 202408, 17, '20,500', '-', '10', '개인', '개인', '2019', '신지정로 325', '중개거래', '아파트', '127.872381749626', '37.3838542419853');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17798, '강원특별자치도 원주시 지정면 가곡리', '1453', 1453, 0, 'EG-the1아파트', 84.9822, 202408, 20, '30,800', '-', '21', '개인', '개인', '2019', '신지정로 325', '중개거래', '아파트', '127.872381749626', '37.3838542419853');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12073, '강원특별자치도 원주시 지정면 가곡리', '1453', 1453, 0, 'EG-the1아파트', 84.9822, 202408, 24, '29,400', '-', '10', '개인', '개인', '2019', '신지정로 325', '중개거래', '아파트', '127.872381749626', '37.3838542419853');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10551, '강원특별자치도 원주시 지정면 가곡리', '1453', 1453, 0, 'EG-the1아파트', 84.9822, 202408, 26, '29,000', '-', '5', '개인', '개인', '2019', '신지정로 325', '중개거래', '아파트', '127.872381749626', '37.3838542419853');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1977, '강원특별자치도 평창군 봉평면 무이리', '1182', 1182, 0, 'eliott아파트', 59.56, 202409, 5, '9,300', '-', '6', '개인', '개인', '2019', '안흥동1길 25-4', '중개거래', '아파트', '128.317314307302', '37.5886641516602');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7476, '강원특별자치도 평창군 봉평면 무이리', '1182', 1182, 0, 'eliott아파트', 59.56, 202408, 28, '10,590', '101', '7', '개인', '개인', '2019', '안흥동1길 25-4', '직거래', '아파트', '128.317314307302', '37.5886641516602');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22161, '강원특별자치도 평창군 봉평면 무이리', '1182', 1182, 0, 'eliott아파트', 59.56, 202408, 16, '8,650', '101', '7', '법인', '법인', '2019', '안흥동1길 25-4', '직거래', '아파트', '128.317314307302', '37.5886641516602');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23106, '대전광역시 동구 낭월동', '723', 723, 0, 'e편한세상', 84.974, 202408, 16, '27,300', '-', '5', '개인', '개인', '2011', '산내로 1330', '중개거래', '아파트', '127.470414141531', '36.2827588305761');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20642, '광주광역시 서구 광천동', '895', 895, 0, 'e편한세상', 84.8921, 202408, 17, '50,500', '-', '8', '개인', '개인', '2010', '화운로 278', '중개거래', '아파트', '126.877576244102', '35.162165052796');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12798, '광주광역시 서구 광천동', '895', 895, 0, 'e편한세상', 113.738, 202408, 24, '57,000', '-', '3', '개인', '개인', '2010', '화운로 278', '중개거래', '아파트', '126.877576244102', '35.162165052796');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16532, '서울특별시 도봉구 쌍문동', '731', 731, 0, 'e편한세상', 84.978, 202408, 21, '68,000', '-', '10', '개인', '개인', '2007', '노해로41가길 16', '중개거래', '아파트', '127.027430789794', '37.6499814851783');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (558, '광주광역시 서구 광천동', '895', 895, 0, 'e편한세상', 84.8921, 202409, 8, '51,000', '-', '2', '개인', '개인', '2010', '화운로 278', '중개거래', '아파트', '126.877576244102', '35.162165052796');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (780, '광주광역시 서구 광천동', '895', 895, 0, 'e편한세상', 84.8921, 202409, 7, '45,500', '-', '3', '개인', '개인', '2010', '화운로 278', '중개거래', '아파트', '126.877576244102', '35.162165052796');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (562, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 46.4818, 202409, 8, '34,800', '-', '14', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (745, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 59.9768, 202409, 7, '51,700', '-', '13', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6700, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 59.8883, 202408, 29, '50,000', '-', '31', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5551, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 84.9299, 202408, 31, '64,800', '-', '7', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5477, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 59.8883, 202408, 31, '52,000', '-', '25', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3861, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 59.8883, 202409, 2, '49,500', '-', '20', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25105, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 84.9299, 202408, 14, '68,900', '-', '14', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25106, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 46.4818, 202408, 14, '34,000', '-', '6', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9412, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 74.9322, 202408, 27, '62,000', '-', '29', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13599, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 74.9322, 202408, 23, '58,600', '-', '16', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13320, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 74.9322, 202408, 23, '57,800', '-', '27', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15336, '인천광역시 계양구 효성동', '677', 677, 0, 'e편한세상 계양 더프리미어', 84.9299, 202408, 22, '64,000', '-', '22', '개인', '개인', '2021', '효서로 145', '중개거래', '아파트', '126.713053847459', '37.5283576329517');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13803, '경기도 군포시 산본동', '310-2', 310, 2, 'e편한세상 금정역 에코센트럴 아파트', 117.994, 202408, 23, '94,000', '-', '25', '개인', '개인', '2007', '금산로 47', '중개거래', '아파트', '126.936799059919', '37.3659048193681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13802, '경기도 군포시 산본동', '310-2', 310, 2, 'e편한세상 금정역 에코센트럴 아파트', 84.995, 202408, 23, '74,000', '-', '11', '개인', '개인', '2007', '금산로 47', '중개거래', '아파트', '126.936799059919', '37.3659048193681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (949, '경기도 군포시 산본동', '310-2', 310, 2, 'e편한세상 금정역 에코센트럴 아파트', 84.995, 202409, 7, '71,500', '-', '9', '개인', '개인', '2007', '금산로 47', '중개거래', '아파트', '126.936799059919', '37.3659048193681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17765, '경기도 군포시 산본동', '310-2', 310, 2, 'e편한세상 금정역 에코센트럴 아파트', 84.995, 202408, 20, '75,000', '-', '17', '개인', '개인', '2007', '금산로 47', '중개거래', '아파트', '126.936799059919', '37.3659048193681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18989, '경기도 군포시 산본동', '310-2', 310, 2, 'e편한세상 금정역 에코센트럴 아파트', 59.995, 202408, 19, '60,700', '-', '20', '개인', '개인', '2007', '금산로 47', '중개거래', '아파트', '126.936799059919', '37.3659048193681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18991, '경기도 군포시 산본동', '310-2', 310, 2, 'e편한세상 금정역 에코센트럴 아파트', 59.995, 202408, 19, '60,700', '-', '20', '개인', '개인', '2007', '금산로 47', '중개거래', '아파트', '126.936799059919', '37.3659048193681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21136, '경기도 남양주시 다산동', '6091', 6091, 0, 'e편한세상 다산', 84.97, 202408, 17, '84,000', '-', '24', '개인', '개인', '2017', '다산중앙로82번길 15', '중개거래', '아파트', '127.155547427004', '37.6210512529867');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23809, '경기도 남양주시 다산동', '6091', 6091, 0, 'e편한세상 다산', 74.98, 202408, 15, '80,000', '-', '7', '개인', '개인', '2017', '다산중앙로82번길 15', '직거래', '아파트', '127.155547427004', '37.6210512529867');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11839, '경기도 남양주시 다산동', '6091', 6091, 0, 'e편한세상 다산', 74.98, 202408, 24, '82,000', '-', '21', '개인', '개인', '2017', '다산중앙로82번길 15', '중개거래', '아파트', '127.155547427004', '37.6210512529867');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11840, '경기도 남양주시 다산동', '6091', 6091, 0, 'e편한세상 다산', 84.96, 202408, 24, '82,000', '-', '6', '개인', '개인', '2017', '다산중앙로82번길 15', '중개거래', '아파트', '127.155547427004', '37.6210512529867');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12986, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 72.8227, 202408, 24, '35,000', '-', '28', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11230, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 59.8825, 202408, 25, '31,000', '-', '20', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20727, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 84.9964, 202408, 17, '45,800', '-', '34', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20710, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 84.9964, 202408, 17, '45,800', '-', '34', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (421, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 59.8825, 202409, 9, '31,800', '-', '5', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6400, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 59.8825, 202408, 30, '29,957', '-', '28', '개인', '개인', '2020', '용운로 203', '직거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6598, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 59.8825, 202408, 29, '33,000', '-', '20', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8302, '대전광역시 동구 용운동', '783', 783, 0, 'e편한세상 대전에코포레', 59.8825, 202408, 28, '31,500', '-', '13', '개인', '개인', '2020', '용운로 203', '중개거래', '아파트', '127.464787200907', '36.3273127654815');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1117, '경기도 양주시 옥정동', '958', 958, 0, 'e편한세상 옥정어반센트럴', 84.9539, 202409, 7, '49,000', '-', '8', '개인', '개인', '2017', '옥정로5길 35', '중개거래', '아파트', '127.089479851192', '37.8221389355629');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10945, '경기도 양주시 옥정동', '958', 958, 0, 'e편한세상 옥정어반센트럴', 74.8607, 202408, 25, '40,800', '-', '24', '개인', '개인', '2017', '옥정로5길 35', '중개거래', '아파트', '127.089479851192', '37.8221389355629');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21851, '경기도 양주시 옥정동', '958', 958, 0, 'e편한세상 옥정어반센트럴', 84.6278, 202408, 17, '47,500', '-', '21', '개인', '개인', '2017', '옥정로5길 35', '중개거래', '아파트', '127.089479851192', '37.8221389355629');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21961, '경기도 양주시 옥정동', '958', 958, 0, 'e편한세상 옥정어반센트럴', 74.8607, 202408, 16, '39,850', '-', '7', '개인', '개인', '2017', '옥정로5길 35', '중개거래', '아파트', '127.089479851192', '37.8221389355629');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24203, '경기도 양주시 옥정동', '958', 958, 0, 'e편한세상 옥정어반센트럴', 84.6278, 202408, 15, '47,800', '-', '17', '개인', '개인', '2017', '옥정로5길 35', '중개거래', '아파트', '127.089479851192', '37.8221389355629');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21224, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 84.9634, 202408, 17, '51,400', '-', '10', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8766, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 101.212, 202408, 27, '56,700', '-', '2', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8765, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 101.212, 202408, 27, '62,000', '-', '17', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2386, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 84.9808, 202409, 4, '49,500', '-', '7', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1667, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 84.9808, 202409, 5, '51,200', '-', '6', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3310, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 84.9946, 202409, 2, '57,000', '-', '16', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17345, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 101.212, 202408, 20, '62,300', '-', '10', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15060, '울산광역시 중구 반구동', '679', 679, 0, 'e편한세상강변', 84.9634, 202408, 22, '51,000', '-', '6', '개인', '개인', '2015', '반구로 55', '중개거래', '아파트', '128.583737833157', '36.7729282641518');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13422, '서울특별시 광진구 구의동', '680', 680, 0, 'e편한세상광진그랜드파크', 84.9716, 202408, 23, '176,000', '-', '19', '개인', '개인', '2021', '광나루로 458', '중개거래', '아파트', '127.080444598161', '37.5446727531742');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22905, '서울특별시 광진구 구의동', '680', 680, 0, 'e편한세상광진그랜드파크', 84.9716, 202408, 16, '166,000', '-', '13', '개인', '개인', '2021', '광나루로 458', '중개거래', '아파트', '127.080444598161', '37.5446727531742');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22904, '서울특별시 광진구 구의동', '680', 680, 0, 'e편한세상광진그랜드파크', 84.9839, 202408, 16, '142,000', '-', '1', '개인', '개인', '2021', '광나루로 458', '중개거래', '아파트', '127.080444598161', '37.5446727531742');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24062, '경상북도 구미시 선산읍 교리', '1172', 1172, 0, 'e편한세상구미교리', 84.9, 202408, 15, '18,000', '-', '3', '개인', '개인', '2016', '선산향교길 16', '중개거래', '아파트', '128.305716508602', '36.2528684881723');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2611, '경상북도 구미시 선산읍 교리', '1172', 1172, 0, 'e편한세상구미교리', 84.9, 202409, 4, '19,400', '-', '17', '개인', '개인', '2016', '선산향교길 16', '중개거래', '아파트', '128.305716508602', '36.2528684881723');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26511, '경상북도 구미시 공단동', '601', 601, 0, 'e편한세상구미파크밸리', 84.994, 202408, 13, '32,000', '-', '13', '개인', '개인', '2017', '신비로7길 10', '중개거래', '아파트', '128.366474390977', '36.1228991792608');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18431, '경상북도 구미시 공단동', '601', 601, 0, 'e편한세상구미파크밸리', 59.996, 202408, 19, '22,400', '-', '18', '개인', '개인', '2017', '신비로7길 10', '중개거래', '아파트', '128.366474390977', '36.1228991792608');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21447, '경기도 성남시 중원구 금광동', '1003', 1003, 0, 'e편한세상금빛그랑메종2단지', 59.9, 202408, 17, '78,000', '-', '4', '개인', '개인', '2023', '금광로 26', '중개거래', '아파트', '127.16265170113', '37.4431024996503');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11401, '경기도 성남시 중원구 금광동', '1003', 1003, 0, 'e편한세상금빛그랑메종2단지', 74.62, 202408, 24, '88,000', '-', '4', '개인', '개인', '2023', '금광로 26', '중개거래', '아파트', '127.16265170113', '37.4431024996503');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (273, '경기도 성남시 중원구 금광동', '1003', 1003, 0, 'e편한세상금빛그랑메종2단지', 59.95, 202409, 9, '80,000', '-', '17', '개인', '개인', '2023', '금광로 26', '중개거래', '아파트', '127.16265170113', '37.4431024996503');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5198, '경기도 성남시 중원구 금광동', '1008', 1008, 0, 'e편한세상금빛그랑메종3단지', 74.62, 202408, 31, '88,700', '-', '21', '개인', '개인', '2023', '금광로 40', '중개거래', '아파트', '127.164294595138', '37.4435880362709');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5199, '경기도 성남시 중원구 금광동', '1008', 1008, 0, 'e편한세상금빛그랑메종3단지', 74.62, 202408, 31, '88,700', '-', '22', '개인', '개인', '2023', '금광로 40', '중개거래', '아파트', '127.164294595138', '37.4435880362709');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18716, '경기도 성남시 중원구 금광동', '1008', 1008, 0, 'e편한세상금빛그랑메종3단지', 59.98, 202408, 19, '81,820', '-', '11', '개인', '개인', '2023', '금광로 40', '중개거래', '아파트', '127.164294595138', '37.4435880362709');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (541, '충청남도 금산군 금산읍 중도리', '684', 684, 0, 'e편한세상금산센터하임', 84.9416, 202409, 8, '29,000', '-', '8', '개인', '개인', '2022', '금산로 1554', '중개거래', '아파트', '127.495092242931', '36.1126167477587');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9018, '충청남도 금산군 금산읍 중도리', '684', 684, 0, 'e편한세상금산센터하임', 84.9416, 202408, 27, '29,000', '-', '13', '개인', '개인', '2022', '금산로 1554', '중개거래', '아파트', '127.495092242931', '36.1126167477587');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12225, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 84.8822, 202408, 24, '34,200', '-', '6', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12224, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 84.8822, 202408, 24, '34,000', '107동', '15', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2915, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 67.9214, 202409, 3, '28,200', '-', '20', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7705, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 67.9214, 202408, 28, '28,000', '-', '14', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6074, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 84.8822, 202408, 30, '36,000', '-', '5', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1951, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 67.9214, 202409, 5, '28,500', '-', '10', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1965, '경상북도 구미시 사곡동', '749', 749, 0, 'e편한세상금오파크', 84.8822, 202409, 5, '37,000', '-', '27', '개인', '개인', '2020', '새마을로 150', '중개거래', '아파트', '128.352196428717', '36.105077367469');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4833, '경기도 김포시 통진읍 마송리', '513', 513, 0, 'e편한세상김포로얄하임', 66.9783, 202408, 31, '32,300', '-', '9', '개인', '개인', '2021', '마송1로 122', '중개거래', '아파트', '126.594653031353', '37.6900315200459');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (836, '경기도 김포시 통진읍 마송리', '513', 513, 0, 'e편한세상김포로얄하임', 74.9764, 202409, 7, '36,700', '-', '17', '개인', '개인', '2021', '마송1로 122', '중개거래', '아파트', '126.594653031353', '37.6900315200459');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5738, '경기도 김포시 통진읍 마송리', '513', 513, 0, 'e편한세상김포로얄하임', 84.997, 202408, 30, '39,500', '-', '6', '개인', '개인', '2021', '마송1로 122', '중개거래', '아파트', '126.594653031353', '37.6900315200459');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8530, '경기도 김포시 통진읍 마송리', '513', 513, 0, 'e편한세상김포로얄하임', 66.9783, 202408, 27, '31,500', '-', '11', '개인', '개인', '2021', '마송1로 122', '중개거래', '아파트', '126.594653031353', '37.6900315200459');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7006, '경기도 김포시 통진읍 마송리', '513', 513, 0, 'e편한세상김포로얄하임', 66.9656, 202408, 29, '33,200', '-', '4', '개인', '개인', '2021', '마송1로 122', '중개거래', '아파트', '126.594653031353', '37.6900315200459');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1501, '경기도 김포시 통진읍 마송리', '586', 586, 0, 'e편한세상김포어반베뉴', 53.9035, 202409, 6, '26,000', '-', '4', '개인', '개인', '2022', '율마로438번길 52', '중개거래', '아파트', '126.605702040275', '37.6877012272303');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18888, '경기도 김포시 통진읍 마송리', '586', 586, 0, 'e편한세상김포어반베뉴', 53.9907, 202408, 19, '23,900', '-', '2', '개인', '개인', '2022', '율마로438번길 52', '중개거래', '아파트', '126.605702040275', '37.6877012272303');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18889, '경기도 김포시 통진읍 마송리', '586', 586, 0, 'e편한세상김포어반베뉴', 53.9035, 202408, 19, '26,400', '-', '4', '개인', '개인', '2022', '율마로438번길 52', '중개거래', '아파트', '126.605702040275', '37.6877012272303');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23751, '경기도 김포시 통진읍 마송리', '586', 586, 0, 'e편한세상김포어반베뉴', 59.9953, 202408, 15, '30,300', '-', '8', '개인', '개인', '2022', '율마로438번길 52', '중개거래', '아파트', '126.605702040275', '37.6877012272303');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17429, '경기도 김포시 통진읍 마송리', '586', 586, 0, 'e편한세상김포어반베뉴', 53.9907, 202408, 20, '25,500', '-', '6', '개인', '개인', '2022', '율마로438번길 52', '중개거래', '아파트', '126.605702040275', '37.6877012272303');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13948, '경기도 김포시 통진읍 마송리', '586', 586, 0, 'e편한세상김포어반베뉴', 59.9953, 202408, 23, '30,000', '-', '11', '개인', '개인', '2022', '율마로438번길 52', '중개거래', '아파트', '126.605702040275', '37.6877012272303');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10927, '경상남도 양산시 동면 석산리', '1450-1', 1450, 1, 'e편한세상남양산2차', 104.664, 202408, 25, '38,000', '204', '7', '개인', '개인', '2013', '금오13길 71', '중개거래', '아파트', '129.022055294273', '35.3205533610681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9060, '경상남도 양산시 동면 석산리', '1450-1', 1450, 1, 'e편한세상남양산2차', 104.664, 202408, 27, '42,500', '-', '18', '개인', '개인', '2013', '금오13길 71', '중개거래', '아파트', '129.022055294273', '35.3205533610681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2545, '경상남도 양산시 동면 석산리', '1450-1', 1450, 1, 'e편한세상남양산2차', 104.664, 202409, 4, '43,200', '-', '3', '개인', '개인', '2013', '금오13길 71', '중개거래', '아파트', '129.022055294273', '35.3205533610681');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6673, '대구광역시 중구 대신동', '2110', 2110, 0, 'e편한세상대신', 84.976, 202408, 29, '51,000', '-', '11', '개인', '개인', '2018', '달구벌대로 1943', '중개거래', '아파트', '128.57686695382', '35.8636199724894');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8422, '대구광역시 중구 대신동', '2110', 2110, 0, 'e편한세상대신', 59.984, 202408, 28, '41,000', '-', '10', '개인', '개인', '2018', '달구벌대로 1943', '중개거래', '아파트', '128.57686695382', '35.8636199724894');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9573, '대구광역시 중구 대신동', '2110', 2110, 0, 'e편한세상대신', 84.976, 202408, 27, '52,200', '-', '24', '개인', '개인', '2018', '달구벌대로 1943', '중개거래', '아파트', '128.57686695382', '35.8636199724894');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13490, '대구광역시 중구 대신동', '2110', 2110, 0, 'e편한세상대신', 59.984, 202408, 23, '41,000', '-', '6', '개인', '개인', '2018', '달구벌대로 1943', '중개거래', '아파트', '128.57686695382', '35.8636199724894');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24917, '대구광역시 중구 대신동', '2110', 2110, 0, 'e편한세상대신', 59.984, 202408, 14, '40,800', '-', '8', '개인', '개인', '2018', '달구벌대로 1943', '중개거래', '아파트', '128.57686695382', '35.8636199724894');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8633, '대전광역시 대덕구 법동', '448', 448, 0, 'e편한세상대전법동', 84.9971, 202408, 27, '52,200', '-', '15', '개인', '개인', '2020', '중리북로 46', '중개거래', '아파트', '127.423886685475', '36.3668436843799');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8634, '대전광역시 대덕구 법동', '448', 448, 0, 'e편한세상대전법동', 74.9795, 202408, 27, '44,000', '-', '28', '개인', '개인', '2020', '중리북로 46', '중개거래', '아파트', '127.423886685475', '36.3668436843799');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8639, '대전광역시 대덕구 법동', '448', 448, 0, 'e편한세상대전법동', 74.9795, 202408, 27, '47,500', '102', '18', '개인', '개인', '2020', '중리북로 46', '직거래', '아파트', '127.423886685475', '36.3668436843799');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (944, '대전광역시 대덕구 법동', '448', 448, 0, 'e편한세상대전법동', 84.9971, 202409, 7, '50,000', '-', '4', '개인', '개인', '2020', '중리북로 46', '중개거래', '아파트', '127.423886685475', '36.3668436843799');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10380, '대전광역시 대덕구 법동', '448', 448, 0, 'e편한세상대전법동', 74.9979, 202408, 26, '43,300', '-', '12', '개인', '개인', '2020', '중리북로 46', '중개거래', '아파트', '127.423886685475', '36.3668436843799');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11016, '대전광역시 대덕구 법동', '448', 448, 0, 'e편한세상대전법동', 84.9808, 202408, 25, '51,800', '-', '13', '개인', '개인', '2020', '중리북로 46', '중개거래', '아파트', '127.423886685475', '36.3668436843799');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13259, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 84.98, 202408, 23, '54,700', '-', '4', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20207, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 76.33, 202408, 17, '52,000', '-', '28', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20206, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 76.33, 202408, 17, '52,300', '-', '26', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (702, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 76.33, 202409, 7, '50,800', '-', '5', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (703, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 76.33, 202409, 7, '50,800', '-', '5', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4146, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 76.22, 202409, 1, '50,000', '-', '5', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5606, '부산광역시 동래구 명장동', '623', 623, 0, 'e편한세상동래명장1단지', 84.98, 202408, 31, '54,000', '-', '14', '개인', '개인', '2019', '명장로 65', '중개거래', '아파트', '129.105513244994', '35.2051196931617');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23021, '부산광역시 동래구 온천동', '1846', 1846, 0, 'e편한세상동래아시아드', 49.9839, 202408, 16, '36,400', '-', '14', '개인', '개인', '2020', '아시아드대로 202', '중개거래', '아파트', '129.066385139165', '35.2022971190576');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23020, '부산광역시 동래구 온천동', '1846', 1846, 0, 'e편한세상동래아시아드', 84.9602, 202408, 16, '62,000', '-', '3', '개인', '개인', '2020', '아시아드대로 202', '중개거래', '아파트', '129.066385139165', '35.2022971190576');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14614, '강원특별자치도 동해시 북평동', '327', 327, 0, 'e편한세상동해', 84.98, 202408, 22, '32,300', '-', '9', '개인', '개인', '2020', '단봉길 39', '중개거래', '아파트', '129.121614168638', '37.4794834543718');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3539, '강원특별자치도 동해시 북평동', '327', 327, 0, 'e편한세상동해', 78.64, 202409, 2, '28,500', '-', '16', '개인', '개인', '2020', '단봉길 39', '중개거래', '아파트', '129.121614168638', '37.4794834543718');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3561, '강원특별자치도 동해시 북평동', '327', 327, 0, 'e편한세상동해', 78.64, 202409, 2, '28,500', '-', '4', '개인', '개인', '2020', '단봉길 39', '중개거래', '아파트', '129.121614168638', '37.4794834543718');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2105, '대구광역시 서구 내당동', '2346', 2346, 0, 'e편한세상두류역', 84.9286, 202409, 5, '55,500', '-', '17', '개인', '개인', '2022', '달구벌대로361길 41', '중개거래', '아파트', '128.559662166963', '35.8638190126679');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (561, '대구광역시 서구 내당동', '2346', 2346, 0, 'e편한세상두류역', 74.8683, 202409, 8, '50,500', '-', '10', '개인', '개인', '2022', '달구벌대로361길 41', '중개거래', '아파트', '128.559662166963', '35.8638190126679');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4139, '대구광역시 서구 내당동', '2346', 2346, 0, 'e편한세상두류역', 74.9916, 202409, 1, '49,500', '-', '29', '개인', '개인', '2022', '달구벌대로361길 41', '중개거래', '아파트', '128.559662166963', '35.8638190126679');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20546, '대구광역시 서구 내당동', '2346', 2346, 0, 'e편한세상두류역', 84.9286, 202408, 17, '62,700', '-', '22', '개인', '개인', '2022', '달구벌대로361길 41', '중개거래', '아파트', '128.559662166963', '35.8638190126679');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19227, '대구광역시 서구 내당동', '2346', 2346, 0, 'e편한세상두류역', 74.9916, 202408, 19, '48,300', '-', '19', '개인', '개인', '2022', '달구벌대로361길 41', '중개거래', '아파트', '128.559662166963', '35.8638190126679');
INSERT INTO address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24700, '대구광역시 서구 내당동', '2346', 2346, 0, 'e편한세상두류역', 74.9916, 202408, 15, '47,200', '-', '8', '개인', '개인', '2022', '달구벌대로361길 41', '중개거래', '아파트', '128.559662166963', '35.8638190126679');


# 여기부터 새로운 테이블 만들어서 운영함
DROP TABLE IF EXISTS address_distinct;
CREATE TABLE address_distinct (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  road_name VARCHAR(255) NOT NULL,
                                  x_coordinate VARCHAR(255),
                                  y_coordinate VARCHAR(255)
);

-- 중복되지 않는 도로명 주소 삽입
INSERT INTO address_distinct (road_name, x_coordinate, y_coordinate)
SELECT DISTINCT ap.doro_juso, ap.x_coordinate, ap.y_coordinate
FROM address_price ap;

-- address_price 테이블에 address_id 컬럼 추가 (이미 존재한다면 생략 가능)
ALTER TABLE address_price
    ADD COLUMN address_id INT;

-- 인덱스 추가 (성능 향상)
CREATE INDEX idx_address_price_doro_juso ON address_price(doro_juso);
CREATE INDEX idx_address_distinct_road_name ON address_distinct(road_name);

-- 배치 업데이트 예시
UPDATE address_price ap
    JOIN address_distinct ad ON ap.doro_juso = ad.road_name
SET ap.address_id = ad.id
WHERE ap.address_id IS NULL;

# 데이터 확인
SELECT * FROM address_distinct;


select * from member_tbl;


