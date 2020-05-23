﻿/*
Deployment script for CourseDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "CourseDB"
:setvar DefaultFilePrefix "CourseDB"
:setvar DefaultDataPath "C:\Users\dell\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\dell\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Cast_Details]...';


GO
CREATE TABLE [dbo].[Cast_Details] (
    [Cast_ID]    INT            IDENTITY (200, 1) NOT NULL,
    [Cast_Fname] NVARCHAR (100) NOT NULL,
    [Cast_Lname] NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([Cast_ID] ASC)
);


GO
PRINT N'Creating [dbo].[DVD_Detail]...';


GO
CREATE TABLE [dbo].[DVD_Detail] (
    [Dvd_ID]      INT            IDENTITY (50, 1) NOT NULL,
    [Title]       NVARCHAR (100) NOT NULL,
    [Genres]      NVARCHAR (100) NOT NULL,
    [Stock]       INT            NOT NULL,
    [date_added]  NVARCHAR (100) NOT NULL,
    [Cast_ID]     INT            NOT NULL,
    [Studio_ID]   INT            NOT NULL,
    [Producer_ID] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Dvd_ID] ASC)
);


GO
PRINT N'Creating [dbo].[Loan]...';


GO
CREATE TABLE [dbo].[Loan] (
    [Loan_ID]        INT            IDENTITY (27, 1) NOT NULL,
    [Date_out]       NVARCHAR (100) NOT NULL,
    [Amount_paid]    INT            NOT NULL,
    [Date_returned]  NVARCHAR (100) NOT NULL,
    [Penalty_Charge] INT            NOT NULL,
    [Dvd_ID]         INT            NOT NULL,
    [Member_ID]      INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Loan_ID] ASC)
);


GO
PRINT N'Creating [dbo].[Member]...';


GO
CREATE TABLE [dbo].[Member] (
    [Member_ID]   INT            IDENTITY (89, 1) NOT NULL,
    [FirstName]   NVARCHAR (100) NOT NULL,
    [LastName]    NVARCHAR (10)  NOT NULL,
    [Phone]       INT            NOT NULL,
    [User_ID]     INT            NOT NULL,
    [DVD_On_Loan] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Member_ID] ASC)
);


GO
PRINT N'Creating [dbo].[Producer_Details]...';


GO
CREATE TABLE [dbo].[Producer_Details] (
    [Producer_ID]   INT            IDENTITY (17, 1) NOT NULL,
    [Producer_name] NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([Producer_ID] ASC)
);


GO
PRINT N'Creating [dbo].[Studio_Details]...';


GO
CREATE TABLE [dbo].[Studio_Details] (
    [Studio_ID]   INT            IDENTITY (459, 1) NOT NULL,
    [Studio_Name] NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([Studio_ID] ASC)
);


GO
PRINT N'Creating [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [User_ID]  INT            IDENTITY (100, 1) NOT NULL,
    [Username] NVARCHAR (100) NOT NULL,
    [Email]    NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([User_ID] ASC)
);


GO
PRINT N'Creating [dbo].[FK_dvd_producer]...';


GO
ALTER TABLE [dbo].[DVD_Detail]
    ADD CONSTRAINT [FK_dvd_producer] FOREIGN KEY ([Producer_ID]) REFERENCES [dbo].[Producer_Details] ([Producer_ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dvd_studio]...';


GO
ALTER TABLE [dbo].[DVD_Detail]
    ADD CONSTRAINT [FK_dvd_studio] FOREIGN KEY ([Studio_ID]) REFERENCES [dbo].[Studio_Details] ([Studio_ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dvd_cast]...';


GO
ALTER TABLE [dbo].[DVD_Detail]
    ADD CONSTRAINT [FK_dvd_cast] FOREIGN KEY ([Cast_ID]) REFERENCES [dbo].[Cast_Details] ([Cast_ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[FK_loan_dvd]...';


GO
ALTER TABLE [dbo].[Loan]
    ADD CONSTRAINT [FK_loan_dvd] FOREIGN KEY ([Dvd_ID]) REFERENCES [dbo].[DVD_Detail] ([Dvd_ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[FK_loan_member]...';


GO
ALTER TABLE [dbo].[Loan]
    ADD CONSTRAINT [FK_loan_member] FOREIGN KEY ([Member_ID]) REFERENCES [dbo].[Member] ([Member_ID]);


GO
PRINT N'Creating [dbo].[FK_member]...';


GO
ALTER TABLE [dbo].[Member]
    ADD CONSTRAINT [FK_member] FOREIGN KEY ([User_ID]) REFERENCES [dbo].[Users] ([User_ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7dd73d7d-0ec9-4575-81d3-a1f49abb2c30')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7dd73d7d-0ec9-4575-81d3-a1f49abb2c30')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e0dd817e-b0d3-474b-a7fc-9333c3439314')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e0dd817e-b0d3-474b-a7fc-9333c3439314')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6cd8fda0-99e4-45a6-9bb6-e397570f4d04')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6cd8fda0-99e4-45a6-9bb6-e397570f4d04')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b872a8ef-717d-4e74-88a3-e35f047dd7fc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b872a8ef-717d-4e74-88a3-e35f047dd7fc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1b00d4d7-86a7-42df-98c9-651363327e00')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1b00d4d7-86a7-42df-98c9-651363327e00')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9475015b-f8c7-48db-8983-bfebfaa16adb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9475015b-f8c7-48db-8983-bfebfaa16adb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '805ceb19-8446-4ce3-9e73-0029266726a0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('805ceb19-8446-4ce3-9e73-0029266726a0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5902d1ca-5fd2-45af-b4fe-ef4ed34ebcdb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5902d1ca-5fd2-45af-b4fe-ef4ed34ebcdb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c3fa7d24-73d8-440d-9a79-6788183339f4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c3fa7d24-73d8-440d-9a79-6788183339f4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd849e33b-5bfc-4abb-82ab-50806b43ad35')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d849e33b-5bfc-4abb-82ab-50806b43ad35')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
