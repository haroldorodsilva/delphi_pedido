unit uPrincipal;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
   TfrmPrincipal = class(TForm)
      MainMenu: TMainMenu;
      PedidoVenda1: TMenuItem;
      procedure PedidoVenda1Click(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   frmPrincipal: TfrmPrincipal;

implementation

uses
   uPedidoVenda;

{$R *.dfm}

procedure TfrmPrincipal.PedidoVenda1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
end;

end.

