ALTER TABLE [dbo].[DVD_Detail]
	ADD CONSTRAINT [FK_dvd_producer]
	FOREIGN KEY (Producer_ID)
	REFERENCES [Producer_Details] (Producer_ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
