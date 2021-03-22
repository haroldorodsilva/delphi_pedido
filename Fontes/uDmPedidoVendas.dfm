object dmPedido: TdmPedido
  OldCreateOrder = False
  Height = 79
  Width = 209
  object cdsItens: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 20
    Top = 16
    object cdsItensCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsItensDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object cdsItensQuantidade: TCurrencyField
      FieldName = 'Quantidade'
      DisplayFormat = ',0.00'
      currency = False
    end
    object cdsItensValorUnitario: TCurrencyField
      FieldName = 'ValorUnitario'
      DisplayFormat = ',0.00'
      currency = False
    end
    object cdsItensValorTotal: TCurrencyField
      FieldName = 'ValorTotal'
      DisplayFormat = ',0.00'
      currency = False
    end
    object cdsItensTOTAL: TAggregateField
      FieldName = 'TOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = ',0.00'
      Expression = 'SUM(ValorTotal)'
    end
    object cdsItensCOUNT: TAggregateField
      FieldName = 'COUNT'
      Active = True
      DisplayName = ''
      Expression = 'COUNT(Codigo)'
    end
  end
  object FDTransaction: TFDTransaction
    Connection = DmConexao.Conexao
    Left = 152
    Top = 16
  end
  object FDQuery: TFDQuery
    Connection = DmConexao.Conexao
    Transaction = FDTransaction
    Left = 88
    Top = 16
  end
end
