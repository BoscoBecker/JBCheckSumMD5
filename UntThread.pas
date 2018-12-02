unit UntThread;

interface

uses
  Classes;

type
  CarregaFile = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure CarregaFileThread;
  end;

implementation

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure CarregaFile.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ CarregaFile }

procedure CarregaFile.CarregaFileThread;
begin

end;

procedure CarregaFile.Execute;
begin
   editArquivo.Text = EmptyStr then
  Begin
    if OpenDialog1.Execute then

    //editArquivo.Text:= OpenDialog1.FileName;
    if editArquivo.Text = EmptyStr then
     begin
       Application.MessageBox('O diretorio não foi informado ou o arquivo não foi selecionado!',
       'Diretório vazio', MB_ICONINFORMATION+MB_OK);
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
       Application.MessageBox('Diretorio Inválido',
       'Inválido', MB_ICONINFORMATION+MB_OK);
       if editArquivo.CanFocus  then
         edtComparar.SetFocus;
       exit;

    end;
  End;

end;

end.
