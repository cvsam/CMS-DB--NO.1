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

