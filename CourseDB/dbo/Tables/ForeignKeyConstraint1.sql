﻿ALTER TABLE [dbo].[Member]
	ADD CONSTRAINT [FK_member]
	FOREIGN KEY (User_ID)
	REFERENCES [Users] (User_ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
