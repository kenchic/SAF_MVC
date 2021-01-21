USE [SAF]
GO

/****** Object:  View [SEG].[vArtefactoRequerimiento]    Script Date: 20/01/2021 08:07:33 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [SEG].[vArtefactoRequerimiento]
AS
SELECT     SEG.bdArtefacto.Id, SEG.bdArtefacto.Tipo, bdArtefactoTipo.Descripcion, SEG.bdArtefacto.Nombre, SEG.bdArtefacto.Estado AS ArtefactoEstado, 
                      bdArtefactoEstado.Descripcion AS ArtefactoEstadoDes, SEG.bdArtefacto.idSistema, SEG.bdArtefacto.Descripcion AS ArtefactoDescripcion, 
                      SEG.bdArtefactoHistorial.Objetivo, SEG.bdArtefactoHistorial.Version, SEG.bdArtefactoHistorial.idArtefacto, SEG.bdArtefactoHistorial.idRequerimiento, 
                      SEG.bdRequerimiento.Descripcion AS RequerimientoDescripcion, SEG.bdRequerimiento.Estado, bdRequerimientoEstado.Descripcion AS RequerimientoEstadoDes, 
                      SEG.bdSistema.Codigo, bdSistemaCodigo.Descripcion AS SistemaCodigoDes
FROM         SEG.bdCatalogoDetalle AS bdArtefactoTipo INNER JOIN
                      SEG.bdSistema INNER JOIN
                      SEG.bdArtefacto ON SEG.bdSistema.Id = SEG.bdArtefacto.idSistema ON bdArtefactoTipo.Codigo = SEG.bdArtefacto.Tipo INNER JOIN
                      SEG.bdCatalogoDetalle AS bdArtefactoEstado ON SEG.bdArtefacto.Estado = bdArtefactoEstado.Codigo INNER JOIN
                      SEG.bdCatalogoDetalle AS bdSistemaCodigo ON SEG.bdSistema.Codigo = bdSistemaCodigo.Codigo LEFT OUTER JOIN
                      SEG.bdArtefactoHistorial LEFT OUTER JOIN
                      SEG.bdRequerimiento INNER JOIN
                      SEG.bdCatalogoDetalle AS bdRequerimientoEstado ON SEG.bdRequerimiento.Estado = bdRequerimientoEstado.Codigo ON 
                      SEG.bdArtefactoHistorial.idRequerimiento = SEG.bdRequerimiento.Id ON SEG.bdArtefacto.Id = SEG.bdArtefactoHistorial.idArtefacto


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
         Configuration = "(H (1[46] 4[29] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
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
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "bdArtefactoHistorial"
            Begin Extent = 
               Top = 0
               Left = 230
               Bottom = 127
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdRequerimiento"
            Begin Extent = 
               Top = 4
               Left = 472
               Bottom = 98
               Right = 623
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdRequerimientoEstado"
            Begin Extent = 
               Top = 17
               Left = 674
               Bottom = 160
               Right = 825
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "bdArtefactoTipo"
            Begin Extent = 
               Top = 244
               Left = 415
               Bottom = 353
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdSistema"
            Begin Extent = 
               Top = 137
               Left = 288
               Bottom = 231
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdArtefacto"
            Begin Extent = 
               Top = 167
               Left = 28
               Bottom = 319
               Right = 182
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "bdArtefactoEstado"
            Begin Extent = 
               Top = 310
               Left = 239
               Bottom = 465
               Rig' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ht = 390
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdSistemaCodigo"
            Begin Extent = 
               Top = 178
               Left = 730
               Bottom = 287
               Right = 881
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
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
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 3795
         Alias = 2265
         Table = 3075
         Output = 720
         Append = 1400
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
' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO


