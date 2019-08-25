drop Procedure [dbo].[SP_DSDiemcualop]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE PROC [dbo].[SP_DSDiemcualop]
@malop char(8), @mamh nvarchar(50), @lan int
AS
BEGIN
	SELECT SV.MASV, HOTEN = HO +' '+TEN, DIEM = (SELECT DIEM FROM DIEM WHERE MASV = SV.MASV AND MAMH = @mamh AND LAN = @lan)
 	into #temp
	FROM
		(SELECT MASV, HO, TEN FROM SINHVIEN WHERE MALOP = @malop AND NGHIHOC = 'false') SV
	select MASV,HOTEN,DIEM from #temp
	drop table #temp
END
go
