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
    member_age int ,
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
INSERT INTO member_tbl (member_id, member_email, member_name, member_sex, member_age, member_birthday, member_phone, member_role)
VALUES
    (
        'N11111', 'one@naver.com', '김일번', 0, 24, '2000-01-01', '010-1111-1111', 'MEMBER'
    ),
    (
        'G22222', 'two@gmail.com', '정이번', 1, 25, '1999-02-02', '010-2222-2222', 'MEMBER'
    ),
    (
        'N33333', 'three@naver.com', '이삼번', 1, 26, '1998-03-03', '010-3333-3333', 'MEMBER'
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
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16280, '충청북도 청주시 흥덕구 가경동', '1028', 1028, 0, '(1028-0)', 24.83, 202408, 21, '5,000', '-', '6', '법인', '법인', '2013', '풍년로193번길 26', '직거래', '아파트', '127.430151368967', '36.6282076685257');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3485, '경기도 구리시 수택동', '625', 625, 0, '(625-0)', 59.81, 202409, 2, '35,800', '-', '6', '개인', '개인', '1997', '원수택로32번길 75', '중개거래', '아파트', '127.143577809204', '37.5934262442083');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3812, '서울특별시 구로구 구로동', '749-29', 749, 29, '(749-29)', 44.61, 202409, 2, '19,000', '-', '1', '개인', '개인', '1996', '구로동로20길 58-8', '중개거래', '아파트', '126.8874022127', '37.4877299192593');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13630, '대구광역시 동구 신암동', '193-1', 193, 1, '73신암시영', 37.82, 202408, 23, '7,300', '6', '4', '개인', '개인', '1975', '신암남로 10', '직거래', '아파트', '128.617532855364', '35.8776063167317');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18466, '경상북도 청도군 청도읍 고수리', '97-6', 97, 6, 'BS에코파크', 84.7025, 202408, 19, '18,800', '-', '6', '개인', '개인', '2013', '한내길 50-14', '중개거래', '아파트', '128.74241095468', '35.6493291451113');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18203, '전라남도 강진군 강진읍 서성리', '234', 234, 0, 'CNS후레쉬빌3차', 59.988, 202408, 20, '16,970', '-', '2', '개인', '개인', '2005', '서문길 29-9', '직거래', '아파트', '126.763349289854', '34.6400434412297');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25124, '서울특별시 서초구 서초동', '1584-6', 1584, 6, 'DK밸리뷰시티', 28.14, 202408, 14, '45,000', '2동', '6', '개인', '개인', '2019', '반포대로14길 14', '중개거래', '아파트', '127.01183823828', '37.4850604047094');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15605, '서울특별시 은평구 수색동', '418', 418, 0, 'DMCSKVIEW', 59.9865, 202408, 22, '119,000', '-', '11', '개인', '개인', '2023', '수색로 216', '중개거래', '아파트', '126.899932768477', '37.5798457128547');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13618, '서울특별시 서대문구 북가좌동', '459', 459, 0, 'DMC두산위브', 84.9923, 202408, 23, '80,500', '-', '4', '개인', '개인', '2007', '증가로 200-8', '중개거래', '아파트', '126.917155400657', '37.5798834729778');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12994, '서울특별시 은평구 증산동', '254', 254, 0, 'DMC문영퀸즈파크아파트', 84.97, 202408, 24, '63,300', '-', '13', '개인', '개인', '2004', '증산로13길 44-5', '중개거래', '아파트', '126.907696662489', '37.5876001284071');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25224, '서울특별시 서대문구 북가좌동', '467', 467, 0, 'DMC서부인터빌', 59.93, 202408, 14, '60,000', '-', '5', '개인', '개인', '2008', '증가로30길 8', '중개거래', '아파트', '126.913068683936', '37.5832379959214');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20613, '서울특별시 은평구 증산동', '258', 258, 0, 'DMC센트럴자이(2단지)', 59.67, 202408, 17, '130,000', '-', '13', '개인', '개인', '2023', '수색로 200', '중개거래', '아파트', '126.900673276716', '37.5794195375926');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8285, '서울특별시 서대문구 남가좌동', '381', 381, 0, 'DMC센트레빌', 114.85, 202408, 28, '131,000', '-', '7', '개인', '개인', '2009', '거북골로 120', '중개거래', '아파트', '126.916097519773', '37.5754832622486');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24872, '서울특별시 서대문구 북가좌동', '458', 458, 0, 'DMC아이파크', 84.93, 202408, 15, '102,500', '-', '7', '개인', '개인', '2009', '거북골로14길 32', '중개거래', '아파트', '126.914595329134', '37.576951075894');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12953, '서울특별시 서대문구 남가좌동', '389', 389, 0, 'DMC에코자이', 72.845, 202408, 24, '119,500', '-', '22', '개인', '개인', '2019', '거북골로 84', '중개거래', '아파트', '126.918481311495', '37.5782296308468');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12995, '서울특별시 은평구 증산동', '223-28', 223, 28, 'DMC자이2단지', 108.52, 202408, 24, '111,000', '-', '7', '개인', '개인', '2009', '수색로 217-1', '중개거래', '아파트', '126.899533764375', '37.5786200225853');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11777, '경기도 고양시 덕양구 덕은동', '가-', 0, 0, 'DMC한강에일린의뜰', 106.214, 202408, 24, '117,000', '-', '17', '개인', '개인', '2022', '청초로 65', '중개거래', '아파트', '126.862510109744', '37.578862375379');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3974, '서울특별시 서대문구 북가좌동', '456', 456, 0, 'DMC휴먼빌아파트', 84.99, 202409, 2, '77,000', '-', '12', '개인', '개인', '2008', '거북골로18가길 23', '중개거래', '아파트', '126.911817022824', '37.5773418665934');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22020, '경상북도 안동시 태화동', '922', 922, 0, 'e-편한세상안동1단지', 70.975, 202408, 16, '31,200', '-', '8', '개인', '개인', '2016', '경동로 404-22', '중개거래', '아파트', '128.7037376519', '36.5695949952274');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2011, '광주광역시 광산구 소촌동', '791-22', 791, 22, 'EG스위트밸리2차', 84.9831, 202409, 5, '22,500', '-', '13', '개인', '개인', '2001', '소촌로152번길 5', '중개거래', '아파트', '126.792310848272', '35.1593389556129');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5777, '경기도 안성시 석정동', '29-2', 29, 2, 'ELYSIA', 22.47, 202408, 30, '10,600', '-', '12', '개인', '개인', '2019', '중앙로 360', '중개거래', '아파트', '127.260743772847', '37.4307197889906');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9706, '서울특별시 영등포구 문래동6가', '58', 58, 0, 'e편한세상 문래 에듀플라츠', 59.9833, 202408, 26, '90,000', '-', '3', '개인', '개인', '2020', '선유서로 50', '직거래', '아파트', '126.8852629', '37.520252341103');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3105, '서울특별시 은평구 수색동', '415-1', 415, 1, 'e편한세상 수색 에코포레', 114.18, 202409, 3, '82,000', '109', '13', '개인', '개인', '2003', '은평터널로 65', '직거래', '아파트', '126.89916689751', '37.586899476029');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7153, '경기도 가평군 가평읍 대곡리', '694', 694, 0, 'e편한세상가평퍼스트원', 74.9267, 202408, 29, '30,000', '-', '6', '개인', '개인', '2023', '문화로 167', '중개거래', '아파트', '127.507216419597', '37.8275068547506');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24949, '부산광역시 수영구 민락동', '773', 773, 0, 'e편한세상광안비치', 84.988, 202408, 14, '67,500', '-', '17', '개인', '개인', '2016', '민락수변로7번길 60', '중개거래', '아파트', '129.126522212849', '35.1555179926384');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25584, '경기도 성남시 중원구 금광동', '1001', 1001, 0, 'e편한세상금빛그랑메종1단지', 59.98, 202408, 14, '80,500', '-', '1', '개인', '개인', '2023', '금광로 11', '중개거래', '아파트', '127.159571028887', '37.442960644558');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25571, '경기도 성남시 중원구 금광동', '1016', 1016, 0, 'e편한세상금빛그랑메종4단지', 59.98, 202408, 14, '85,000', '-', '14', '개인', '개인', '2023', '금광로 71', '중개거래', '아파트', '127.166480621712', '37.4449952439451');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16124, '경기도 화성시 남양읍 남양리', '2195', 2195, 0, 'e편한세상남양뉴타운', 84.9339, 202408, 21, '45,000', '-', '12', '개인', '개인', '2022', '남양로862번길 42', '중개거래', '아파트', '126.836822931163', '37.2113967397415');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4203, '경기도 의정부시 가능동', '847', 847, 0, 'e편한세상녹양역', 59.9802, 202409, 1, '38,300', '-', '23', '개인', '개인', '2019', '녹양로34번길 47', '중개거래', '아파트', '127.034925101207', '37.7543945944383');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8851, '충청북도 단양군 단양읍 도전리', '682', 682, 0, 'e편한세상단양리버비스타', 84.8608, 202408, 27, '30,500', '104동', '20', '개인', '개인', '2023', '군청로 21', '직거래', '아파트', '128.366227355966', '36.9807731169628');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16588, '서울특별시 금천구 독산동', '1007-13', 1007, 13, 'e편한세상독산더타워', 59.8637, 202408, 21, '71,000', '-', '7', '개인', '개인', '2019', '범안로 1212', '중개거래', '아파트', '126.896264072547', '37.4660352420573');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26149, '전북특별자치도 군산시 조촌동', '3967', 3967, 0, 'e편한세상디오션시티2차', 84.9427, 202408, 14, '41,150', '-', '12', '개인', '개인', '2020', '궁포1로 82', '중개거래', '아파트', '126.746859758159', '35.9778214973617');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8464, '광주광역시 동구 소태동', '1113', 1113, 0, 'e편한세상무등산', 84.9508, 202408, 28, '45,000', '-', '15', '개인', '개인', '2022', '지원로42번길 10', '중개거래', '아파트', '126.937087949661', '35.1239846228107');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1044, '경상남도 밀양시 삼문동', '760', 760, 0, 'e편한세상밀양삼문', 84.9676, 202409, 7, '38,900', '-', '28', '개인', '개인', '2018', '미리벌중앙로 10', '중개거래', '아파트', '128.752859528538', '35.4798766189951');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17937, '충청남도 보령시 동대동', '1981', 1981, 0, 'e편한세상보령', 84.9414, 202408, 20, '33,700', '-', '11', '개인', '개인', '2017', '한내로터리길 170', '중개거래', '아파트', '126.617338329689', '36.353015367161');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14550, '충청남도 천안시 동남구 봉명동', '204-3', 204, 3, 'e편한세상봉명아너리움', 59.8035, 202408, 22, '27,600', '107동', '6', '개인', '개인', '2020', '쌍용대로 160', '중개거래', '아파트', '127.134644711525', '36.8124230833361');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20286, '인천광역시 부평구 부개동', '531', 531, 0, 'e편한세상부평역어반루체', 59.993, 202408, 17, '44,800', '-', '4', '개인', '개인', '2022', '경인로1024번길 21', '중개거래', '아파트', '126.733936574214', '37.4860654448846');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8373, '서울특별시 동작구 상도동', '903', 903, 0, 'e편한세상상도노빌리티', 59.5905, 202408, 28, '143,000', '-', '27', '개인', '개인', '2018', '만양로 6', '중개거래', '아파트', '126.946788478219', '37.5049818982281');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15645, '서울특별시 관악구 봉천동', '1730-1', 1730, 1, 'e편한세상서울대입구2단지', 84.93, 202408, 22, '117,500', '206', '8', '개인', '개인', '2019', '청룡16길 43', '중개거래', '아파트', '126.943195705239', '37.4766334506936');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24882, '서울특별시 관악구 봉천동', '1733', 1733, 0, 'e편한세상서울대입구2차', 116.72, 202408, 15, '140,000', '-', '3', '개인', '개인', '2020', '참숯1길 19', '중개거래', '아파트', '126.94238244228', '37.477304218918');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7603, '경상북도 영천시 완산동', '1436', 1436, 0, 'e편한세상센텀스타시티영천1블럭', 84.7086, 202408, 28, '30,700', '102동', '18', '개인', '개인', '2021', '완산9길 15', '중개거래', '아파트', '128.942083563667', '35.9621519309106');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19489, '부산광역시 서구 암남동', '419', 419, 0, 'e편한세상송도더퍼스트비치', 59.944, 202408, 19, '37,817', '-', '19', '개인', '개인', '2024', '충무대로21번길 9', '직거래', '아파트', '129.015072978936', '35.0755106315152');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20011, '서울특별시 송파구 거여동', '696', 696, 0, 'e편한세상송파파크센트럴', 113.63, 202408, 18, '175,000', '-', '15', '개인', '개인', '2021', '오금로 551', '중개거래', '아파트', '127.150367774224', '37.4931824051771');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13986, '경기도 구리시 수택동', '437', 437, 0, 'e편한세상수택센트럴파크', 74.938, 202408, 23, '79,400', '-', '4', '개인', '개인', '2020', '안골로64번길 10', '중개거래', '아파트', '127.138025856953', '37.5965411057161');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6277, '전라남도 순천시 용당동', '764', 764, 0, 'e편한세상순천1단지', 84.9902, 202408, 30, '42,500', '-', '16', '개인', '개인', '2020', '용당삼산로 29', '중개거래', '아파트', '127.489079531552', '34.9740382408581');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12971, '서울특별시 서대문구 북아현동', '1013', 1013, 0, 'e편한세상신촌2단지', 84.93, 202408, 24, '174,000', '-', '12', '개인', '개인', '2018', '북아현로1길 17', '중개거래', '아파트', '126.953450474616', '37.5586677131962');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19471, '서울특별시 서대문구 북아현동', '1013', 1013, 0, 'e편한세상신촌4단지', 59.9, 202408, 19, '151,000', '-', '24', '개인', '개인', '2018', '신촌로35길 10', '중개거래', '아파트', '126.955860405605', '37.558621696785');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16879, '부산광역시 연제구 연산동', '2380', 2380, 0, 'e편한세상연산더퍼스트', 84.9967, 202408, 20, '55,500', '-', '5', '개인', '개인', '2021', '반송로 40', '중개거래', '아파트', '128.661493806406', '35.241318041161');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18022, '경기도 연천군 연천읍 옥산리', '860', 860, 0, 'e편한세상연천웰스하임', 74.9205, 202408, 20, '26,765', '-', '18', '개인', '법인', '2023', '차옥로 149', '중개거래', '아파트', '127.07890717172', '38.1050867106306');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22974, '인천광역시 중구 중산동', '1871-1', 1871, 1, 'e편한세상영종국제도시센텀베뉴', 98.0214, 202408, 16, '66,000', '-', '10', '개인', '개인', '2023', '하늘달빛로 139', '중개거래', '아파트', '126.551790348911', '37.489996426937');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17540, '경기도 수원시 영통구 망포동', '726', 726, 0, 'e편한세상영통2차(1단지)', 74.5822, 202408, 20, '63,500', '-', '18', '개인', '개인', '2016', '봉영로 1410-17', '중개거래', '아파트', '127.063969666393', '37.2396132032104');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3727, '경기도 광주시 신현동', '1232', 1232, 0, 'e편한세상오포3차', 79.04, 202409, 2, '64,500', '-', '7', '개인', '개인', '2016', '신현로 20', '중개거래', '아파트', '127.148925261411', '37.3591612558882');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19495, '부산광역시 기장군 일광읍 삼성리', '773', 773, 0, 'e편한세상일광', 74.9729, 202408, 19, '46,000', '-', '20', '개인', '개인', '2020', '해빛2로 21', '중개거래', '아파트', '129.226184066487', '35.2690584434882');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13871, '울산광역시 동구 전하동', '631-1', 631, 1, 'e편한세상전하2단지', 84.99, 202408, 23, '41,500', '-', '10', '개인', '개인', '2013', '봉수로 290', '중개거래', '아파트', '129.423555658089', '35.5125072671002');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21173, '경기도 평택시 동삭동', '416', 416, 0, 'e편한세상지제역', 74.7074, 202408, 17, '51,000', '-', '22', '개인', '개인', '2022', '지제동삭1로 220', '중개거래', '아파트', '127.086671621137', '37.016098104306');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9314, '서울특별시 용산구 청암동', '181', 181, 0, 'GS자이', 157.43, 202408, 27, '230,000', '-', '11', '개인', '개인', '2005', '삼개로 60', '중개거래', '아파트', '126.947642942696', '37.5350715443607');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (756, '서울특별시 영등포구 대림동', '1101-7', 1101, 7, 'G밸리소홈', 16.1, 202409, 7, '15,000', '-', '12', '개인', '개인', '2018', '도림천로19길 11', '직거래', '아파트', '126.900207675003', '37.486586968186');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (26255, '제주특별자치도 서귀포시 서호동', '1545', 1545, 0, 'HausD블루오션', 84.94, 202408, 13, '45,500', '-', '7', '개인', '개인', '2015', '서호남로 92-16', '중개거래', '아파트', '126.519792813276', '33.2480114788051');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18347, '충청남도 당진시 송악읍 반촌리', '985', 985, 0, 'HB한빛101동', 59.98, 202408, 19, '11,000', 'HB한빛아파트101', '5', '개인', '개인', '2007', '반촌로 125', '직거래', '아파트', '126.696986087498', '36.9045418347547');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7780, '충청남도 당진시 송악읍 반촌리', '986', 986, 0, 'HB한빛102동', 59.94, 202408, 28, '12,500', '-', '8', '개인', '개인', '2007', '반촌로 125', '직거래', '아파트', '126.696986087498', '36.9045418347547');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5632, '전북특별자치도 정읍시 상동', '119-3', 119, 3, 'JK힐스타운', 80.36, 202408, 31, '21,000', '-', '4', '개인', '개인', '2015', '하신경5길 37', '중개거래', '아파트', '126.870164007567', '35.5640171015229');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3807, '제주특별자치도 제주시 삼도이동', '14-7', 14, 7, 'JNC패밀리3차', 84.8497, 202409, 2, '30,500', '-', '4', '개인', '개인', '2013', '북성로 14', '직거래', '아파트', '128.744324481203', '35.4981493190297');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14041, '경기도 남양주시 별내동', '1072', 1072, 0, 'KCC스위첸', 116.861, 202408, 23, '79,500', '-', '9', '개인', '개인', '2012', '별내5로 81', '중개거래', '아파트', '127.116795681766', '37.6574314086709');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18824, '울산광역시 울주군 삼남읍 교동리', '1678-1', 1678, 1, 'KTX울산역우성스마트시티뷰', 84.9939, 202408, 19, '38,300', '-', '4', '개인', '개인', '2018', '울산역로 300', '중개거래', '아파트', '129.128473261418', '35.5597114787397');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13216, '서울특별시 강남구 삼성동', '142-7', 142, 7, 'LG선릉에클라트(A)', 36.16, 202408, 24, '33,000', '-', '4', '개인', '개인', '2003', '선릉로100길 42', '중개거래', '아파트', '127.050848399493', '37.5065447414109');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20119, '서울특별시 강남구 삼성동', '142-3', 142, 3, 'LG선릉에클라트(B)', 36.35, 202408, 17, '32,000', '-', '13', '개인', '개인', '2004', '테헤란로63길 12', '중개거래', '아파트', '127.050947634813', '37.5061147390354');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11323, '대구광역시 동구 지묘동', '1386', 1386, 0, 'LH뉴웰시티', 59.99, 202408, 25, '24,800', '-', '13', '개인', '개인', '2021', '동화천로77길 30', '중개거래', '아파트', '128.632135889393', '35.9416232491266');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17564, '경기도 성남시 중원구 도촌동', '700', 700, 0, 'LH동분당센트럴파크', 84.99, 202408, 20, '85,000', '-', '4', '개인', '기타', '2010', '도촌남로 22', '중개거래', '아파트', '127.148285002374', '37.4141393987401');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22773, '경기도 화성시 장지동', '917', 917, 0, 'LH동탄호수하우스디', 84.97, 202408, 16, '66,900', '-', '17', '개인', '개인', '2021', '동탄대로1길 66', '중개거래', '아파트', '127.097870366858', '37.1619957219568');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15067, '경기도 동두천시 송내동', '664-1', 664, 1, 'LH지행역더퍼스트', 59.99, 202408, 22, '25,000', '-', '13', '개인', '개인', '2021', '이담로 10', '중개거래', '아파트', '127.048822785142', '37.8883288726383');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13438, '서울특별시 도봉구 창동', '635-42', 635, 42, 'LIG건영캐스빌', 80.1498, 202408, 23, '64,500', '-', '10', '개인', '개인', '2002', '우이천로20길 7', '중개거래', '아파트', '127.034771563448', '37.6417332058849');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14081, '경기도 화성시 반송동', '96', 96, 0, 'METAPOLIS', 161.891, 202408, 23, '155,000', '-', '57', '개인', '개인', '2010', '동탄중앙로 220', '중개거래', '아파트', '127.069311476941', '37.2048573925088');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6699, '서울특별시 종로구 창신동', '601', 601, 0, 'MID그린(1동)', 59.55, 202408, 29, '44,300', '-', '7', '개인', '개인', '2002', '창신길 140-21', '중개거래', '아파트', '127.010001336653', '37.5781604969248');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15817, '경기도 수원시 영통구 영통동', '1025-7', 1025, 7, 'myown', 14.235, 202408, 21, '9,700', '-', '3', '개인', '개인', '2014', '청명로 8', '중개거래', '아파트', '127.07949238307', '37.2484715250826');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (771, '인천광역시 서구 청라동', '155-12', 155, 12, 'NPART', 117.951, 202409, 7, '67,000', '-', '3', '개인', '개인', '2011', '청라커낼로 249', '중개거래', '아파트', '126.64338957328', '37.5305187968065');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4050, '대전광역시 유성구 봉명동', '549-1', 549, 1, 'SCIENCETOWN', 70.3303, 202409, 2, '29,000', '-', '32', '개인', '개인', '2013', '온천로 60', '중개거래', '아파트', '127.344307826696', '36.3545408428681');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19107, '인천광역시 부평구 부평동', '415-7', 415, 7, 'SC제일행복해아파트', 44.55, 202408, 19, '16,500', '-', '8', '개인', '개인', '2016', '주부토로 52', '중개거래', '아파트', '126.72552683816', '37.499491807574');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16709, '대구광역시 북구 읍내동', '1448', 1448, 0, 'SD아이프라임강북', 118.482, 202408, 21, '33,650', '-', '3', '개인', '개인', '2010', '칠곡중앙대로125길 7', '중개거래', '아파트', '128.551857868956', '35.9513688737557');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3108, '서울특별시 중랑구 상봉동', '128-10', 128, 10, 'SG타워', 84.92, 202409, 3, '53,000', '-', '9', '개인', '개인', '2004', '동일로 709', '중개거래', '아파트', '127.079839569194', '37.5936866783744');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23892, '경기도 평택시 합정동', '766-2', 766, 2, 'SKVIEW1단지', 104.9, 202408, 15, '28,500', '-', '10', '개인', '개인', '2007', '중앙로 176', '중개거래', '아파트', '126.870283295163', '37.6035593331849');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23039, '대전광역시 유성구 지족동', '894-5', 894, 5, 'SK허브', 111.18, 202408, 16, '41,000', '-', '7', '개인', '개인', '2006', '은구비남로 13', '중개거래', '아파트', '127.317066213559', '36.3725709688826');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5271, '부산광역시 동래구 온천동', '161-1', 161, 1, 'SK허브올리브', 53.29, 202408, 31, '18,500', '-', '16', '개인', '개인', '2006', '금강공원로 2', '중개거래', '아파트', '129.084118251771', '35.2185947957268');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3848, '서울특별시 강서구 화곡동', '920-5', 920, 5, 'SPACE(920-5)', 19.75, 202409, 2, '15,300', '-', '15', '개인', '개인', '2014', '곰달래로 86', '중개거래', '아파트', '126.842428629982', '37.5301434410709');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1006, '경상남도 창원시 진해구 남양동', '20', 20, 0, 'STX칸', 84.9916, 202409, 7, '16,900', '-', '4', '개인', '개인', '2009', '월남로 142', '중개거래', '아파트', '128.780396210471', '35.1199864204725');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6233, '경상남도 창원시 마산회원구 내서읍 삼계리', '7', 7, 0, 'THE-푸른', 59.99, 202408, 30, '15,200', '-', '6', '개인', '개인', '1998', '삼계10길 22', '중개거래', '아파트', '128.502811193217', '35.2349142808915');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17748, '경기도 평택시 지산동', '750-1', 750, 1, 'THEH', 49.82, 202408, 20, '15,000', '-', '5', '개인', '개인', '2017', '지산1로70번길 11', '중개거래', '아파트', '127.05882727858', '37.0820914182744');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11553, '경기도 부천시 원미구 심곡동', '161-5', 161, 5, 'TK리즈빌', 56.73, 202408, 24, '33,000', '-', '13', '개인', '개인', '2019', '부천로 48', '중개거래', '아파트', '126.784146764005', '37.4884878486359');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21655, '경기도 양주시 고읍동', '77', 77, 0, 'TS푸른솔1차', 59.97, 202408, 17, '24,900', '-', '13', '개인', '개인', '1999', '부흥로 2021-7', '중개거래', '아파트', '127.081758997771', '37.8013734979929');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13020, '부산광역시 수영구 광안동', '744-18', 744, 18, 'W-PARK', 47.91, 202408, 24, '17,500', '-', '2', '개인', '개인', '2014', '장대골로7번길 51', '중개거래', '아파트', '129.112488326905', '35.1566269081924');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (136, '충청북도 청주시 흥덕구 강서동', '583', 583, 0, '가경아이파크5단지', 116.984, 202409, 9, '82,500', '-', '11', '개인', '개인', '2023', '서부로 1123', '중개거래', '아파트', '127.423990655042', '36.6123902682714');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6228, '경상남도 창원시 마산회원구 내서읍 상곡리', '194', 194, 0, '가고파', 43.105, 202408, 30, '5,150', '-', '3', '개인', '개인', '1993', '상곡로 35', '중개거래', '아파트', '128.501148267993', '35.242872713561');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4719, '전라남도 순천시 가곡동', '1032-1', 1032, 1, '가곡양우내안애아파트', 84.9675, 202408, 31, '25,700', '-', '13', '개인', '개인', '2013', '원가곡길 75', '중개거래', '아파트', '127.480965465799', '34.9851801028507');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25928, '경상북도 봉화군 봉화읍 내성리', '334', 334, 0, '가든목화', 59.84, 202408, 14, '3,800', '가', '6', '개인', '기타', '1996', '거촌로 55', '직거래', '아파트', '128.745754950484', '36.8925982733469');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5728, '세종특별자치시  고운동', '1395', 1395, 0, '가락마을16단지(에듀그린)', 59.9964, 202408, 30, '33,500', '-', '6', '개인', '개인', '2015', '만남로 187', '중개거래', '아파트', '127.238834881321', '36.5155457244987');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22705, '세종특별자치시  고운동', '2112', 2112, 0, '가락마을18단지', 100.899, 202408, 16, '58,500', '-', '11', '개인', '개인', '2018', '마음안1로 139', '중개거래', '아파트', '127.234213665742', '36.5215542252198');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21101, '세종특별자치시  고운동', '1708', 1708, 0, '가락마을3단지(호반베르디움)', 84.9893, 202408, 17, '48,000', '-', '12', '개인', '개인', '2014', '마음안로 47', '중개거래', '아파트', '127.236187890858', '36.5056254096208');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5331, '서울특별시 송파구 가락동', '8', 8, 0, '가락스타클래스', 115.94, 202408, 31, '133,500', '-', '15', '개인', '개인', '2007', '오금로 306', '중개거래', '아파트', '127.126114097948', '37.5028743435851');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20728, '서울특별시 송파구 가락동', '21-6', 21, 6, '가락쌍용(2차)', 59.88, 202408, 17, '104,000', '-', '20', '개인', '개인', '1999', '송이로15길 31', '중개거래', '아파트', '127.122168125123', '37.5021716517865');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13356, '서울특별시 송파구 가락동', '120-4', 120, 4, '가락우성2', 84.95, 202408, 23, '108,700', '-', '12', '개인', '개인', '2000', '중대로12길 35', '중개거래', '아파트', '127.125471424252', '37.4920155636208');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (117, '충청북도 청주시 흥덕구 가경동', '1758', 1758, 0, '가로수마을선광로즈웰', 84.9468, 202409, 10, '39,800', '-', '14', '개인', '개인', '2008', '서현중로 48', '중개거래', '아파트', '127.429110239826', '36.6230594714391');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (107, '충청북도 청주시 흥덕구 가경동', '1759', 1759, 0, '가로수마을호반베르디움', 84.9667, 202409, 10, '39,800', '-', '10', '개인', '개인', '2008', '서현중로 47', '중개거래', '아파트', '127.428179506184', '36.6228290659922');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10049, '경기도 수원시 장안구 정자동', '36-20', 36, 20, '가림', 93.73, 202408, 26, '38,000', '-', '9', '개인', '개인', '2007', '송정로76번길 14', '중개거래', '아파트', '127.005435317096', '37.2951848900075');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22347, '경기도 군포시 산본동', '1155-7', 1155, 7, '가야3주공', 42.75, 202408, 16, '20,000', '-', '13', '개인', '법인', '1993', '번영로 353', '중개거래', '아파트', '126.923598599561', '37.3468727271689');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (348, '부산광역시 부산진구 가야동', '128-1', 128, 1, '가야동원로얄듀크', 84.9889, 202409, 9, '43,000', '-', '18', '개인', '법인', '2013', '가야대로 531', '직거래', '아파트', '129.030183984771', '35.1540473007319');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2528, '충청남도 서산시 해미면 읍내리', '110-1', 110, 1, '가야아파트', 36.45, 202409, 4, '5,000', '-', '7', '개인', '개인', '1999', '일락골길 13', '직거래', '아파트', '126.550058721175', '36.7104788920944');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9119, '경기도 양주시 백석읍 복지리', '93-3', 93, 3, '가야아파트2단지', 59.97, 202408, 27, '12,900', '-', '12', '개인', '개인', '1997', '호명로 77', '중개거래', '아파트', '126.99214455936', '37.7863050109794');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6534, '부산광역시 부산진구 가야동', '611-5', 611, 5, '가야일산주택', 53.19, 202408, 30, '19,500', '-', '3', '개인', '개인', '1984', '가야대로510번길 78', '중개거래', '아파트', '129.027954447211', '35.1498119409945');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24633, '서울특별시 강서구 가양동', '1461', 1461, 0, '가양2단지(성지)', 39.6, 202408, 15, '60,000', '-', '7', '개인', '개인', '1992', '허준로 47', '중개거래', '아파트', '126.84658518265', '37.5710135675057');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20444, '서울특별시 강서구 등촌동', '726', 726, 0, '가양역두산위브', 59.98, 202408, 17, '90,400', '-', '13', '개인', '개인', '2022', '공항대로45길 15', '중개거래', '아파트', '126.854556711293', '37.5562925590397');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23859, '세종특별자치시  다정동', '970', 970, 0, '가온마을11단지(세종지웰푸르지오)', 74.2745, 202408, 15, '49,400', '-', '5', '개인', '개인', '2019', '가온로 10', '중개거래', '아파트', '127.254620635302', '36.4918347730363');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14129, '세종특별자치시  다정동', '931', 931, 0, '가온마을8단지(더하이스트)', 59.8817, 202408, 23, '43,800', '-', '8', '개인', '개인', '2018', '다정북로 180', '중개거래', '아파트', '127.250482489197', '36.4955050217996');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20233, '인천광역시 서구 경서동', '727-1', 727, 1, '가이아샹베르2차', 84.5496, 202408, 17, '34,700', '-', '8', '개인', '개인', '2005', '경서로31번길 47', '중개거래', '아파트', '126.651125447793', '37.5573676792338');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18859, '세종특별자치시  종촌동', '656', 656, 0, '가재마을10단지', 84.9365, 202408, 19, '52,000', '-', '6', '개인', '개인', '2014', '도움1로 74', '중개거래', '아파트', '127.253290300919', '36.5018458449445');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11953, '세종특별자치시  종촌동', '683', 683, 0, '가재마을2단지', 59.8652, 202408, 24, '35,500', '-', '4', '개인', '개인', '2014', '달빛1로 39', '중개거래', '아파트', '127.244572431579', '36.502175384169');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1415, '경기도 고양시 일산서구 가좌동', '1090', 1090, 0, '가좌마을1단지양우', 84.6399, 202409, 6, '30,000', '-', '3', '개인', '개인', '2005', '가좌4로 29', '중개거래', '아파트', '126.716501079359', '37.6851663384123');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17434, '경기도 고양시 일산서구 가좌동', '1089', 1089, 0, '가좌마을2단지대우', 84.8566, 202408, 20, '34,000', '-', '17', '개인', '개인', '2005', '가좌3로 45', '중개거래', '아파트', '126.716976231954', '37.6884429733186');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9033, '경상남도 진주시 가좌동', '660', 660, 0, '가좌주공2차', 44.94, 202408, 27, '12,300', '212', '1', '개인', '개인', '1993', '가호로 26', '중개거래', '아파트', '128.110499072524', '35.1628599327687');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12828, '대구광역시 달성군 가창면 용계리', '465', 465, 0, '가창중석타운', 84.98, 202408, 24, '16,000', '-', '4', '개인', '개인', '1997', '가창로 1008', '중개거래', '아파트', '128.627271011893', '35.796623037106');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (856, '경기도 성남시 수정구 태평동', '7343', 7343, 0, '가천대역동부센트레빌1단지', 68.38, 202409, 7, '62,500', '-', '14', '개인', '개인', '2006', '태평로 28', '중개거래', '아파트', '127.129983636439', '37.4478640729627');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22588, '경기도 성남시 수정구 태평동', '7344', 7344, 0, '가천대역동부센트레빌2단지', 84.91, 202408, 16, '84,000', '-', '11', '개인', '개인', '2007', '제일로 244', '중개거래', '아파트', '127.129088685735', '37.4475914160259');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7068, '경기도 성남시 수정구 태평동', '7342', 7342, 0, '가천대역쌍용스윗닷홈', 84.7957, 202408, 29, '60,000', '103', '6', '개인', '개인', '2005', '태평로 9', '중개거래', '아파트', '127.128186057201', '37.448312488422');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14786, '경기도 가평군 가평읍 읍내리', '766-3', 766, 3, '가평블루핀', 63.1818, 202408, 22, '17,700', '-', '2', '개인', '개인', '2019', '가화로 219', '중개거래', '아파트', '127.507579124413', '37.8378231999531');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (14362, '경기도 가평군 가평읍 읍내리', '457-5', 457, 5, '가평센트럴파크더스카이', 59.377, 202408, 23, '23,000', '-', '5', '개인', '개인', '2022', '보납로 11', '중개거래', '아파트', '127.512140809', '37.8312318617132');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (19784, '경상남도 진주시 가좌동', '1936', 1936, 0, '가호에일린의뜰', 84.9982, 202408, 18, '42,900', '-', '15', '개인', '개인', '2012', '강변길 31', '중개거래', '아파트', '128.109354934258', '35.1654981611534');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (333, '울산광역시 울주군 온산읍 덕신리', '184-1', 184, 1, '가화파티오', 84.8939, 202409, 9, '24,500', '-', '11', '개인', '개인', '2008', '영남길 26', '중개거래', '아파트', '129.309952121444', '35.438700967661');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16885, '서울특별시 금천구 독산동', '1093-5', 1093, 5, '각산', 84.78, 202408, 20, '50,700', '-', '4', '개인', '개인', '2002', '한내로 52', '중개거래', '아파트', '126.886989161084', '37.4559702749684');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11222, '광주광역시 북구 각화동', '587', 587, 0, '각화골드클래스', 84.9528, 202408, 25, '36,000', '-', '4', '개인', '개인', '2017', '각화대로69번길 16', '중개거래', '아파트', '126.939058476805', '35.1804446960892');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20858, '경기도 구리시 갈매동', '626', 626, 0, '갈매와이시티', 84.96, 202408, 17, '66,500', '-', '4', '개인', '개인', '2017', '갈매중앙로 45', '중개거래', '아파트', '127.114984210567', '37.6292529400707');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (4852, '경기도 이천시 갈산동', '789', 789, 0, '갈산화성파크드림', 116.719, 202408, 31, '54,000', '-', '12', '개인', '개인', '2013', '안흥로 67', '중개거래', '아파트', '127.454639587873', '37.28427516546');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15364, '부산광역시 사하구 감천동', '682', 682, 0, '감천백산', 81.78, 202408, 22, '17,000', '-', '19', '개인', '개인', '1995', '감천로 32', '중개거래', '아파트', '128.995825878518', '35.0905945623474');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17016, '부산광역시 사하구 감천동', '789', 789, 0, '감천유림2차', 146.05, 202408, 20, '26,600', '-', '21', '개인', '개인', '1999', '사하로 80', '중개거래', '아파트', '128.994593048433', '35.089103751456');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21780, '경상남도 김해시 진영읍 진영리', '348', 348, 0, '갑목빙그레(101동102동)', 57.18, 202408, 17, '6,300', '102', '6', '개인', '개인', '1995', '진영로 88-7', '중개거래', '아파트', '128.722278282856', '35.3035002697847');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (3648, '경상남도 김해시 대청동', '291-1', 291, 1, '갑오마을1단지대우푸르지오3', 101.924, 202409, 2, '27,300', '-', '4', '개인', '개인', '2005', '계동로 138', '중개거래', '아파트', '128.795487689322', '35.1880510533936');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1369, '경상남도 김해시 대청동', '333-3', 333, 3, '갑오마을4단지부영8차', 80.7474, 202409, 6, '14,600', '-', '9', '개인', '개인', '2002', '계동로102번길 24', '중개거래', '아파트', '128.798021645537', '35.184562733234');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22448, '경기도 용인시 기흥구 구갈동', '543', 543, 0, '강남마을코오롱하늘채수', 153.33, 202408, 16, '59,700', '-', '4', '개인', '개인', '2004', '강남서로 94', '중개거래', '아파트', '127.129491921189', '37.2793585385456');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (575, '서울특별시 강남구 역삼동', '902', 902, 0, '강남센트럴아이파크', 125.413, 202409, 8, '430,000', '-', '14', '개인', '개인', '2022', '테헤란로44길 26', '중개거래', '아파트', '127.045717100228', '37.5012057685259');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20223, '서울특별시 강남구 자곡동', '602', 602, 0, '강남자곡아이파크', 59.96, 202408, 17, '136,000', '-', '13', '개인', '개인', '2014', '자곡로 175', '중개거래', '아파트', '127.102642242027', '37.4742742244507');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20871, '울산광역시 남구 선암동', '626', 626, 0, '강남파크맨션', 63.99, 202408, 17, '13,300', '-', '9', '개인', '개인', '1991', '두왕로190번길 50', '중개거래', '아파트', '129.315923395705', '35.5171234191742');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13970, '울산광역시 중구 서동', '61-2', 61, 2, '강동그린타워', 82.84, 202408, 23, '12,000', '-', '7', '개인', '개인', '1995', '병영성4길 142', '직거래', '아파트', '129.346228436819', '35.5799559705149');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12497, '서울특별시 강동구 천호동', '155-5', 155, 5, '강동역두산위브센티움', 59.96, 202408, 24, '64,700', '-', '5', '개인', '개인', '2004', '성안로 155', '중개거래', '아파트', '127.134759480647', '37.5372361473065');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13413, '서울특별시 강동구 길동', '414-10', 414, 10, '강동한신휴플러스', 84.98, 202408, 23, '64,500', '-', '8', '개인', '개인', '2006', '진황도로 99', '중개거래', '아파트', '127.137473996228', '37.5360846941657');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9705, '서울특별시 강동구 길동', '160', 160, 0, '강동헤리티지자이', 59.98, 202408, 26, '134,000', '-', '17', '개인', '법인', '2024', '천중로 264', '중개거래', '아파트', '127.149551483961', '37.5396196848963');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7306, '강원특별자치도 강릉시 홍제동', '1007', 1007, 0, '강릉홍제힐스테이트', 84.992, 202408, 29, '33,500', '-', '11', '개인', '개인', '2007', '토성로 39', '중개거래', '아파트', '127.114698219289', '37.530027347512');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24202, '강원특별자치도 강릉시 회산동', '610', 610, 0, '강릉회산한신더휴', 84.9955, 202408, 15, '38,000', '-', '18', '개인', '개인', '2019', '회산로 313', '중개거래', '아파트', '128.863292886268', '37.7379529455597');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (6223, '경기도 연천군 전곡읍 전곡리', '449-18', 449, 18, '강민', 34.98, 202408, 30, '4,800', '-', '2', '개인', '개인', '1997', '전영로11번길 26', '중개거래', '아파트', '127.067650145188', '38.031333701577');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16998, '대구광역시 동구 방촌동', '1102-2', 1102, 2, '강변1', 58.23, 202408, 20, '20,000', '105', '2', '개인', '개인', '1989', '동촌로54길 13', '중개거래', '아파트', '128.668036501339', '35.8788117149123');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15323, '대구광역시 동구 방촌동', '1113-8', 1113, 8, '강변2', 65.67, 202408, 22, '10,000', '201', '1', '개인', '개인', '1990', '동촌로56길 36', '직거래', '아파트', '128.66930811504', '35.8779379708605');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24746, '서울특별시 성동구 성수동1가', '710', 710, 0, '강변건영아파트', 84.952, 202408, 15, '203,000', '-', '5', '개인', '개인', '2002', '왕십리로 36', '중개거래', '아파트', '127.044276890259', '37.5404656250355');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23893, '울산광역시 울주군 범서읍 굴화리', '6-1', 6, 1, '강변그린빌(6-1)', 59.06, 202408, 15, '29,700', '-', '6', '개인', '개인', '2002', '울밀로 2879-7', '중개거래', '아파트', '129.262545389534', '35.5582395646924');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (17315, '서울특별시 성동구 성수동1가', '479-1', 479, 1, '강변동양', 84.14, 202408, 20, '260,000', '-', '1', '개인', '개인', '2001', '둘레길 21', '중개거래', '아파트', '127.046650629806', '37.537662691024');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2169, '대전광역시 서구 정림동', '641', 641, 0, '강변들보람', 84.93, 202409, 4, '22,000', '-', '3', '개인', '개인', '1996', '정림서로 162-18', '중개거래', '아파트', '127.36405058308', '36.3011950777348');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (22689, '경기도 김포시 고촌읍 신곡리', '1280', 1280, 0, '강변마을 월드메르디앙아파트', 116.092, 202408, 16, '61,300', '-', '5', '개인', '개인', '2010', '신곡로 48', '중개거래', '아파트', '126.77512611743', '37.6068396887655');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (15740, '울산광역시 남구 신정동', '319', 319, 0, '강변센트럴하이츠', 159.092, 202408, 21, '84,000', '-', '1', '개인', '개인', '2011', '중앙로290번길 53', '중개거래', '아파트', '129.314853857982', '35.5481353116438');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25348, '대구광역시 남구 봉덕동', '862', 862, 0, '강변코오롱하늘채', 84.9627, 202408, 14, '29,500', '-', '3', '개인', '개인', '2008', '봉덕로 134', '중개거래', '아파트', '128.447860934973', '36.6535588100571');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (12887, '대구광역시 남구 이천동', '214-456', 214, 456, '강변타운', 59.85, 202408, 24, '20,000', '-', '5', '개인', '개인', '1994', '명덕로68길 19', '중개거래', '아파트', '128.606513110524', '35.8544811642663');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (1591, '서울특별시 성동구 성수동2가', '400', 400, 0, '강변현대', 81.8, 202409, 6, '233,000', '-', '7', '개인', '개인', '1994', '둘레11길 1', '중개거래', '아파트', '127.050825417873', '37.5365295818816');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25347, '대구광역시 남구 봉덕동', '1635', 1635, 0, '강변효성백년가약', 122.603, 202408, 14, '52,500', '106', '13', '개인', '개인', '2012', '봉덕로 135', '중개거래', '아파트', '128.604543876633', '35.8446591463275');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9503, '대구광역시 북구 읍내동', '1452', 1452, 0, '강북태왕아너스더퍼스트', 62.4891, 202408, 27, '32,300', '-', '13', '개인', '개인', '2021', '칠곡중앙대로110길 10', '중개거래', '아파트', '128.552096888618', '35.9432203054595');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25511, '울산광역시 남구 신정동', '1586-13', 1586, 13, '강산리더스', 78.8099, 202408, 14, '42,500', '-', '4', '개인', '법인', '2011', '봉월로67번길 46', '중개거래', '아파트', '129.300757828697', '35.5397715890473');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (7869, '울산광역시 울주군 온산읍 덕신리', '1346-12', 1346, 12, '강산리더스3차', 84.7221, 202408, 28, '22,000', '-', '2', '개인', '개인', '2008', '서영남2길 18', '중개거래', '아파트', '129.305394867465', '35.4378549586495');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (18, '부산광역시 연제구 연산동', '478-19', 478, 19, '강산마을', 74.38, 202409, 10, '11,000', '-', '3', '개인', '개인', '2002', '고분로235번길 31', '중개거래', '아파트', '129.107795846144', '35.1859484107933');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16493, '강원특별자치도 평창군 대관령면 횡계리', '366-8', 366, 8, '강산횡계', 59.4, 202408, 21, '10,100', '-', '8', '개인', '개인', '1994', '대관령로 46-4', '중개거래', '아파트', '128.701821004024', '37.6746073946881');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (9354, '서울특별시 강서구 염창동', '308', 308, 0, '강서쌍용예가', 84.9025, 202408, 27, '96,000', '-', '3', '개인', '개인', '2014', '양천로 613', '중개거래', '아파트', '126.866376455791', '37.5552667767912');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (21092, '경기도 고양시 일산서구 주엽동', '84', 84, 0, '강선마을15단지보성', 70.47, 202408, 17, '53,000', '-', '9', '개인', '개인', '1994', '강선로 30', '중개거래', '아파트', '126.76313345678', '37.6668539651765');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (23530, '경기도 고양시 일산서구 주엽동', '86', 86, 0, '강선마을16단지동문', 84.225, 202408, 15, '57,000', '1604', '10', '개인', '개인', '1993', '주화로 7', '중개거래', '아파트', '126.765318014775', '37.6663490086214');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (25671, '경기도 고양시 일산서구 주엽동', '38', 38, 0, '강선마을2단지경남', 129.09, 202408, 14, '66,000', '208', '5', '개인', '개인', '1994', '강선로 116', '중개거래', '아파트', '126.767782852843', '37.6733680926696');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2973, '경기도 고양시 일산서구 주엽동', '46', 46, 0, '강선마을4단지동신', 59.49, 202409, 3, '38,500', '-', '8', '개인', '개인', '1993', '대산로 53', '직거래', '아파트', '126.771047830183', '37.67097427051');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (16638, '서울특별시 강동구 강일동', '695', 695, 0, '강일리버파크10단지', 84.74, 202408, 21, '93,000', '-', '13', '개인', '개인', '2009', '고덕로97길 20', '중개거래', '아파트', '127.179997616634', '37.5592084943697');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (8205, '서울특별시 강동구 강일동', '674', 674, 0, '강일리버파크3단지', 59.87, 202408, 28, '80,500', '-', '2', '개인', '개인', '2009', '아리수로93길 40', '중개거래', '아파트', '127.175106641578', '37.5655171416703');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (10887, '전라남도 강진군 군동면 호계리', '1295', 1295, 0, '강진코아루블루핀아파트', 84.995, 202408, 25, '28,600', '-', '13', '개인', '개인', '2020', '백금포길 8', '중개거래', '아파트', '126.783432483684', '34.6419084157969');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (13427, '대구광역시 달성군 다사읍 매곡리', '719-3', 719, 3, '강창한서꼼빠니아', 59.96, 202408, 23, '12,900', '-', '6', '개인', '개인', '1996', '달구벌대로 802-1', '중개거래', '아파트', '128.45943709386', '35.8607535509035');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (11954, '경기도 고양시 일산동구 마두동', '806', 806, 0, '강촌마을(한양6)', 35.1, 202408, 24, '17,800', '-', '19', '개인', '개인', '1998', '중앙로 1130', '중개거래', '아파트', '126.780207120567', '37.6501177027389');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (5594, '부산광역시 부산진구 개금동', '523-27', 523, 27, '개금동포르투나', 74.0806, 202408, 31, '33,700', '-', '9', '개인', '개인', '2019', '복지로 15', '중개거래', '아파트', '126.786561433687', '37.44168162187');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (20211, '부산광역시 부산진구 개금동', '796', 796, 0, '개금롯데캐슬', 84.9542, 202408, 17, '48,800', '-', '21', '개인', '개인', '2010', '개금온정로 10', '중개거래', '아파트', '129.027322196214', '35.1548022955911');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (2255, '부산광역시 부산진구 개금동', '165-2', 165, 2, '개금역대상웰리움', 80.7212, 202409, 4, '25,000', '-', '3', '개인', '개인', '2017', '가야대로498번길 14', '중개거래', '아파트', '129.02610730878', '35.1524578679999');
INSERT INTO estate.address_price (no, sigungu, bunji, bonbun, bubun, apart_name, spacial, con_month, con_date, price, dong, floor, buyer, seller, build_year, doro_juso, type_trade, type_build, x_coordinate, y_coordinate) VALUES (24481, '부산광역시 부산진구 개금동', '53-1', 53, 1, '개금주공1', 31.98, 202408, 15, '15,000', '-', '1', '개인', '개인', '1987', '백양대로208번길 25', '중개거래', '아파트', '129.025642105969', '35.1594857551659');
