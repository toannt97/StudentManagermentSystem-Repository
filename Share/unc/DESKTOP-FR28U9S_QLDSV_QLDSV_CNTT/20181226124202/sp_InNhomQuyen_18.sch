drop Procedure [dbo].[sp_InNhomQuyen]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
create proc [dbo].[sp_InNhomQuyen]
@MaGv char(8)
as
select NAME FROM sys.sysusers  WHERE UID = (SELECT GROUPUID 
     FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@MaGv))
go
