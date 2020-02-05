program Codex;

uses
  Forms,
  U_Principal in 'U_Principal.pas' {F_Principal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Codex Lain';
  Application.CreateForm(TF_Principal, F_Principal);
  Application.Run;
end.
