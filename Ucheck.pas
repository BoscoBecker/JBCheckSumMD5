unit Ucheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IdHashMessageDigest, StdCtrls, pngimage, ExtCtrls;

type
  TForm1 = class(TForm)
    editArquivo: TEdit;
    Button1: TButton;
    editResult: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ckComparer: TCheckBox;
    edtComparar: TEdit;
    OpenDialog1: TOpenDialog;
    lblValidor: TLabel;
    Label3: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure ckComparerClick(Sender: TObject);
    procedure edtCompararChange(Sender: TObject);
    procedure edtCompararClick(Sender: TObject);
    procedure edtCompararExit(Sender: TObject);
  private
    { Private declarations }
  function MD5(const fileName : string) : string;

  procedure compare();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if editArquivo.Text = EmptyStr then
  Begin
    if OpenDialog1.Execute then
    editArquivo.Text:= OpenDialog1.FileName;
    if editArquivo.Text = EmptyStr then
     begin
       Application.MessageBox('O diretorio n�o foi informado ou o arquivo n�o foi selecionado!',
       'Diret�rio vazio', MB_ICONINFORMATION+MB_OK);
       if editArquivo.CanFocus  then
         edtComparar.SetFocus;
       exit;
     end;
    editResult.text:= MD5(editArquivo.Text);
  End
  else
  Begin
    if FileExists(editArquivo.Text) then
      editResult.text:= MD5(editArquivo.Text)
    else
    begin
       Application.MessageBox('Diretorio Inv�lido',
       'Inv�lido', MB_ICONINFORMATION+MB_OK);
       if editArquivo.CanFocus  then
         edtComparar.SetFocus;
       exit;

    end;
  End;

end;

procedure TForm1.ckComparerClick(Sender: TObject);
begin
  if ckComparer.State = cbChecked then
    edtComparar.Visible:= true;

  if ckComparer.State = cbUnchecked then
   begin
     edtComparar.Visible  := false;
     lblValidor.Caption   := '';
   end;
end;

procedure TForm1.compare;
begin
  if UpperCase(editResult.Text) = UpperCase(edtComparar.Text) then
  begin
   lblValidor.Font.Color:= clGreen;
   lblValidor.Font.Style:= [fsBold];
   lblValidor.Caption   := 'O arquivo est� integro';
  end else
  Begin
   lblValidor.Font.Color:= clred;
   lblValidor.Font.Style:= [fsBold];
   lblValidor.Caption   := 'O arquivo n�o est� integro';
  End;
  edtComparar.Text:= UpperCase(edtComparar.Text);
end;

procedure TForm1.edtCompararChange(Sender: TObject);
begin
 compare;
end;

procedure TForm1.edtCompararClick(Sender: TObject);
begin
 compare
end;

procedure TForm1.edtCompararExit(Sender: TObject);
begin
compare;
end;

function TForm1.MD5(const fileName : string) : string;
var
  idmd5 : TIdHashMessageDigest5;
  fs : TFileStream;
begin
  idmd5 := TIdHashMessageDigest5.Create;

  fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite) ;
  try
    result := idmd5.HashStreamAsHex(fs);
  finally
    fs.Free;
    idmd5.Free;
  end;
end;



end.