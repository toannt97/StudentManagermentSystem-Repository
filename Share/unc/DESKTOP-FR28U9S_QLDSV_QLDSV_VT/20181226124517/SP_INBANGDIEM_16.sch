drop Procedure [dbo].[SP_INBANGDIEM]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE PROC [dbo].[SP_INBANGDIEM]
@malop NVARCHAR(20), 
@mamh NVARCHAR(20), 
@lan INT
AS
BEGIN
  SELECT  HOTEN = sv.HO +' '+sv.TEN, DIEM = (SELECT DIEM FROM DIEM WHERE MASV = SV.MASV AND MAMH = @mamh AND LAN = @lan)
	FROM
		(SELECT MASV, HO, TEN FROM SINHVIEN WHERE MALOP = @malop ) SV  
END
go
