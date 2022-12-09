CREATE DATABASE M141;
USE M141;

CREATE TABLE `Type` (
    ID_Type INT PRIMARY KEY AUTO_INCREMENT,
    `Type` VARCHAR(100)
);

CREATE TABLE `Tag` (
    ID_Tag INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(100)
);

CREATE TABLE `Systemuser` (
    ID_Systemuser INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(50)
);

CREATE TABLE `Usergroup` (
    ID_Usergroup INT PRIMARY KEY,
    `Name` VARCHAR(50)
);


CREATE TABLE `Data` (
    ID_Data INT PRIMARY KEY AUTO_INCREMENT,
    `Digest` VARCHAR(100),
    `Content` TEXT,
    `Size` INT,
    `Compression` SMALLINT,
    Type_ID INT,
    FOREIGN KEY (Type_ID)
        REFERENCES `Type` (ID_Type)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Data_Tag (
    Data_ID INT,
    Tag_ID INT,
    PRIMARY KEY (Data_ID , Tag_ID),
    FOREIGN KEY (Data_ID)
        REFERENCES `Data` (ID_Data)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Tag_ID)
        REFERENCES `Tag` (ID_Tag)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `Meta` (
    ID_Meta INT PRIMARY KEY AUTO_INCREMENT,
    `Path` VARCHAR(100),
    `Time` LONG,
    Systemuser_ID INT,
    Usergroup_ID INT,
    Data_ID INT,
    FOREIGN KEY (Systemuser_ID)
        REFERENCES `Systemuser` (ID_Systemuser)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Usergroup_ID)
        REFERENCES `Usergroup` (ID_Usergroup)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Data_ID)
        REFERENCES `Data` (ID_Data)
        ON UPDATE CASCADE ON DELETE CASCADE
);