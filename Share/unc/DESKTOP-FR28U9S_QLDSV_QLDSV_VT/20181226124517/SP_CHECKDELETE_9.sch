drop Procedure [dbo].[SP_CHECKDELETE]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE PROC [dbo].[SP_CHECKDELETE]
@Masv char(20)
as
IF EXISTS(SELECT MASV FROM DIEM 
          WHERE MASV= @Masv) 
		  return 1;
else IF EXISTS(SELECT MASV FROM LINK.QLDSV.DBO.DIEM 
          WHERE DIEM.MASV= @Masv) 
		  return 1;
else return 0;
go
