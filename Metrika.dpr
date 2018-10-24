program Metrika;

uses
  Forms,
  UMetrika in 'UMetrika.pas' {FMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
