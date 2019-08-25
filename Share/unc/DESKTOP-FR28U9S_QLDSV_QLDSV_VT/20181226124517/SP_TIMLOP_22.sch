drop Procedure [dbo].[SP_TIMLOP]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE proc [dbo].[SP_TIMLOP]
@Malop char(8),
@Solan int
as
declare @value int
Set @value = ( Select Count(*) From LOP where LOp.MALOP= @Malop )
if(@value > @Solan) return 1;
else IF EXISTS(SELECT * FROM LINK.QLDSV.DBO.LOP 
          WHERE LOP.MALOP =@Malop) 
		  return 1;
else return 0;
go
