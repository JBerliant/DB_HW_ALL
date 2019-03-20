
--DROP DATABASE IF EXISTS tavern_db;
--CREATE DATABASE tavern_db;
USE JBerliant_2019;

GO

DROP TABLE IF EXISTS delivery_received;
DROP TABLE IF EXISTS tavern_sales;
DROP TABLE IF EXISTS service_status;
DROP TABLE IF EXISTS service_desc;
DROP TABLE IF EXISTS room_stays;
DROP TABLE IF EXISTS tavern_rooms;
DROP TABLE IF EXISTS tavern_inventory;
DROP TABLE IF EXISTS tavern_supplies;
DROP TABLE IF EXISTS tavern_employment;
DROP TABLE IF EXISTS role_desc;
DROP TABLE IF EXISTS classlvl;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS tavern_visitors;
DROP TABLE IF EXISTS employee_id;
DROP TABLE IF EXISTS visitor_id;
DROP TABLE IF EXISTS tavern_humanoids;
DROP TABLE IF EXISTS tavern_info;


CREATE TABLE tavern_info(
tavern_id INT PRIMARY KEY NOT NULL,
tavern_name VARCHAR(50) NOT NULL,
tavern_location VARCHAR(50) NOT NULL,
tavern_floors INT
);

CREATE TABLE role_desc
(
employee_role VARCHAR(30) PRIMARY KEY,
role_desc VARCHAR(255)
);

CREATE TABLE tavern_humanoids --anyone who interacts with the tavern and their information - employee, customer
(  
humanoid_id INT IDENTITY(100001,1) PRIMARY KEY NOT NULL,
humanoid_name VARCHAR(30),
humanoid_title VARCHAR(50),
humanoid_birthday DATE,
humanoid_cakeday DATE,
humanoid_race VARCHAR(30),
humanoid_class VARCHAR(30), --starting class
humanoid_notes VARCHAR(255)
);


CREATE TABLE employee_id(
employee_id INT IDENTITY(900001,1) PRIMARY KEY,   --If a humanoid has more than one role, or works at more than one tavern - humanoid will repeat, but employee ID will not.
humanoid_id INT
FOREIGN KEY (humanoid_id) REFERENCES tavern_humanoids(humanoid_id) ON DELETE CASCADE
);

create table tavern_employment
(
employment_id INT IDENTITY (70001,1) PRIMARY KEY, --sometimes an employee is rehired for the same job, but a different term, employment_id is the identifier of term of employment in a role for the employee
employee_id INT,
tavern_id INT,
employee_role VARCHAR(30),
role_start_date DATE,
role_end_date DATE, 
admin_status VARCHAR(10),
FOREIGN KEY(tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE,
FOREIGN KEY (employee_role) REFERENCES role_desc(employee_role) ON DELETE CASCADE,
FOREIGN KEY (employee_id) REFERENCES employee_id(employee_id) ON DELETE CASCADE
);

CREATE TABLE tavern_supplies --description of supply types--
(
item_sku INT IDENTITY (33001,1) PRIMARY KEY,
item_name VARCHAR(100),
item_unit VARCHAR(30),
item_cost DEC(6,2), 
last_update TIMESTAMP
);

CREATE TABLE tavern_inventory
(
item_sku INT,
tavern_id INT NOT NULL,
item_qty INT,
item_sale_price DEC(6,2),
last_delivery DATETIME2(0),
last_updated TIMESTAMP,
FOREIGN KEY(item_sku) REFERENCES tavern_supplies(item_sku) ON DELETE CASCADE,
FOREIGN KEY(tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE,
PRIMARY KEY (item_sku, tavern_id)
);


CREATE TABLE delivery_received
(
order_id INT IDENTITY(888001,1) PRIMARY KEY,
tavern_id INT,
item_sku INT,
order_qty INT,
order_total DEC(6,2),
delivery_time DATETIME2(0),
FOREIGN KEY(item_sku) REFERENCES tavern_supplies(item_sku) ON DELETE CASCADE,
FOREIGN KEY (tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE
);


CREATE TABLE service_desc 
(
service_id int IDENTITY (1, 1) PRIMARY KEY,
service_title VARCHAR(50) NOT NULL,
service_desc VARCHAR(255)
);

CREATE TABLE service_status
(
service_id INT,
tavern_id INT,
service_status VARCHAR(20),
FOREIGN KEY(service_id) REFERENCES service_desc(service_id) ON DELETE CASCADE,
FOREIGN KEY (tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE,
PRIMARY KEY (service_id, tavern_id)
);

CREATE TABLE visitor_id
(
visitor_id INT IDENTITY(600001,1) PRIMARY KEY, --each visit is unique. guests and taverns are repeated - especially for regulars and employees off shift hours
humanoid_id INT,
tavern_id INT,
FOREIGN KEY (tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE,
FOREIGN KEY (humanoid_id) REFERENCES tavern_humanoids(humanoid_id) ON DELETE CASCADE
);

CREATE TABLE class(
class_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
class_name VARCHAR(30),
class_desc VARCHAR(255),
--party_role1 VARCHAR(50),
--party_role2 VARCHAR(50)
);

CREATE TABLE classlvl(
guest_id INT REFERENCES visitor_id(visitor_id),
class_id SMALLINT REFERENCES class(class_id),
lvl SMALLINT,
updated DATETIME2(0) DEFAULT GETDATE(),
PRIMARY KEY (class_id,guest_id)
);

CREATE TABLE tavern_visitors(
visitor_id INT PRIMARY KEY,
visitor_status VARCHAR(150),
visitor_class VARCHAR(30), -- in case of a class change
visitor_level INT, -- current level
visitor_notes VARCHAR(255),
visitor_in DATETIME2(0),
visitor_out DATETIME2(0),
FOREIGN KEY (visitor_id) REFERENCES visitor_id(visitor_id) ON DELETE CASCADE
);


CREATE TABLE tavern_rooms(
room_id INT IDENTITY (474001,1) PRIMARY KEY,
room_attr VARCHAR(100),
room_status VARCHAR(50),
room_rate DEC(6,2),
tavern_id INT FOREIGN KEY REFERENCES tavern_info(tavern_id) ON DELETE CASCADE
);

CREATE TABLE room_stays (
stay_id INT PRIMARY KEY IDENTITY (674001,1),
room_id INT FOREIGN KEY REFERENCES tavern_rooms(room_id) ON DELETE CASCADE,
guest_id INT FOREIGN KEY REFERENCES visitor_id(visitor_id),
DATE_IN DATETIME2(0),
DATE_OUT DATETIME2(0),
days_stayed SMALLINT,
sale_amt DEC (8,2),
time_of_sale DATETIME2(0)
);


CREATE TABLE tavern_sales
(
sale_id INT IDENTITY (310000,1) PRIMARY KEY,
customer_id INT,
service_id INT,
service_price DEC(6,2),
service_qty INT,
total_sale DEC(6,2) NOT NULL,
sale_datetime DATETIME2(0),
tavern_id INT,
FOREIGN KEY(tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE,
FOREIGN KEY(service_id) REFERENCES service_desc(service_id) ON DELETE CASCADE
);

CREATE TABLE tavern_item_sales
(
it_sale INT IDENTITY (1,1) PRIMARY KEY,
customer_id INT FOREIGN KEY REFERENCES visitor_id(visitor_id),
item_sku INT,
qty INT,
total_sale DEC(8,2) NOT NULL,
sale_datetime DATETIME2(0),
tavern_id INT,
FOREIGN KEY(tavern_id) REFERENCES tavern_info(tavern_id) ON DELETE CASCADE,
FOREIGN KEY(item_sku) REFERENCES tavern_supplies(item_sku) ON DELETE CASCADE
);




ALTER TABLE tavern_sales
ADD CONSTRAINT FK_VisitorID
FOREIGN KEY (customer_id) REFERENCES visitor_id(visitor_id);
GO