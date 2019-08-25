drop Procedure [dbo].[SP_GetLoginName_By_UserName]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE PROC [dbo].[SP_GetLoginName_By_UserName]
@UsrName VARCHAR(50)
as
select name from sys.server_principals where sid =( select sid from sys.sysusers  
                                      WHERE NAME= @UsrName)
go
