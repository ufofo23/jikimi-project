USE shop41;

CREATE TABLE IF NOT EXISTS BML_tbl (
                                       bml_no INT AUTO_INCREMENT PRIMARY KEY,
                                       bml_use_type VARCHAR(255) NOT NULL,
                                       bml_violation_structure VARCHAR(255),
                                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE shop41.COR_tbl
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    address            VARCHAR(255) NULL,
    owner_state        VARCHAR(255) NULL,
    ownership          VARCHAR(255) NULL,
    common_owner       VARCHAR(255) NULL,
    change_owner_count VARCHAR(255) NULL,
    maximum_of_bond    VARCHAR(255) NULL,
    deposit            VARCHAR(255) NULL,
    created_at         timestamp default CURRENT_TIMESTAMP
);
