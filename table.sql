CREATE TABLE post_offices2 (
    office_code    INTEGER       PRIMARY KEY,
    address        VARCHAR(255)  NOT NULL,
    city           VARCHAR(100)  NOT NULL,
    district       VARCHAR(100),
    postal_index   CHAR(6)       NOT NULL,
    phone          VARCHAR(20)
);

CREATE TABLE mail_acceptance2 (
    track_number     VARCHAR(20)   NOT NULL,
    office_code      INTEGER       NOT NULL
    accepted_at      TIMESTAMP     NOT NULL,
    declared_value   NUMERIC(10,2) NOT NULL,
    total_cost       NUMERIC(10,2) NOT NULL,
    is_paid          BOOLEAN       NOT NULL,
    sent_at          TIMESTAMP
);