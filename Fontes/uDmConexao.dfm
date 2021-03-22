object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 73
  Width = 150
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=banco'
      'User_Name=usuario'
      'Password=senha'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Left = 24
    Top = 16
  end
  object FDPhysMySQL: TFDPhysMySQLDriverLink
    VendorLib = 'libmysql.dll'
    Left = 88
    Top = 16
  end
end
