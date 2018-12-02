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
    lblhash: TLabel;
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

  TMinhaThread = class(TThread)
  private

  protected
    procedure Execute; override;
  public
    constructor Create();

end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

constructor TMinhaThread.Create();
begin
  inherited Create(True);

  { Chama o contrutor herdado. Ele irá temporariamente colocar o
    thread em estado de espera para depois executá-lo. }
  FreeOnTerminate := True; // Libera da memoria o objeto após terminar.

  { Configura sua prioridade na lista de processos do Sistema operacional. }
  Priority := TpLower;

  Resume; // Inicia o Thread.
end;

 procedure TMinhaThread.Execute;
begin
  inherited;
  if Form1.editArquivo.Text = EmptyStr then
  Begin
    if Form1.OpenDialog1.Execute then
      Form1.editArquivo.Text := Form1.OpenDialog1.FileName;
   if Form1.editArquivo.Text = EmptyStr then
     begin
       Application.MessageBox('O diretorio não foi informado ou o arquivo não foi selecionado!',
       'Diretório vazio', MB_ICONINFORMATION+MB_OK);
       if Form1.editArquivo.CanFocus  then
         Form1.edtComparar.SetFocus;
       exit;
     end;
    Form1.editResult.text:= Form1.MD5(Form1.editArquivo.Text);
  End
  else
  Begin
    if FileExists(Form1.editArquivo.Text) then
      Form1.editResult.text:= Form1.MD5(Form1.editArquivo.Text)
    else
    begin
       Application.MessageBox('Diretorio Inválido',
       'Inválido', MB_ICONINFORMATION+MB_OK);
       if Form1.editArquivo.CanFocus  then
         Form1.edtComparar.SetFocus;
       exit;

    end;
  End;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  vThread : TMinhaThread;
begin
  vThread := TMinhaThread.Create;

  vThread.Execute;
end;

procedure TForm1.ckComparerClick(Sender: TObject);
begin
  if ckComparer.State = cbChecked then
  begin
    edtComparar.Visible:= true;
    lblhash.Visible := True;
  end;

  if ckComparer.State = cbUnchecked then
   begin
     edtComparar.Visible  := false;
     lblValidor.Caption   := '';
     lblhash.Visible      := False;
   end;
end;

procedure TForm1.compare;
begin
  edtComparar.Text:= Trim(edtComparar.Text);
  if UpperCase(editResult.Text) = UpperCase(edtComparar.Text) then
  begin
   lblValidor.Font.Color:= clGreen;
   lblValidor.Font.Style:= [fsBold];
   lblValidor.Caption   := 'O arquivo está integro';
  end else
  Begin
   lblValidor.Font.Color:= clred;
   lblValidor.Font.Style:= [fsBold];
   lblValidor.Caption   := 'O arquivo não está integro';
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
