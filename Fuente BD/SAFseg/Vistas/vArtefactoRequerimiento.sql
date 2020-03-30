USE [SAFseg]
GO

/****** Object:  View [dbo].[vArtefactoRequerimiento]    Script Date: 27/03/2020 02:26:26 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vArtefactoRequerimiento]
AS
SELECT     dbo.bdArtefacto.Id, dbo.bdArtefacto.idTipoArtefacto, dbo.bdArtefacto.Nombre, dbo.bdArtefacto.idEstado, dbo.bdArtefacto.idSistema, 
                      dbo.bdSistema.Nombre AS SistemaNombre, dbo.bdArtefacto.Descripcion AS ArtefactoDescripcion, dbo.bdArtefactoHistorial.Objetivo, 
                      dbo.bdArtefactoHistorial.Descripcion, dbo.bdArtefactoHistorial.Extension, dbo.bdArtefactoHistorial.Version, dbo.bdArtefactoHistorial.idRequerimiento, 
                      dbo.bdRequerimiento.Descripcion AS RequerimientoDescripcion, dbo.bdRequerimiento.Estado
FROM         dbo.bdRequerimiento RIGHT OUTER JOIN
                      dbo.bdArtefactoHistorial ON dbo.bdRequerimiento.Id = dbo.bdArtefactoHistorial.idRequerimiento RIGHT OUTER JOIN
                      dbo.bdSistema INNER JOIN
                      dbo.bdArtefacto ON dbo.bdSistema.Id = dbo.bdArtefacto.idSistema ON dbo.bdArtefactoHistorial.idArtefacto = dbo.bdArtefacto.Id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[27] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[45] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "bdRequerimiento"
            Begin Extent = 
               Top = 4
               Left = 660
               Bottom = 98
               Right = 811
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdArtefactoHistorial"
            Begin Extent = 
               Top = 2
               Left = 380
               Bottom = 168
               Right = 537
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdSistema"
            Begin Extent = 
               Top = 153
               Left = 207
               Bottom = 247
               Right = 358
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdArtefacto"
            Begin Extent = 
               Top = 3
               Left = 15
               Bottom = 112
               Right = 169
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2265
         Table = 3075
         Output = 720
         Append = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO


