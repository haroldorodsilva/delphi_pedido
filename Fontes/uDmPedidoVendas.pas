unit uDmPedidoVendas;

interface

uses
   System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Rec.Produto,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TdmPedido = class(TDataModule)
      cdsItens: TClientDataSet;
      cdsItensCodigo: TIntegerField;
      cdsItensDescricao: TStringField;
      cdsItensQuantidade: TCurrencyField;
      cdsItensValorUnitario: TCurrencyField;
      cdsItensValorTotal: TCurrencyField;
      cdsItensTOTAL: TAggregateField;
      cdsItensCOUNT: TAggregateField;
      FDTransaction: TFDTransaction;
      FDQuery: TFDQuery;
   private

      function TrataValor(const Valor: Currency): string;
   public
      procedure AdicionarProduto(const Produto: TRecProduto);
      procedure AlerarProduto(const Produto: TRecProduto);
      function getProdutoSelecionado: TRecProduto;

      procedure GravarPedido(const Cliente: string);
      procedure CancelarPedido;
      function ConsultarPedido(out Cliente, PedidoNumero: string): Boolean;
   end;

var
   dmPedido: TdmPedido;

implementation

uses
   uDmConexao, Vcl.Dialogs, Vcl.Forms, Winapi.Windows, Vcl.Controls;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmPedido }

procedure TdmPedido.AlerarProduto(const Produto: TRecProduto);
begin
   if cdsItens.IsEmpty then
      exit;

   cdsItens.Edit;
   cdsItensCodigo.AsString := Produto.Codigo;
   cdsItensDescricao.AsString := Produto.Descricao;
   cdsItensQuantidade.AsCurrency := Produto.Quantidade;
   cdsItensValorUnitario.AsCurrency := Produto.ValorUnitario;
   cdsItensValorTotal.AsCurrency := Produto.Total;
   cdsItens.Post;
end;

procedure TdmPedido.CancelarPedido;
var
   pedido: string;
begin
   if not InputQuery('Cancelar Pedido', 'Informe o código do pedido: ', pedido) then
      Exit;

   if StrToIntDef(pedido, -1) = -1 then
      raise Exception.Create('Informe um numero de pedido válido');

   with DmConexao.gerarConsulta('SELECT pve_numero FROM pedido_venda WHERE pve_numero = ' + pedido) do
      try
         if IsEmpty then
            raise Exception.Create('Pedido não encontrado');
      finally
         free;
      end;

   if Application.MessageBox(Pchar(
      'Confirma o cancelamento do pedido ' + pedido + ' ?'),
      'Confirmação', MB_ICONQUESTION + MB_YESNO) <> mrYes then
      exit;

   FDTransaction.StartTransaction;
   try
      FDQuery.ExecSQL('DELETE FROM pedido_venda WHERE pve_numero = ' + pedido);

      FDTransaction.Commit;
      ShowMessage('Pedido ' + pedido + ' cancelado com sucesso!');
   except
      on e: Exception do
      begin
         raise Exception.Create('Não foi possível cancelar o pedido. Erro:'#13 + e.Message);
         FDTransaction.Rollback;
      end;
   end;
end;

function TdmPedido.ConsultarPedido(out Cliente, PedidoNumero: string): Boolean;
var
   pedido: string;
begin
   Result := false;
   cdsItens.Close;

   if not InputQuery('Consulta de Pedido', 'Informe o código do pedido: ', pedido) then
      Exit;

   if StrToIntDef(pedido, -1) = -1 then
      raise Exception.Create('Informe um numero de pedido válido');

   with DmConexao.gerarConsulta(
      'SELECT  i.pit_quantidade, i.pit_valorunitario, i.pit_valortotal, ' +
      'i.pit_prod_id, p.prod_descricao, v.pve_cli_id ' +
      'FROM pedido_venda v ' +
      'INNER JOIN pedido_itens i ON v.pve_numero = i.pit_pve_numero ' +
      'INNER JOIN  produtos p ON i.pit_prod_id = p.prod_id ' +
      'WHERE pve_numero = ' + pedido) do
      try
         if IsEmpty then
            raise Exception.Create('Pedido não encontrado');

         cdsItens.CreateDataSet;
         cdsItens.DisableControls;

         Cliente := FieldByName('pve_cli_id').AsString;
         PedidoNumero := pedido;
         while not Eof do
         begin
            cdsItens.Insert;
            cdsItensCodigo.AsString := FieldByName('pit_prod_id').AsString;
            cdsItensDescricao.AsString := FieldByName('prod_descricao').AsString;
            cdsItensQuantidade.AsCurrency := FieldByName('pit_quantidade').AsCurrency;
            cdsItensValorUnitario.AsCurrency := FieldByName('pit_valorunitario').AsCurrency;
            cdsItensValorTotal.AsCurrency := FieldByName('pit_valortotal').AsCurrency;
            cdsItens.Post;

            Next;
         end;
         Result := True;
      finally
         free;
         cdsItens.EnableControls;
      end;
end;

function TdmPedido.getProdutoSelecionado: TRecProduto;
begin
   if cdsItens.IsEmpty then
      raise Exception.Create('Nenhum produto informado');

   Result.Codigo := cdsItensCodigo.AsString;
   Result.Descricao := cdsItensDescricao.AsString;
   Result.Quantidade := cdsItensQuantidade.AsCurrency;
   Result.ValorUnitario := cdsItensValorUnitario.AsCurrency;
   Result.Total := cdsItensValorTotal.AsCurrency;
end;

procedure TdmPedido.GravarPedido(const Cliente: string);
var
   lastID: string;
begin
   if Cliente = EmptyStr then
      raise Exception.Create('Informe um cliente');

   if cdsItens.RecordCount = 0 then
      raise Exception.Create('Informe os Produtos');

   FDTransaction.StartTransaction;
   try
      FDQuery.ExecSQL(Format('INSERT INTO pedido_venda (pve_dataemissao, pve_valortotal, pve_cli_id) ' +
         'VALUES(CURRENT_TIMESTAMP(), %s, %s)',
         [TrataValor(cdsItensTOTAL.Value), Cliente]));

      lastID := DmConexao.UltimoID('pedido_venda');

      cdsItens.First;
      while not cdsItens.Eof do
      begin
         FDQuery.ExecSQL(Format('INSERT INTO pedido_itens (pit_quantidade, pit_valorunitario, ' +
            'pit_valortotal, pit_prod_id, pit_pve_numero) VALUES (%s,%s,%s,%s,%s)',
            [TrataValor(cdsItensQuantidade.AsCurrency),
               TrataValor(cdsItensValorUnitario.AsCurrency),
               TrataValor(cdsItensValorTotal.AsCurrency),
               cdsItensCodigo.AsString, lastID]));

         cdsItens.Next;
      end;

      FDTransaction.Commit;
      ShowMessage('Pedido ' + lastID + ' gravado com sucesso!');
   except
      on e: Exception do
      begin
         raise Exception.Create('Não foi possível gravar o pedido. Erro:'#13 + e.Message);
         FDTransaction.Rollback;
      end;
   end;
end;

procedure TdmPedido.AdicionarProduto(const Produto: TRecProduto);
begin
   if not cdsItens.Active then
      cdsItens.CreateDataSet;

   cdsItens.Insert;
   cdsItensCodigo.AsString := Produto.Codigo;
   cdsItensDescricao.AsString := Produto.Descricao;
   cdsItensQuantidade.AsCurrency := Produto.Quantidade;
   cdsItensValorUnitario.AsCurrency := Produto.ValorUnitario;
   cdsItensValorTotal.AsCurrency := Produto.Total;
   cdsItens.Post;
end;

function TdmPedido.TrataValor(const Valor: Currency): string;
begin
   Result := StringReplace(CurrToStr(Valor), ',', '.', [rfReplaceAll]);
end;

end.

