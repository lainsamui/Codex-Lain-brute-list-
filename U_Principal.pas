unit U_Principal;

{
 Dev.: Lain Samui
 Dúvidas, choros, lamentações, ranger de dentes? Envie-me um email : )
 lainisamui@riseup.net

 Componentes: Padrão
 Delphi 2010
 2014
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, ExtCtrls, Math, IdGlobal, dxSkinsCore,
  dxSkinSharp, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxButtons, dxSkinsForm, cxControls, jpeg, dxStatusBar, dxRibbonStatusBar,
  cxContainer, cxEdit, cxListBox, dxGDIPlusClasses, ComCtrls, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze;

type
  TF_Principal = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ScrollBar1: TScrollBar;
    CheckBox4: TCheckBox;
    Edit1: TEdit;
    Label2: TLabel;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    ListBox1: TListBox;
    BtnGo: TButton;
    BtnExportar: TButton;
    Panel1: TPanel;
    Image1: TImage;
    AntiFreeze: TIdAntiFreeze;
    Label3: TLabel;
    Label4: TLabel;
    ScrollBar2: TScrollBar;
    BtnAbort: TButton;
    BtnLimpar: TButton;
    BtnSobre: TButton;
    procedure BtnGoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure BtnExportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBar2Change(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure brute(Char: string);
    procedure addme(text: string);
    procedure setup();
    function checkme(): boolean;
    procedure charupdate();
    procedure BtnAbortClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnSobreClick(Sender: TObject);

  private
  Var
    Dir: String;
    Pausa: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;

implementation

// Var Globais
Var
  linke, confirm: array [0 .. 15] of integer;
  len, size1, size2, Index: integer;
  characters: string;
  starttime, endtime: cardinal;

  // Constantes Globais
const
  MAX_BRUTE: integer = 15;
  LOW_ALPHA: string = 'abcdefghijklmnopqrstuvwxyz';
  UPR_ALPHA: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  STD_NUMBR: string = '0123456789';
{$R *.dfm}

procedure TF_Principal.brute(Char: string);
var
  a, b: integer;
  tmp: string;
begin
  len := length(Char) - 1;
  for a := size1 to MAX_BRUTE do // 0
    linke[a] := -1;
  a := -1;
  setup();
  while not(checkme()) do
  begin
    if not(a < len) then
    begin
      linke[MAX_BRUTE - 1] := linke[MAX_BRUTE - 1] + 1;
      for b := MAX_BRUTE - 1 downto 1 do
      begin
        if (linke[b] > len) then
        begin
          linke[b] := 0;
          linke[b - 1] := linke[b - 1] + 1;
        end;
      end;
      a := -1;
    end;
    a := a + 1;
    tmp := '';

    for b := 0 to MAX_BRUTE - 1 do
    begin
      if linke[b] > -1 then
        tmp := tmp + copy(Char, linke[b] + 1, 1);
    end;
    if a <= len then
    begin
      linke[MAX_BRUTE] := a;
      tmp := tmp + copy(Char, linke[MAX_BRUTE] + 1, 1);
    end;
    if ListBox1.Count <= 4998 then // Divisão de pacotes em 5 Mil Registros
    Begin
      addme(tmp);
      ListBox1.refresh;
      //Acompanhar Lista - Top/Down
      ListBox1.Selected[ListBox1.Count - 1] := True;
      ListBox1.Selected[ListBox1.Count - 1] := false;
    End
    Else if (ListBox1.Count = 4999) Or (Pausa = True) then
    Begin
      Index := Index + 1;
      addme(tmp);
      ListBox1.refresh;
      //Acompanhar Lista - Top/Down
      ListBox1.Selected[ListBox1.Count - 1] := True;
      ListBox1.Selected[ListBox1.Count - 1] := false;

      ListBox1.Items.SaveToFile(Dir + '\CodPack[' + InttoSTR(Index) + '].txt');
      ListBox1.Clear;
      Sleep(1000);  // Deixe o Processador Respirar xD
    End;
    FreeonRelease;
    if Pausa = True then
      Exit;
  end;
  StatusBar1.Panels.Items[1].text := (InttoSTR(ListBox1.Count));
end;

procedure TF_Principal.setup();
var
  a, b: integer;
begin
  b := size2;
  for a := MAX_BRUTE downto 0 do
  begin
    if b > -1 then
    begin
      confirm[a] := 1;
      b := b - 1;
    end
    else
    begin
      confirm[a] := 0;
    end;
  end;
  Application.ProcessMessages;
  FreeonRelease;
end;

procedure TF_Principal.charupdate();
begin
  characters := '';
  if F_Principal.CheckBox1.checked then
    characters := characters + LOW_ALPHA;
  if F_Principal.CheckBox2.checked then
    characters := characters + UPR_ALPHA;
  if F_Principal.CheckBox3.checked then
    characters := characters + STD_NUMBR;
  if F_Principal.CheckBox4.checked then
    characters := characters + F_Principal.Edit1.text;
  FreeonRelease;
end;

function TF_Principal.checkme(): boolean;
var
  a, c: integer;
begin
  c := 0;
  for a := MAX_BRUTE downto (MAX_BRUTE - size2) do
  begin
    if confirm[a] = 1 then
    begin
      if linke[a] >= len then
        c := c + 1;
    end;
  end;
  if c = size2 + 1 then
    result := True
  else
    result := false;

  FreeonRelease;
  Application.ProcessMessages;
end;

procedure TF_Principal.addme(text: string);
begin
  ListBox1.Items.add(text);
  Application.ProcessMessages;
end;

procedure TF_Principal.BtnGoClick(Sender: TObject);
Begin
  Pausa := false;
  BtnGo.Enabled := false;
  BtnExportar.Enabled := false;
  BtnLimpar.Enabled := false;
  BtnSobre.Enabled := false;
  ListBox1.Clear;
  charupdate;
  starttime := GetTickCount;
  brute(characters); // Motor
  endtime := GetTickCount;
  StatusBar1.Panels.Items[0].text := InttoSTR(gettickdiff(starttime, endtime))
    + ' Milissegundos';
  BtnGo.Enabled := True;
  BtnExportar.Enabled := True;
  BtnLimpar.Enabled := True;
  BtnSobre.Enabled := True;
  Pausa := false;
  if ListBox1.Items.text <> '' then
  Begin
    Index := Index + 1;
    ListBox1.Items.SaveToFile(Dir + '\CodPack[' + InttoSTR(Index) + '].txt');
  End;
  ListBox1.Clear;
  FreeonRelease;
  Index := 0;
end;

procedure TF_Principal.BtnLimparClick(Sender: TObject);
begin
  ListBox1.Clear;
  BtnExportar.Enabled := false;
end;

procedure TF_Principal.BtnSobreClick(Sender: TObject);
begin
  ListBox1.Clear;
  ListBox1.Items.add('  Protocolo Lain');
  ListBox1.Items.add('    protocololain.wordpress.com');
end;

procedure TF_Principal.BtnAbortClick(Sender: TObject);
begin
  Pausa := True;
  Index := 0;
  BtnGo.Enabled := True;
  BtnExportar.Enabled := True;
  BtnLimpar.Enabled := True;
  BtnSobre.Enabled := True;
end;

procedure TF_Principal.BtnExportarClick(Sender: TObject);
begin
  if SaveDialog1.Execute = false then
    Exit
  Else
    ListBox1.Items.SaveToFile(SaveDialog1.FileName);
end;

procedure TF_Principal.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.checked = True then
  Begin
    Edit1.Enabled := True;
    Edit1.SetFocus;
  End
  Else if CheckBox4.checked = false then
    Edit1.Enabled := false;
end;

procedure TF_Principal.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
{  if (Key In ['A' .. 'Z', 'a' .. 'z', '0' .. '9']) then
  begin
    Key := #0;
  end;     }
end;

procedure TF_Principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BtnAbort.Click;
  Application.Terminate;
end;

procedure TF_Principal.FormCreate(Sender: TObject);
begin
  Pausa := false;
  Dir := extractfilepath(Application.ExeName);
  Index := 0;
  charupdate;
  size1 := 0;
  size2 := 0;
  ListBox1.Items.add('  Protocolo Lain');
  ListBox1.Items.add('    protocololain.wordpress.com');
end;

procedure TF_Principal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TF_Principal.ScrollBar1Change(Sender: TObject);
begin
  size1 := ScrollBar1.Position - 1;
  Label2.Caption := InttoSTR(size1 + 1);

  if ScrollBar1.Position > ScrollBar2.Position then
    ScrollBar2.Position := ScrollBar1.Position;
end;

procedure TF_Principal.ScrollBar2Change(Sender: TObject);
begin
  size2 := ScrollBar2.Position - 1;
  Label3.Caption := InttoSTR(size2 + 1);

  if ScrollBar1.Position > ScrollBar2.Position then
    ScrollBar1.Position := ScrollBar2.Position;
end;

end.
