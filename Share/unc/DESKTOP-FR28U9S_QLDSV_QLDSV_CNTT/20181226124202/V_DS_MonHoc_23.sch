drop View [dbo].[V_DS_MonHoc]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
create view [dbo].[V_DS_MonHoc]
as
select MAMH,TENMH from MONHOC 
go
