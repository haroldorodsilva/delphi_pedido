object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema de Emiss'#227'o de Pedido de Vendas'
  ClientHeight = 201
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 72
    Top = 40
    object PedidoVenda1: TMenuItem
      Caption = 'Pedido Venda'
      OnClick = PedidoVenda1Click
    end
  end
end
