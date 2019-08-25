drop Procedure [dbo].[SP_CHECKMASV]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE PROC [dbo].[SP_CHECKMASV]
@MASV nvarchar(20),
@Solan int
as
declare @value int
Set @value = ( Select Count(*) From SINHVIEN where SINHVIEN.MASV= @MASV )
if(@value > @Solan) return 1;
else IF EXISTS(SELECT MASV FROM LINK.QLDSV.DBO.SINHVIEN 
          WHERE MASV = @MASV) 
		  return 1;
else return 0;
--as
go
