-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema vratomir
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `vratomir` ;

-- -----------------------------------------------------
-- Schema vratomir
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vratomir` DEFAULT CHARACTER SET utf8 ;
USE `vratomir` ;

-- -----------------------------------------------------
-- Table `vratomir`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`User` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`User` (
  `Id` INT NOT NULL,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FirstName` NVARCHAR(100) NOT NULL,
  `LastName` NVARCHAR(100) NOT NULL,
  `Email` NVARCHAR(45) NOT NULL,
  `UserName` NVARCHAR(45) NOT NULL,
  `CellPhone` VARCHAR(45) NULL,
  `Workphone` VARCHAR(45) NULL,
  `Password` VARCHAR(128) NOT NULL,
  `Salt` VARCHAR(36) NOT NULL,
  `IsPasswordExpired` BIT NOT NULL DEFAULT 0,
  `AllowLogin` BIT NOT NULL DEFAULT 1,
  `LastPasswordChangeDate` DATETIME NULL,
  `CreatedUser_Id` INT NULL,
  `UpdatedUser_Id` INT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Password_UNIQUE` (`Password` ASC),
  UNIQUE INDEX `ix_Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `ix_Username_UNIQUE` (`UserName` ASC),
  INDEX `fk_User_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  INDEX `fk_User_User_CreatedUser_idx` (`CreatedUser_Id` ASC),
  UNIQUE INDEX `Salt_UNIQUE` (`Salt` ASC),
  CONSTRAINT `fk_User_User_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Actor` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Actor` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_Actor_User` (`User_Id` ASC),
  INDEX `fk_Actor_User_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_Actor_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_Actor_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actor_User_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actor_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Stage` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Stage` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Role` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Role` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` NVARCHAR(100) NOT NULL,
  `Description` NVARCHAR(100) NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`UserRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`UserRole` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`UserRole` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Role_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_UserRole_Role` (`Role_Id` ASC),
  INDEX `ix_UserRole_User` (`User_Id` ASC),
  CONSTRAINT `fk_UserRole_Role1`
    FOREIGN KEY (`Role_Id`)
    REFERENCES `vratomir`.`Role` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserRole_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Policy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Policy` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Policy` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`RolePolicy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`RolePolicy` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`RolePolicy` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Policy_Id` INT NOT NULL,
  `Role_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_UserPolicy_Policy` (`Policy_Id` ASC),
  INDEX `ix_RolePolicy_Role` (`Role_Id` ASC),
  CONSTRAINT `fk_RolePolicy_Policy1`
    FOREIGN KEY (`Policy_Id`)
    REFERENCES `vratomir`.`Policy` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RolePolicy_Role1`
    FOREIGN KEY (`Role_Id`)
    REFERENCES `vratomir`.`Role` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`SiteMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`SiteMap` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`SiteMap` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `URL` VARCHAR(255) NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Parent_SiteMap_Id` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_SiteMap_SiteMap` (`Parent_SiteMap_Id` ASC),
  CONSTRAINT `fk_SiteMap_SiteMap1`
    FOREIGN KEY (`Parent_SiteMap_Id`)
    REFERENCES `vratomir`.`SiteMap` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Permission` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Permission` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`SiteMapUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`SiteMapUser` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`SiteMapUser` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `SiteMap_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  `Permission_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_SiteMapUser_SiteMap` (`SiteMap_Id` ASC),
  INDEX `ix_SiteMapUser_User` (`User_Id` ASC),
  INDEX `ix_SiteMapUser_Permission` (`Permission_Id` ASC),
  CONSTRAINT `fk_SiteMapUser_SiteMap1`
    FOREIGN KEY (`SiteMap_Id`)
    REFERENCES `vratomir`.`SiteMap` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SiteMapUser_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SiteMapUser_Permission1`
    FOREIGN KEY (`Permission_Id`)
    REFERENCES `vratomir`.`Permission` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`UserDetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`UserDetail` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`UserDetail` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `User_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_UserDetail_User` (`User_Id` ASC),
  CONSTRAINT `fk_UserDetail_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Project` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Project` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DueDate` DATETIME NOT NULL,
  `Notes` NVARCHAR(1024) NULL,
  `Keywords` NVARCHAR(45) NULL,
  `Code` VARCHAR(45) NULL,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC),
  INDEX `fk_Project_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_Project_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_Project_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Project_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectStage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectStage` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectStage` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `StartDateTime` DATETIME NOT NULL,
  `EndDateTime` DATETIME NULL,
  `Estimated` INT NULL,
  `Done` INT NULL,
  `AcceptanceCriteria` TINYTEXT NULL,
  `DefinitionOfDone` TINYTEXT NULL,
  `Points` TINYINT(2) NULL,
  `Stage_Id` INT NOT NULL,
  `Project_Id` INT NOT NULL,
  `ProjectStage_Id` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectStage_Stage` (`Stage_Id` ASC),
  INDEX `ix_ProjectStage_Project` (`Project_Id` ASC),
  INDEX `ix_ProjectStage_ProjectStage` (`ProjectStage_Id` ASC),
  CONSTRAINT `fk_ProjectStage_Stage1`
    FOREIGN KEY (`Stage_Id`)
    REFERENCES `vratomir`.`Stage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectStage_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `vratomir`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectStage_ProjectStage1`
    FOREIGN KEY (`ProjectStage_Id`)
    REFERENCES `vratomir`.`ProjectStage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`Comment` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`Comment` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Content` NVARCHAR(1024) NOT NULL,
  `Comment_Id` INT NULL,
  `ProjectStage_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_Comment_Comment` (`Comment_Id` ASC),
  INDEX `ix_Comment_ProjectStage` (`ProjectStage_Id` ASC),
  INDEX `ix_Commnet_User` (`User_Id` ASC),
  CONSTRAINT `fk_Comment_Comment1`
    FOREIGN KEY (`Comment_Id`)
    REFERENCES `vratomir`.`Comment` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comment_ProjectStage1`
    FOREIGN KEY (`ProjectStage_Id`)
    REFERENCES `vratomir`.`ProjectStage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commnet_User`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`StagePermission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`StagePermission` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`StagePermission` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ActorProject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ActorProject` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ActorProject` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Project_Id` INT NOT NULL,
  `Actor_Id` INT NOT NULL,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  INDEX `ix_ActorStage_Project` (`Project_Id` ASC),
  INDEX `ix_ActorStage_Actor` (`Actor_Id` ASC),
  CONSTRAINT `fk_ActorStage_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `vratomir`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorStage_Actor1`
    FOREIGN KEY (`Actor_Id`)
    REFERENCES `vratomir`.`Actor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ActorStage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ActorStage` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ActorStage` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `WorkTime` TINYINT NULL DEFAULT 0,
  `PlannedTime` TINYINT NULL DEFAULT 0,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `ProjectStage_Id` INT NOT NULL,
  `Actor_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ActorStage_ProjectStage` (`ProjectStage_Id` ASC),
  INDEX `ix_ActorStage_Actor` (`Actor_Id` ASC),
  INDEX `fk_ActorStage_User_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_ActorStage_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ActorStage_ProjectStage1`
    FOREIGN KEY (`ProjectStage_Id`)
    REFERENCES `vratomir`.`ProjectStage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorStage_Actor2`
    FOREIGN KEY (`Actor_Id`)
    REFERENCES `vratomir`.`Actor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorStage_User_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorStage_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ActorStagePermission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ActorStagePermission` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ActorStagePermission` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `StagePermission_Id` INT NOT NULL,
  `ActorStage_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ActorStagePermission_StagePermission` (`StagePermission_Id` ASC),
  INDEX `ix_ActorStagePermission_ActorStage` (`ActorStage_Id` ASC),
  CONSTRAINT `fk_ActorStagePermission_StagePermission1`
    FOREIGN KEY (`StagePermission_Id`)
    REFERENCES `vratomir`.`StagePermission` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorStagePermission_ActorStage1`
    FOREIGN KEY (`ActorStage_Id`)
    REFERENCES `vratomir`.`ActorStage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`FeatureToggle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`FeatureToggle` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`FeatureToggle` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  `Description` NVARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectFeature` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectFeature` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Project_Id` INT NOT NULL,
  `FeatureToggle_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectFeature_Project` (`Project_Id` ASC),
  INDEX `ix_ProjectFeature_FeatureToggle` (`FeatureToggle_Id` ASC),
  CONSTRAINT `fk_ProjectFeature_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `vratomir`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectFeature_FeatureToggle1`
    FOREIGN KEY (`FeatureToggle_Id`)
    REFERENCES `vratomir`.`FeatureToggle` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`DocumentTemplate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`DocumentTemplate` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`DocumentTemplate` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  `Template` BLOB NOT NULL,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `ix_Code_UNIQUE` (`Code` ASC),
  INDEX `fk_DocumentTemplate_User_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_DocumentTemplate_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_DocumentTemplate_User_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DocumentTemplate_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`DocumentStorage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`DocumentStorage` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`DocumentStorage` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Data` BLOB NOT NULL,
  `FileExtension` VARCHAR(10) NOT NULL,
  `OriginalName` NVARCHAR(100) NOT NULL,
  `Remarks` NVARCHAR(100) NULL,
  `Keywords` NVARCHAR(100) NULL,
  `DocumentTemplate_Id` INT NOT NULL,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_DocumentStorage_DocumentTemplate` (`DocumentTemplate_Id` ASC),
  INDEX `fk_DocumentStorage_User_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_DocumentStorage_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_DocumentStorage_DocumentTemplate1`
    FOREIGN KEY (`DocumentTemplate_Id`)
    REFERENCES `vratomir`.`DocumentTemplate` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DocumentStorage_User_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DocumentStorage_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`DocumentStorageHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`DocumentStorageHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`DocumentStorageHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `Data` BLOB NOT NULL,
  `FileExtension` VARCHAR(10) NOT NULL,
  `OriginalName` NVARCHAR(100) NOT NULL,
  `Remarks` NVARCHAR(100) NULL,
  `Keywords` NVARCHAR(100) NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `DocumentStorage_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_DocumentStorageHistorization_DocumentStorage` (`DocumentStorage_Id` ASC),
  INDEX `fk_DocumentStorageHistorization_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_DocumentStorageHistorization_DocumentStorage1`
    FOREIGN KEY (`DocumentStorage_Id`)
    REFERENCES `vratomir`.`DocumentStorage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DocumentStorageHistorization_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`DocumentTemplateHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`DocumentTemplateHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`DocumentTemplateHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `Code` VARCHAR(45) NOT NULL,
  `Template` BLOB NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `DocumentTemplate_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_DocumentTemplateHistorization_DocumentTemplate` (`DocumentTemplate_Id` ASC),
  INDEX `fk_DocumentTemplateHistorization_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_DocumentTemplateHistorization_DocumentTemplate1`
    FOREIGN KEY (`DocumentTemplate_Id`)
    REFERENCES `vratomir`.`DocumentTemplate` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DocumentTemplateHistorization_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectExpense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectExpense` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectExpense` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Notes` NVARCHAR(255) NULL,
  `Project_Id` INT NOT NULL,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectExpense_Project` (`Project_Id` ASC),
  INDEX `fk_ProjectExpense_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_ProjectExpense_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ProjectExpense_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `vratomir`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectExpense_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectExpense_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectArrival`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectArrival` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectArrival` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` DATETIME NOT NULL,
  `UpdatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Notes` NVARCHAR(255) NULL,
  `Project_Id` INT NOT NULL,
  `CreatedUser_Id` INT NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectArrival_Project` (`Project_Id` ASC),
  INDEX `fk_ProjectArrival_CreatedUser_idx` (`CreatedUser_Id` ASC),
  INDEX `fk_ProjectArrival_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ProjectArrival_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `vratomir`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectArrival_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectArrival_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectArrivalHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectArrivalHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectArrivalHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Notes` NVARCHAR(255) NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `ProjectArrival_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectArrivalHistorization_ProjectArrival` (`ProjectArrival_Id` ASC),
  INDEX `fk_ProjectArrivalHistorization_UpdateUserId_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ProjectArrivalHistorization_ProjectArrival1`
    FOREIGN KEY (`ProjectArrival_Id`)
    REFERENCES `vratomir`.`ProjectArrival` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectArrivalHistorization_User_UpdateUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectExpenseHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectExpenseHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectExpenseHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Notes` NVARCHAR(255) NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `ProjectExpense_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectExpenseHistorization_ProjectExpense` (`ProjectExpense_Id` ASC),
  INDEX `fk_ProjectExpenseHistorization_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ProjectExpenseHistorization_ProjectExpense1`
    FOREIGN KEY (`ProjectExpense_Id`)
    REFERENCES `vratomir`.`ProjectExpense` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectExpenseHistorization_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`DocumentComment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`DocumentComment` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`DocumentComment` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `CreatedDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Text` MEDIUMTEXT NULL,
  `CreatedUser_Id` INT NOT NULL,
  `DocumentStorage_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_DocumentCommnet_DocumentStorage` (`DocumentStorage_Id` ASC),
  INDEX `fk_DocumentComment_User_CreatedUser_idx` (`CreatedUser_Id` ASC),
  CONSTRAINT `fk_DocumentComment_DocumentStorage1`
    FOREIGN KEY (`DocumentStorage_Id`)
    REFERENCES `vratomir`.`DocumentStorage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DocumentComment_User_CreatedUser`
    FOREIGN KEY (`CreatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ActorStageHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ActorStageHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ActorStageHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `WorkTime` TINYINT NULL DEFAULT 0,
  `PlannedTime` TINYINT NULL DEFAULT 0,
  `UpdatedUser_Id` INT NOT NULL,
  `ActorStage_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ActorStageHistorization_ActorStage` (`ActorStage_Id` ASC),
  INDEX `fk_ActorStageHistorization_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ActorStageHistorization_ActorStage1`
    FOREIGN KEY (`ActorStage_Id`)
    REFERENCES `vratomir`.`ActorStage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorStageHistorization_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`UserHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`UserHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`UserHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `FirstName` NVARCHAR(100) NOT NULL,
  `LastName` NVARCHAR(100) NOT NULL,
  `Email` NVARCHAR(45) NOT NULL,
  `UserName` NVARCHAR(45) NOT NULL,
  `CellPhone` VARCHAR(45) NULL,
  `WorkPhone` VARCHAR(45) NULL,
  `Password` VARCHAR(50) NOT NULL,
  `Salt` VARCHAR(64) NOT NULL,
  `IsPasswordExpired` BIT NOT NULL DEFAULT 0,
  `AllowLogin` BIT NOT NULL DEFAULT 1,
  `LastPasswordChangeDate` DATETIME NULL,
  `User_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_UserHistorization_User_idx` (`User_Id` ASC),
  CONSTRAINT `fk_UserHistorization_User_User`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`StageHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`StageHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`StageHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `Code` VARCHAR(45) NOT NULL,
  `Stage_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_StageHistorization_Stage` (`Stage_Id` ASC),
  CONSTRAINT `fk_StageHistorization_Stage1`
    FOREIGN KEY (`Stage_Id`)
    REFERENCES `vratomir`.`Stage` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ProjectHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ProjectHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ProjectHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `Price` DECIMAL(2) NOT NULL DEFAULT 0.0,
  `DueDate` DATETIME NOT NULL,
  `Notes` NVARCHAR(1024) NULL,
  `Keywords` NVARCHAR(45) NULL,
  `Code` VARCHAR(45) NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `Project_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ix_ProjectHistorization_Project` (`Project_Id` ASC),
  INDEX `fk_ProjectHistorization_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  CONSTRAINT `fk_ProjectHistorization_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `vratomir`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectHistorization_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vratomir`.`ActorHistorization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vratomir`.`ActorHistorization` ;

CREATE TABLE IF NOT EXISTS `vratomir`.`ActorHistorization` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Invalidated` BIT NOT NULL DEFAULT 0,
  `UpdatedDateTime` TIMESTAMP NOT NULL,
  `UpdatedUser_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  `Actor_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_ActorHistorization_User_UpdatedUser_idx` (`UpdatedUser_Id` ASC),
  INDEX `fk_ActorHistorization_User_UserId_idx` (`User_Id` ASC),
  INDEX `fk_ActorHistorization_Actor_Actor_idx` (`Actor_Id` ASC),
  CONSTRAINT `fk_ActorHistorization_User_UpdatedUser`
    FOREIGN KEY (`UpdatedUser_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorHistorization_User_User`
    FOREIGN KEY (`User_Id`)
    REFERENCES `vratomir`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActorHistorization_Actor_Actor`
    FOREIGN KEY (`Actor_Id`)
    REFERENCES `vratomir`.`Actor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `vratomir`;

DELIMITER $$

USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`User_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`User_BEFORE_INSERT` BEFORE INSERT ON `User` FOR EACH ROW
BEGIN
declare salt nvarchar(36) default UUID();
set New.Salt = salt;
set New.Password = SHA2(CONCAT(salt, New.Password), 512);
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`User_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`User_AFTER_UPDATE` AFTER UPDATE ON `User` FOR EACH ROW
BEGIN
INSERT INTO UserHistorization(Invalidated, UpdatedDateTime, FirstName, LastName, Email, UserName, CellPhone, WorkPhone, Password, Salt, IsPasswordExpired, AllowLogin, LastPasswordChangeDate, User_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.FirstName, OLD.LastName, OLD.Email, OLD.UserName, OLD.CellPhone, OLD.WorkPhone, OLD.Password, OLD.Salt, OLD.IsPasswordExpired, OLD.AllowLogin, OLD.LastPasswordChangeDate, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`Actor_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`Actor_BEFORE_INSERT` BEFORE INSERT ON `Actor` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`Actor_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`Actor_AFTER_UPDATE` AFTER UPDATE ON `Actor` FOR EACH ROW
BEGIN
INSERT INTO ActorHistorization(Invalidated, UpdatedDateTime, UpdatedUser_Id, User_Id, Actor_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.UpdatedUser_Id, OLD.User_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`Stage_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`Stage_AFTER_UPDATE` AFTER UPDATE ON `Stage` FOR EACH ROW
BEGIN
INSERT INTO StageHistorization(Invalidated, Code, Stage_Id) VALUES (OLD.Invalidated, OLD.Code, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`Project_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`Project_AFTER_UPDATE` AFTER UPDATE ON `Project` FOR EACH ROW
BEGIN
INSERT INTO ProjectHistorization(Invalidated, UpdatedDateTime, Price, DueDate, Notes, Keywords, Code, UpdatedUser_Id, Project_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.Price, OLD.DueDate, OLD.Notes, OLD.Keywords, OLD.Code, OLD.UpdatedUser_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`Project_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`Project_BEFORE_INSERT` BEFORE INSERT ON `Project` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`ActorStage_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`ActorStage_BEFORE_INSERT` BEFORE INSERT ON `ActorStage` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`ActorStage_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`ActorStage_AFTER_UPDATE` AFTER UPDATE ON `ActorStage` FOR EACH ROW
BEGIN
INSERT INTO ActorStageHistorization(Invalidated, UpdatedDateTime, WorkTime, PlannedTime, UpdatedUser_Id, ActorStage_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.WorkTime, OLD.PlannedTime, OLD.UpdatedUser_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`DocumentTemplate_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`DocumentTemplate_AFTER_UPDATE` AFTER UPDATE ON `DocumentTemplate` FOR EACH ROW
BEGIN
INSERT INTO DocumentTemplateHistorization(Invalidated, UpdatedDateTime, Code, Template, UpdatedUser_Id, DocumentTemplate_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.Code, OLD.Template, OLD.UpdatedUser_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`DocumentTemplate_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`DocumentTemplate_BEFORE_INSERT` BEFORE INSERT ON `DocumentTemplate` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`DocumentStorage_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`DocumentStorage_AFTER_UPDATE` AFTER UPDATE ON `DocumentStorage` FOR EACH ROW
BEGIN
INSERT INTO DocumentStorageHistorization(Invalidated, UpdatedDateTime, Data, FileExtension, OriginalName, Remarks, Keywords, UpdatedUser_Id, DocumentStorage_Id) VALUES 
(OLD.Invalidated, OLD.UpdatedDateTime, OLD.Data, OLD.FileExtension, OLD.OriginalName, OLD.Remarks, OLD.Keywords, OLD.UpdatedUser_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`DocumentStorage_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`DocumentStorage_BEFORE_INSERT` BEFORE INSERT ON `DocumentStorage` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`ProjectExpense_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`ProjectExpense_AFTER_UPDATE` AFTER UPDATE ON `ProjectExpense` FOR EACH ROW
BEGIN
INSERT INTO ProjectExpenseHistorization(Invalidated, UpdatedDateTime, Price, Notes, UpdatedUser_Id, ProjectExpense_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.Price, OLD.Notes, OLD.UpdatedUser_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`ProjectExpense_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`ProjectExpense_BEFORE_INSERT` BEFORE INSERT ON `ProjectExpense` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`ProjectArrival_AFTER_UPDATE` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`ProjectArrival_AFTER_UPDATE` AFTER UPDATE ON `ProjectArrival` FOR EACH ROW
BEGIN
INSERT INTO ProjectArrivalHistorization(Invalidated, UpdatedDateTime, Price, Notes, UpdatedUser_Id, ProjectArrival_Id) 
VALUES (OLD.Invalidated, OLD.UpdatedDateTime, OLD.Price, OLD.Notes, OLD.UpdatedUser_Id, OLD.Id);
END$$


USE `vratomir`$$
DROP TRIGGER IF EXISTS `vratomir`.`ProjectArrival_BEFORE_INSERT` $$
USE `vratomir`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vratomir`.`ProjectArrival_BEFORE_INSERT` BEFORE INSERT ON `ProjectArrival` FOR EACH ROW
BEGIN
set New.CreatedDateTime = NOW();
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `vratomir`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `vratomir`;
INSERT INTO `vratomir`.`User` (`Id`, `Invalidated`, `CreatedDateTime`, `UpdatedDateTime`, `FirstName`, `LastName`, `Email`, `UserName`, `CellPhone`, `Workphone`, `Password`, `Salt`, `IsPasswordExpired`, `AllowLogin`, `LastPasswordChangeDate`, `CreatedUser_Id`, `UpdatedUser_Id`) VALUES (1, 0, '2018-01-01', '2018-01-01', 'Ratomir', 'Vukadin', 'ratomir@live.com', 'ratomirx', '065211581', '065211581', 'pokemon', 'pokemon', 0, 1, NULL, NULL, NULL);

COMMIT;

