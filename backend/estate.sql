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
      location_no int,
      property_addr_sigungu varchar(200) NOT NULL,
      property_addr_bunji varchar(50),
      property_addr_bonbun int,
      property_addr_bubun int,
      property_addr_apt_name varchar(50),
      property_area float NOT NULL,
      contract_year_month int,
      contract_date int,
      price varchar(50),
      property_addr_apt_dong varchar(50),
      property_addr_floor int,
      building_year varchar(50),
      property_doro_juso    VARCHAR(50) NOT NULL,
      contract_type varchar(50),
      building_type varchar(50) NOT NULL,
      deposit int,
      rent int
);

DROP TABLE IF EXISTS property_location;
CREATE TABLE property_location (
       location_no int AUTO_INCREMENT PRIMARY KEY,
       road_name VARCHAR(255) NOT NULL,
       recent_price VARCHAR(255) NOT NULL,
       recent_date int NOT NULL,
       x_coordinate VARCHAR(255),
       y_coordinate VARCHAR(255)
);
-- 인덱스 추가 (성능 향상)
CREATE INDEX idx_address_distinct_road_name ON property_location(road_name);


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

#부동산 매물
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (1, '대구광역시 달서구 유천동', '298-1', 298, 1, '대곡역화성파크드림', 84.8403, 202409, 10, '29,500', '-', 8, '2007', '달서대로 41', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (2, '대전광역시 서구 월평동', '508', 508, 0, '갤러리빌9차', 17.4302, 202409, 10, '4,800', '-', 12, '2013', '한밭대로570번길 33', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (3, '대구광역시 동구 신천동', '1511', 1511, 0, '동대구비스타동원', 84.9864, 202409, 10, '57,200', '-', 22, '2021', '화랑로 51', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (4, '대전광역시 서구 탄방동', '1486', 1486, 0, 'e편한세상둔산2단지', 72.471, 202409, 10, '59,500', '-', 3, '2020', '계룡로615번길 82', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (5, '대구광역시 동구 각산동', '389-2', 389, 2, '성지각산', 48.07, 202409, 10, '7,000', '-', 1, '1989', '반야월북로 155', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (6, '광주광역시 서구 쌍촌동', '1228-1', 1228, 1, '빛고을파크', 50.16, 202409, 10, '13,300', '-', 11, '1991', '화정로 105', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (7, '광주광역시 북구 임동', '104-8', 104, 8, '한국아델리움2차', 84.9308, 202409, 10, '37,500', '-', 5, '2007', '천변우로79번길 25', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (8, '광주광역시 북구 신용동', '869', 869, 0, '힐스테이트신용더리버', 84.77, 202409, 10, '40,000', '-', 11, '2024', '빛고을대로 615', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (9, '서울특별시 서대문구 남가좌동', '387', 387, 0, '디엠씨엘가', 13.03, 202409, 10, '13,900', '-', 4, '2017', '모래내로 151', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (10, '광주광역시 북구 일곡동', '850-5', 850, 5, '호반일신', 59.935, 202409, 10, '14,750', '-', 9, '1997', '설죽로 545', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (11, '부산광역시 강서구 명지동', '3415', 3415, 0, '명지국제신도시호반베르디움1차', 84.965, 202409, 10, '45,500', '-', 5, '2016', '명지국제5로 29', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (12, '인천광역시 연수구 연수동', '578-1', 578, 1, '세경', 51.75, 202409, 10, '22,900', '-', 13, '1997', '새말로 134', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (13, '인천광역시 서구 청라동', '160-1', 160, 1, '청라린스트라우스', 124.411, 202409, 10, '94,000', '-', 15, '2013', '청라라임로 85', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (14, '인천광역시 부평구 부평동', '70-123', 70, 123, '동아(2차)', 84.72, 202409, 10, '60,700', '-', 9, '1995', '부흥로 246', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (15, '대전광역시 중구 문화동', '757', 757, 0, '주공3', 39.87, 202409, 10, '8,500', '-', 7, '1994', '산성로 108-23', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (16, '서울특별시 성북구 돈암동', '639', 639, 0, '돈암힐스테이트', 112.42, 202409, 10, '100,000', '-', 3, '2007', '아리랑로 68', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (17, '대구광역시 동구 신서동', '823-7', 823, 7, '신서그린빌', 59.8231, 202409, 10, '14,800', '-', 2, '2001', '반야월북로 251', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (18, '부산광역시 연제구 연산동', '478-19', 478, 19, '강산마을', 74.38, 202409, 10, '11,000', '-', 3, '2002', '고분로235번길 31', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (19, '인천광역시 남동구 간석동', '917-2', 917, 2, '두진', 59.43, 202409, 10, '18,000', '-', 3, '1994', '호구포로899번길 8', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (20, '부산광역시 사하구 구평동', '518', 518, 0, 'e편한세상사하2차', 84.9552, 202409, 10, '36,800', '-', 15, '2017', '서포로30번길 12', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (21, '인천광역시 서구 신현동', '302-1', 302, 1, '루원e-편한세상하늘채아파트', 59.999, 202409, 10, '44,000', '-', 15, '2010', '가정로 387', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (22, '서울특별시 광진구 화양동', '530', 530, 0, '씨즈건대힐스', 14.23, 202409, 10, '17,000', '-', 2, '2017', '광나루로20길 17', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (23, '대구광역시 수성구 중동', '641', 641, 0, '수성효성해링턴플레이스', 84.9971, 202409, 10, '58,200', '-', 15, '2020', '희망로24길 24', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (24, '대구광역시 달서구 상인동', '1598', 1598, 0, '상인푸르지오', 59.699, 202409, 10, '25,800', '-', 15, '2010', '상화로 235', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (25, '대구광역시 달서구 감삼동', '521', 521, 0, '우방드림시티', 53.066, 202409, 10, '19,000', '-', 7, '2003', '장기로 242', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (26, '대구광역시 서구 평리동', '1676', 1676, 0, '평리롯데캐슬', 84.9639, 202409, 10, '30,000', '-', 6, '2009', '국채보상로 316', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (27, '대전광역시 서구 정림동', '584', 584, 0, '우성', 128.652, 202409, 10, '41,000', '-', 15, '1993', '정림서로 162-15', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (28, '부산광역시 영도구 동삼동', '1124', 1124, 0, '함지그린', 57.09, 202409, 10, '16,500', '-', 12, '1994', '함지로 8', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (29, '인천광역시 중구 항동7가', '27-107', 27, 107, '라이프비취2차', 54.71, 202409, 10, '9,500', '-', 13, '1981', '축항대로86번길 47', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (30, '경기도 광명시 철산동', '625', 625, 0, '도덕파크타운2단지', 49.98, 202409, 10, '54,500', '-', 8, '2001', '가림일로 101', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (31, '울산광역시 북구 매곡동', '966', 966, 0, '매곡에듀파크에일린의뜰', 84.9939, 202409, 10, '42,800', '-', 18, '2021', '신천로 103', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (32, '경기도 광주시 태전동', '697', 697, 0, '이편한세상태전2차(301~306동)', 74.4991, 202409, 10, '50,800', '-', 18, '2017', '태전동로 11', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (33, '울산광역시 북구 화봉동', '1485-2', 1485, 2, '울산송정금강펜테리움그린테라스1차', 84.2118, 202409, 10, '52,800', '-', 17, '2019', '화산로 75', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (34, '세종특별자치시  종촌동', '690', 690, 0, '가재마을5단지', 84.9424, 202409, 10, '53,000', '-', 18, '2014', '도움1로 105', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (35, '경기도 의정부시 가능동', '224-191', 224, 191, '브라운스톤흥선', 59.986, 202409, 10, '30,000', '-', 10, '2008', '호국로1142번길 22', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (36, '울산광역시 북구 화봉동', '1485-2', 1485, 2, '울산송정금강펜테리움그린테라스1차', 84.2118, 202409, 10, '52,800', '-', 17, '2019', '화산로 75', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (37, '경기도 고양시 덕양구 행신동', '697', 697, 0, '무원마을(기산)', 134.91, 202409, 10, '55,000', '-', 15, '1994', '무원로 41', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (38, '세종특별자치시  반곡동', '1035', 1035, 0, '수루배마을6단지', 59.9, 202409, 10, '34,700', '-', 2, '2019', '시청대로 598', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (39, '경기도 오산시 원동', '900', 900, 0, '오산역e-편한세상2단지', 84.9064, 202409, 10, '40,800', '-', 13, '2007', '오산로132번길 10', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (40, '세종특별자치시  반곡동', '1035', 1035, 0, '수루배마을6단지', 59.9, 202409, 10, '34,700', '-', 2, '2019', '시청대로 598', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (41, '경기도 화성시 봉담읍 동화리', '575', 575, 0, '동화마을동일하이빌', 140.866, 202409, 10, '56,000', '-', 6, '2008', '동화길 82', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (42, '울산광역시 동구 화정동', '949', 949, 0, '힐스테이트 이스턴베이', 84.9044, 202409, 10, '36,800', '-', 23, '2015', '화진길 100', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (43, '경기도 고양시 일산서구 탄현동', '1480', 1480, 0, '탄현마을(부영7)', 50.28, 202409, 10, '19,000', '-', 4, '1995', '탄현로 64', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (44, '울산광역시 북구 중산동', '200', 200, 0, '디아채', 123.786, 202409, 10, '29,000', '-', 5, '2007', '중산동로 37', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (45, '경기도 평택시 칠원동', '542', 542, 0, '평택지제역동문굿모닝힐맘시티1단지', 59.7056, 202409, 10, '29,000', '-', 16, '2019', '신촌1로 9', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (46, '경기도 수원시 영통구 매탄동', '1209', 1209, 0, 'e-편한세상', 101.709, 202409, 10, '56,000', '-', 23, '2010', '매봉로 20', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (47, '경기도 의정부시 가능동', '224-191', 224, 191, '브라운스톤흥선', 59.986, 202409, 10, '30,000', '-', 10, '2008', '호국로1142번길 22', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (48, '울산광역시 울주군 웅촌면 대복리', '302', 302, 0, '한솔그린빌', 49.93, 202409, 10, '5,300', '-', 10, '1997', '삼동로 1617', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (49, '울산광역시 남구 야음동', '594-10', 594, 10, '신정현대홈타운2', 114.6, 202409, 10, '45,000', '-', 19, '1999', '대암로 82', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (50, '경기도 광명시 하안동', '295', 295, 0, '주공7', 45.77, 202409, 10, '40,000', '-', 15, '1990', '금당로 13', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (51, '경기도 용인시 기흥구 동백동', '599', 599, 0, '모아미래도1단지아파트', 59.735, 202409, 10, '38,450', '-', 14, '2006', '동백8로 90', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (52, '대전광역시 유성구 전민동', '462-5', 462, 5, '세종', 75.29, 202409, 10, '23,500', '-', 12, '1994', '유성대로 1741', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (53, '경기도 수원시 장안구 정자동', '887-1', 887, 1, '화서역 우방 센트럴파크', 59.98, 202409, 10, '35,000', '-', 3, '1999', '수성로245번길 21', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (54, '경기도 의정부시 장암동', '20', 20, 0, '동아', 84.97, 202409, 10, '36,500', '-', 20, '1997', '장곡로 240', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (55, '경기도 화성시 영천동', '720', 720, 0, '동탄역포레너스', 84.5202, 202409, 10, '58,800', '-', 6, '2017', '동탄대로24길 199', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (56, '전북특별자치도 정읍시 수성동', '1027', 1027, 0, '부영2차', 58.779, 202409, 10, '9,800', '-', 14, '2000', '샘골로 158', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (57, '전북특별자치도 완주군 이서면 은교리', '851', 851, 0, '완주이서양우내안애퍼스트힐아파트', 74.2722, 202409, 10, '25,430', '-', 2, '2023', '원앙1길 50', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (58, '전북특별자치도 진안군 진안읍 군상리', '200-1', 200, 1, '진안군상고향마을', 84.62, 202409, 10, '16,500', '-', 8, '2006', '진장로 51-16', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (59, '전라남도 화순군 화순읍 일심리', '861', 861, 0, '서라4차', 59.915, 202409, 10, '9,200', '-', 13, '1997', '알메로 86', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (60, '경기도 여주시 현암동', '188-1', 188, 1, '벽산', 37.52, 202409, 10, '7,200', '-', 15, '1997', '도예로 35', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (61, '전북특별자치도 전주시 완산구 삼천동1가', '705-5', 705, 5, '우성', 120.315, 202409, 10, '19,000', '-', 5, '1993', '백제대로 13', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (62, '전북특별자치도 전주시 덕진구 인후동1가', '890-1', 890, 1, '인후꿈마을부영(2차)', 59.933, 202409, 10, '12,700', '-', 14, '1999', '무삼지로 40', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (63, '강원특별자치도 삼척시 남양동', '52', 52, 0, '세연상가', 53.25, 202409, 10, '7,000', '-', 4, '1995', '중앙시장1길 22-23', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (64, '충청북도 청주시 서원구 산남동', '669', 669, 0, '유승한내들', 59.8886, 202409, 10, '18,700', '-', 2, '2007', '두꺼비로 109', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (65, '경상북도 포항시 남구 오천읍 문덕리', '1359', 1359, 0, '신문덕코아루', 106.91, 202409, 10, '32,500', '-', 13, '2018', '해병로489번길 9', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (66, '경기도 여주시 홍문동', '353', 353, 0, '동원', 59.469, 202409, 10, '15,850', '-', 9, '2001', '세종로 173-69', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (67, '충청북도 청주시 흥덕구 복대동', '2456', 2456, 0, '아름다운나날영조1', 59.3291, 202409, 10, '18,800', '-', 6, '2003', '증안로 21', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (68, '경상남도 창원시 마산회원구 양덕동', '910', 910, 0, '한일3', 59.852, 202409, 10, '21,700', '-', 15, '2003', '삼호로 151', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (69, '전라남도 목포시 상동', '766', 766, 0, '주공2', 38.64, 202409, 10, '3,500', '-', 3, '1992', '상동로 43', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (70, '경상북도 경산시 중산동', '655', 655, 0, '펜타힐즈더샵2차', 84.9515, 202409, 10, '41,000', '-', 28, '2018', '펜타힐즈2로 40', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (71, '경상북도 구미시 구평동', '430', 430, 0, '부영1', 45.8895, 202409, 10, '7,100', '-', 1, '2001', '인동45길 7', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (72, '경기도 여주시 홍문동', '181', 181, 0, '홍문현대', 59.72, 202409, 10, '15,500', '-', 13, '1996', '세종로 61', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (73, '전북특별자치도 전주시 완산구 서신동', '762-2', 762, 2, '성원', 59.97, 202409, 10, '15,100', '-', 18, '1995', '서신천변11길 22', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (74, '충청남도 아산시 배방읍 공수리', '282-5', 282, 5, '아산한도', 39.9, 202409, 10, '6,400', '-', 11, '1997', '모산로126번길 17-26', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (75, '경기도 가평군 가평읍 읍내리', '637-3', 637, 3, '준수아파트A동', 84.99, 202409, 10, '12,000', '-', 3, '1992', '중촌로 16-55', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (76, '전라남도 광양시 광양읍 구산리', '832-1', 832, 1, '덕진광양의봄', 59.9576, 202409, 10, '15,700', '-', 9, '2013', '서평1길 9', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (77, '충청남도 아산시 탕정면 매곡리', '1391', 1391, 0, '한들물빛도시예미지', 84.6132, 202409, 10, '62,500', '-', 14, '2022', '한들물빛3로 14', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (78, '충청북도 충주시 용산동', '2627', 2627, 0, '동일하이빌', 84.516, 202409, 10, '28,500', '-', 3, '2008', '염밭로 22', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (79, '경상북도 포항시 남구 연일읍 생지리', '144', 144, 0, '영남비취타운3차(144)', 73.98, 202409, 10, '4,500', '-', 4, '1991', '형산강남로326번길 25', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (80, '전북특별자치도 전주시 완산구 평화동1가', '445-6', 445, 6, '평화주공1,2', 38.64, 202409, 10, '5,200', '-', 4, '1992', '덕적골2길 11', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (81, '전북특별자치도 익산시 남중동', '455-5', 455, 5, '이화남중', 58.32, 202409, 10, '6,000', '-', 12, '1993', '익산대로 255', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (82, '경상남도 거제시 고현동', '751-1', 751, 1, '송림', 54.36, 202409, 10, '7,000', '-', 5, '1986', '계룡로 168', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (83, '충청남도 아산시 용화동', '426', 426, 0, '백자', 76.68, 202409, 10, '9,000', '-', 2, '1993', '시민로 241', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (84, '충청남도 당진시 읍내동', '1486', 1486, 0, '당진2차푸르지오', 75.6427, 202409, 10, '22,700', '-', 6, '2016', '북문로 16', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (85, '경상남도 진주시 대곡면 광석리', '315-1', 315, 1, '대곡한양', 84.87, 202409, 10, '8,500', '-', 4, '1994', '진의로1079번길 13', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (86, '충청북도 제천시 신백동', '198-3', 198, 3, '화성2차아파트', 45.6, 202409, 10, '3,000', '-', 2, '1992', '신백로14길 21', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (87, '경상북도 경주시 현곡면 금장리', '447-1', 447, 1, '우남리버빌', 46.915, 202409, 10, '12,000', '-', 6, '2001', '금장2길 3', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (88, '강원특별자치도 동해시 쇄운동', '1100', 1100, 0, '아름다운아침', 60, 202409, 10, '9,350', '-', 3, '2012', '효자로 572-1', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (89, '충청북도 충주시 호암동', '905', 905, 0, '호암동수채', 84.9254, 202409, 10, '26,300', '-', 15, '2007', '호암중앙1로 47', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (90, '전라남도 목포시 대양동', '75-18', 75, 18, '근화희망타운3차', 39.84, 202409, 10, '5,850', '-', 6, '2000', '산양로 50', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (91, '전라남도 광양시 태인동', '397-1', 397, 1, '선미', 59.892, 202409, 10, '4,500', '-', 10, '1995', '담안2길 36-10', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (92, '전라남도 고흥군 고흥읍 남계리', '409-1', 409, 1, '장미2차', 59.58, 202409, 10, '10,100', '-', 7, '1996', '후동길 50', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (93, '전북특별자치도 전주시 덕진구 인후동1가', '858-1', 858, 1, '아중1차대우', 84.71, 202409, 10, '19,900', '-', 5, '1998', '석소로 77', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (94, '강원특별자치도 원주시 태장동', '580', 580, 0, '금광포란재1단지', 84.961, 202409, 10, '18,000', '-', 12, '2006', '포란재로 36', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (95, '충청남도 서산시 음암면 부산리', '729-9', 729, 9, '음암마을', 51.27, 202409, 10, '3,300', '-', 1, '1996', '서령로 330', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (96, '경상북도 영주시 휴천동', '1213', 1213, 0, '세영첼시빌', 84.9314, 202409, 10, '23,400', '-', 11, '2002', '남간로71번길 10', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (97, '강원특별자치도 동해시 용정동', '250-1', 250, 1, '승우', 84.89, 202409, 10, '9,100', '-', 1, '1993', '봉오동길 22', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (98, '경상북도 상주시 낙양동', '171-3', 171, 3, '대림아크로빌', 138.948, 202409, 10, '30,217', '-', 2, '2001', '상서문로 5', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (99, '전라남도 고흥군 도양읍 봉암리', '3948', 3948, 0, '고흥경보이-그린', 84.87, 202409, 10, '17,950', '-', 14, '2013', '천마로 163', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (100, '전북특별자치도 전주시 덕진구 만성동', '1290-1', 1290, 1, '제일풍경채', 103.032, 202409, 10, '56,900', '-', 7, '2018', '만성동로 48', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (101, '전북특별자치도 전주시 덕진구 만성동', '1367-1', 1367, 1, '골드클래스', 84.9525, 202409, 10, '50,000', '-', 12, '2018', '만성로 181', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (102, '경상남도 하동군 하동읍 읍내리', '1494-21', 1494, 21, '미도빌라', 71.49, 202409, 10, '6,000', '-', 3, '1991', '섬진강대로 2174', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (103, '충청북도 청주시 흥덕구 옥산면 가락리', '981', 981, 0, '청주리버파크자이', 84.933, 202409, 10, '36,000', '-', 29, '2019', '오송가락로 1056', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (104, '경상북도 경주시 용강동', '1291-3', 1291, 3, '보우근화', 65.88, 202409, 10, '9,900', '-', 4, '1993', '승삼2길 46', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (105, '충청남도 아산시 둔포면 석곡리', '1788', 1788, 0, '아산테크노밸리EGthe13단지', 72.345, 202409, 10, '21,500', '-', 22, '2016', '아산밸리중앙로 47', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (106, '충청북도 충주시 교현동', '144-28', 144, 28, '신원7', 33.93, 202409, 10, '3,400', '-', 4, '1990', '만리산로 33', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (107, '충청북도 청주시 흥덕구 가경동', '1759', 1759, 0, '가로수마을호반베르디움', 84.9667, 202409, 10, '39,800', '-', 10, '2008', '서현중로 47', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (108, '충청북도 청주시 상당구 방서동', '654', 654, 0, '청주센트럴자이', 84.8479, 202409, 10, '44,500', '-', 3, '2018', '단재로 316', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (109, '전북특별자치도 전주시 완산구 효자동3가', '1482-1', 1482, 1, '서곡주공', 59.85, 202409, 10, '14,000', '-', 9, '2000', '서곡로 8', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (110, '경상북도 구미시 송정동', '40', 40, 0, '로얄맨션', 50.36, 202409, 10, '7,750', '-', 1, '1990', '송원동로 35', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (111, '충청북도 청주시 흥덕구 비하동', '362', 362, 0, '효성2차', 59.86, 202409, 10, '13,300', '-', 7, '1997', '2순환로1050번길 24', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (112, '강원특별자치도 강릉시 노암동', '605', 605, 0, '노암3한라', 39.762, 202409, 10, '9,900', '-', 4, '2000', '남부로125번길 7', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (113, '충청북도 청주시 청원구 율량동', '2605', 2605, 0, '율량금호어울림센트로', 59.9396, 202409, 10, '31,300', '-', 6, '2022', '율천북로 91', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (114, '전북특별자치도 익산시 동산동', '667-1', 667, 1, '동산동제일2차아파트', 84.8211, 202409, 10, '14,500', '-', 15, '2001', '평동로17길 5', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (115, '경상남도 김해시 외동', '1251', 1251, 0, '내외대동한마음', 59.63, 202409, 10, '13,700', '-', 2, '1995', '함박로101번길 19', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (116, '강원특별자치도 횡성군 횡성읍 읍하리', '500', 500, 0, '금광포란채', 59.98, 202409, 10, '10,400', '-', 3, '2001', '읍하로25번길 17', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (117, '충청북도 청주시 흥덕구 가경동', '1758', 1758, 0, '가로수마을선광로즈웰', 84.9468, 202409, 10, '39,800', '-', 14, '2008', '서현중로 48', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (118, '전라남도 목포시 옥암동', '964', 964, 0, '우미2', 59.94, 202409, 10, '9,000', '-', 6, '1994', '삼향천로 113', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (119, '강원특별자치도 횡성군 횡성읍 읍하리', '500', 500, 0, '금광포란채', 59.98, 202409, 10, '10,800', '-', 11, '2001', '읍하로25번길 17', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (120, '경상남도 김해시 주촌면 선지리', '1476', 1476, 0, '김해 센텀Q시티', 59.9625, 202409, 10, '20,000', '-', 18, '2018', '선지로 85', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (121, '경기도 양주시 백석읍 오산리', '296', 296, 0, '한승리메이드', 84.86, 202409, 9, '17,000', '-', 3, '2001', '권율로 1455-15', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (122, '강원특별자치도 강릉시 교동', '313-1', 313, 1, '서일용궁맨션', 79.26, 202409, 9, '15,000', '-', 7, '1990', '율곡로 2982-7', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (123, '경상북도 문경시 흥덕동', '337-21', 337, 21, '주은우방', 68.075, 202409, 9, '11,800', '-', 8, '1994', '흥덕4길 35', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (124, '강원특별자치도 동해시 이도동', '302-6', 302, 6, '강변', 59.955, 202409, 9, '8,500', '-', 10, '1996', '전천로 175-24', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (125, '경상남도 창원시 마산합포구 두월동2가', '7-1', 7, 1, '두월동상우the헤라우스', 84.9937, 202409, 9, '27,300', '-', 17, '2016', '문화북1길 65', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (126, '경상북도 포항시 북구 창포동', '656', 656, 0, '창포메트로시티2단지', 69.44, 202409, 9, '23,900', '-', 28, '2018', '우창로 166', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (127, '경상북도 포항시 북구 창포동', '656', 656, 0, '창포메트로시티2단지', 59.852, 202409, 9, '22,300', '-', 23, '2018', '우창로 166', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (128, '충청남도 천안시 동남구 청수동', '261', 261, 0, '청솔엘지에스케이', 59.83, 202409, 9, '16,000', '-', 7, '1999', '청수로 98', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (129, '충청남도 천안시 동남구 청수동', '183', 183, 0, '극동2차', 72.88, 202409, 9, '13,700', '-', 11, '1992', '청수로 71-7', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (130, '충청남도 서산시 읍내동', '624-6', 624, 6, '동신', 61.56, 202409, 9, '10,000', '-', 6, '1994', '문화로 131', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (131, '경기도 포천시 신읍동', '143-4', 143, 4, '유한', 59.875, 202409, 9, '10,000', '-', 4, '1999', '왕방로 159', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (132, '충청남도 천안시 서북구 직산읍 군동리', '39', 39, 0, '희홍밸러-뷰', 56.0499, 202409, 9, '8,000', '-', 3, '2010', '직산로 252-10', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (133, '경상남도 창원시 마산회원구 내서읍 호계리', '10', 10, 0, '코오롱하늘채1차아파트', 71.886, 202409, 9, '19,300', '-', 21, '2001', '호원로 361-3', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (134, '전북특별자치도 전주시 덕진구 인후동1가', '890-1', 890, 1, '인후꿈마을부영(2차)', 59.933, 202409, 9, '11,000', '-', 7, '1999', '무삼지로 40', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (135, '전라남도 목포시 옥암동', '992', 992, 0, '현대아이파크2', 84.983, 202409, 9, '16,500', '-', 7, '2002', '삼향천로91번길 21', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (136, '충청북도 청주시 흥덕구 강서동', '583', 583, 0, '가경아이파크5단지', 116.984, 202409, 9, '82,500', '-', 11, '2023', '서부로 1123', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (137, '전북특별자치도 전주시 완산구 중화산동1가', '154', 154, 0, '중화산동신일', 84.93, 202409, 9, '12,500', '-', 1, '1995', '서원로 386', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (138, '전라남도 여수시 미평동', '741', 741, 0, '선경2차', 84.79, 202409, 9, '17,400', '-', 6, '1995', '양지6길 2', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (139, '경기도 양평군 양평읍 창대리', '844', 844, 0, '한화포레나양평', 74.9933, 202409, 9, '40,400', '-', 15, '2023', '남북로 53', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (140, '경상남도 창원시 마산합포구 월영동', '738', 738, 0, '마린애시앙부영', 124.664, 202409, 9, '57,000', '-', 26, '2019', '가포순환로 33', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (141, '충청남도 천안시 동남구 문화동', '180', 180, 0, '천안역필하우스에듀시티(1단지)', 114.993, 202409, 9, '55,000', '-', 11, '2022', '성황로 40', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (142, '경상북도 포항시 북구 장성동', '1455-1', 1455, 1, '롯데낙천대', 84.99, 202409, 9, '16,800', '-', 14, '2004', '법원로40번길 38', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (143, '전북특별자치도 군산시 나운동', '1188-5', 1188, 5, '동산은파', 62.46, 202409, 9, '5,000', '-', 4, '1985', '한밭1길 32', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (144, '충청남도 부여군 부여읍 쌍북리', '734', 734, 0, '홍선', 84.9038, 202409, 9, '27,700', '-', 10, '2001', '성왕로328번길 18-7', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (145, '충청북도 진천군 광혜원면 죽현리', '202', 202, 0, '갑을아파트', 49.92, 202409, 9, '6,800', '-', 13, '2000', '진광로 923', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (146, '충청남도 보령시 명천동', '389', 389, 0, '명천주공5', 59.8, 202409, 9, '14,000', '-', 1, '1998', '주공로 65', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (147, '경상북도 구미시 산동읍 신당리', '1383', 1383, 0, '우미린센트럴파크', 84.9495, 202409, 9, '38,250', '-', 19, '2017', '신당3로 16', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (148, '경기도 양평군 양평읍 양근리', '136-1', 136, 1, '제이파크', 61.26, 202409, 9, '19,800', '-', 5, '2016', '중앙로 14-18', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (149, '충청남도 아산시 배방읍 세교리', '424-9', 424, 9, '신라', 59.34, 202409, 9, '11,000', '-', 2, '1997', '온천대로 2358', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (150, '강원특별자치도 평창군 대관령면 용산리', '161', 161, 0, '용평빌리지', 84.152, 202409, 9, '15,000', '-', 1, '2002', '솔봉로 463-6', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (151, '전북특별자치도 전주시 완산구 효자동1가', '408-1', 408, 1, '케이제이라미안', 81.96, 202409, 9, '22,300', '-', 7, '2003', '강변로 210', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (152, '전북특별자치도 군산시 나운동', '155-1', 155, 1, '한울', 59.73, 202409, 9, '8,400', '-', 11, '1996', '하나운로 20', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (153, '충청남도 천안시 서북구 두정동', '1593', 1593, 0, '두정3푸르지오', 73.005, 202409, 9, '20,200', '-', 10, '2003', '성정두정로 142', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (154, '전북특별자치도 군산시 나운동', '831', 831, 0, '나운금호어울림센트럴', 59.7894, 202409, 9, '21,200', '-', 6, '2022', '하나운2길 15', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (155, '경상남도 창원시 마산회원구 양덕동', '79-9', 79, 9, '마산양덕4차한일타운', 83.683, 202409, 9, '33,000', '-', 22, '2004', '양덕서로 45', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (156, '경기도 가평군 가평읍 대곡리', '695', 695, 0, '가평자이', 84.9777, 202409, 9, '41,500', '-', 4, '2023', '문화로 91', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (157, '충청북도 음성군 음성읍 읍내리', '805', 805, 0, '한성진주아파트', 39.96, 202409, 9, '4,200', '-', 8, '1994', '설성로 22', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (158, '충청북도 청주시 청원구 내덕동', '141', 141, 0, '영우예인촌', 30.31, 202409, 9, '3,500', '-', 8, '1997', '안덕벌로69번길 50', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (159, '강원특별자치도 양양군 양양읍 내곡리', '263', 263, 0, '한양수자인', 84.9782, 202409, 9, '35,000', '-', 20, '2020', '한고개길 31-46', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (160, '충청남도 아산시 둔포면 둔포리', '292', 292, 0, '우정배꽃마을아파트', 84.18, 202409, 9, '18,150', '-', 14, '2005', '둔포중앙로161번길 34', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (161, '충청북도 충주시 교현동', '144-28', 144, 28, '신원7', 34.83, 202409, 9, '3,300', '-', 3, '1990', '만리산로 33', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (162, '경상남도 거제시 고현동', '860', 860, 0, '거제롯데인벤스가', 108.207, 202409, 9, '32,000', '-', 7, '2007', '서문로 30', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (163, '경상남도 김해시 내동', '121-2', 121, 2, '연지공원푸르지오', 84.8621, 202409, 9, '53,900', '-', 30, '2022', '금관대로 1407', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (164, '경기도 양주시 삼숭동', '688', 688, 0, '양주자이(6단지)', 84.9218, 202409, 9, '21,000', '-', 1, '2006', '삼숭로58번길 115', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (165, '강원특별자치도 동해시 동회동', '442', 442, 0, '북삼코아루', 103.667, 202409, 9, '24,500', '-', 13, '2007', '효자남길 9', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (166, '충청남도 서산시 예천동', '1718', 1718, 0, '서산예천2지구중흥S-클래스더퍼스트', 84.928, 202409, 9, '40,900', '-', 3, '2021', '예천5로 32', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (167, '경상북도 경산시 압량읍 신대리', '702', 702, 0, '경산한신휴플러스아파트', 84.9175, 202409, 9, '22,800', '-', 9, '2016', ' 11', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (168, '경상북도 영주시 휴천동', '1777', 1777, 0, '남산현대', 59.76, 202409, 9, '11,500', '-', 15, '1998', '구성로142번길 20', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (169, '충청남도 태안군 태안읍 삭선리', '281-1', 281, 1, '해송마을3차', 59.157, 202409, 9, '6,000', '-', 2, '2001', '원이로 302', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (170, '충청남도 예산군 예산읍 산성리', '324-1', 324, 1, '유익효도마을', 41.82, 202409, 9, '5,000', '-', 14, '1998', '역전로126번길 24-10', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (171, '경상남도 사천시 용현면 신복리', '7-1', 7, 1, '동강아뜨리에', 49.7, 202409, 9, '5,300', '-', 2, '2005', '죽천강길 56', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (172, '충청북도 청주시 청원구 오창읍 장대리', '330', 330, 0, '오창재원', 59.9, 202409, 9, '8,000', '-', 4, '1992', '복현3길 16', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (173, '전라남도 목포시 용해동', '152-80', 152, 80, '동아', 134.94, 202409, 9, '9,800', '-', 1, '1993', '삼학로 303-3', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (174, '충청북도 청주시 흥덕구 신봉동', '528', 528, 0, '주공', 53.85, 202409, 9, '8,590', '-', 1, '1986', '1순환로501번길 15', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (175, '경상북도 영주시 가흥동', '530', 530, 0, '시영', 47.46, 202409, 9, '4,000', '-', 1, '1992', '창진로 63', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (176, '전북특별자치도 전주시 덕진구 중동', '789', 789, 0, '호반베르디움', 84.9396, 202409, 9, '49,300', '-', 9, '2013', '오공로 71', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (177, '경상남도 창녕군 남지읍 남지리', '481-27', 481, 27, '동서목련빌라', 83.69, 202409, 9, '7,300', '-', 3, '1997', '남지중앙2길 95-2', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (178, '경상남도 김해시 대청동', '321-1', 321, 1, '갑오마을2단지주공2', 51.72, 202409, 9, '12,000', '-', 14, '2002', '계동로102번길 9', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (179, '충청북도 충주시 대소원면 본리', '642', 642, 0, '충주지웰', 59.0907, 202409, 9, '13,000', '-', 1, '2016', '첨단산업2로 42', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (180, '전라남도 목포시 대양동', '75-18', 75, 18, '근화희망타운3차', 39.78, 202409, 9, '5,600', '-', 5, '2000', '산양로 50', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (181, '경상북도 예천군 호명읍 산합리', '1382', 1382, 0, '경북도청아이파크', 84.9931, 202409, 9, '26,300', '-', 9, '2015', ' 7', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (182, '충청남도 서산시 인지면 둔당리', '224', 224, 0, '아진', 39.66, 202409, 9, '4,700', '-', 12, '1998', '무학로 1742', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (183, '전북특별자치도 전주시 완산구 평화동2가', '952', 952, 0, '영무예다음', 84.97, 202409, 9, '29,700', '-', 5, '2012', '구이로 2065', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (184, '전북특별자치도 전주시 완산구 평화동2가', '567', 567, 0, '동신', 75.6, 202409, 9, '16,500', '-', 16, '1998', '양지2길 10', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (185, '충청북도 청주시 흥덕구 문암동', '213', 213, 0, '청주테크노폴리스신영지웰푸르지오', 59.9721, 202409, 9, '40,800', '-', 27, '2022', '송화로 229', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (186, '전라남도 목포시 상동', '1120', 1120, 0, '우미파크빌', 84.9723, 202409, 9, '22,900', '-', 12, '2001', '평화로20번길 11', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (187, '충청남도 계룡시 엄사면 엄사리', '282', 282, 0, '성원', 58.32, 202409, 9, '8,000', '-', 1, '1997', '엄사중앙로 66', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (188, '경상북도 포항시 남구 연일읍 오천리', '1013', 1013, 0, '연일에코코아루', 84.9822, 202409, 9, '22,500', '-', 9, '2010', '동문로54번길 20', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (189, '충청북도 청주시 서원구 분평동', '1200', 1200, 0, '분평주공3', 59.99, 202409, 9, '14,000', '-', 8, '1997', '1순환로1137번길 130', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (190, '충청남도 계룡시 엄사면 엄사리', '226-4', 226, 4, '삼진', 29.13, 202409, 9, '4,350', '-', 9, '1997', '번영3길 73-12', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (191, '충청남도 공주시 신관동', '1', 1, 0, '새뜸현대3차', 59.5, 202409, 9, '14,500', '-', 15, '1996', '신금1길 72', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (192, '충청남도 당진시 송악읍 복운리', '1629-1', 1629, 1, '동광', 59.9974, 202409, 9, '11,700', '-', 11, '2007', '신복운로3길 8', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (193, '경상남도 통영시 봉평동', '64-19', 64, 19, '송림비치맨션', 78.65, 202409, 9, '7,600', '-', 4, '1989', '해평2길 10-16', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (194, '충청남도 천안시 동남구 신방동', '1893', 1893, 0, '신방한라비발디', 84.9737, 202409, 9, '24,000', '-', 7, '2009', '통정9로 75', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (195, '경상남도 김해시 삼계동', '1428-5', 1428, 5, '분성마을4단지한솔솔파크', 84.9902, 202409, 9, '18,000', '-', 14, '2005', '삼계로 218', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (196, '전북특별자치도 익산시 팔봉동', '313', 313, 0, '기안파인골드빌2차', 84.9435, 202409, 9, '13,000', '-', 7, '2005', '무왕로32길 80', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (197, '전라남도 영광군 영광읍 남천리', '14', 14, 0, '석가', 71.98, 202409, 9, '7,500', '-', 3, '2001', '중앙로 123-1', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (198, '충청남도 천안시 동남구 병천면 병천리', '308', 308, 0, '아우네아파트', 41.65, 202409, 9, '3,000', '-', 5, '1996', '아우내장터1길 7', '직거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (199, '전북특별자치도 전주시 덕진구 송천동2가', '1268', 1268, 0, '송천주공', 59.99, 202409, 9, '12,000', '-', 9, '1998', '붓내3길 29', '중개거래', '아파트', null, null);
INSERT INTO property_tbl (property_no, property_addr_sigungu, property_addr_bunji, property_addr_bonbun, property_addr_bubun, property_addr_apt_name, property_area, contract_year_month, contract_date, price, property_addr_apt_dong, property_addr_floor, building_year, property_doro_juso, contract_type, building_type, deposit, rent) VALUES (200, '충청북도 청주시 흥덕구 복대동', '2461', 2461, 0, '세원느티마을', 59.99, 202409, 9, '17,400', '-', 9, '1999', '진재로 67', '중개거래', '아파트', null, null);




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

#부동산 위치
# INSERT INTO property_location (road_name, recent_price, recent_date)
#     (SELECT ap.property_doro_juso, ap.price, CONCAT(ap.contract_year_month, ap.contract_date) as d
#      FROM property_tbl ap
#               LEFT JOIN (SELECT property_doro_juso, MAX(CONCAT(contract_year_month, contract_date)) as d FROM property_tbl GROUP BY property_doro_juso) as rc
#                         ON ap.property_doro_juso = rc.property_doro_juso AND d = rc.d
#     );



INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('달서대로 41', '29,500', 20240910, '128.510309706501', '35.8135853305856');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('한밭대로570번길 33', '4,800', 20240910, '127.362370682032', '36.3567088262589');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('화랑로 51', '57,200', 20240910, '126.796699654161', '37.3298714824793');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('계룡로615번길 82', '59,500', 20240910, '127.394927241243', '36.3425526501276');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('반야월북로 155', '7,000', 20240910, '128.715083034003', '35.8741972317789');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('화정로 105', '13,300', 20240910, '126.868959955753', '35.146017374053');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('천변우로79번길 25', '37,500', 20240910, '126.887672207093', '35.1660715869472');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('빛고을대로 615', '40,000', 20240910, '126.866419651538', '35.2162536414669');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('모래내로 151', '13,900', 20240910, '126.917835668207', '37.5699012905386');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('설죽로 545', '14,750', 20240910, '126.896298874908', '35.208342466446');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('명지국제5로 29', '45,500', 20240910, '128.917897059642', '35.0961151515237');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('새말로 134', '22,900', 20240910, '127.128833865415', '37.4829769123873');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('청라라임로 85', '94,000', 20240910, '126.652614505895', '37.5346639378439');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('부흥로 246', '60,700', 20240910, '126.932246172357', '37.8123204774097');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('산성로 108-23', '8,500', 20240910, '127.40083863196', '36.3091786590725');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('아리랑로 68', '100,000', 20240910, '127.015087054825', '37.5987879114086');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('반야월북로 251', '14,800', 20240910, '128.724934428052', '35.8739742262703');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('고분로235번길 31', '11,000', 20240910, '129.107795846144', '35.1859484107933');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('호구포로899번길 8', '18,000', 20240910, '126.719768321525', '37.4631765694512');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서포로30번길 12', '36,800', 20240910, '128.984491722497', '35.0827778603371');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('가정로 387', '44,000', 20240910, '126.672750890456', '37.5216812205617');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('광나루로20길 17', '17,000', 20240910, '127.074664230756', '37.5461815782557');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('희망로24길 24', '58,200', 20240910, '128.61036617233', '35.8467242553961');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('상화로 235', '25,800', 20240910, '128.538729736548', '35.8108625326772');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('장기로 242', '19,000', 20240910, '128.533421428562', '35.844418549778');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('국채보상로 316', '30,000', 20240910, '128.56508677082', '35.8717612751281');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('정림서로 162-15', '41,000', 20240910, '127.363868670472', '36.303281689254');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('함지로 8', '16,500', 20240910, '129.061998563801', '35.0712895362543');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('축항대로86번길 47', '9,500', 20240910, '126.60497770554', '37.4517673879313');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('가림일로 101', '54,500', 20240910, '126.865848668665', '37.470494091663');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('신천로 103', '42,800', 20240910, '126.786410959848', '37.4393998935996');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('태전동로 11', '50,800', 20240910, '127.233966961002', '37.3879593555786');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('화산로 75', '52,800', 20240910, '127.210179798804', '37.1465522374057');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('도움1로 105', '53,000', 20240910, '127.245609967589', '36.5015097318766');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('호국로1142번길 22', '30,000', 20240910, '127.030463026707', '37.7422577199487');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('화산로 75', '52,800', 20240910, '127.210179798804', '37.1465522374057');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('무원로 41', '55,000', 20240910, '126.831788927147', '37.6166241800814');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('시청대로 598', '34,700', 20240910, '127.318320399076', '36.493940941487');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('오산로132번길 10', '40,800', 20240910, '127.069214427873', '37.1383758195927');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('시청대로 598', '34,700', 20240910, '127.318320399076', '36.493940941487');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('동화길 82', '56,000', 20240910, '126.956977556234', '37.216596575233');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('화진길 100', '36,800', 20240910, '129.422935393819', '35.4937725225038');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('탄현로 64', '19,000', 20240910, '126.76998608677', '37.6974840565549');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('중산동로 37', '29,000', 20240910, '129.351420934451', '35.6550956047846');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('신촌1로 9', '29,000', 20240910, '126.69585120462', '37.7304030131973');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('매봉로 20', '56,000', 20240910, '127.052622384357', '37.2693936820941');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('호국로1142번길 22', '30,000', 20240910, '127.030463026707', '37.7422577199487');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼동로 1617', '5,300', 20240910, '129.213545512707', '35.4899279508705');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('대암로 82', '45,000', 20240910, '128.706240940406', '35.2148410032029');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('금당로 13', '40,000', 20240910, '126.881471381871', '37.4603292818743');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('동백8로 90', '38,450', 20240910, '127.160111317632', '37.2842166067514');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('유성대로 1741', '23,500', 20240910, '127.40424395435', '36.4002913376325');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('수성로245번길 21', '35,000', 20240910, '126.9987508', '37.289773735445');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('장곡로 240', '36,500', 20240910, '127.052878271709', '37.7256179755265');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('동탄대로24길 199', '58,800', 20240910, '127.117293621663', '37.2079666999267');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('샘골로 158', '9,800', 20240910, '126.863408183247', '37.2978529184');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('원앙1길 50', '25,430', 20240910, '127.01119961307', '35.8159158528589');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('진장로 51-16', '16,500', 20240910, '127.4373855202', '35.7940626589229');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('알메로 86', '9,200', 20240910, '126.995007016722', '35.0631223481204');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('도예로 35', '7,200', 20240910, '127.640185390267', '37.3074145514252');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('백제대로 13', '19,000', 20240910, '127.130623212699', '35.7962804451544');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('무삼지로 40', '12,700', 20240910, '127.165270104773', '35.8285301687872');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('중앙시장1길 22-23', '7,000', 20240910, '129.167311921192', '37.4409299710027');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('두꺼비로 109', '18,700', 20240910, '127.463708122682', '36.6148234479654');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('해병로489번길 9', '32,500', 20240910, '129.408579930922', '35.9536702374915');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('세종로 173-69', '15,850', 20240910, '127.640867402286', '37.2839147235306');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('증안로 21', '18,800', 20240910, '127.425675231087', '36.6367792624793');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼호로 151', '21,700', 20240910, '129.374123183664', '36.0530788904646');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('상동로 43', '3,500', 20240910, '126.41356427416', '34.8134315557998');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('펜타힐즈2로 40', '41,000', 20240910, '128.718944368103', '35.8269233784784');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('인동45길 7', '7,100', 20240910, '128.440093985763', '36.09342431445');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('세종로 61', '15,500', 20240910, '127.636823169191', '37.2917195925146');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서신천변11길 22', '15,100', 20240910, '127.111097479981', '35.8308332500779');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('모산로126번길 17-26', '6,400', 20240910, '127.059340443481', '36.7721663254954');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('중촌로 16-55', '12,000', 20240910, '127.508938786903', '37.8339808345982');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서평1길 9', '15,700', 20240910, '127.575011758452', '34.9761689038062');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('한들물빛3로 14', '62,500', 20240910, '127.086826809897', '36.7832739867267');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('염밭로 22', '28,500', 20240910, '127.944410939365', '36.9599600901318');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('형산강남로326번길 25', '4,500', 20240910, '129.349614833731', '35.9975377994718');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('덕적골2길 11', '5,200', 20240910, '127.141707096347', '35.7966460631753');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('익산대로 255', '6,000', 20240910, '126.949682011031', '35.9487372286086');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('계룡로 168', '7,000', 20240910, '128.620507040707', '34.8845441402125');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('시민로 241', '9,000', 20240910, '127.061567747745', '37.7360724954351');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('북문로 16', '22,700', 20240910, '126.627234473671', '36.9004617426082');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('진의로1079번길 13', '8,500', 20240910, '128.168112327951', '35.262545131522');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('신백로14길 21', '3,000', 20240910, '128.227583009452', '37.1312090305408');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('금장2길 3', '12,000', 20240910, '129.202965971245', '35.865335699436');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('효자로 572-1', '9,350', 20240910, '129.099106906092', '37.4876771833493');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('호암중앙1로 47', '26,300', 20240910, '127.938146791411', '36.956870744193');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('산양로 50', '5,850', 20240910, '126.429113108477', '34.8358398748805');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('담안2길 36-10', '4,500', 20240910, '127.748969355013', '34.9425866966226');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('후동길 50', '10,100', 20240910, '127.288194540582', '34.6129897270176');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('석소로 77', '19,900', 20240910, '127.165143000139', '35.8336312835454');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('포란재로 36', '18,000', 20240910, '127.956077063125', '37.3748931838278');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서령로 330', '3,300', 20240910, '126.477851128102', '36.8043646082931');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('남간로71번길 10', '23,400', 20240910, '128.636318637843', '36.819596311654');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('봉오동길 22', '9,100', 20240910, '129.12239448493', '37.5109681200683');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('상서문로 5', '30,217', 20240910, '128.156187008817', '36.4101079128062');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('천마로 163', '17,950', 20240910, '127.14624490274', '34.5283879002868');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('만성동로 48', '56,900', 20240910, '127.077151987392', '35.8384312156124');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('만성로 181', '50,000', 20240910, '127.079706807467', '35.8481784461566');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('섬진강대로 2174', '6,000', 20240910, '127.741068447669', '35.0678717237125');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('오송가락로 1056', '36,000', 20240910, '127.390236932016', '36.6779393525675');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('승삼2길 46', '9,900', 20240910, '129.226965705305', '35.8732482543555');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('아산밸리중앙로 47', '21,500', 20240910, '127.052973914975', '36.9239313382029');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('만리산로 33', '3,400', 20240910, '127.94409885564', '36.9747765170459');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서현중로 47', '39,800', 20240910, '127.428179506184', '36.6228290659922');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('단재로 316', '44,500', 20240910, '127.500967809429', '36.6011278961228');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서곡로 8', '14,000', 20240910, '127.096617337887', '35.8317797369767');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('송원동로 35', '7,750', 20240910, '128.348554182211', '36.120398692615');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('2순환로1050번길 24', '13,300', 20240910, '127.420142018067', '36.6409239181082');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('남부로125번길 7', '9,900', 20240910, '128.892471787551', '37.7420897229719');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('율천북로 91', '31,300', 20240910, '127.481495663704', '36.6635792586908');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('평동로17길 5', '14,500', 20240910, '126.95838219181', '35.9295458899316');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('함박로101번길 19', '13,700', 20240910, '128.86478303055', '35.2334783485348');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('읍하로25번길 17', '10,400', 20240910, '127.984207677551', '37.4951925924503');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서현중로 48', '39,800', 20240910, '127.429110239826', '36.6230594714391');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼향천로 113', '9,000', 20240910, '126.4292956367', '34.8091278252799');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('읍하로25번길 17', '10,800', 20240910, '127.984207677551', '37.4951925924503');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('선지로 85', '20,000', 20240910, '128.845588695676', '35.2301851714054');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('권율로 1455-15', '17,000', 2024099, '126.980171114072', '37.8105816945781');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('율곡로 2982-7', '15,000', 2024099, '128.892869547033', '37.7685702754359');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('흥덕4길 35', '11,800', 2024099, '128.201049800486', '36.6045851955971');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('전천로 175-24', '8,500', 2024099, '129.109767518866', '37.4810310970674');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('문화북1길 65', '27,300', 2024099, '128.560570767171', '35.1861101226417');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('우창로 166', '23,900', 2024099, '129.365866474045', '36.0668592717425');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('우창로 166', '22,300', 2024099, '129.365866474045', '36.0668592717425');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('청수로 98', '16,000', 2024099, '127.158945352625', '36.7919510127243');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('청수로 71-7', '13,700', 2024099, '127.152674780971', '36.7904169713272');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('문화로 131', '10,000', 2024099, '127.506125214946', '37.8254310813271');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('왕방로 159', '10,000', 2024099, '127.194461641551', '37.89719053245');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('직산로 252-10', '8,000', 2024099, '127.166689492211', '36.8962552131922');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('호원로 361-3', '19,300', 2024099, '128.524986267974', '35.2663045036371');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('무삼지로 40', '11,000', 2024099, '127.165270104773', '35.8285301687872');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼향천로91번길 21', '16,500', 2024099, '126.429090792357', '34.8071208070338');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서부로 1123', '82,500', 2024099, '127.423990655042', '36.6123902682714');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서원로 386', '12,500', 2024099, '127.136235975985', '35.8134253287042');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('양지6길 2', '17,400', 2024099, '127.703871498621', '34.7726490844614');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('남북로 53', '40,400', 2024099, '127.500885386944', '37.487301416642');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('가포순환로 33', '57,000', 2024099, '128.562589220715', '35.1750235873689');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('성황로 40', '55,000', 2024099, '127.153473836838', '36.8120944375135');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('법원로40번길 38', '16,800', 2024099, '129.38865988055', '36.0762458630868');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('한밭1길 32', '5,000', 2024099, '126.693342376755', '35.961776713246');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('성왕로328번길 18-7', '27,700', 2024099, '126.922334694555', '36.2822848139336');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('진광로 923', '6,800', 2024099, '127.429075694853', '36.9410685545594');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('주공로 65', '14,000', 2024099, '126.608067362193', '36.3426774086383');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('신당3로 16', '38,250', 2024099, '128.434269733053', '36.1581412810764');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('중앙로 14-18', '19,800', 2024099, '127.491703634786', '37.4959847093584');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('온천대로 2358', '11,000', 2024099, '127.093949419001', '36.780983256545');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('솔봉로 463-6', '15,000', 2024099, '128.681911433431', '37.6570841777954');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('강변로 210', '22,300', 2024099, '128.89166443622', '37.7476018018241');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('하나운로 20', '8,400', 2024099, '126.702226885883', '35.9593552953866');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('성정두정로 142', '20,200', 2024099, '127.143650540826', '36.8382042436596');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('하나운2길 15', '21,200', 2024099, '126.696856740986', '35.9680929358612');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('양덕서로 45', '33,000', 2024099, '128.581005876933', '35.2288455464935');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('문화로 91', '41,500', 2024099, '127.508957631216', '37.8210633344458');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('설성로 22', '4,200', 2024099, '127.520164403244', '37.1335239323313');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('안덕벌로69번길 50', '3,500', 2024099, '127.494306469954', '36.6609683076659');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('한고개길 31-46', '35,000', 2024099, '128.612762419688', '38.0803412909211');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('둔포중앙로161번길 34', '18,150', 2024099, '127.041766885024', '36.9260007537367');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('만리산로 33', '3,300', 2024099, '127.94409885564', '36.9747765170459');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('서문로 30', '32,000', 2024099, '127.48049669726', '34.9513090140604');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('금관대로 1407', '53,900', 2024099, '128.867492233651', '35.2480101904963');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼숭로58번길 115', '21,000', 2024099, '127.105554454009', '37.8027995400701');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('효자남길 9', '24,500', 2024099, '129.107695770532', '37.4881569594524');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('예천5로 32', '40,900', 2024099, '126.452264668334', '36.7638529620896');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES (' 11', '22,800', 2024099, null, null);
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('구성로142번길 20', '11,500', 2024099, '128.6321748036', '36.8060385226313');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('원이로 302', '6,000', 2024099, '126.27714627722', '36.7835489441128');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('역전로126번길 24-10', '5,000', 2024099, '126.832466533467', '36.6894863991556');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('죽천강길 56', '5,300', 2024099, '128.074525314171', '35.046457310432');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('복현3길 16', '8,000', 2024099, '127.452996596154', '36.7434677872017');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼학로 303-3', '9,800', 2024099, '126.407003667501', '34.7970493484416');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('1순환로501번길 15', '8,590', 2024099, '127.468966490398', '36.6494577867596');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('창진로 63', '4,000', 2024099, '128.610229642582', '36.8359556992273');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('오공로 71', '49,300', 2024099, '127.062304643529', '35.8380504866319');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('남지중앙2길 95-2', '7,300', 2024099, '128.479998946453', '35.3937036376805');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('계동로102번길 9', '12,000', 2024099, '128.795148460767', '35.1866181197613');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('첨단산업2로 42', '13,000', 2024099, '127.829500709684', '36.9883883748359');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('산양로 50', '5,600', 2024099, '126.429113108477', '34.8358398748805');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES (' 7', '26,300', 2024099, null, null);
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('무학로 1742', '4,700', 2024099, '126.428592329295', '36.7576354630369');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('구이로 2065', '29,700', 2024099, '127.128171315815', '35.7824370437381');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('양지2길 10', '16,500', 2024099, '126.931768991207', '37.4708779700836');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('송화로 229', '40,800', 2024099, '127.456756074424', '36.6708529012753');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('평화로20번길 11', '22,900', 2024099, '126.428043364016', '34.7948015401105');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('엄사중앙로 66', '8,000', 2024099, '127.242924719338', '36.2864298260421');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('동문로54번길 20', '22,500', 2024099, '129.352972156445', '35.9939141890834');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('1순환로1137번길 130', '14,000', 2024099, '127.493360906535', '36.6116557493125');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('번영3길 73-12', '4,350', 2024099, '127.238976974024', '36.2814548385594');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('신금1길 72', '14,500', 2024099, '127.147751914929', '36.4766759678708');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('신복운로3길 8', '11,700', 2024099, '126.779366326665', '36.9394396714704');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('해평2길 10-16', '7,600', 2024099, '128.416961981896', '34.832113763616');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('통정9로 75', '24,000', 2024099, '127.132683692902', '36.7708312453123');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('삼계로 218', '18,000', 2024099, '128.869838250609', '35.2681104504229');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('무왕로32길 80', '13,000', 2024099, '127.015586847797', '35.9654745032585');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('중앙로 123-1', '7,500', 2024099, '127.203050014116', '37.8975254170348');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('아우내장터1길 7', '3,000', 2024099, '127.295114819519', '36.7606637170975');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('붓내3길 29', '12,000', 2024099, '127.124668209179', '35.8693470871875');
INSERT INTO property_location (road_name, recent_price, recent_date, x_coordinate, y_coordinate) VALUES ('진재로 67', '17,400', 2024099, '127.428051432426', '36.6377558640148');


#부동산 위치 정보
# INSERT INTO property_location (road_name, recent_price, recent_date)
#     (SELECT ap.property_doro_juso, ap.price, CONCAT(ap.contract_year_month, ap.contract_date) as d
#      FROM property_tbl ap
#               LEFT JOIN (SELECT property_doro_juso, MAX(CONCAT(contract_year_month, contract_date)) as d FROM property_tbl GROUP BY property_doro_juso) as rc
#                         ON ap.property_doro_juso = rc.property_doro_juso AND d = rc.d
#     );
#
UPDATE property_tbl as pr
    JOIN property_location pl ON pr.property_doro_juso = pl.road_name
SET pr.location_no = pl.location_no
WHERE pr.location_no IS NULL;

desc property_location;
desc property_tbl;
select * from property_location where location_no = 1;
select * from property_tbl where location_no = 1;

desc property_tbl