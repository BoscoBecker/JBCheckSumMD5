unit Ucheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IdHashMessageDigest, StdCtrls, pngimage, ExtCtrls, Vcl.WinXCtrls;

type
  TFormVerificadorMd5 = class(TForm)
    editArquivo: TEdit;
    btnSelecionarArquivo: TButton;
    editResult: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtComparar: TEdit;
    OpenDialog1: TOpenDialog;
    lblValidor: TLabel;
    Label3: TLabel;
    Image1: TImage;
    lblhash: TLabel;
    shp1: TShape;
    lbl1: TLabel;
    pnlSobre: TPanel;
    mmo1: TMemo;
    btnFechar: TButton;
    actvtyndctr1: TActivityIndicator;
    ToggleSwitch1: TToggleSwitch;
    procedure btnSelecionarArquivoClick(Sender: TObject);
    procedure edtCompararChange(Sender: TObject);
    procedure edtCompararClick(Sender: TObject);
    procedure edtCompararExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure editArquivoChange(Sender: TObject);
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
  FormVerificadorMd5: TFormVerificadorMd5;

implementation

{$R *.dfm}

constructor TMinhaThread.Create();
begin
  inherited Create(True);

  { Chama o contrutor herdado. Ele irá temporariamente colocar o
    thread em estado de espera para depois executá-lo. }
  FreeOnTerminate := True; // Libera da memoria o objeto após terminar.

  { Configura sua prioridade na lista de processos do Sistema operacional. }
  Priority := tpLower;


  //Start; // Inicia o Thread.
end;

 procedure TMinhaThread.Execute;
begin
  inherited;

  FormVerificadorMd5.actvtyndctr1.Animate := True;
  FormVerificadorMd5.editResult.text:= FormVerificadorMd5.MD5(FormVerificadorMd5.editArquivo.Text);
  FormVerificadorMd5.actvtyndctr1.Animate := False;
end;

procedure TFormVerificadorMd5.btnFecharClick(Sender: TObject);
begin
  pnlSobre.Visible := False;
end;

procedure TFormVerificadorMd5.btnSelecionarArquivoClick(Sender: TObject);
var
  vThread : TMinhaThread;
begin
  actvtyndctr1.Animate := True;

  if (FormVerificadorMd5.editArquivo.Text = EmptyStr)
     or (not FileExists(FormVerificadorMd5.editArquivo.Text,True))
  then
  begin
    if FormVerificadorMd5.OpenDialog1.Execute then
      FormVerificadorMd5.editArquivo.Text := FormVerificadorMd5.OpenDialog1.FileName;
  end;

  if FormVerificadorMd5.editArquivo.Text = EmptyStr then
  begin
    Application.MessageBox('O diretorio não foi informado ou o arquivo não foi selecionado!',
    'Diretório vazio', MB_ICONINFORMATION+MB_OK);
    actvtyndctr1.Animate := False;
    Exit;
  end  else
  begin
    if not FileExists(FormVerificadorMd5.editArquivo.Text) then
    begin
      Application.MessageBox('Diretorio Inválido',
      'Inválido', MB_ICONINFORMATION+MB_OK);
      actvtyndctr1.Animate := False;
      exit;
    end;
  end;

  actvtyndctr1.Animate := False;

  vThread := TMinhaThread.Create;
  vThread.Start;
end;

procedure TFormVerificadorMd5.compare;
begin
  //edtComparar.Text:= Trim(edtComparar.Text);

  if UpperCase(Trim(editResult.Text)) = UpperCase(Trim(edtComparar.Text)) then
  begin
   lblValidor.Font.Color:= clGreen;
   lblValidor.Font.Style:= [fsBold];
   lblValidor.Caption   := 'O arquivo está integro';
  end else
  begin
   lblValidor.Font.Color:= clred;
   lblValidor.Font.Style:= [fsBold];
   lblValidor.Caption   := 'O arquivo não está integro';
  end;

  edtComparar.Text:= UpperCase(edtComparar.Text);
end;

procedure TFormVerificadorMd5.editArquivoChange(Sender: TObject);
var
  vThread : TMinhaThread;
begin
  actvtyndctr1.Animate := True;

  if Trim(FormVerificadorMd5.editArquivo.Text) = EmptyStr then
  begin
    actvtyndctr1.Animate := False;

    Exit;
  end  else
  begin
    if not FileExists(FormVerificadorMd5.editArquivo.Text) then
    begin
      actvtyndctr1.Animate := False;

      exit;
    end;
  end;

  actvtyndctr1.Animate := False;

  vThread := TMinhaThread.Create;
  vThread.Start;
end;

procedure TFormVerificadorMd5.edtCompararChange(Sender: TObject);
begin
  compare;
end;

procedure TFormVerificadorMd5.edtCompararClick(Sender: TObject);
begin
//  compare
end;

procedure TFormVerificadorMd5.edtCompararExit(Sender: TObject);
begin
  compare;
end;

procedure TFormVerificadorMd5.Image1Click(Sender: TObject);
begin
  pnlSobre.Visible := True;
end;

function TFormVerificadorMd5.MD5(const fileName : string) : string;
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
procedure TFormVerificadorMd5.ToggleSwitch1Click(Sender: TObject);
begin
  if ToggleSwitch1.State =  tssOn then
  begin
    edtComparar.Visible:= true;
    lblhash.Visible := True;
    compare;
  end else
  if ToggleSwitch1.State =  tssOff then
  begin
    edtComparar.Visible  := false;
    lblValidor.Caption   := '';
    lblhash.Visible      := False;
  end;
end;

end.
