USE [SAF]
GO

/****** Object:  View [SAF].[vDocumentoDetalle]    Script Date: 20/01/2021 08:04:32 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SAF].[vDocumentoDetalle]
AS
SELECT     DD.Id, DD.idElemento, DD.idDocumento, D.Descripcion, D.idBodegaDestino, D.idBodegaOrigen, DD.Cantidad, E.Nombre AS ElementoNombre, 
                      BO.Nombre AS BodegaOrigenNombre, BD.Nombre AS BodegaDestinoNombre
FROM         SAF.bdDocumentoDetalle AS DD INNER JOIN
                      SAF.bdDocumento AS D ON DD.idDocumento = D.Id INNER JOIN
                      SAF.bdElemento AS E ON DD.idElemento = E.Id INNER JOIN
                      SAF.bdBodega AS BO ON D.idBodegaOrigen = BO.Id INNER JOIN
                      SAF.bdBodega AS BD ON D.idBodegaDestino = BD.Id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Configuration = "(H (1 [75] 4))"
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
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 115
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 427
               Bottom = 115
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BO"
            Begin Extent = 
               Top = 6
               Left = 626
               Bottom = 115
               Right = 777
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BD"
            Begin Extent = 
               Top = 6
               Left = 815
               Bottom = 115
               Right = 966
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
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
' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumentoDetalle'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumentoDetalle'
GO
