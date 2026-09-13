unit ufrmRunnerSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls,
  ExtCtrls, IniFiles, uVisualOperatorTheme, uAppConfig;

type
  { TfrmRunnerSettings }
  TfrmRunnerSettings = class(TForm)
    btnAdd: TButton;
    btnDelete: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    lblInfo: TLabel;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    sgRunners: TStringGrid;
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure LoadSettings;
    procedure SaveSettings;
  public
  end;

var
  frmRunnerSettings: TfrmRunnerSettings;

implementation

{$R *.lfm}

{ TfrmRunnerSettings }

procedure TfrmRunnerSettings.FormCreate(Sender: TObject);
begin
  // Terapkan Tema Gelap/Terang
  TVisualTheme.ApplyTheme(Self, Config.Theme);

  // Konfigurasi Tabel StringGrid
  sgRunners.Cells[0, 0] := 'Ekstensi (misal: .py)';
  sgRunners.Cells[1, 0] := 'Perintah Eksekutor (Gunakan "%f" untuk nama file)';

  LoadSettings;
end;

procedure TfrmRunnerSettings.LoadSettings;
var
  Ini: TIniFile;
  Keys: TStringList;
  i: Integer;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ss_runners.ini');
  Keys := TStringList.Create;
  try
    Ini.ReadSection('Runners', Keys);

    // Jika file belum ada, muat konfigurasi bawaan (Default)
    if Keys.Count = 0 then
    begin
      sgRunners.RowCount := 10; // Diperbesar dari 7 menjadi 10 untuk 3 bahasa baru
      sgRunners.Cells[0, 1] := '.py';    sgRunners.Cells[1, 1] := 'python "%f"';
      sgRunners.Cells[0, 2] := '.js';    sgRunners.Cells[1, 2] := 'node "%f"';
      sgRunners.Cells[0, 3] := '.pas';   sgRunners.Cells[1, 3] := 'fpc "%f" && "%n"';
      sgRunners.Cells[0, 4] := '.java';  sgRunners.Cells[1, 4] := 'java "%f"';
      sgRunners.Cells[0, 5] := '.lua';   sgRunners.Cells[1, 5] := 'lua "%f"';
      sgRunners.Cells[0, 6] := '.html';  sgRunners.Cells[1, 6] := 'browser';
      // Tambahan Bahasa Baru
      sgRunners.Cells[0, 7] := '.rb';    sgRunners.Cells[1, 7] := 'ruby "%f"';
      sgRunners.Cells[0, 8] := '.jl';    sgRunners.Cells[1, 8] := 'julia "%f"';
      sgRunners.Cells[0, 9] := '.scala'; sgRunners.Cells[1, 9] := 'scala "%f"';
    end
    else
    begin
      sgRunners.RowCount := Keys.Count + 1;
      for i := 0 to Keys.Count - 1 do
      begin
        sgRunners.Cells[0, i + 1] := Keys[i];
        sgRunners.Cells[1, i + 1] := Ini.ReadString('Runners', Keys[i], '');
      end;
    end;
  finally
    Keys.Free;
    Ini.Free;
  end;
end;

procedure TfrmRunnerSettings.SaveSettings;
var
  Ini: TIniFile;
  i: Integer;
  Ext, Cmd: string;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ss_runners.ini');
  try
    Ini.EraseSection('Runners'); // Hapus semua agar terganti dengan yang baru

    for i := 1 to sgRunners.RowCount - 1 do
    begin
      Ext := Trim(sgRunners.Cells[0, i]);
      Cmd := Trim(sgRunners.Cells[1, i]);

      // Simpan hanya jika ekstensi tidak kosong
      if Ext <> '' then
      begin
        if Ext[1] <> '.' then Ext := '.' + Ext; // Otomatis tambah titik jika lupa
        Ini.WriteString('Runners', Ext, Cmd);
      end;
    end;
  finally
    Ini.Free;
  end;
end;

procedure TfrmRunnerSettings.btnAddClick(Sender: TObject);
begin
  sgRunners.RowCount := sgRunners.RowCount + 1;
  sgRunners.Row := sgRunners.RowCount - 1;
  sgRunners.Cells[0, sgRunners.Row] := '.';
  sgRunners.Cells[1, sgRunners.Row] := 'command "%f"';
  sgRunners.SetFocus;
end;

procedure TfrmRunnerSettings.btnDeleteClick(Sender: TObject);
begin
  if sgRunners.Row > 0 then
  begin
    if sgRunners.RowCount > 2 then
      sgRunners.DeleteRow(sgRunners.Row)
    else
    begin
      sgRunners.Cells[0, 1] := '';
      sgRunners.Cells[1, 1] := '';
    end;
  end;
end;

procedure TfrmRunnerSettings.btnSaveClick(Sender: TObject);
begin
  SaveSettings;
  ModalResult := mrOk;
end;

procedure TfrmRunnerSettings.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
