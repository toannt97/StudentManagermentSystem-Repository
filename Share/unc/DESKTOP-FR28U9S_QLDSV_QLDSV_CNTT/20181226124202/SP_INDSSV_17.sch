drop Procedure [dbo].[SP_INDSSV]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE proc [dbo].[SP_INDSSV]
@MaLop varchar(20)
as
select HO,TEN, PHAI, NGAYSINH,NOISINH,DIACHI from SINHVIEN where MALOP=@MaLop
go
