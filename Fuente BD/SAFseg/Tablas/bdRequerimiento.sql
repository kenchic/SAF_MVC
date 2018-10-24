USE [SAFseg]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdRequerimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripción] [varchar](max) NOT NULL,
 CONSTRAINT [PK_bdRequerimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRequerimiento'
GO


