﻿ALTER TABLE [dbo].[Loan]
	ADD CONSTRAINT [FK_loan_dvd]
	FOREIGN KEY (Dvd_ID)
	REFERENCES [DVD_Detail] (Dvd_ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
