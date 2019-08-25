drop Procedure [dbo].[SP_LoadDiem]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
create proc [dbo].[SP_LoadDiem]
@malop char(15),@mamh char(15),@lan int
as
Begin
	IF @LAN != 1 -- nếu lần thi = 2
		BEGIN
			IF exists (SELECT SV.MASV  
				FROM  (SELECT MASV FROM SINHVIEN WHERE MALOP = @malop and NGHIHOC = 'false') SV, 
						(SELECT MASV  FROM DIEM WHERE MAMH = @mamh AND LAN = '2') DIEM
				WHERE   SV.MASV = DIEM.MASV)-- đã có điểm lần 2
				BEGIN
					SELECT SV.MASV, HOTEN=HO+' '+TEN, DIEM 
					FROM  (SELECT MASV, HO,TEN FROM SINHVIEN WHERE MALOP = @malop and NGHIHOC = 'false') SV, 
							(SELECT MASV , DIEM FROM DIEM WHERE MAMH = @mamh AND LAN = '2') DIEM
					WHERE   SV.MASV = DIEM.MASV
					RETURN 5
				END
			ELSE IF exists (SELECT SV.MASV -- điểm lần 2 chưa có nhưng có điểm l
				FROM  (SELECT MASV FROM SINHVIEN WHERE MALOP = @malop and NGHIHOC = 'false') SV, 
						(SELECT MASV  FROM DIEM WHERE MAMH = @mamh AND LAN = '1') DIEM
				WHERE   SV.MASV = DIEM.MASV)
				BEGIN
					IF exists (SELECT SV.MASV -- điểm lần 1 đã có và có sinh viên có điểm nhỏ hơn 4
						FROM  (SELECT MASV FROM SINHVIEN WHERE MALOP = @malop and NGHIHOC = 'false') SV, 
								(SELECT MASV FROM DIEM WHERE MAMH = @mamh AND LAN = '1' AND DIEM < 4) DIEM
						WHERE   SV.MASV = DIEM.MASV)
						BEGIN
							SELECT SV.MASV, HOTEN=HO+' '+TEN, DIEM 
							FROM  (SELECT MASV, HO,TEN FROM SINHVIEN WHERE MALOP = @malop and NGHIHOC = 'false') SV, 
								  (SELECT MASV , DIEM FROM DIEM WHERE MAMH = @mamh AND LAN = '1' AND DIEM < 4) DIEM
							WHERE   SV.MASV = DIEM.MASV
							RETURN 2
						END
					ELSE RETURN 4 -- có điểm lần 1 nhưng không ai rớt
				END
			ELSE RETURN 3 -- chưa có điểm lần 1 mà nhập lần 2 => báo lỗi
		END
	ELSE -- nếu lần thi = 1
	BEGIN
		SELECT SV.MASV, HOTEN = HO +' '+TEN, DIEM = (SELECT DIEM FROM DIEM WHERE MASV = SV.MASV AND MAMH = @mamh AND LAN = @lan)
 	into #temp
	FROM
		(SELECT MASV, HO, TEN FROM SINHVIEN WHERE MALOP = @malop AND NGHIHOC = 'false') SV
	select MASV,HOTEN,DIEM from #temp
	drop table #temp
	END
End
go
