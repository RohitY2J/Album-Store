﻿CREATE TABLE [dbo].[Cast_Details]
(
	[Cast_ID] INT NOT NULL IDENTITY(200, 1) PRIMARY KEY, 
    [FirstName] NVARCHAR(100) NOT NULL, 
    [LastName] NVARCHAR(100) NOT NULL
)
