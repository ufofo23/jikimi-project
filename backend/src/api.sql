

CREATE TABLE analysis (
    analysis_no INT PRIMARY KEY AUTO_INCREMENT,
    property_no INT
);

CREATE TABLE BML_tbl (
    bml_no INT PRIMARY KEY AUTO_INCREMENT,
    analysis_no INT,
    violation_structure BOOLEAN,
    use_type VARCHAR(255),
    FOREIGN KEY (analysis_no) REFERENCES analysis(analysis_no)
);

CREATE TABLE COR_tbl (
    cor_no INT PRIMARY KEY AUTO_INCREMENT,
    analysis_no INT,
    owner_state VARCHAR(255),
    type_of_ownership VARCHAR(255),
    common_owner VARCHAR(255),
    change_owner_count INT,
    maximum_of_bond INT,
    FOREIGN KEY (analysis_no) REFERENCES analysis(analysis_no)
);