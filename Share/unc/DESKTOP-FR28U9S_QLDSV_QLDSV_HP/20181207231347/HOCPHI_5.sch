drop Table [dbo].[HOCPHI]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOCPHI](
	[MASV] [char](12) NOT NULL,
	[NIENKHOA] [nvarchar](50) NOT NULL,
	[HOCKY] [int] NOT NULL,
	[HOCPHI] [int] NOT NULL,
	[SOTIENDADONG] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL
)

GO
ALTER TABLE [dbo].[HOCPHI] ADD  CONSTRAINT [DF_HOCPHI_HOCKY]  DEFAULT ((1)) FOR [HOCKY]
GO
ALTER TABLE [dbo].[HOCPHI] ADD  CONSTRAINT [DF_HOCPHI_HOCPHI]  DEFAULT ((6000000)) FOR [HOCPHI]
GO
ALTER TABLE [dbo].[HOCPHI] ADD  CONSTRAINT [DF_HOCPHI_SOTIENDADONG]  DEFAULT ((0)) FOR [SOTIENDADONG]
GO
ALTER TABLE [dbo].[HOCPHI] ADD  CONSTRAINT [MSmerge_df_rowguid_3D446EE6A6E64C5A90612B7023006407]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET ANSI_PADDING ON

GO
ALTER TABLE [dbo].[HOCPHI] ADD  CONSTRAINT [PK_HOCPHI] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[NIENKHOA] ASC,
	[HOCKY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
