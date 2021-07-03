create database if not exists sales;
use sales;

CREATE TABLE sales (
    purchase_number 	INT 			NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase 	DATE 			NOT NULL,
    customer_id 		INT,
    item_code 			VARCHAR(10) 	NOT NULL
);

alter table sales
add foreign key (customer_id) references customers (customer_id) on delete cascade;


-- select * from customers
-- select * from sales.customers

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

alter table customers
change column number_of_complaints number_of_complaints int default 0;

CREATE TABLE items (
    item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255),
    PRIMARY KEY (item_code)
);

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number INT(12),
    PRIMARY KEY (company_id),
    UNIQUE KEY (headquarters_phone_number)
);


drop table sales, customers, items, companies;



INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);


INSERT INTO customers (first_name, last_name, gender)
VALUES ('peter', 'figaro', 'M');

