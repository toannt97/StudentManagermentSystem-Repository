drop View [dbo].[V_DSNHOM]
go

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
CREATE view [dbo].[V_DSNHOM]
as 
select name, principal_id
from sys.database_principals
where type='R' and (principal_id >4 and principal_id<16384) and name<>'public'
go
