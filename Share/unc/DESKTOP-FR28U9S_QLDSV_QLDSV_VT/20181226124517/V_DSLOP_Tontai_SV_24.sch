drop View [dbo].[V_DSLOP_Tontai_SV]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
create view [dbo].[V_DSLOP_Tontai_SV]
as
select DISTINCT LOP.MALOP,TENLOP from LOP,SINHVIEN where (LOP.MALOP=SINHVIEN.MALOP and SINHVIEN.MALOP<>'') 

go
