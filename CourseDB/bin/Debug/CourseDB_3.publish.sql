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
PRINT N'Dropping [dbo].[FK_member]...';


GO
ALTER TABLE [dbo].[Member] DROP CONSTRAINT [FK_member];


GO
PRINT N'Starting rebuilding table [dbo].[User]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_User] (
    [User_ID]  INT            NOT NULL,
    [Username] NVARCHAR (100) NOT NULL,
    [Email]    NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([User_ID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[User])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_User] ([User_ID], [Username], [Email])
        SELECT   [User_ID],
                 [Username],
                 [Email]
        FROM     [dbo].[User]
        ORDER BY [User_ID] ASC;
    END

DROP TABLE [dbo].[User];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_User]', N'User';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_member]...';


GO
ALTER TABLE [dbo].[Member] WITH NOCHECK
    ADD CONSTRAINT [FK_member] FOREIGN KEY ([User_ID]) REFERENCES [dbo].[User] ([User_ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Member] WITH CHECK CHECK CONSTRAINT [FK_member];


GO
PRINT N'Update complete.';


GO
