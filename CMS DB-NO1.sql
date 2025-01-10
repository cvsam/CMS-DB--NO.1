drop database cms;
create database cms;
use cms;
create table Properties (
    PropertyID INT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Type VARCHAR(50) CHECK (Type IN ('Residential', 'Commercial', 'Industrial')),
    Size INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Available', 'Sold', 'Rented'))
);
select * from properties;
-- insert 10 Records.

insert into properties(PropertyID, Address, City, Type, Size, Price, Status)
values(1,"10 Main St","Kampala","Residential",1200, 15000.0,"Available"),
(2,"74 jinja road", "kampala","Residential",1210,1600.45,"Rented"),
(3,"west avenue", "wakiso", "industrial", 1600, 32000.8,"Available"),
(4, "namanve", "wakiso", "industrial", 1800, 45000.0, "Rented"),
(5, "jomayi","mukono", "industrial", 500, 23000.23, "Available"),
(6,"nansaana","kampala", "commercial", 1100, 1532.12, "sold"),
(7, "naalya", "kampala", "Residential", 900, 54313.0, "Rented"),
(8, "mutungo", "kampala", "commercial", 1100, 9754.5,"sold"),
(9,"namugongo", "kampala", "Residential", 450, 20000.0, "available"),
(10, "11 street", "kampala", "commercial", 800, 35000.0, "Rented");


-- properties for sale in a pecific city
SELECT * FROM Properties WHERE City = 'kampala' AND Status = 'Available';
-- properties status.
create table Properties (
    PropertyID INT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Type VARCHAR(50) CHECK (Type IN ('Residential', 'Commercial', 'Industrial')),
    Size INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Available', 'Sold', 'Rented'))
);
-- commissionRate
create table Agents (
    AgentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) UNIQUE,
    CommissionRate DECIMAL(5,2) CHECK (CommissionRate >= 1 AND CommissionRate <= 15)
);
DELIMITER $$
CREATE TRIGGER CheckTransactionAmount
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE propertyPrice DECIMAL(10,2);
    SELECT Price INTO propertyPrice FROM Properties WHERE PropertyID = NEW.PropertyID;
    IF NEW.Amount > propertyPrice THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction amount cannot exceed the listed property price';
    END IF;
END$$
DELIMITER ;

