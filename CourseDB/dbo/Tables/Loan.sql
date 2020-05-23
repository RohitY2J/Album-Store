CREATE TABLE [dbo].[Loan]
(
	[Loan_ID] INT NOT NULL IDENTITY(27, 1) PRIMARY KEY, 
    [Date_out] NVARCHAR(100) NOT NULL, 
    [Amount_paid] INT NOT NULL, 
    [Date_returned] NVARCHAR(100) NULL, 
    [Penalty_Charge] INT NULL, 
    [Dvd_ID] INT NOT NULL, 
    [Member_ID] INT NOT NULL
)
