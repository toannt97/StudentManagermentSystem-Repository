drop Procedure [dbo].[SP_check_Loginname]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
create proc [dbo].[SP_check_Loginname]
@loginName char(15)
as
if exists(select name from  sys.server_principals where name = @loginName)
return 1;
else return 0; 
go
