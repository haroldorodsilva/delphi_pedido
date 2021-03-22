program PedidoVendas;

uses
  Vcl.Forms,
  uPrincipal in 'Fontes\uPrincipal.pas' {frmPrincipal},
  uDmConexao in 'Fontes\uDmConexao.pas' {DmConexao: TDataModule},
  Rec.Conexao in 'Fontes\Rec\Rec.Conexao.pas',
  uPedidoVenda in 'Fontes\uPedidoVenda.pas' {frmPedidoVenda},
  uDmPedidoVendas in 'Fontes\uDmPedidoVendas.pas' {dmPedido: TDataModule},
  uFrmItemPedido in 'uFrmItemPedido.pas' {frmItemPedido},
  Rec.Produto in 'Fontes\Rec\Rec.Produto.pas';

{$R *.res}

begin
   {$IFDEF DEBUG}
   ReportMemoryLeaksOnShutdown := true;
   {$ENDIF}

   Application.Initialize;
   Application.MainFormOnTaskbar := True;
   Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

