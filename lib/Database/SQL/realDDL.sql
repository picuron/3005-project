-- Everything without a FK will be created first
CREATE TABLE cart
  (
    cart_id         SERIAL,
    PRIMARY KEY (cart_id)
  );

CREATE TABLE author_email
  (
    email_address  VARCHAR(50),
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    PRIMARY KEY (email_address)
  );

CREATE TABLE owner_email
  (
    email_address  VARCHAR(50),
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    PRIMARY KEY (email_address)
  );

CREATE TABLE publisher_email
  (
    email_address  VARCHAR(50),
    name           VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (email_address)         
  );

CREATE TABLE customer_email
  (
    email_address VARCHAR(50), 
    first_name    VARCHAR(50) NOT NULL, 
    last_name     VARCHAR(50) NOT NULL, 
    PRIMARY KEY (email_address)
  );

CREATE TABLE publisher_bank
  (
    bank_account   BIGINT,
    account_value  INT NOT NULL,
    PRIMARY KEY (bank_account)
  );

CREATE TABLE region
  (
    postal_code VARCHAR(6), 
    city        VARCHAR(100) NOT NULL, 
    country     VARCHAR(100) NOT NULL,
    PRIMARY KEY (postal_code)
  );

-- region makes address possible 
CREATE TABLE address
  (
    address_id      SERIAL, 
    street_number   VARCHAR(8) NOT NULL, 
    street_name     VARCHAR(100) NOT NULL, 
    postal_code     VARCHAR(6) NOT NULL,
    PRIMARY KEY (address_id),
    FOREIGN KEY (postal_code) REFERENCES region
    ON DELETE CASCADE
  );

-- Primary Entities
CREATE TABLE author
  (
    a_id           SERIAL,
    email_address  VARCHAR(50),
    PRIMARY KEY (a_id),
    FOREIGN KEY (email_address) REFERENCES author_email
    ON DELETE SET NULL
  );

CREATE TABLE publisher
  (
    p_id           SERIAL,
    address_id     INT,
    email_address  VARCHAR(50),
    bank_account   BIGINT,
    PRIMARY KEY (p_id),
    FOREIGN KEY (address_id) REFERENCES address
    ON DELETE SET NULL,
    FOREIGN KEY (email_address) REFERENCES publisher_email
    ON DELETE SET NULL,
    FOREIGN KEY (bank_account) REFERENCES publisher_bank
    ON DELETE SET NULL
  );

CREATE TABLE book
  (
    isbn           INT,   
    p_id           INT,
    title          VARCHAR(80) NOT NULL UNIQUE,
    genre          VARCHAR(50) NOT NULL,
    royalty        NUMERIC(4,2) NOT NULL CHECK (royalty >= 0 and royalty <= 100),
    num_pages      SMALLINT NOT NULL CHECK (num_pages > 0),
    price          NUMERIC(6,2) NOT NULL CHECK (price >= 0),
    cost           NUMERIC(6,2) NOT NULL CHECK (cost >= 0),
    num_in_stock   SMALLINT NOT NULL CHECK (num_in_stock >= 0),
    threshold_num  SMALLINT NOT NULL CHECK (threshold_num >= 0),
    num_sold       INT NOT NULL CHECK (num_sold >= 0),
    PRIMARY KEY (isbn),
    FOREIGN KEY (p_id) REFERENCES publisher
    ON DELETE SET NULL
  );

CREATE TABLE owner
  (
    o_id           SERIAL,
    email_address  VARCHAR(50),
    username       VARCHAR(50) NOT NULL,
    password       VARCHAR(50) NOT NULL,
    PRIMARY KEY (o_id),
    FOREIGN KEY (email_address) REFERENCES owner_email
    ON DELETE SET NULL
  );

CREATE TABLE customer
  (
    c_id                  SERIAL, 
    shipping_address_id   INT, 
    billing_address_id    INT,
    email_address         VARCHAR(50),
    username              VARCHAR(50) NOT NULL,
    password              VARCHAR(50) NOT NULL,
    PRIMARY KEY (c_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address
    ON DELETE SET NULL,
    FOREIGN KEY (billing_address_id) REFERENCES address
    ON DELETE SET NULL,
    FOREIGN KEY (email_address) REFERENCES customer_email
    ON DELETE SET NULL
  );

CREATE TABLE reports
  (
    r_id           SERIAL,
    o_id           INT,
    day            SMALLINT NOT NULL CHECK (day > 0 and day < 32),
    month          SMALLINT NOT NULL CHECK (month > 0 and month < 13),
    year           SMALLINT NOT NULL CHECK (year > 1500 and year < 2022),
    report_type    VARCHAR(50) NOT NULL,
    result         VARCHAR(200) NOT NULL,
    PRIMARY KEY (r_id),
    FOREIGN KEY (o_id) REFERENCES owner
    ON DELETE SET NULL
  );

CREATE TABLE checkout
  (
    check_id            SERIAL, 
    billing_address_id  INT NOT NULL, 
    shipping_address_id INT NOT NULL, 
    c_id                INT NOT NULL, 
    cart_id             INT NOT NULL, 
    day                 SMALLINT NOT NULL CHECK (day > 0 and day < 32), 
    month               SMALLINT NOT NULL CHECK (month > 0 and month < 13),
    year                SMALLINT NOT NULL CHECK (year > 1500 and year < 2022),
    PRIMARY KEY (check_id),
    FOREIGN KEY (billing_address_id) REFERENCES address
    ON DELETE SET NULL,
    FOREIGN KEY (shipping_address_id) REFERENCES address
    ON DELETE SET NULL,
    FOREIGN KEY (c_id) REFERENCES customer
    ON DELETE SET NULL, 
    FOREIGN KEY (cart_id) REFERENCES cart
    ON DELETE SET NULL
  );

CREATE TABLE orders
  (
    order_number   SERIAL, 
    o_id           INT, 
    check_id       INT, 
    cl_city        VARCHAR(80) NOT NULL,
    cl_country     VARCHAR(80) NOT NULL,
    status         VARCHAR(20) NOT NULL,
    PRIMARY KEY (order_number),
    FOREIGN KEY (o_id) REFERENCES owner
    ON DELETE SET NULL,
    FOREIGN KEY (check_id) REFERENCES checkout
    ON DELETE SET NULL
  );

-- Join Tables

CREATE TABLE cart_books
  (
    cart_id        INT,
    isbn           INT,
    PRIMARY KEY (cart_id, isbn),
    FOREIGN KEY (cart_id) REFERENCES cart
    ON DELETE CASCADE,
    FOREIGN KEY (isbn) REFERENCES book
    ON DELETE CASCADE
  );

CREATE TABLE author_books
  (
    isbn           INT,
    a_id           INT,
    PRIMARY KEY (isbn, a_id),
    FOREIGN KEY (a_id) REFERENCES author
    ON DELETE CASCADE,
    FOREIGN KEY (isbn) REFERENCES book
    ON DELETE CASCADE
  );

-- Phone Number Tables

CREATE TABLE author_phone_number
  (
    a_id           INT,
    phone_number   VARCHAR(30),
    PRIMARY KEY (a_id, phone_number),
    FOREIGN KEY (a_id) REFERENCES author
    ON DELETE CASCADE
  );

CREATE TABLE owner_phone_number
  (
    o_id           INT,
    phone_number   VARCHAR(30),
    PRIMARY KEY (o_id, phone_number),
    FOREIGN KEY (o_id) REFERENCES owner
    ON DELETE CASCADE
  );

CREATE TABLE customer_phone_number
  (
    c_id           INT,
    phone_number   VARCHAR(30),
    PRIMARY KEY (c_id, phone_number),
    FOREIGN KEY (c_id) REFERENCES customer
    ON DELETE CASCADE
  );

CREATE TABLE publisher_phone_number
  (
    p_id           INT,
    phone_number   VARCHAR(30),
    PRIMARY KEY (p_id, phone_number),
    FOREIGN KEY (p_id) REFERENCES publisher
    ON DELETE CASCADE
  );
