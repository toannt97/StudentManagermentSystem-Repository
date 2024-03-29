drop Procedure [dbo].[SP_CheckExists_DiemSV]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
create proc [dbo].[SP_CheckExists_DiemSV]
@MaLop VARCHAR(50),
@MaMH VARCHAR(50),
@Lan int
as
if(@lan =2)
	if exists(select SINHVIEN.MASV from SINHVIEN,DIEM where MALOP = @MaLop AND DIEM.MASV = SINHVIEN.MASV AND DIEM.MAMH = @MaMH AND DIEM.LAN = @Lan)
		RETURN 2
else if exists(select SINHVIEN.MASV from SINHVIEN,DIEM where MALOP = @MaLop AND DIEM.MASV = SINHVIEN.MASV AND DIEM.MAMH = @MaMH AND DIEM.LAN = 1)
	RETURN 1
if exists(select SINHVIEN.MASV from SINHVIEN,DIEM where MALOP = @MaLop AND DIEM.MASV = SINHVIEN.MASV AND DIEM.MAMH = @MaMH AND DIEM.LAN = @Lan)
	RETURN 1
RETURN 0
go
