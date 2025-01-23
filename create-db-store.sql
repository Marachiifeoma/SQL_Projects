DROP DATABASE IF EXISTS Store;
CREATE DATABASE store;


CREATE TABLE products (
  product_id SMALLSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  quantity_in_stock INT NOT NULL,
  unit_price DECIMAL(4,2) NOT NULL
);
INSERT INTO products(name, quantity_in_stock, unit_price) VALUES
	('Foam Dinner Plate',70,1.21),
	('Pork - Bacon,back Peameal',49,4.65),
	('Lettuce - Romaine, Heart',38,3.35),
	('Brocolinni - Gaylan, Chinese',90,4.53),
	('Sauce - Ranch Dressing',94,1.63),
	('Petit Baguette',14,2.39),
	('Sweet Pea Sprouts',98,3.29),
	('Island Oasis - Raspberry',26,0.74),
	('Longan',67,2.26),
	('Broom - Push',6,1.09);


CREATE TABLE shippers (
  shipper_id SMALLSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);
INSERT INTO shippers(name) VALUES 
	('Hettinger LLC'),
	('Schinner-Predovic'),
	('Satterfield LLC'),
	('Mraz, Renner and Nolan'),
	('Waters, Mayert and Prohaska');


CREATE TABLE customers (
  customer_id SMALLSERIAL NOT NULL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birth_date DATE NULL,
  phone VARCHAR(50) NULL,
  address VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state CHAR(2) NOT NULL,
  points INT NOT NULL DEFAULT 0
);
INSERT INTO customers(first_name, last_name, birth_date, phone,address, city, state, points) VALUES
	('Babara','MacCaffrey','1986-03-28','781-932-9754','0 Sage Terrace','Waltham','MA',2273),
	('Ines','Brushfield','1986-04-13','804-427-9456','14187 Commercial Trail','Hampton','VA',947),
	('Freddi','Boagey','1985-02-07','719-724-7869','251 Springs Junction','Colorado Springs','CO',2967),
	('Ambur','Roseburgh','1974-04-14','407-231-8017','30 Arapahoe Terrace','Orlando','FL',457),
	('Clemmie','Betchley','1973-11-07',NULL,'5 Spohn Circle','Arlington','TX',3675),
	('Elka','Twiddell','1991-09-04','312-480-8498','7 Manley Drive','Chicago','IL',3073),
	('Ilene','Dowson','1964-08-30','615-641-4759','50 Lillian Crossing','Nashville','TN',1672),
	('Thacher','Naseby','1993-07-17','941-527-3977','538 Mosinee Center','Sarasota','FL',205),
	('Romola','Rumgay','1992-05-23','559-181-3744','3520 Ohio Trail','Visalia','CA',1486),
	('Levy','Mynett','1969-10-13','404-246-3370','68 Lawn Avenue','Atlanta','GA',796);


CREATE TABLE order_statuses (
  order_status_id SMALLINT NOT NULL PRIMARY KEY,
  name varchar(50) NOT NULL
);
INSERT INTO order_statuses(order_status_id, name) VALUES
	(1,'Processed'),
	(2,'Shipped'),
	(3,'Delivered');


CREATE TABLE orders (
  order_id SMALLSERIAL NOT NULL PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  status SMALLINT NOT NULL DEFAULT '1',
  comments VARCHAR(2000) NULL,
  shipped_date DATE NULL,
  shipper_id SMALLINT NULL,
  
  CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON UPDATE CASCADE,
  CONSTRAINT fk_orders_order_statuses FOREIGN KEY (status) REFERENCES order_statuses (order_status_id) ON UPDATE CASCADE,
  CONSTRAINT fk_orders_shippers FOREIGN KEY (shipper_id) REFERENCES shippers (shipper_id) ON UPDATE CASCADE
);

	CREATE INDEX fk_orders_customers_idx ON orders (customer_id);
	CREATE INDEX fk_orders_shippers_idx ON orders(shipper_id);
	CREATE INDEX fk_orders_order_statuses_idx ON orders (status);

INSERT INTO orders(customer_id, order_date, status, comments, shipped_date,shipper_id) VALUES
	(6,'2019-01-30',1,NULL,NULL,NULL),
	(7,'2018-08-02',2,NULL,'2018-08-03',4),
	(8,'2017-12-01',1,NULL,NULL,NULL),
	(2,'2017-01-22',1,NULL,NULL,NULL),
	(5,'2017-08-25',2,'','2017-08-26',3),
	(10,'2018-11-18',1,'Aliquam erat volutpat. In congue.',NULL,NULL),
	(2,'2018-09-22',2,NULL,'2018-09-23',4),
	(5,'2018-06-08',1,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,NULL),
	(10,'2017-07-05',2,'Nulla mollis molestie lorem. Quisque ut erat.','2017-07-06',1),
	(6,'2018-04-22',2,NULL,'2018-04-23',2);


CREATE TABLE order_items (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(4,2) NOT NULL,
  
  CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders (order_id) ON UPDATE CASCADE,
  CONSTRAINT fk_order_items_products FOREIGN KEY (product_id) REFERENCES products (product_id) ON UPDATE CASCADE
);
	CREATE INDEX fk_order_items_products_idx ON order_items (product_id);

INSERT INTO order_items(order_id, product_id, quantity, unit_price) VALUES
	(1,4,4,3.74),
	(2,1,2,9.10),
	(2,4,4,1.66),
	(2,6,2,2.94),
	(3,3,10,9.12),
	(4,3,7,6.99),
	(4,10,7,6.40),
	(5,2,3,9.89),
	(6,1,4,8.65),
	(6,2,4,3.28),
	(6,3,4,7.46),
	(6,5,1,3.45),
	(7,3,7,9.17),
	(8,5,2,6.94),
	(8,8,2,8.59),
	(9,6,5,7.28),
	(10,1,10,6.01),
	(10,9,9,4.28);

CREATE TABLE order_item_notes (
  note_id INT NOT NULL PRIMARY KEY,
  order_Id INT NOT NULL,
  product_id INT NOT NULL,
  note VARCHAR(255) NOT NULL
);

INSERT INTO order_item_notes (note_id, order_Id, product_id, note) VALUES 
	('1', '1', '2', 'first note'),
	('2', '1', '2', 'second note');
