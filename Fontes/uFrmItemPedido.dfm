object frmItemPedido: TfrmItemPedido
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adicionar Produto'
  ClientHeight = 133
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 7
    Top = 1
    Width = 38
    Height = 13
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 56
    Height = 13
    Caption = 'Quantidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 95
    Top = 48
    Width = 64
    Height = 13
    Caption = 'Valor Unit'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 92
    Width = 399
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object btnGravar: TButton
      Left = 119
      Top = 8
      Width = 78
      Height = 29
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 203
      Top = 8
      Width = 78
      Height = 29
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object edtCod: TEdit
    Left = 7
    Top = 17
    Width = 52
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnExit = edtCodExit
  end
  object edtDescricao: TEdit
    Left = 60
    Top = 17
    Width = 331
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object edtQuantidade: TEdit
    Left = 8
    Top = 64
    Width = 81
    Height = 21
    NumbersOnly = True
    TabOrder = 2
  end
  object edtValor: TEdit
    Left = 95
    Top = 64
    Width = 81
    Height = 21
    TabOrder = 3
    OnChange = edtValorChange
  end
end
