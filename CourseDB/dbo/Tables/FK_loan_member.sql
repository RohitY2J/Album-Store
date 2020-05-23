ALTER TABLE [dbo].[Loan]
	ADD CONSTRAINT [FK_loan_member]
	FOREIGN KEY (Member_ID)
	REFERENCES [Member] (Member_ID)
