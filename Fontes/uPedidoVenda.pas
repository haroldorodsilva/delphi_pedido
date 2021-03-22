unit uPedidoVenda;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
   Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, System.ImageList, Vcl.ImgList;

type
   TfrmPedidoVenda = class(TForm)
      Panel1: TPanel;
      Panel2: TPanel;
      btnAlterarItem: TBitBtn;
      btnNovoItem: TBitBtn;
      btnExcluirItem: TBitBtn;
      Panel3: TPanel;
      btnGravar: TButton;
      dsItens: TDataSource;
      Label1: TLabel;
      Label2: TLabel;
      DBText1: TDBText;
      DBText2: TDBText;
      edtCodCliente: TEdit;
      edtClienteNome: TEdit;
      btnConsultarPedido: TButton;
      btnCancelarPedido: TButton;
      Label3: TLabel;
      btnCancelar: TButton;
      lblNumeroPedido: TLabel;
      GroupBox1: TGroupBox;
      DBGrid1: TDBGrid;
      procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure dsItensDataChange(Sender: TObject; Field: TField);
      procedure edtCodClienteExit(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure btnCancelarClick(Sender: TObject);
      procedure btnNovoItemClick(Sender: TObject);
      procedure btnExcluirItemClick(Sender: TObject);
      procedure btnGravarClick(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormShow(Sender: TObject);
      procedure btnAlterarItemClick(Sender: TObject);
      procedure btnCancelarPedidoClick(Sender: TObject);
      procedure btnConsultarPedidoClick(Sender: TObject);
   private
      procedure ApagarItem;
      procedure AlterarItem;
   public
      procedure Cancelar;
   end;

var
   frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
   uDmPedidoVendas, uDmConexao, uFrmItemPedido;

{$R *.dfm}

procedure TfrmPedidoVenda.AlterarItem;
begin
   if lblNumeroPedido.Visible then
      exit;

   if dmPedido.cdsItens.IsEmpty then
   begin
      ShowMessage('Nenhum produto encontrado!');
      exit;
   end;

   with TfrmItemPedido.Create(nil) do
      try
         setProduto(dmPedido.getProdutoSelecionado);

         if ShowModal = mrOk then
            dmPedido.AlerarProduto(getProduto);

         btnNovoItem.SetFocus;
      finally
         free;
      end;
end;

procedure TfrmPedidoVenda.ApagarItem;
begin
   if lblNumeroPedido.Visible then
      exit;

   with dmPedido do
   begin
      if cdsItens.IsEmpty then
      begin
         ShowMessage('Nenhum produto encontrado!');
         exit;
      end;

      if Application.MessageBox(Pchar(
         'Deseja excluir o item ' + cdsItensDescricao.AsString + ' ?'),
         'Confirmação', MB_ICONQUESTION + MB_YESNO) = mrYes then
      begin
         cdsItens.Delete;
         cdsItens.First;
         DBGrid1.SetFocus;
      end;
   end;
end;

procedure TfrmPedidoVenda.btnAlterarItemClick(Sender: TObject);
begin
   AlterarItem;
end;

procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin
   Cancelar;
end;

procedure TfrmPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
begin
   dmPedido.CancelarPedido;
   Cancelar;
end;

procedure TfrmPedidoVenda.btnConsultarPedidoClick(Sender: TObject);
var
   cliente, Pedido: string;
begin
   Cancelar;
   if dmPedido.ConsultarPedido(cliente, Pedido) then
   begin
      lblNumeroPedido.Caption := 'Pedido nº: ' + Pedido;
      lblNumeroPedido.Visible := true;
      edtCodCliente.Text := cliente;
      btnNovoItem.Enabled := false;
      edtCodClienteExit(nil);
      dsItensDataChange(nil, nil);
      DBGrid1.SetFocus;
   end;
end;

procedure TfrmPedidoVenda.btnExcluirItemClick(Sender: TObject);
begin
   ApagarItem;
end;

procedure TfrmPedidoVenda.btnGravarClick(Sender: TObject);
begin
   try
      dmPedido.GravarPedido(edtCodCliente.Text);
      Cancelar;
   except
      on e: Exception do
         ShowMessage(e.Message);
   end;
end;

procedure TfrmPedidoVenda.btnNovoItemClick(Sender: TObject);
begin
   with TfrmItemPedido.Create(nil) do
      try
         if ShowModal = mrOk then
         begin
            dmPedido.AdicionarProduto(getProduto);
            btnNovoItem.SetFocus;
         end;
      finally
         free;
      end;
end;

procedure TfrmPedidoVenda.Cancelar;
begin
   edtCodCliente.Enabled := true;
   btnGravar.Enabled := true;
   btnNovoItem.Enabled := true;
   lblNumeroPedido.Visible := false;

   edtCodCliente.Clear;
   edtClienteNome.Clear;
   edtCodClienteExit(nil);

   with dmPedido do
   begin
      cdsItens.Close;
      cdsItens.CreateDataSet;
   end;

   edtCodCliente.SetFocus;
end;

procedure TfrmPedidoVenda.DBGrid1KeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if Key = VK_RETURN then
      AlterarItem;

   if Key = VK_DELETE then
      ApagarItem;
end;

procedure TfrmPedidoVenda.dsItensDataChange(Sender: TObject; Field: TField);
begin
   btnAlterarItem.Enabled := (dmPedido.cdsItens.RecordCount > 0) and (not lblNumeroPedido.Visible);
   btnExcluirItem.Enabled := btnAlterarItem.Enabled;

   btnGravar.Enabled := btnAlterarItem.Enabled;
end;

procedure TfrmPedidoVenda.edtCodClienteExit(Sender: TObject);
begin
   btnConsultarPedido.Visible := edtCodCliente.Text = EmptyStr;
   btnCancelarPedido.Visible := btnConsultarPedido.Visible;

   if edtCodCliente.Text = EmptyStr then
      edtClienteNome.Clear
   else
   begin
      with DmConexao.gerarConsulta(
         'SELECT c.cli_nome FROM cliente c WHERE c.cli_id = ' + edtCodCliente.Text) do
         try
            if IsEmpty then
            begin
               ShowMessage('Cliente não encontrado');
               edtCodCliente.Clear;
               edtCodClienteExit(nil);
               edtCodCliente.SetFocus;
               Exit;
            end;

            edtClienteNome.Text := FieldByName('cli_nome').AsString;
            edtCodCliente.Enabled := false;
            if btnNovoItem.enabled then
               btnNovoItem.SetFocus;
         finally
            free;
         end;
   end;

end;

procedure TfrmPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
   dmPedido := TdmPedido.Create(nil);
end;

procedure TfrmPedidoVenda.FormDestroy(Sender: TObject);
begin
   dmPedido.Free;
end;

procedure TfrmPedidoVenda.FormShow(Sender: TObject);
begin
   Cancelar;
end;

end.

