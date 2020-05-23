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
USE [$(DatabaseName)];


GO
/*
The column [dbo].[Cast_Details].[FirstName] is being dropped, data loss could occur.

The column [dbo].[Cast_Details].[LastName] is being dropped, data loss could occur.

The column [dbo].[Cast_Details].[Cast_Fname] on table [dbo].[Cast_Details] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[Cast_Details].[Cast_Lname] on table [dbo].[Cast_Details] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Cast_Details])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column Date_out on table [dbo].[Loan] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column Date_returned on table [dbo].[Loan] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column Penalty_Charge on table [dbo].[Loan] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Loan])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'The following operation was generated from a refactoring log file d849e33b-5bfc-4abb-82ab-50806b43ad35';

PRINT N'Rename [dbo].[Member].[Loan_On_DVD] to DVD_On_Loan';


GO
EXECUTE sp_rename @objname = N'[dbo].[Member].[Loan_On_DVD]', @newname = N'DVD_On_Loan', @objtype = N'COLUMN';


GO
PRINT N'Altering [dbo].[Cast_Details]...';


GO
ALTER TABLE [dbo].[Cast_Details] DROP COLUMN [FirstName], COLUMN [LastName];


GO
ALTER TABLE [dbo].[Cast_Details]
    ADD [Cast_Fname] NVARCHAR (100) NOT NULL,
        [Cast_Lname] NVARCHAR (100) NOT NULL;


GO
PRINT N'Altering [dbo].[Loan]...';


GO
ALTER TABLE [dbo].[Loan] ALTER COLUMN [Date_out] NVARCHAR (100) NOT NULL;

ALTER TABLE [dbo].[Loan] ALTER COLUMN [Date_returned] NVARCHAR (100) NOT NULL;

ALTER TABLE [dbo].[Loan] ALTER COLUMN [Penalty_Charge] INT NOT NULL;


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd849e33b-5bfc-4abb-82ab-50806b43ad35')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d849e33b-5bfc-4abb-82ab-50806b43ad35')

GO

GO
PRINT N'Update complete.';


GO
