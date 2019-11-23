program JBCheck;

uses
  Forms,
  Ucheck in 'Ucheck.pas' {FormVerificadorMd5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormVerificadorMd5, FormVerificadorMd5);
  Application.Run;
end.
