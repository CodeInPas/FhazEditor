unit uSessionManager;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, SynEdit;

type
  { Representasi data untuk setiap tab/sesi }
  TSessionItem = class
    SynEdit: TSynEdit;
    FileName: string;
    TempFileName: string;
  end;

  { TSessionManager: Mengelola proses Open/Save file dan Auto-Save untuk Multi-Tab }
  TSessionManager = class
  private
    FSessions: TList;
    FAutoSaveTimer: TTimer;
    FAppPath: string;

    procedure OnAutoSaveTick(Sender: TObject);
    function FindSession(ASynEdit: TSynEdit): TSessionItem;
  public
    constructor Create;
    destructor Destroy; override;

    // Manajemen Multi-Tab
    procedure AddSession(ASynEdit: TSynEdit; const AFileName: string = '');
    procedure RemoveSession(ASynEdit: TSynEdit);

    // Fungsi I/O standar
    function OpenFile(ASynEdit: TSynEdit; const AFileName: string): Boolean;
    function SaveFile(ASynEdit: TSynEdit; const AFileName: string): Boolean;

    // Fungsi pemulihan (Crash recovery)
    procedure GetRecoverableFiles(var AList: TStringList);
    procedure ClearSession(ASynEdit: TSynEdit);
    procedure ClearAllSessions;

    // Properti Getter & Setter
    function GetFileName(ASynEdit: TSynEdit): string;
    procedure SetFileName(ASynEdit: TSynEdit; const AFileName: string);
  end;

implementation

{ TSessionManager }

constructor TSessionManager.Create;
begin
  FSessions := TList.Create;
  FAppPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  // Inisialisasi Timer untuk Auto-Save Multi-Tab di latar belakang
  FAutoSaveTimer := TTimer.Create(nil);
  FAutoSaveTimer.Interval := 10000; // Cek setiap 10 detik
  FAutoSaveTimer.OnTimer := @OnAutoSaveTick;
  FAutoSaveTimer.Enabled := True;
end;

destructor TSessionManager.Destroy;
begin
  FAutoSaveTimer.Enabled := False;
  FAutoSaveTimer.Free;
  ClearAllSessions; // Pastikan semua file .tmp yang aktif dihapus saat aplikasi ditutup normal
  FSessions.Free;
  inherited Destroy;
end;

procedure TSessionManager.OnAutoSaveTick(Sender: TObject);
var
  i: Integer;
  Item: TSessionItem;
begin
  // Iterasi semua tab yang terbuka, lakukan background save jika ada perubahan (Modified)
  for i := 0 to FSessions.Count - 1 do
  begin
    Item := TSessionItem(FSessions[i]);
    if Assigned(Item.SynEdit) and Item.SynEdit.Modified then
    begin
      try
        Item.SynEdit.Lines.SaveToFile(Item.TempFileName);
      except
        // Abaikan error I/O sementara agar aplikasi tidak crash
      end;
    end;
  end;
end;

function TSessionManager.FindSession(ASynEdit: TSynEdit): TSessionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FSessions.Count - 1 do
  begin
    if TSessionItem(FSessions[i]).SynEdit = ASynEdit then
    begin
      Result := TSessionItem(FSessions[i]);
      Break;
    end;
  end;
end;

procedure TSessionManager.AddSession(ASynEdit: TSynEdit; const AFileName: string);
var
  Item: TSessionItem;
begin
  if FindSession(ASynEdit) <> nil then Exit;

  Item := TSessionItem.Create;
  Item.SynEdit := ASynEdit;
  Item.FileName := AFileName;

  // Berikan nama file temporary yang unik per tab menggunakan kombinasi waktu dan ID pointer memori
  Item.TempFileName := FAppPath + '~ss_autosave_' + FormatDateTime('yymmddhhnnsszzz', Now) + '_' + IntToStr(PtrUInt(ASynEdit)) + '.tmp';

  FSessions.Add(Item);
end;

procedure TSessionManager.RemoveSession(ASynEdit: TSynEdit);
var
  Item: TSessionItem;
begin
  Item := FindSession(ASynEdit);
  if Assigned(Item) then
  begin
    ClearSession(ASynEdit); // Hapus file .tmp
    FSessions.Remove(Item);
    Item.Free;
  end;
end;

procedure TSessionManager.GetRecoverableFiles(var AList: TStringList);
var
  SR: TSearchRec;
begin
  if not Assigned(AList) then Exit;
  AList.Clear;

  // Cari semua file temporary (sisa crash sebelumnya) di root aplikasi
  if FindFirst(FAppPath + '~ss_autosave_*.tmp', faAnyFile, SR) = 0 then
  begin
    try
      repeat
        AList.Add(FAppPath + SR.Name);
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
  end;
end;

procedure TSessionManager.ClearSession(ASynEdit: TSynEdit);
var
  Item: TSessionItem;
begin
  Item := FindSession(ASynEdit);
  if Assigned(Item) then
  begin
    if FileExists(Item.TempFileName) then
      DeleteFile(Item.TempFileName);
  end;
end;

procedure TSessionManager.ClearAllSessions;
var
  i: Integer;
begin
  // Hapus dari belakang ke depan untuk keamanan manipulasi TList
  for i := FSessions.Count - 1 downto 0 do
  begin
    RemoveSession(TSessionItem(FSessions[i]).SynEdit);
  end;
end;

function TSessionManager.OpenFile(ASynEdit: TSynEdit; const AFileName: string): Boolean;
var
  Item: TSessionItem;
begin
  Result := False;
  if not FileExists(AFileName) then Exit;

  Item := FindSession(ASynEdit);
  if not Assigned(Item) then Exit;

  try
    ASynEdit.BeginUpdate;
    try
      ASynEdit.Lines.LoadFromFile(AFileName);
      Item.FileName := AFileName;
      ASynEdit.Modified := False;

      // Hapus .tmp lama karena file berhasil dimuat bersih
      if FileExists(Item.TempFileName) then
        DeleteFile(Item.TempFileName);

      Result := True;
    finally
      ASynEdit.EndUpdate;
    end;
  except
    Result := False;
  end;
end;

function TSessionManager.SaveFile(ASynEdit: TSynEdit; const AFileName: string): Boolean;
var
  Item: TSessionItem;
begin
  Result := False;
  if AFileName = '' then Exit;

  Item := FindSession(ASynEdit);
  if not Assigned(Item) then Exit;

  try
    ASynEdit.Lines.SaveToFile(AFileName);
    Item.FileName := AFileName;
    ASynEdit.Modified := False;

    // Setelah berhasil disimpan ke file asli, hapus file temporary
    if FileExists(Item.TempFileName) then
      DeleteFile(Item.TempFileName);

    Result := True;
  except
    Result := False;
  end;
end;

function TSessionManager.GetFileName(ASynEdit: TSynEdit): string;
var
  Item: TSessionItem;
begin
  Result := '';
  Item := FindSession(ASynEdit);
  if Assigned(Item) then
    Result := Item.FileName;
end;

procedure TSessionManager.SetFileName(ASynEdit: TSynEdit; const AFileName: string);
var
  Item: TSessionItem;
begin
  Item := FindSession(ASynEdit);
  if Assigned(Item) then
    Item.FileName := AFileName;
end;

end.
