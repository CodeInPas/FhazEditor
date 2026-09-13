unit uAppConfig;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

type
  TThemeMode = (tmDark, tmLight);
  TLineEndingStyle = (leCRLF, leLF);

  // Enumerasi mesin AI dipusatkan di sini
  TAIEngine = (aeLocalLlama, aeGeminiCloud);

  TAppConfig = class
  private
    FIniFileName: string;

    // Preferences
    FTheme: TThemeMode;
    FFontName: string;
    FFontSize: Integer;
    FTabWidth: Integer;
    FLineEnding: TLineEndingStyle;
    FWordWrap: Boolean;

    // AI Settings
    FAIEngine: TAIEngine;
    FAIEndpoint: string;
    FAIApiKey: string;

    // Window State
    FWindowLeft: Integer;
    FWindowTop: Integer;
    FWindowWidth: Integer;
    FWindowHeight: Integer;
    FWindowState: Integer;

    procedure SetDefaultValues;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Load;
    procedure Save;

    property Theme: TThemeMode read FTheme write FTheme;
    property FontName: string read FFontName write FFontName;
    property FontSize: Integer read FFontSize write FFontSize;
    property TabWidth: Integer read FTabWidth write FTabWidth;
    property LineEnding: TLineEndingStyle read FLineEnding write FLineEnding;
    property WordWrap: Boolean read FWordWrap write FWordWrap;

    // Properti AI
    property AIEngine: TAIEngine read FAIEngine write FAIEngine;
    property AIEndpoint: string read FAIEndpoint write FAIEndpoint;
    property AIApiKey: string read FAIApiKey write FAIApiKey;

    property WindowLeft: Integer read FWindowLeft write FWindowLeft;
    property WindowTop: Integer read FWindowTop write FWindowTop;
    property WindowWidth: Integer read FWindowWidth write FWindowWidth;
    property WindowHeight: Integer read FWindowHeight write FWindowHeight;
    property WindowState: Integer read FWindowState write FWindowState;
  end;

var
  Config: TAppConfig;

implementation

const
  SEC_PREFS = 'Preferences';
  SEC_AI = 'AI';
  SEC_WINDOW = 'Window';

constructor TAppConfig.Create;
begin
  FIniFileName := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'ss_config.ini';
  SetDefaultValues;
  Load;
end;

destructor TAppConfig.Destroy;
begin
  Save;
  inherited Destroy;
end;

procedure TAppConfig.SetDefaultValues;
begin
  FTheme := tmDark;
  {$IFDEF WINDOWS}
  FFontName := 'Consolas';
  {$ELSE}
  FFontName := 'Monospace';
  {$ENDIF}
  FFontSize := 11;
  FTabWidth := 4;
  FLineEnding := leCRLF;
  FWordWrap := True;

  // Nilai Default AI
  FAIEngine := aeLocalLlama;
  FAIEndpoint := 'http://127.0.0.1:8080/completion';
  FAIApiKey := '';

  FWindowLeft := -1;
  FWindowTop := -1;
  FWindowWidth := 800;
  FWindowHeight := 600;
  FWindowState := 0;
end;

procedure TAppConfig.Load;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FIniFileName);
  try
    FTheme := TThemeMode(Ini.ReadInteger(SEC_PREFS, 'Theme', Ord(FTheme)));
    FFontName := Ini.ReadString(SEC_PREFS, 'FontName', FFontName);
    FFontSize := Ini.ReadInteger(SEC_PREFS, 'FontSize', FFontSize);
    FTabWidth := Ini.ReadInteger(SEC_PREFS, 'TabWidth', FTabWidth);
    FLineEnding := TLineEndingStyle(Ini.ReadInteger(SEC_PREFS, 'LineEnding', Ord(FLineEnding)));
    FWordWrap := Ini.ReadBool(SEC_PREFS, 'WordWrap', FWordWrap);

    // Muat konfigurasi AI
    FAIEngine := TAIEngine(Ini.ReadInteger(SEC_AI, 'Engine', Ord(FAIEngine)));
    FAIEndpoint := Ini.ReadString(SEC_AI, 'Endpoint', FAIEndpoint);
    FAIApiKey := Ini.ReadString(SEC_AI, 'ApiKey', FAIApiKey);

    FWindowLeft := Ini.ReadInteger(SEC_WINDOW, 'Left', FWindowLeft);
    FWindowTop := Ini.ReadInteger(SEC_WINDOW, 'Top', FWindowTop);
    FWindowWidth := Ini.ReadInteger(SEC_WINDOW, 'Width', FWindowWidth);
    FWindowHeight := Ini.ReadInteger(SEC_WINDOW, 'Height', FWindowHeight);
    FWindowState := Ini.ReadInteger(SEC_WINDOW, 'State', FWindowState);
  finally
    Ini.Free;
  end;
end;

procedure TAppConfig.Save;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FIniFileName);
  try
    Ini.WriteInteger(SEC_PREFS, 'Theme', Ord(FTheme));
    Ini.WriteString(SEC_PREFS, 'FontName', FFontName);
    Ini.WriteInteger(SEC_PREFS, 'FontSize', FFontSize);
    Ini.WriteInteger(SEC_PREFS, 'TabWidth', FTabWidth);
    Ini.WriteInteger(SEC_PREFS, 'LineEnding', Ord(FLineEnding));
    Ini.WriteBool(SEC_PREFS, 'WordWrap', FWordWrap);

    // Simpan konfigurasi AI
    Ini.WriteInteger(SEC_AI, 'Engine', Ord(FAIEngine));
    Ini.WriteString(SEC_AI, 'Endpoint', FAIEndpoint);
    Ini.WriteString(SEC_AI, 'ApiKey', FAIApiKey);

    Ini.WriteInteger(SEC_WINDOW, 'Left', FWindowLeft);
    Ini.WriteInteger(SEC_WINDOW, 'Top', FWindowTop);
    Ini.WriteInteger(SEC_WINDOW, 'Width', FWindowWidth);
    Ini.WriteInteger(SEC_WINDOW, 'Height', FWindowHeight);
    Ini.WriteInteger(SEC_WINDOW, 'State', FWindowState);
  finally
    Ini.Free;
  end;
end;

initialization
  Config := TAppConfig.Create;

finalization
  Config.Free;

end.
