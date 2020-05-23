CREATE TABLE [dbo].[DVD_Detail]
(
	[Dvd_ID] INT NOT NULL IDENTITY(50, 1) PRIMARY KEY, 
    [Title] NVARCHAR(100) NOT NULL, 
    [Genres] NVARCHAR(100) NOT NULL, 
    [Stock] INT NOT NULL, 
    [date_added] NVARCHAR(100) NOT NULL, 
    [Cast_ID] INT NOT NULL, 
    [Studio_ID] INT NOT NULL, 
    [Producer_ID] INT NOT NULL
)
