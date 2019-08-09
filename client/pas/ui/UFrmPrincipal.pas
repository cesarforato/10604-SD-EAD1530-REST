unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    cmbSaborPizza: TComboBox;
    Button1: TButton;
    mmRetornoWebService: TMemo;
    edtEnderecoBackend: TLabeledEdit;
    edtPortaBackend: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  MVCFramework.RESTClient;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Clt: TRestClient;
begin
  Clt := MVCFramework.RESTClient.TRestClient.Create(edtEnderecoBackend.Text, StrToIntDef(edtPortaBackend.Text, 80), nil);
  try
    ShowMessage(Clt.doGET('/div/10/20', []).BodyAsString);
  finally
    Clt.Free;
  end;
end;

end.
