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
    member_sex tinyint NOT NULL,
    member_age int NOT NULL,
    member_birthday date NOT NULL,
    member_phone varchar(50) NOT NULL,
    member_role varchar(50) NOT NULL,
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

select * from dictionary_tbl order by dictionary_title asc
