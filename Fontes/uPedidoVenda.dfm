object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pedido de Vendas'
  ClientHeight = 399
  ClientWidth = 711
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 705
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 7
      Top = 1
      Width = 33
      Height = 13
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblNumeroPedido: TLabel
      Left = 368
      Top = 20
      Width = 67
      Height = 13
      Caption = 'Pedido n'#186': 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edtCodCliente: TEdit
      Left = 7
      Top = 17
      Width = 52
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnExit = edtCodClienteExit
    end
    object edtClienteNome: TEdit
      Left = 60
      Top = 17
      Width = 285
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object btnConsultarPedido: TButton
      AlignWithMargins = True
      Left = 505
      Top = 3
      Width = 95
      Height = 35
      Margins.Right = 5
      Align = alRight
      Caption = 'Consultar Pedido'
      TabOrder = 2
      TabStop = False
      WordWrap = True
      OnClick = btnConsultarPedidoClick
    end
    object btnCancelarPedido: TButton
      AlignWithMargins = True
      Left = 608
      Top = 3
      Width = 92
      Height = 35
      Margins.Right = 5
      Align = alRight
      Caption = 'Cancelar Pedido'
      ImageIndex = 0
      TabOrder = 3
      TabStop = False
      OnClick = btnCancelarPedidoClick
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 2
    Top = 326
    Width = 707
    Height = 32
    Margins.Left = 2
    Margins.Top = 1
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 0
    ExplicitWidth = 711
    object Label1: TLabel
      Left = 8
      Top = 1
      Width = 84
      Height = 13
      Caption = 'Quantidade Itens'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 224
      Top = 1
      Width = 59
      Height = 13
      Caption = 'Total Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 224
      Top = 13
      Width = 52
      Height = 14
      AutoSize = True
      DataField = 'TOTAL'
      DataSource = dsItens
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 8
      Top = 13
      Width = 52
      Height = 14
      AutoSize = True
      DataField = 'COUNT'
      DataSource = dsItens
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnAlterarItem: TBitBtn
      AlignWithMargins = True
      Left = 625
      Top = 1
      Width = 75
      Height = 26
      Cursor = crHandPoint
      Hint = 'Alterar Item - Pressione ENTER'
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Alterar'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnAlterarItemClick
      ExplicitLeft = 629
    end
    object btnNovoItem: TBitBtn
      AlignWithMargins = True
      Left = 463
      Top = 1
      Width = 75
      Height = 26
      Cursor = crHandPoint
      Hint = 'Novo Item - Pressione INSERT'
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Novo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnNovoItemClick
      ExplicitLeft = 467
    end
    object btnExcluirItem: TBitBtn
      AlignWithMargins = True
      Left = 544
      Top = 1
      Width = 75
      Height = 26
      Cursor = crHandPoint
      Hint = 'Exclui o Item - Pressione DELETE.'
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Excluir'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnExcluirItemClick
      ExplicitLeft = 548
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 358
    Width = 711
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnGravar: TButton
      AlignWithMargins = True
      Left = 530
      Top = 3
      Width = 84
      Height = 35
      Margins.Right = 5
      Align = alRight
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 622
      Top = 3
      Width = 84
      Height = 35
      Margins.Right = 5
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 1
    Top = 47
    Width = 709
    Height = 278
    Margins.Left = 1
    Margins.Top = 0
    Margins.Right = 1
    Margins.Bottom = 0
    Align = alClient
    Caption = '  Produtos do pedido de venda  '
    TabOrder = 3
    ExplicitLeft = 32
    ExplicitTop = 80
    ExplicitWidth = 185
    ExplicitHeight = 105
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 705
      Height = 261
      Align = alClient
      DataSource = dsItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Title.Caption = 'C'#243'digo'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 340
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade'
          Title.Alignment = taCenter
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorUnitario'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorTotal'
          Title.Alignment = taCenter
          Title.Caption = 'Total'
          Width = 93
          Visible = True
        end>
    end
  end
  object dsItens: TDataSource
    DataSet = dmPedido.cdsItens
    OnDataChange = dsItensDataChange
    Left = 600
    Top = 136
  end
end
