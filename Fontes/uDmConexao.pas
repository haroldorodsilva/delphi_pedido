unit uDmConexao;

interface

uses
   System.SysUtils, System.Classes, Rec.Conexao, System.IniFiles,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
   FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
   FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
   Data.DB, FireDAC.Comp.Client, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
   FireDAC.Comp.Script, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
   FireDAC.DApt, FireDAC.Comp.DataSet, System.ImageList, Vcl.ImgList,
  Vcl.Controls;

type
   TDmConexao = class(TDataModule)
      Conexao: TFDConnection;
      FDPhysMySQL: TFDPhysMySQLDriverLink;
      procedure DataModuleCreate(Sender: TObject);
      procedure DataModuleDestroy(Sender: TObject);
   private
      function LerIni: TRecConexao;
   public
      function UltimoID(const Tabela: string): string;
      function gerarConsulta(const pSQL: string): TDataSet;
   end;

var
   DmConexao: TDmConexao;

implementation

uses
   Vcl.Forms, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmConexao }

procedure TDmConexao.DataModuleCreate(Sender: TObject);
var
   ConData: TRecConexao;
begin
   Conexao.Connected := false;

   ConData := LerIni;
   Conexao.DriverName := 'MySQL';
   Conexao.Params.Values['Database'] := ConData.DataBase;
   Conexao.Params.Values['User_Name'] := ConData.User;
   Conexao.Params.Values['Password'] := ConData.Password;
   Conexao.Params.Values['Server'] := ConData.Host;
   Conexao.Params.Values['Port'] := ConData.Port;

   try
      Conexao.Connected := true;
   except
      on e: exception do
      begin
         showMessage('Não foi possível conectar verifique o arquivo de configurações.');
         Halt(0);
      end;
   end;
end;

procedure TDmConexao.DataModuleDestroy(Sender: TObject);
begin
   Conexao.Connected := false;
end;

function TDmConexao.gerarConsulta(const pSQL: string): TDataSet;
var
   DataSet: TFDQuery;
begin
   DataSet := TFDQuery.Create(nil);
   DataSet.Connection := Conexao;
   DataSet.SQL.Text := pSQL;
   DataSet.Open;
   Result := DataSet;
end;

function TDmConexao.LerIni: TRecConexao;
begin
   Result := default(TRecConexao);

   with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'CONFIG.INI') do
      try
         Result.Host := ReadString('CONEXAO', 'host', '127.0.0.1');
         Result.Port := ReadString('CONEXAO', 'port', '3306');
         Result.User := ReadString('CONEXAO', 'user', 'root');
         Result.Password := ReadString('CONEXAO', 'password', '');
         Result.DataBase := ReadString('CONEXAO', 'database', 'pedido');
      finally
         Free;
      end;
end;

function TDmConexao.UltimoID(const Tabela: string): string;
begin
   with gerarConsulta('SELECT LAST_INSERT_ID() FROM ' + Tabela) do
      try
         Result := Fields[0].AsString;
      finally
         free;
      end;
end;

end.

