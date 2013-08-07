CREATE TABLE attachment_parameter (AP_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, id VARCHAR(45) UNIQUE NOT NULL, name VARCHAR(45) NOT NULL, value VARCHAR(45) NULL, unit_name VARCHAR(45) NULL, unit_accession VARCHAR(45) NULL, accession VARCHAR(45) NULL, binary BLOBs, unit_cv_ref INTEGER NULL, cv_ref INTEGER NOT NULL, quality_parameter_ref VARCHAR(45) NULL, QA_ID_FK INTEGER NOT NULL, FOREIGN KEY (unit_cv_ref ) REFERENCES cv (CV_ID_PK ), FOREIGN KEY (cv_ref ) REFERENCES cv (CV_ID_PK ), FOREIGN KEY (QA_ID_FK ) REFERENCES quality_assessment (QA_ID_PK ));
CREATE TABLE cv (CV_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, id VARCHAR(45) UNIQUE NOT NULL, full_name VARCHAR(45) NULL, version VARCHAR(45) NULL, uri VARCHAR(45) NULL);
CREATE TABLE cv_list (MQ_ID_FK INTEGER NOT NULL, CV_ID_FK INTEGER NOT NULL, PRIMARY KEY (MQ_ID_FK, CV_ID_FK), FOREIGN KEY (MQ_ID_FK ) REFERENCES mzquality (MQ_ID_PK ) FOREIGN KEY (CV_ID_FK ) REFERENCES cv (CV_ID_PK ));
CREATE TABLE mzquality (MQ_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, mzqualml_file VARCHAR(45) NULL);
CREATE TABLE quality_assessment (QA_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, id VARCHAR(45) UNIQUE NOT NULL, is_set INTEGER(1) NOT NULL DEFAULT 0, MQ_ID_FK INTEGER NOT NULL, FOREIGN KEY (MQ_ID_FK) REFERENCES mzquality (MQ_ID_PK));
CREATE TABLE quality_parameter (QP_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, id VARCHAR(45) UNIQUE NOT NULL, name VARCHAR(45) NOT NULL, value VARCHAR(45) NULL, accession VARCHAR(45) NULL, unit_name VARCHAR(45) NULL, unit_accession VARCHAR(45) NULL, flag BOOLEAN, cv_ref INTEGER NOT NULL, unit_cv_ref INTEGER NULL, QA_ID_FK INTEGER NOT NULL, FOREIGN KEY (unit_cv_ref ) REFERENCES cv (CV_ID_PK ), FOREIGN KEY (cv_ref ) REFERENCES cv (CV_ID_PK ), FOREIGN KEY (QA_ID_FK) REFERENCES quality_assessment (QA_ID_PK));
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE table_attachment (TA_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, AP_ID_FK INTEGER NOT NULL, FOREIGN KEY (AP_ID_FK) REFERENCES attachment_parameter (AP_ID_PK));
CREATE TABLE table_column (TC_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, name VARCHAR(100), TA_ID_FK INTEGER NOT NULL, FOREIGN KEY (TA_ID_FK) REFERENCES table_attachment (TA_ID_PK));
CREATE TABLE table_row (TR_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, row_num INTEGER, TA_ID_FK INTEGER NOT NULL, FOREIGN KEY (TA_ID_FK) REFERENCES table_attachment (TA_ID_PK));
CREATE TABLE table_value (TV_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, value VARCHAR(100), type VARCHAR(100), TR_ID_FK INTEGER NOT NULL, TC_ID_FK INTEGER NOT NULL, FOREIGN KEY (TC_ID_FK) REFERENCES table_column (TC_ID_PK) );
CREATE TABLE threshold (TH_ID_PK INTEGER PRIMARY KEY ASC AUTOINCREMENT, name VARCHAR(45) NOT NULL, value VARCHAR(45) NULL, accession VARCHAR(45) NULL, unit_name VARCHAR(45) NULL, unit_accession VARCHAR(45) NULL, cv_ref INTEGER NOT NULL, unit_cv_ref INTEGER NULL, threshold_filename VARCHAR(45), QP_ID_FK INTEGER NOT NULL, FOREIGN KEY (unit_cv_ref ) REFERENCES cv (CV_ID_PK ), FOREIGN KEY (cv_ref ) REFERENCES cv (CV_ID_PK ), FOREIGN KEY (QP_ID_FK) REFERENCES quality_parameter (QP_ID_PK));
