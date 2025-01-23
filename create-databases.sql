DROP DATABASE IF EXISTS sql_invoicing;
CREATE DATABASE sql_invoicing; 


SET NAMES 'utf8';
SET CLIENT_ENCODING TO 'UTF8';

CREATE TABLE payment_methods (
    payment_method_id SMALLSERIAL PRIMARY KEY, -- Automatically incrementing ID
    payment_name VARCHAR(50) NOT NULL
);

-- Insert data
INSERT INTO payment_methods (payment_name) VALUES 
('Credit Card'),
('Cash'),
('PayPal'),
('Wire Transfer');

CREATE TABLE clients (
  client_id INT NOT NULL PRIMARY KEY,
  client_name VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state CHAR(2) NOT NULL,
  phone VARCHAR(50) DEFAULT NULL
);
INSERT INTO clients(client_id, client_name, address, city, state, phone) VALUES
	(1,'Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305'),
	(2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170'),
	(3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037'),
	(4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784'),
	(5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

CREATE TABLE invoices (
  invoice_id INT NOT NULL PRIMARY KEY,
  number VARCHAR(50) NOT NULL,
  client_id INT NOT NULL,
  invoice_total DECIMAL(9,2) NOT NULL,
  payment_total DECIMAL(9,2) NOT NULL DEFAULT 0.00,
  invoice_date DATE NOT NULL,
  due_date DATE NOT NULL,
  payment_date DATE DEFAULT NULL,
  CONSTRAINT fk_clients FOREIGN KEY (client_id) REFERENCES clients (client_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO invoices(
	invoice_id,
	number, 
	client_id,
	invoice_total,
	payment_total,
	invoice_date,
	due_date,
	payment_date) VALUES
	(1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL),
	(2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12'),
	(3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL),
	(4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL),
	(5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL),
	(6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03'),
	(7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL),
	(8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL),
	(9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL),
	(10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL),
	(11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11'),
	(13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26'),
	(15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15'),
	(16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL),
	(17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15'),
	(18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08'),
	(19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

CREATE TABLE payments (
  payment_id SERIAL PRIMARY KEY,
  client_id INT NOT NULL,
  invoice_id INT NOT NULL,
  date DATE NOT NULL,
  amount DECIMAL(9,2) NOT NULL,
  payment_method SMALLINT NOT NULL,
  CONSTRAINT fk_payment_client FOREIGN KEY (client_id) REFERENCES clients (client_id) ON UPDATE CASCADE,
  CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id) ON UPDATE CASCADE,
  CONSTRAINT fk_payment_payment_method FOREIGN KEY (payment_method) REFERENCES payment_methods (payment_method_id)
);

	CREATE INDEX fk_client_id_idx ON payments (client_id);
	CREATE INDEX fk_invoice_id_idx ON payments (invoice_id);
	CREATE INDEX fk_payment_payment_method_idx ON payments (payment_method);

INSERT INTO payments (client_id, invoice_id, date, amount, payment_method) VALUES 
	(5,2,'2019-02-12',8.18,1),
	(1,6,'2019-01-03',74.55,1),
	(3,11,'2019-01-11',0.03,1),
	(5,13,'2019-01-26',87.44,1),
	(3,15,'2019-01-15',80.31,1),
	(3,17,'2019-01-15',68.10,1),
	(5,18,'2019-01-08',32.77,1),
	(5,18,'2019-01-08',10.00,2);


