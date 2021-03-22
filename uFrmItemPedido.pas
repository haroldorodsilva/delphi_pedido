unit uFrmItemPedido;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   Rec.Produto;

type
   TfrmItemPedido = class(TForm)
      Panel1: TPanel;
      btnGravar: TButton;
      btnCancelar: TButton;
      edtCod: TEdit;
      edtDescricao: TEdit;
      Label3: TLabel;
      edtQuantidade: TEdit;
      Label1: TLabel;
      edtValor: TEdit;
      Label2: TLabel;
      procedure btnCancelarClick(Sender: TObject);
      procedure btnGravarClick(Sender: TObject);
      procedure edtCodExit(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure edtValorChange(Sender: TObject);
      procedure FormShow(Sender: TObject);
   private
      { Private declarations }
   public
      procedure setProduto(const Produto: TRecProduto);
      function getProduto: TRecProduto;
   end;

var
   frmItemPedido: TfrmItemPedido;

implementation

uses
   uDmConexao;

{$R *.dfm}

procedure TfrmItemPedido.btnCancelarClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfrmItemPedido.btnGravarClick(Sender: TObject);
begin
   if edtCod.Text = EmptyStr then
   begin
      edtCod.SetFocus;
      raise Exception.Create('Informe um Produto.');
   end;

   if StrToCurrDef(edtQuantidade.Text, 0) = 0 then
   begin
      edtQuantidade.SetFocus;
      raise Exception.Create('Informe uma quantidade maior que zero.');
   end;

   if StrToCurrDef(edtValor.Text, 0) = 0 then
   begin
      edtValor.SetFocus;
      raise Exception.Create('Informe um valor maior que zero.');
   end;

   ModalResult := mrOk;
end;

procedure TfrmItemPedido.edtCodExit(Sender: TObject);
begin
   if edtCod.Text <> EmptyStr then
      with DmConexao.gerarConsulta('SELECT p.prod_descricao, p.prod_preco FROM produtos p WHERE p.prod_id = ' + edtCod.Text) do
         try
            if IsEmpty then
            begin
               raise Exception.Create('Produto não encontrado.');
               edtCod.Clear;
               edtCod.SetFocus;
            end;

            edtDescricao.Text := FieldByName('prod_descricao').AsString;
            edtValor.Text := FieldByName('prod_preco').AsString;

            edtQuantidade.Text := '1';
            edtQuantidade.SetFocus;
         finally
            free;
         end;
end;

procedure TfrmItemPedido.edtValorChange(Sender: TObject);
begin
   if (edtValor.Text <> EmptyStr) and (StrToCurrDef(edtValor.Text, -1) = -1) then
   begin
      ShowMessage('Informe um valor válido: Ex: 10,50');
      edtValor.Clear;
   end;
end;

procedure TfrmItemPedido.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
      ModalResult := mrCancel;
end;

procedure TfrmItemPedido.FormShow(Sender: TObject);
begin
   if edtCod.Enabled then
      edtCod.SetFocus
   else
      edtQuantidade.SetFocus;
end;

function TfrmItemPedido.getProduto: TRecProduto;
begin
   Result.Codigo := edtCod.Text;
   Result.Descricao := edtDescricao.Text;
   Result.Quantidade := StrToCurrDef(edtQuantidade.Text, 1);
   Result.ValorUnitario := StrToCurrDef(edtValor.Text, 1);
   Result.Total := Result.Quantidade * Result.ValorUnitario;
end;

procedure TfrmItemPedido.setProduto(const Produto: TRecProduto);
begin
   Caption := 'Alterar Produto';
   edtCod.Text := Produto.Codigo;
   edtDescricao.Text := Produto.Descricao;
   edtQuantidade.Text := CurrToStr(Produto.Quantidade);
   edtValor.Text := CurrToStr(Produto.ValorUnitario);

   edtCod.Enabled := False;
end;

end.

