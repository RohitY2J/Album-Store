CREATE TABLE [dbo].[Member]
(
	[Member_ID] INT NOT NULL IDENTITY(89, 1) PRIMARY KEY, 
    [FirstName] NVARCHAR(100) NOT NULL, 
    [LastName] NVARCHAR(10) NOT NULL, 
    [Phone] INT NOT NULL, 
    [User_ID] INT NOT NULL, 
    [DVD_On_Loan] INT NOT NULL
)
