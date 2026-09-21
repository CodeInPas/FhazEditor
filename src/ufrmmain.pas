unit ufrmMain;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, ComCtrls, SynEdit, SynEditSearch, SynEditTypes, SynEditMiscClasses,
  uAppConfig, uVisualOperatorTheme, uSessionManager, ufrmPreferences, uAIAssistant, SynEditMarkupSpecialLine,
  SynHighlighterPas, SynHighlighterHTML, SynHighlighterXML,SynHighlighterPHP,SynHighlighterCpp,
  SynHighlighterJScript, SynHighlighterCss, SynHighlighterPython, SynHighlighterSQL,
  SynCompletion, LCLType, Types, ufrmAbout, SynHighlighterAny,
  Process, LCLIntf, IniFiles, ufrmRunnerSettings;

type
  { TfrmMain: Jendela Editor Utama }
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    mnuSynGo: TMenuItem;
    mnuSynCpp: TMenuItem;
    mnuSynCS: TMenuItem;
    mnuSynRust: TMenuItem;
    mnuSynPHP: TMenuItem;
    mnuFile: TMenuItem;
    mnuNew: TMenuItem;
    mnuOpen: TMenuItem;
    mnuOpenFolder: TMenuItem;
    mnuRecentFiles: TMenuItem;
    MenuItem7: TMenuItem;
    mnuSave: TMenuItem;
    mnuSaveAs: TMenuItem;
    mnuCloseTab: TMenuItem;
    MenuItem8: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuUndo: TMenuItem;
    mnuRedo: TMenuItem;
    MenuItem6: TMenuItem;
    mnuFind: TMenuItem;
    mnuFindInFiles: TMenuItem;
    mnuReplace: TMenuItem;
    mnuView: TMenuItem;
    mnuToggleSidebar: TMenuItem;
    mnuToggleMinimap: TMenuItem;

    mnuToggleSplitView: TMenuItem;
    mnuMoveTabOtherPane: TMenuItem;
    MenuItem16: TMenuItem;

    mnuDistractionFree: TMenuItem;
    mnuPreferences: TMenuItem;
    MenuItem5: TMenuItem;

    MenuItem9: TMenuItem;
    mnuSyntax: TMenuItem;
    mnuSynNone: TMenuItem;
    mnuSynPas: TMenuItem;
    mnuSynHTML: TMenuItem;
    mnuSynXML: TMenuItem;
    mnuSynJS: TMenuItem;
    mnuSynCSS: TMenuItem;
    mnuSynPython: TMenuItem;
    mnuSynSQL: TMenuItem;

    MenuItem10: TMenuItem;
    mnuFontQuality: TMenuItem;
    mnuFQClearType: TMenuItem;
    mnuFQAntialiased: TMenuItem;
    mnuFQDefault: TMenuItem;

    mnuRunMenu: TMenuItem;
    mnuRunCode: TMenuItem;
    MenuItem17: TMenuItem;
    mnuCompilerSettings: TMenuItem;

    MenuItem2: TMenuItem;
    mnFocusMode: TMenuItem;

    mnuHelp: TMenuItem;
    mnuAbout: TMenuItem;

    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dlgFind: TFindDialog;
    dlgReplace: TReplaceDialog;
    dlgSelectDirectory: TSelectDirectoryDialog;

    pnlSidebar: TPanel;
    tvExplorer: TTreeView;
    pnlSearch: TPanel;
    edtSearchExplorer: TEdit;
    Splitter1: TSplitter;

    PageControl1: TPageControl;
    Splitter4: TSplitter;
    PageControl2: TPageControl;

    pnlMinimap: TPanel;
    Splitter2: TSplitter;

    Splitter3: TSplitter;
    pnlBottomResults: TPanel;
    pnlResultsHeader: TPanel;
    btnCloseResults: TButton;
    lbSearchResults: TListBox;

    pnlStatus: TPanel;
    lblStats: TLabel;
    lblCaretPos: TLabel;

    tmrUIUpdate: TTimer;

    popEditor: TPopupMenu;
    popUndo: TMenuItem;
    popRedo: TMenuItem;
    MenuItem11: TMenuItem;
    popCut: TMenuItem;
    popCopy: TMenuItem;
    popPaste: TMenuItem;
    popDelete: TMenuItem;
    MenuItem12: TMenuItem;
    popSelectAll: TMenuItem;

    popExplorer: TPopupMenu;
    popExpOpen: TMenuItem;
    MenuItem13: TMenuItem;
    popExpNewFile: TMenuItem;
    popExpNewFolder: TMenuItem;
    MenuItem14: TMenuItem;
    popExpRename: TMenuItem;
    popExpDeleteItem: TMenuItem;
    MenuItem15: TMenuItem;
    popExpRefresh: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure mnuNewClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuOpenFolderClick(Sender: TObject);
    procedure mnuToggleSidebarClick(Sender: TObject);
    procedure mnuToggleMinimapClick(Sender: TObject);

    procedure mnuToggleSplitViewClick(Sender: TObject);
    procedure mnuMoveTabOtherPaneClick(Sender: TObject);

    procedure mnuSaveClick(Sender: TObject);
    procedure mnuSaveAsClick(Sender: TObject);
    procedure mnuCloseTabClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuUndoClick(Sender: TObject);
    procedure mnuRedoClick(Sender: TObject);
    procedure mnuFindClick(Sender: TObject);
    procedure mnuReplaceClick(Sender: TObject);
    procedure mnuPreferencesClick(Sender: TObject);
    procedure mnuDistractionFreeClick(Sender: TObject);
    procedure mnFocusModeClick(Sender: TObject);
    procedure mnuSyntaxChangeClick(Sender: TObject);
    procedure mnuFontQualityClick(Sender: TObject);

    procedure mnuRunCodeClick(Sender: TObject);
    procedure mnuCompilerSettingsClick(Sender: TObject);

    procedure mnuAboutClick(Sender: TObject);

    procedure mnuFindInFilesClick(Sender: TObject);
    procedure btnCloseResultsClick(Sender: TObject);
    procedure lbSearchResultsDblClick(Sender: TObject);

    procedure popCutClick(Sender: TObject);
    procedure popCopyClick(Sender: TObject);
    procedure popPasteClick(Sender: TObject);
    procedure popDeleteClick(Sender: TObject);
    procedure popSelectAllClick(Sender: TObject);

    procedure popExpOpenClick(Sender: TObject);
    procedure popExpNewFileClick(Sender: TObject);
    procedure popExpNewFolderClick(Sender: TObject);
    procedure popExpRenameClick(Sender: TObject);
    procedure popExpDeleteClick(Sender: TObject);
    procedure popExpRefreshClick(Sender: TObject);

    procedure dlgFindFind(Sender: TObject);
    procedure dlgReplaceReplace(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure tvExplorerExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure tvExplorerDblClick(Sender: TObject);
    procedure tmrUIUpdateTimer(Sender: TObject);

    procedure edtSearchExplorerChange(Sender: TObject);
    procedure edtSearchExplorerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    FSessionManager: TSessionManager;
    FDistractionFree: Boolean;
    FFocusMode: Boolean;
    FNeedsUIUpdate: Boolean;
    FExplorerRoot: string;
    FFontQuality: TFontQuality;

    FSynPas: TSynPasSyn;
    FSynHTML: TSynHTMLSyn;
    FSynXML: TSynXMLSyn;
    FSynJS: TSynJScriptSyn;
    FSynCSS: TSynCssSyn;
    FSynPython: TSynPythonSyn;
    FSynSQL: TSynSQLSyn;
    FSynPHP: TSynPHPSyn;
    FSynDart : TSynAnySyn;
    FImageList: TImageList;
    FCppSyn: TSynCppSyn;
    FSynCSharp: TSynAnySyn;
    FSynRust: TSynAnySyn;
    FSynGo: TSynAnySyn;

    synMinimap: TSynEdit;
    FMinimapDirty: Boolean;

    FActivePageControl: TPageControl;

    FRecentFiles: TStringList;
    procedure LoadRecentFiles;
    procedure SaveRecentFiles;
    procedure AddToRecentFiles(const AFileName: string);
    procedure UpdateRecentFilesMenu;
    procedure mnuRecentFileItemClick(Sender: TObject);

    procedure SearchInFolder(const Dir, Keyword: string);
    function IsTextFile(const AFileName: string): Boolean;

    procedure OpenDocument(const AFileName: string);
    procedure LoadHexView(ASynEdit: TSynEdit; const AFileName: string);

    procedure InitExplorerIcons;
    procedure SyncMinimap;
    procedure MinimapSpecialLineColors(Sender: TObject; Line: integer; var Special: boolean; var FG, BG: TColor);
    procedure MinimapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    // FITUR BARU: Event Autocomplete Dinamis
    procedure SynCompletionExecute(Sender: TObject);

    function GetEditorFromTab(ATab: TTabSheet): TSynEdit;
    function FindTabByFileName(const AFileName: string): TTabSheet;

    function CreateNewTab(const AFileName: string = ''): TSynEdit;
    function GetActiveEditor: TSynEdit;
    function PromptSaveTab(ASynEdit: TSynEdit): Boolean;
    procedure CloseTab(ATabIndex: Integer);

    procedure SynEditEnter(Sender: TObject);
    procedure SynEditChange(Sender: TObject);
    procedure SynEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditSpecialLineColors(Sender: TObject; Line: integer; var Special: boolean; var FG, BG: TColor);
    procedure SynEditMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);

    procedure ApplyConfig;
    procedure UpdateTabCaption(ASynEdit: TSynEdit);
    procedure CalculateStats;
    procedure LoadRecoveredSessions;

    procedure DetectAndApplyHighlighter(ASynEdit: TSynEdit; const AFileName: string);
    procedure SyncHighlighterMenu(ASynEdit: TSynEdit);

    procedure OpenFolder(const APath: string);
    procedure PopulateTreeNode(ParentNode: TTreeNode; const Path: string);
    function GetNodePath(Node: TTreeNode): string;
    procedure SetHightAnySyn;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
  FilePath: string;
begin
  FSynPas := TSynPasSyn.Create(Self);
  FSynHTML := TSynHTMLSyn.Create(Self);
  FSynXML := TSynXMLSyn.Create(Self);
  FSynJS := TSynJScriptSyn.Create(Self);
  FSynCSS := TSynCssSyn.Create(Self);
  FSynPython := TSynPythonSyn.Create(Self);
  FSynSQL := TSynSQLSyn.Create(Self);
  FSynPHP := TSynPHPSyn.Create(Self);
  FCppSyn := TSynCppSyn.Create(self);
  FSynCSharp := TSynAnySyn.Create(Self);
  FSynRust := TSynAnySyn.Create(Self);
  FSynGo := TSynAnySyn.Create(Self);

  SetHightAnySyn;

  FSessionManager := TSessionManager.Create;
  FDistractionFree := False;
  FFocusMode := False;
  FNeedsUIUpdate := False;
  FMinimapDirty := False;

  FActivePageControl := PageControl1;

  FFontQuality := fqClearType;

  FRecentFiles := TStringList.Create;
  LoadRecentFiles;

  InitExplorerIcons;

  // Buat folder 'autocomplete' secara otomatis jika belum ada!
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'autocomplete') then
    CreateDir(ExtractFilePath(Application.ExeName) + 'autocomplete');

  synMinimap := TSynEdit.Create(Self);
  synMinimap.Parent := pnlMinimap;
  synMinimap.Align := alClient;
  synMinimap.ReadOnly := True;
  synMinimap.Gutter.Visible := False;
  synMinimap.Font.Size := 3;
  synMinimap.Options := [eoScrollPastEol, eoNoCaret];
  synMinimap.OnSpecialLineColors := @MinimapSpecialLineColors;
  synMinimap.OnMouseDown := @MinimapMouseDown;
  synMinimap.Cursor := crArrow;

  if (Config.WindowWidth > 0) and (Config.WindowLeft >= 0) then
  begin
    Self.Left := Config.WindowLeft;
    Self.Top := Config.WindowTop;
    Self.Width := Config.WindowWidth;
    Self.Height := Config.WindowHeight;
    Self.WindowState := TWindowState(Config.WindowState);
  end else
    Self.Position := poScreenCenter;

  ApplyConfig;
  LoadRecoveredSessions;

  if ParamCount > 0 then
  begin
    for i := 1 to ParamCount do
    begin
      FilePath := ParamStr(i);
      if FileExists(FilePath) then
        OpenDocument(FilePath);
    end;
  end;

  if PageControl1.PageCount = 0 then
    CreateNewTab;

  // ==============================================================
  // AKTIFKAN FITUR DRAG & DROP DARI OS
  // ==============================================================
  AllowDropFiles := True;
  OnDropFiles := @FormDropFiles;
  // ==============================================================

  CalculateStats;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i: Integer;
  Editor: TSynEdit;
begin
  Config.WindowLeft := Self.Left;
  Config.WindowTop := Self.Top;
  Config.WindowWidth := Self.Width;
  Config.WindowHeight := Self.Height;
  Config.WindowState := Ord(Self.WindowState);
  Config.Save;

  SaveRecentFiles;
  FRecentFiles.Free;

  for i := 0 to PageControl1.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl1.Pages[i]);
    if Assigned(Editor) then
    begin
      Editor.OnChange := nil; Editor.OnStatusChange := nil;
      Editor.OnSpecialLineColors := nil; Editor.OnKeyDown := nil; Editor.OnEnter := nil;
      Editor.OnMouseWheel := nil;
    end;
  end;

  for i := 0 to PageControl2.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl2.Pages[i]);
    if Assigned(Editor) then
    begin
      Editor.OnChange := nil; Editor.OnStatusChange := nil;
      Editor.OnSpecialLineColors := nil; Editor.OnKeyDown := nil; Editor.OnEnter := nil;
      Editor.OnMouseWheel := nil;
    end;
  end;

  FSessionManager.Free;
  FSessionManager := nil;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  CanClose := True;

  FActivePageControl := PageControl1;
  for i := PageControl1.PageCount - 1 downto 0 do
  begin
    PageControl1.ActivePageIndex := i;
    if not PromptSaveTab(GetActiveEditor) then
    begin
      CanClose := False;
      Exit;
    end;
  end;

  FActivePageControl := PageControl2;
  for i := PageControl2.PageCount - 1 downto 0 do
  begin
    PageControl2.ActivePageIndex := i;
    if not PromptSaveTab(GetActiveEditor) then
    begin
      CanClose := False;
      Exit;
    end;
  end;
end;

// ==========================================
// LOGIKA RUN CODE (EKSEKUTOR TERMINAL)
// ==========================================

procedure TfrmMain.mnuRunCodeClick(Sender: TObject);
var
  Editor: TSynEdit;
  FilePath, Ext, CmdTemplate, FullCmd: string;
  AProcess: TProcess;
  MemStream: TMemoryStream;
  StrList: TStringList;
  Ini: TIniFile;
  BytesRead: LongInt;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  FilePath := FSessionManager.GetFileName(Editor);
  if FilePath = '' then
  begin
    ShowMessage('Harap simpan (Save) file terlebih dahulu sebelum dijalankan.');
    Exit;
  end;
  if Editor.Modified then mnuSaveClick(nil); // Paksa Auto-Save sebelum run

  Ext := LowerCase(ExtractFileExt(FilePath));

  // Ambil Perintah dari File ss_runners.ini
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ss_runners.ini');
  try
    CmdTemplate := Ini.ReadString('Runners', Ext, '');
  finally
    Ini.Free;
  end;

  // Nilai Cadangan Bawaan Jika Belum Dikonfigurasi
  if CmdTemplate = '' then
  begin
    if (Ext = '.html') or (Ext = '.htm') then CmdTemplate := 'browser'
    else if Ext = '.py' then CmdTemplate := 'python "%f"'
    else if Ext = '.js' then CmdTemplate := 'node "%f"'
    else if (Ext = '.pas') or (Ext = '.pp') then CmdTemplate := 'fpc "%f" && "%n"'
    else if Ext = '.java' then CmdTemplate := 'java "%f"'
    else if Ext = '.lua' then CmdTemplate := 'lua "%f"'
    else if Ext = '.rb' then CmdTemplate := 'ruby "%f"'
    else if Ext = '.jl' then CmdTemplate := 'julia "%f"'
    else if Ext = '.scala' then CmdTemplate := 'scala "%f"'
    else
    begin
      ShowMessage('Tidak ada konfigurasi kompiler/eksekutor untuk ekstensi ' + Ext +
                  #13#10 + 'Silakan atur di menu [Run -> Compiler Settings...]');
      Exit;
    end;
  end;

  // Kasus Khusus Browser
  if CmdTemplate = 'browser' then
  begin
    OpenURL('file://' + FilePath);
    Exit;
  end;

  // Suntik Variabel Dinamis
  FullCmd := StringReplace(CmdTemplate, '%f', FilePath, [rfReplaceAll]);
  FullCmd := StringReplace(FullCmd, '%n', ChangeFileExt(FilePath, ''), [rfReplaceAll]);

  // Siapkan Antarmuka Panel Bawah
  pnlBottomResults.Visible := True;
  Splitter3.Visible := True;
  lbSearchResults.Clear;
  pnlResultsHeader.Caption := '  Executing: ' + FullCmd;
  Application.ProcessMessages;

  // EKSEKUSI DI LATAR BELAKANG VIA TPROCESS (Zero-Bloat)
  AProcess := TProcess.Create(nil);
  MemStream := TMemoryStream.Create;
  StrList := TStringList.Create;
  try
    // PERBAIKAN: Blok Try harus bertingkat (Nested) di Pascal!
    try
      {$IFDEF WINDOWS}
      AProcess.Executable := 'cmd.exe';
      AProcess.Parameters.Add('/c');
      AProcess.Parameters.Add(FullCmd);
      {$ELSE}
      AProcess.Executable := 'sh';
      AProcess.Parameters.Add('-c');
      AProcess.Parameters.Add(FullCmd);
      {$ENDIF}

      AProcess.Options := [poUsePipes, poStderrToOutPut, poNoConsole];
      AProcess.Execute;

      // Tangkap Output Secara Bertahap agar Editor Tidak Freeze
      while AProcess.Running do
      begin
        if AProcess.Output.NumBytesAvailable > 0 then
        begin
          BytesRead := AProcess.Output.NumBytesAvailable;
          MemStream.SetSize(MemStream.Size + BytesRead);
          AProcess.Output.Read((PByte(MemStream.Memory) + MemStream.Size - BytesRead)^, BytesRead);
        end;
        Application.ProcessMessages;
        Sleep(50);
      end;

      // Tangkap sisa data setelah proses berhenti
      if AProcess.Output.NumBytesAvailable > 0 then
      begin
        BytesRead := AProcess.Output.NumBytesAvailable;
        MemStream.SetSize(MemStream.Size + BytesRead);
        AProcess.Output.Read((PByte(MemStream.Memory) + MemStream.Size - BytesRead)^, BytesRead);
      end;

      // Masukkan ke TListBox
      MemStream.Position := 0;
      if MemStream.Size > 0 then
      begin
        StrList.LoadFromStream(MemStream);
        lbSearchResults.Items.Assign(StrList);
      end
      else
        lbSearchResults.Items.Add('[Selesai tanpa output log]');

      pnlResultsHeader.Caption := Format('  Eksekusi Selesai (Exit Code: %d)', [AProcess.ExitCode]);

    except
      on E: Exception do
        lbSearchResults.Items.Add('ERROR SYSTEM: ' + E.Message + #13#10 + 'Pastikan eksekutor terdaftar di PATH OS Anda.');
    end;
  finally
    StrList.Free;
    MemStream.Free;
    AProcess.Free;
  end;
end;

procedure TfrmMain.mnuCompilerSettingsClick(Sender: TObject);
begin
  frmRunnerSettings := TfrmRunnerSettings.Create(Self);
  try
    frmRunnerSettings.ShowModal;
  finally
    frmRunnerSettings.Free;
  end;
end;

// ==========================================
// LOGIKA OPEN RECENT FILES (Zero-Bloat)
// ==========================================

procedure TfrmMain.LoadRecentFiles;
var
  RecentPath: string;
begin
  RecentPath := ExtractFilePath(Application.ExeName) + 'ss_recent.txt';
  if FileExists(RecentPath) then
    FRecentFiles.LoadFromFile(RecentPath);
  UpdateRecentFilesMenu;
end;

procedure TfrmMain.SaveRecentFiles;
var
  RecentPath: string;
begin
  RecentPath := ExtractFilePath(Application.ExeName) + 'ss_recent.txt';
  FRecentFiles.SaveToFile(RecentPath);
end;

procedure TfrmMain.AddToRecentFiles(const AFileName: string);
var
  Idx: Integer;
begin
  if AFileName = '' then Exit;

  Idx := FRecentFiles.IndexOf(AFileName);
  if Idx >= 0 then FRecentFiles.Delete(Idx);

  FRecentFiles.Insert(0, AFileName);

  while FRecentFiles.Count > 10 do
    FRecentFiles.Delete(10);

  UpdateRecentFilesMenu;
end;

procedure TfrmMain.UpdateRecentFilesMenu;
var
  i: Integer;
  NewItem: TMenuItem;
begin
  mnuRecentFiles.Clear;

  for i := 0 to FRecentFiles.Count - 1 do
  begin
    NewItem := TMenuItem.Create(mnuRecentFiles);
    NewItem.Caption := IntToStr(i + 1) + '. ' + ExtractFileName(FRecentFiles[i]);
    NewItem.Hint := FRecentFiles[i];
    NewItem.OnClick := @mnuRecentFileItemClick;
    mnuRecentFiles.Add(NewItem);
  end;

  mnuRecentFiles.Enabled := (mnuRecentFiles.Count > 0);
end;

procedure TfrmMain.mnuRecentFileItemClick(Sender: TObject);
var
  FilePath: string;
begin
  FilePath := TMenuItem(Sender).Hint;
  if FileExists(FilePath) then
    OpenDocument(FilePath)
  else
  begin
    ShowMessage('File ini sepertinya telah dihapus atau dipindahkan dari tempat asalnya.');
    FRecentFiles.Delete(FRecentFiles.IndexOf(FilePath));
    UpdateRecentFilesMenu;
  end;
end;


// ==========================================
// PANGGILAN MENU ABOUT
// ==========================================
procedure TfrmMain.mnuAboutClick(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(Self);
  try
    frmAbout.ShowModal;
  finally
    frmAbout.Free;
  end;
end;

// ==========================================
// LOGIKA SPLIT VIEW (Layar Belah)
// ==========================================

procedure TfrmMain.mnuToggleSplitViewClick(Sender: TObject);
begin
  if PageControl2.Visible then
  begin
    while PageControl2.PageCount > 0 do
      PageControl2.Pages[0].PageControl := PageControl1;

    PageControl2.Visible := False;
    Splitter4.Visible := False;
    FActivePageControl := PageControl1;
  end
  else
  begin
    PageControl2.Visible := True;
    Splitter4.Visible := True;
    FActivePageControl := PageControl2;
    if PageControl2.PageCount = 0 then CreateNewTab;
  end;
  PageControlChange(FActivePageControl);
end;

procedure TfrmMain.mnuMoveTabOtherPaneClick(Sender: TObject);
var
  TargetPC: TPageControl;
  Tab: TTabSheet;
begin
  if FActivePageControl = PageControl1 then TargetPC := PageControl2
  else TargetPC := PageControl1;

  Tab := FActivePageControl.ActivePage;

  if not TargetPC.Visible then mnuToggleSplitViewClick(nil);

  if Assigned(Tab) then
  begin
    Tab.PageControl := TargetPC;
    FActivePageControl := TargetPC;
    TargetPC.ActivePage := Tab;
    PageControlChange(TargetPC);
  end;
end;

procedure TfrmMain.SynEditEnter(Sender: TObject);
begin
  if (Sender is TSynEdit) and Assigned(TSynEdit(Sender).Parent) then
  begin
    if TSynEdit(Sender).Parent.Parent is TPageControl then
    begin
      if FActivePageControl <> TPageControl(TSynEdit(Sender).Parent.Parent) then
      begin
        FActivePageControl := TPageControl(TSynEdit(Sender).Parent.Parent);
        PageControlChange(FActivePageControl);
      end;
    end;
  end;
end;

// ==========================================
// LOGIKA FIND IN FILES (Pencarian Global)
// ==========================================

function TfrmMain.IsTextFile(const AFileName: string): Boolean;
var
  Ext: string;
begin
  Ext := LowerCase(ExtractFileExt(AFileName));
  Result := (Ext = '.pas') or (Ext = '.pp') or (Ext = '.inc') or
            (Ext = '.lpr') or (Ext = '.dpr') or (Ext = '.lfm') or
            (Ext = '.lpi') or (Ext = '.txt') or (Ext = '.html') or
            (Ext = '.xml') or (Ext = '.js')  or (Ext = '.css') or
            (Ext = '.py')  or (Ext = '.sql') or (Ext = '.json') or
            (Ext = '.md')  or (Ext = '.ini');
end;

procedure TfrmMain.SearchInFolder(const Dir, Keyword: string);
var
  SR: TSearchRec;
  FList: TStringList;
  i: Integer;
  FilePath, LineText: string;
begin
  if FindFirst(IncludeTrailingPathDelimiter(Dir) + '*.*', faAnyFile, SR) = 0 then
  begin
    try
      repeat
        if (SR.Name = '.') or (SR.Name = '..') then Continue;

        FilePath := IncludeTrailingPathDelimiter(Dir) + SR.Name;

        if (SR.Attr and faDirectory) <> 0 then
        begin
          SearchInFolder(FilePath, Keyword);
        end
        else
        begin
          if IsTextFile(FilePath) then
          begin
            pnlResultsHeader.Caption := '  Mencari di: ' + ExtractFileName(FilePath) + '...';
            Application.ProcessMessages;

            FList := TStringList.Create;
            try
              try
                FList.LoadFromFile(FilePath);
                for i := 0 to FList.Count - 1 do
                begin
                  if Pos(LowerCase(Keyword), LowerCase(FList[i])) > 0 then
                  begin
                    LineText := Trim(FList[i]);
                    lbSearchResults.Items.Add(FilePath + '(' + IntToStr(i + 1) + '): ' + LineText);
                  end;
                end;
              except
              end;
            finally
              FList.Free;
            end;
          end;
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
  end;
end;

procedure TfrmMain.mnuFindInFilesClick(Sender: TObject);
var
  Keyword: string;
begin
  if FExplorerRoot = '' then
  begin
    ShowMessage('Silakan buka sebuah folder proyek melalui menu "File -> Open Folder" terlebih dahulu.');
    Exit;
  end;

  Keyword := InputBox('Find in Files', 'Masukkan kata kunci yang dicari pada folder proyek:', '');
  if Trim(Keyword) = '' then Exit;

  pnlBottomResults.Visible := True;
  Splitter3.Visible := True;
  lbSearchResults.Clear;

  pnlResultsHeader.Caption := '  Mencari...';
  Application.ProcessMessages;

  SearchInFolder(FExplorerRoot, Keyword);

  pnlResultsHeader.Caption := '  Pencarian selesai. Ditemukan ' + IntToStr(lbSearchResults.Count) + ' baris di seluruh proyek.';
end;

procedure TfrmMain.btnCloseResultsClick(Sender: TObject);
begin
  pnlBottomResults.Visible := False;
  Splitter3.Visible := False;
end;

procedure TfrmMain.lbSearchResultsDblClick(Sender: TObject);
var
  SelStr, FilePath, LineStr: string;
  p1, p2: Integer;
  LineNum: Integer;
  Editor: TSynEdit;
begin
  if lbSearchResults.ItemIndex < 0 then Exit;
  SelStr := lbSearchResults.Items[lbSearchResults.ItemIndex];

  p1 := Pos('(', SelStr);
  p2 := Pos('):', SelStr);
  if (p1 > 0) and (p2 > p1) then
  begin
    FilePath := Copy(SelStr, 1, p1 - 1);
    LineStr := Copy(SelStr, p1 + 1, p2 - p1 - 1);
    LineNum := StrToIntDef(LineStr, 1);

    if FileExists(FilePath) then
    begin
      OpenDocument(FilePath);
      Editor := GetActiveEditor;
      if Assigned(Editor) then
      begin
        Editor.CaretY := LineNum;
        Editor.TopLine := LineNum - (Editor.LinesInWindow div 2);
        Editor.SetFocus;
      end;
    end;
  end;
end;

// ==========================================
// LOGIKA SENTRALISASI PEMBUKAAN FILE & HEX
// ==========================================

function TfrmMain.FindTabByFileName(const AFileName: string): TTabSheet;
var
  i: Integer;
  Editor: TSynEdit;
begin
  Result := nil;
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl1.Pages[i]);
    if Assigned(Editor) and SameText(FSessionManager.GetFileName(Editor), AFileName) then
      Exit(PageControl1.Pages[i]);
  end;
  for i := 0 to PageControl2.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl2.Pages[i]);
    if Assigned(Editor) and SameText(FSessionManager.GetFileName(Editor), AFileName) then
      Exit(PageControl2.Pages[i]);
  end;
end;

procedure TfrmMain.OpenDocument(const AFileName: string);
var
  Editor: TSynEdit;
  TargetTab: TTabSheet;
  Ext: string;
begin
  if not FileExists(AFileName) then Exit;

  TargetTab := FindTabByFileName(AFileName);
  if Assigned(TargetTab) then
  begin
    TargetTab.PageControl.ActivePage := TargetTab;
    FActivePageControl := TargetTab.PageControl;
    PageControlChange(FActivePageControl);
    Exit;
  end;

  Editor := GetActiveEditor;
  if not Assigned(Editor) then
    Editor := CreateNewTab
  else if (FSessionManager.GetFileName(Editor) <> '') or (Editor.Modified) then
    Editor := CreateNewTab;

  Ext := LowerCase(ExtractFileExt(AFileName));
  if (Ext = '.exe') or (Ext = '.dll') or (Ext = '.sys') or (Ext = '.bin') then
  begin
    FSessionManager.SetFileName(Editor, AFileName);
    LoadHexView(Editor, AFileName);
  end
  else
  begin
    FSessionManager.OpenFile(Editor, AFileName);
    Editor.ReadOnly := False;
  end;

  AddToRecentFiles(AFileName);

  UpdateTabCaption(Editor);
  DetectAndApplyHighlighter(Editor, AFileName);
  CalculateStats;
end;

procedure TfrmMain.LoadHexView(ASynEdit: TSynEdit; const AFileName: string);
var
  FS: TFileStream;
  Buffer: array[0..15] of Byte;
  BytesRead, i: Integer;
  Offset: Int64;
  HexPart, AsciiPart, LineStr: string;
  LinesList: TStringList;
begin
  ASynEdit.Lines.Clear;
  ASynEdit.ReadOnly := True;
  LinesList := TStringList.Create;
  try
    FS := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
    try
      Offset := 0;
      while (Offset < FS.Size) and (Offset < 256 * 1024) do
      begin
        BytesRead := FS.Read(Buffer, SizeOf(Buffer));
        if BytesRead = 0 then Break;

        HexPart := ''; AsciiPart := '';

        for i := 0 to 15 do
        begin
          if i < BytesRead then
          begin
            HexPart := HexPart + IntToHex(Buffer[i], 2) + ' ';
            if (Buffer[i] >= 32) and (Buffer[i] <= 126) then
              AsciiPart := AsciiPart + Chr(Buffer[i])
            else AsciiPart := AsciiPart + '.';
          end else HexPart := HexPart + '   ';

          if i = 7 then HexPart := HexPart + ' ';
        end;

        LineStr := IntToHex(Offset, 8) + '  ' + HexPart + ' |' + AsciiPart + '|';
        LinesList.Add(LineStr);
        Inc(Offset, BytesRead);
      end;

      if FS.Size > (256 * 1024) then
        LinesList.Add('... [Preview dibatasi pada 256KB pertama untuk menjaga performa] ...');

    finally
      FS.Free;
    end;
    ASynEdit.Lines.Text := LinesList.Text;
  finally
    LinesList.Free;
  end;
  ASynEdit.Modified := False;
end;

// ==========================================
// Logika Context / Popup Menu Editor
// ==========================================

procedure TfrmMain.popCutClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.CutToClipboard;
end;

procedure TfrmMain.popCopyClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.CopyToClipboard;
end;

procedure TfrmMain.popPasteClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.PasteFromClipboard;
end;

procedure TfrmMain.popDeleteClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.ClearSelection;
end;

procedure TfrmMain.popSelectAllClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.SelectAll;
end;

// ==========================================
// Logika Context Menu (File Explorer)
// ==========================================

procedure TfrmMain.popExpOpenClick(Sender: TObject);
begin
  tvExplorerDblClick(nil);
end;

procedure TfrmMain.popExpNewFileClick(Sender: TObject);
var
  Node, TargetNode: TTreeNode;
  BasePath, NewName, FullPath: string;
  F: TextFile;
begin
  Node := tvExplorer.Selected;
  if not Assigned(Node) then Exit;

  BasePath := GetNodePath(Node);
  if not DirectoryExists(BasePath) then
  begin
    BasePath := ExtractFilePath(BasePath);
    TargetNode := Node.Parent;
  end
  else
    TargetNode := Node;

  NewName := InputBox('File Baru', 'Masukkan nama file:', 'untitled.txt');
  if Trim(NewName) <> '' then
  begin
    FullPath := IncludeTrailingPathDelimiter(BasePath) + NewName;
    if not FileExists(FullPath) then
    begin
      AssignFile(F, FullPath);
      Rewrite(F);
      CloseFile(F);

      if Assigned(TargetNode) then
      begin
        TargetNode.HasChildren := True;
        TargetNode.Expand(False);
        PopulateTreeNode(TargetNode, BasePath);
      end;
    end
    else
      ShowMessage('File dengan nama tersebut sudah ada!');
  end;
end;

procedure TfrmMain.popExpNewFolderClick(Sender: TObject);
var
  Node, TargetNode: TTreeNode;
  BasePath, NewName, FullPath: string;
begin
  Node := tvExplorer.Selected;
  if not Assigned(Node) then Exit;

  BasePath := GetNodePath(Node);
  if not DirectoryExists(BasePath) then
  begin
    BasePath := ExtractFilePath(BasePath);
    TargetNode := Node.Parent;
  end
  else
    TargetNode := Node;

  NewName := InputBox('Folder Baru', 'Masukkan nama folder:', 'Folder Baru');
  if Trim(NewName) <> '' then
  begin
    FullPath := IncludeTrailingPathDelimiter(BasePath) + NewName;
    if not DirectoryExists(FullPath) then
    begin
      CreateDir(FullPath);
      if Assigned(TargetNode) then
      begin
        TargetNode.HasChildren := True;
        TargetNode.Expand(False);
        PopulateTreeNode(TargetNode, BasePath);
      end;
    end
    else
      ShowMessage('Folder dengan nama tersebut sudah ada!');
  end;
end;

procedure TfrmMain.popExpRenameClick(Sender: TObject);
var
  Node: TTreeNode;
  OldPath, NewName, NewPath: string;
begin
  Node := tvExplorer.Selected;
  if not Assigned(Node) then Exit;

  OldPath := GetNodePath(Node);
  if Node.Parent = nil then Exit;

  NewName := InputBox('Ubah Nama', 'Masukkan nama baru:', ExtractFileName(OldPath));
  if (Trim(NewName) <> '') and (NewName <> ExtractFileName(OldPath)) then
  begin
    NewPath := IncludeTrailingPathDelimiter(ExtractFilePath(OldPath)) + NewName;
    if RenameFile(OldPath, NewPath) then
      Node.Text := NewName
    else
      ShowMessage('Gagal mengubah nama. File mungkin sedang digunakan.');
  end;
end;

procedure TfrmMain.popExpDeleteClick(Sender: TObject);
var
  Node: TTreeNode;
  Path: string;
begin
  Node := tvExplorer.Selected;
  if not Assigned(Node) then Exit;
  if Node.Parent = nil then Exit;

  Path := GetNodePath(Node);
  if MessageDlg('Hapus', 'Anda yakin ingin menghapus permanen "' + ExtractFileName(Path) + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if DirectoryExists(Path) then
    begin
      if not RemoveDir(Path) then
        ShowMessage('Folder tidak dapat dihapus (pastikan folder tersebut kosong dan tidak sedang dibuka).');
    end
    else
    begin
      if not DeleteFile(Path) then
        ShowMessage('Gagal menghapus file. Mungkin file sedang digunakan.');
    end;

    if not FileExists(Path) and not DirectoryExists(Path) then
      Node.Delete;
  end;
end;

procedure TfrmMain.popExpRefreshClick(Sender: TObject);
var
  Node, TargetNode: TTreeNode;
  Path: string;
begin
  Node := tvExplorer.Selected;
  if not Assigned(Node) then Exit;

  Path := GetNodePath(Node);
  if not DirectoryExists(Path) then
  begin
    TargetNode := Node.Parent;
    if Assigned(TargetNode) then Path := GetNodePath(TargetNode);
  end
  else
    TargetNode := Node;

  if Assigned(TargetNode) and DirectoryExists(Path) then
  begin
    tvExplorer.Items.BeginUpdate;
    try
      PopulateTreeNode(TargetNode, Path);
    finally
      tvExplorer.Items.EndUpdate;
    end;
  end;
end;

// ==========================================
// Logika Pencarian / Filter Explorer
// ==========================================

procedure TfrmMain.edtSearchExplorerChange(Sender: TObject);
var
  SearchStr: string;
  Node: TTreeNode;
begin
  SearchStr := LowerCase(edtSearchExplorer.Text);
  if SearchStr = '' then Exit;

  tvExplorer.Items.BeginUpdate;
  try
    Node := tvExplorer.Items.GetFirstNode;
    while Assigned(Node) do
    begin
      if Pos(SearchStr, LowerCase(Node.Text)) > 0 then
      begin
        tvExplorer.Selected := Node;
        Node.MakeVisible;
        Break;
      end;
      Node := Node.GetNext;
    end;
  finally
    tvExplorer.Items.EndUpdate;
  end;
end;

procedure TfrmMain.edtSearchExplorerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  SearchStr: string;
  Node, StartNode: TTreeNode;
begin
  if Key = 13 then
  begin
    SearchStr := LowerCase(edtSearchExplorer.Text);
    if SearchStr = '' then Exit;

    StartNode := tvExplorer.Selected;
    if Assigned(StartNode) then
      Node := StartNode.GetNext
    else
      Node := tvExplorer.Items.GetFirstNode;

    while Assigned(Node) do
    begin
      if Pos(SearchStr, LowerCase(Node.Text)) > 0 then
      begin
        tvExplorer.Selected := Node;
        Node.MakeVisible;
        Key := 0;
        Exit;
      end;
      Node := Node.GetNext;
    end;

    Node := tvExplorer.Items.GetFirstNode;
    while Assigned(Node) and (Node <> StartNode) do
    begin
      if Pos(SearchStr, LowerCase(Node.Text)) > 0 then
      begin
        tvExplorer.Selected := Node;
        Node.MakeVisible;
        Key := 0;
        Exit;
      end;
      Node := Node.GetNext;
    end;

    Key := 0;
  end;
end;

// ==========================================
// Logika Code Minimap
// ==========================================

procedure TfrmMain.SyncMinimap;
var
  Editor: TSynEdit;
begin
  if not pnlMinimap.Visible then Exit;

  Editor := GetActiveEditor;
  if not Assigned(Editor) then
  begin
    synMinimap.Lines.Clear;
    Exit;
  end;

  synMinimap.Lines.Text := Editor.Lines.Text;
  synMinimap.Highlighter := Editor.Highlighter;

  TVisualTheme.ApplySynEditTheme(synMinimap, Config.Theme);
  synMinimap.Gutter.Visible := False;
  synMinimap.Color := Editor.Color;
end;

procedure TfrmMain.MinimapSpecialLineColors(Sender: TObject; Line: integer; var Special: boolean; var FG, BG: TColor);
var
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    if (Line >= Editor.TopLine) and (Line < Editor.TopLine + Editor.LinesInWindow) then
    begin
      Special := True;
      if Config.Theme = tmDark then
        BG := $004A4A4A
      else
        BG := $00D0D0D0;
    end;
  end;
end;

procedure TfrmMain.MinimapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Editor: TSynEdit;
  ClickLine: Integer;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  ClickLine := synMinimap.PixelsToRowColumn(Point(X, Y)).Y;

  Editor.TopLine := ClickLine - (Editor.LinesInWindow div 2);
  Editor.CaretY := ClickLine;
  Editor.SetFocus;
end;

procedure TfrmMain.mnuToggleMinimapClick(Sender: TObject);
begin
  pnlMinimap.Visible := not pnlMinimap.Visible;
  Splitter2.Visible := pnlMinimap.Visible;
  if pnlMinimap.Visible then SyncMinimap;
end;

// ==========================================
// Pelukis Ikon Dinamis (Zero-Bloat)
// ==========================================

procedure TfrmMain.InitExplorerIcons;
var
  Bmp: TBitmap;
begin
  FImageList := TImageList.Create(Self);
  FImageList.Width := 16;
  FImageList.Height := 16;

  Bmp := TBitmap.Create;
  try
    Bmp.SetSize(16, 16);
    Bmp.Transparent := True;
    Bmp.TransparentColor := clFuchsia;

    Bmp.Canvas.Brush.Color := clFuchsia;
    Bmp.Canvas.FillRect(0, 0, 16, 16);
    Bmp.Canvas.Brush.Color := $0067C0E4;
    Bmp.Canvas.Pen.Color := $00428B9E;
    Bmp.Canvas.Polygon([Point(1, 2), Point(6, 2), Point(8, 4), Point(15, 4), Point(15, 14), Point(1, 14)]);
    Bmp.Canvas.MoveTo(1, 5); Bmp.Canvas.LineTo(15, 5);
    FImageList.AddMasked(Bmp, clFuchsia);

    Bmp.Canvas.Brush.Color := clFuchsia;
    Bmp.Canvas.FillRect(0, 0, 16, 16);
    Bmp.Canvas.Brush.Color := $00FAFAFA;
    Bmp.Canvas.Pen.Color := $00909090;
    Bmp.Canvas.Polygon([Point(3, 1), Point(9, 1), Point(13, 5), Point(13, 15), Point(3, 15)]);
    Bmp.Canvas.Brush.Color := $00E0E0E0;
    Bmp.Canvas.Polygon([Point(9, 1), Point(9, 5), Point(13, 5)]);
    Bmp.Canvas.Pen.Color := $00D47A00;
    Bmp.Canvas.MoveTo(5, 7); Bmp.Canvas.LineTo(11, 7);
    Bmp.Canvas.MoveTo(5, 9); Bmp.Canvas.LineTo(9, 9);
    Bmp.Canvas.MoveTo(5, 11); Bmp.Canvas.LineTo(11, 11);
    Bmp.Canvas.MoveTo(5, 13); Bmp.Canvas.LineTo(8, 13);
    FImageList.AddMasked(Bmp, clFuchsia);

  finally
    Bmp.Free;
  end;

  tvExplorer.Images := FImageList;
end;

// ==========================================
// Logika Multi-Tab Dinamis & Autocomplete Super Cerdas
// ==========================================

procedure TfrmMain.SynCompletionExecute(Sender: TObject);
var
  Comp: TSynCompletion;
  Editor: TSynEdit;
  S, WordStr: string;
  i, Len: Integer;
  TempList: TStringList;
  DictPath, Ext: string;
begin
  if not (Sender is TSynCompletion) then Exit;
  Comp := TSynCompletion(Sender);
  Editor := TSynEdit(Comp.Editor);
  if not Assigned(Editor) then Exit;

  // Gunakan TempList yang bersifat Sorted & dupIgnore agar Instan
  // memfilter ribuan kata duplikat dalam dokumen!
  TempList := TStringList.Create;
  try
    TempList.Sorted := True;
    TempList.Duplicates := dupIgnore;

    // ----------------------------------------------------
    // IDE 1: Muat Kamus Eksternal
    // ----------------------------------------------------
    Ext := LowerCase(ExtractFileExt(FSessionManager.GetFileName(Editor)));
    if Ext <> '' then Delete(Ext, 1, 1); // Hapus awalan titik (.py -> py)
    if Ext = '' then Ext := 'txt';

    DictPath := ExtractFilePath(Application.ExeName) + 'autocomplete' + DirectorySeparator + Ext + '.txt';
    if FileExists(DictPath) then
      TempList.LoadFromFile(DictPath)
    else
    begin
      // Fallback Default jika file txt tidak ditemukan
      if Editor.Highlighter = FSynPas then
        TempList.CommaText := 'begin,class,const,constructor,destructor,do,else,end,for,function,if,implementation,interface,procedure,repeat,string,then,try,type,until,uses,var,while'
      else if Editor.Highlighter = FSynPython then
        TempList.CommaText := 'def,class,import,from,if,elif,else,for,in,while,return,print,try,except'
      else if Editor.Highlighter = FSynJS then
        TempList.CommaText := 'function,const,let,var,if,else,for,while,return,document,console'
      else if Editor.Highlighter = FSynPHP then
        TempList.CommaText := 'echo,print,if,else,elseif,for,foreach,while,do,switch,case,break,continue,function,return,class,public,private,protected,static,new,require,include,try,catch,throw'
      else if Editor.Highlighter = FCppSyn then
        TempList.CommaText := 'auto,break,case,char,class,const,continue,default,do,double,else,enum,extern,float,for,goto,if,int,long,return,short,signed,sizeof,static,struct,switch,typedef,union,unsigned,void,volatile,while'
      else if Editor.Highlighter = FSynCSharp then
        TempList.CommaText := 'abstract,as,base,bool,break,byte,case,catch,char,checked,class,const,continue,decimal,default,delegate,do,double,else,enum,event,explicit,extern,false,finally,fixed,float,for,foreach,goto,if,implicit,in,int,interface,internal,is,lock,long,namespace,new,null,object,operator,out,override,params,private,protected,public,readonly,ref,return,sbyte,sealed,short,sizeof,stackalloc,static,string,struct,switch,this,throw,true,try,typeof,uint,ulong,unchecked,unsafe,ushort,using,virtual,void,volatile,while'
      else if Editor.Highlighter = FSynRust then
        TempList.CommaText := 'as,break,const,continue,crate,else,enum,extern,false,fn,for,if,impl,in,let,loop,match,mod,move,mut,pub,ref,return,self,Self,static,struct,super,trait,true,type,unsafe,use,where,while'
      else if Editor.Highlighter = FSynDart then
        TempList.CommaText := 'class,extends,implements,Widget,build,return,final,void,async,await'
      else if Editor.Highlighter = FSynGo then
        TempList.CommaText := 'break,default,func,interface,select,case,defer,go,map,struct,chan,else,goto,package,switch,const,fallthrough,if,range,type,continue,for,import,return,var';
    end;

    // ----------------------------------------------------
    // IDE 2: Parser Variabel di Layar Secara Real-Time
    // ----------------------------------------------------
    S := Editor.Text;
    Len := Length(S);
    WordStr := '';
    for i := 1 to Len do
    begin
      // Jika karakter adalah huruf, angka, atau underscore
      if S[i] in ['a'..'z', 'A'..'Z', '0'..'9', '_'] then
        WordStr := WordStr + S[i]
      else
      begin
        // Masukkan kata jika panjangnya >= 3 karakter
        if Length(WordStr) >= 3 then TempList.Add(WordStr);
        WordStr := '';
      end;
    end;
    if Length(WordStr) >= 3 then TempList.Add(WordStr); // Tangkap sisa kata terakhir

    // Terapkan gabungan sempurna ini ke layar!
    Comp.ItemList.BeginUpdate;
    try
      Comp.ItemList.Assign(TempList);
    finally
      Comp.ItemList.EndUpdate;
    end;
  finally
    TempList.Free;
  end;
end;

function TfrmMain.GetEditorFromTab(ATab: TTabSheet): TSynEdit;
var
  i: Integer;
begin
  Result := nil;
  if not Assigned(ATab) then Exit;

  for i := 0 to ATab.ControlCount - 1 do
  begin
    if ATab.Controls[i] is TSynEdit then
    begin
      Result := TSynEdit(ATab.Controls[i]);
      Exit;
    end;
  end;
end;

function TfrmMain.GetActiveEditor: TSynEdit;
begin
  Result := nil;
  if Assigned(FActivePageControl) and (FActivePageControl.ActivePageIndex >= 0) and (FActivePageControl.ActivePageIndex < FActivePageControl.PageCount) then
  begin
    Result := GetEditorFromTab(FActivePageControl.Pages[FActivePageControl.ActivePageIndex]);
  end;
end;

// ==========================================
// LOGIKA ZOOM IN / ZOOM OUT DENGAN MOUSE WHEEL
// ==========================================

procedure TfrmMain.SynEditMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  NewSize: Integer;
  i: Integer;
  Editor: TSynEdit;
begin
  if ssCtrl in Shift then
  begin
    NewSize := Config.FontSize;

    if WheelDelta > 0 then
      Inc(NewSize)
    else if WheelDelta < 0 then
      Dec(NewSize);

    if NewSize < 6 then NewSize := 6;
    if NewSize > 72 then NewSize := 72;

    if NewSize <> Config.FontSize then
    begin
      Config.FontSize := NewSize;

      for i := 0 to PageControl1.PageCount - 1 do
      begin
        Editor := GetEditorFromTab(PageControl1.Pages[i]);
        if Assigned(Editor) then Editor.Font.Size := NewSize;
      end;

      for i := 0 to PageControl2.PageCount - 1 do
      begin
        Editor := GetEditorFromTab(PageControl2.Pages[i]);
        if Assigned(Editor) then Editor.Font.Size := NewSize;
      end;
    end;

    Handled := True;
  end;
end;

procedure TfrmMain.DetectAndApplyHighlighter(ASynEdit: TSynEdit; const AFileName: string);
var
  Ext: string;
begin
  if not Assigned(ASynEdit) then Exit;
  Ext := LowerCase(ExtractFileExt(AFileName));

  if (Ext = '.pas') or (Ext = '.pp') or (Ext = '.inc') or (Ext = '.lpr') or (Ext = '.dpr') then
    ASynEdit.Highlighter := FSynPas
  else if (Ext = '.html') or (Ext = '.htm') then
    ASynEdit.Highlighter := FSynHTML
  else if (Ext = '.xml') or (Ext = '.lfm') or (Ext = '.lpi') or (Ext = '.svg') then
    ASynEdit.Highlighter := FSynXML
  else if (Ext = '.js') or (Ext = '.json') then
    ASynEdit.Highlighter := FSynJS
  else if (Ext = '.css') then
    ASynEdit.Highlighter := FSynCSS
  else if (Ext = '.py') then
    ASynEdit.Highlighter := FSynPython
  else if (Ext = '.sql') then
    ASynEdit.Highlighter := FSynSQL
  else if (Ext = '.php') or (Ext = '.phtml') then
    ASynEdit.Highlighter := FSynPHP
  else if (Ext = '.dart') then
    ASynEdit.Highlighter := FSynDart
  else if (Ext = '.cpp') or (Ext = '.c') or (Ext = '.h') or (Ext = '.hpp') or (Ext = '.cxx') then
    ASynEdit.Highlighter := FCppSyn
  else if (Ext = '.cs') then
    ASynEdit.Highlighter := FSynCSharp
  else if (Ext = '.rs') then
    ASynEdit.Highlighter := FSynRust
  else if (Ext = '.go') then
    ASynEdit.Highlighter := FSynGo
  else
    ASynEdit.Highlighter := nil;


  SyncHighlighterMenu(ASynEdit);
end;

procedure TfrmMain.SyncHighlighterMenu(ASynEdit: TSynEdit);
begin
  if not Assigned(ASynEdit) then Exit;

  if ASynEdit.Highlighter = FSynPas then mnuSynPas.Checked := True
  else if ASynEdit.Highlighter = FSynHTML then mnuSynHTML.Checked := True
  else if ASynEdit.Highlighter = FSynXML then mnuSynXML.Checked := True
  else if ASynEdit.Highlighter = FSynJS then mnuSynJS.Checked := True
  else if ASynEdit.Highlighter = FSynCSS then mnuSynCSS.Checked := True
  else if ASynEdit.Highlighter = FSynPython then mnuSynPython.Checked := True
  else if ASynEdit.Highlighter = FSynSQL then mnuSynSQL.Checked := True
  else if ASynEdit.Highlighter = FSynPHP then mnuSynPHP.Checked := True
  else if ASynEdit.Highlighter = FCppSyn then mnuSynCpp.Checked := True
  else if ASynEdit.Highlighter = FSynCSharp then mnuSynCS.Checked := True
  else if ASynEdit.Highlighter = FSynRust then mnuSynRust.Checked := True
  else if ASynEdit.Highlighter = FSynGo then mnuSynGo.Checked := True
  else mnuSynNone.Checked := True;
end;

procedure TfrmMain.mnuSyntaxChangeClick(Sender: TObject);
var
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  if Sender = mnuSynPas then Editor.Highlighter := FSynPas
  else if Sender = mnuSynHTML then Editor.Highlighter := FSynHTML
  else if Sender = mnuSynXML then Editor.Highlighter := FSynXML
  else if Sender = mnuSynJS then Editor.Highlighter := FSynJS
  else if Sender = mnuSynCSS then Editor.Highlighter := FSynCSS
  else if Sender = mnuSynPython then Editor.Highlighter := FSynPython
  else if Sender = mnuSynPHP then Editor.Highlighter := FSynPHP
  else if Sender = mnuSynSQL then Editor.Highlighter := FSynSQL
  else if Sender = mnuSynCpp then Editor.Highlighter := FCppSyn
  else if Sender = mnuSynCS then Editor.Highlighter := FSynCSharp
  else if Sender = mnuSynRust then Editor.Highlighter := FSynRust
  else if Sender = mnuSynGo then Editor.Highlighter := FSynGo
  else Editor.Highlighter := nil;

  if Sender is TMenuItem then
    TMenuItem(Sender).Checked := True;

  if pnlMinimap.Visible then SyncMinimap;
end;

procedure TfrmMain.mnuFontQualityClick(Sender: TObject);
var
  i: Integer;
  Editor: TSynEdit;
begin
  if Sender = mnuFQClearType then FFontQuality := fqClearType
  else if Sender = mnuFQAntialiased then FFontQuality := fqAntialiased
  else FFontQuality := fqDefault;

  if Sender is TMenuItem then
    TMenuItem(Sender).Checked := True;

  for i := 0 to PageControl1.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl1.Pages[i]);
    if Assigned(Editor) then Editor.Font.Quality := FFontQuality;
  end;

  for i := 0 to PageControl2.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl2.Pages[i]);
    if Assigned(Editor) then Editor.Font.Quality := FFontQuality;
  end;

  if Assigned(synMinimap) then
    synMinimap.Font.Quality := FFontQuality;
end;

function TfrmMain.CreateNewTab(const AFileName: string): TSynEdit;
var
  NewTab: TTabSheet;
  NewEditor: TSynEdit;
  NewComp: TSynCompletion;
begin
  NewTab := TTabSheet.Create(FActivePageControl);
  NewTab.PageControl := FActivePageControl;

  NewEditor := TSynEdit.Create(NewTab);
  NewEditor.Parent := NewTab;
  NewEditor.Align := alClient;

  NewEditor.PopupMenu := popEditor;

  NewEditor.Options := [eoAutoIndent, eoGroupUndo, eoScrollPastEol, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces];
  NewEditor.Gutter.Width := 57;
  NewEditor.RightEdge := 0;

  NewEditor.OnChange := @SynEditChange;
  NewEditor.OnKeyDown := @SynEditKeyDown;
  NewEditor.OnStatusChange := @SynEditStatusChange;
  NewEditor.OnSpecialLineColors := @SynEditSpecialLineColors;
  NewEditor.OnEnter := @SynEditEnter;
  NewEditor.OnMouseWheel := @SynEditMouseWheel;

  FSessionManager.AddSession(NewEditor, AFileName);

  NewEditor.Font.Name := Config.FontName;
  NewEditor.Font.Size := Config.FontSize;
  NewEditor.Font.Quality := FFontQuality;
  NewEditor.TabWidth := Config.TabWidth;
  if Config.LineEnding = leCRLF then NewEditor.Lines.LineBreak := #13#10 else NewEditor.Lines.LineBreak := #10;
  TVisualTheme.ApplySynEditTheme(NewEditor, Config.Theme);

  // PENYISIPAN KECERDASAN AUTOCOMPLETE DI SINI!
  NewComp := TSynCompletion.Create(NewTab);
  NewComp.Editor := NewEditor;
  NewComp.ShortCut := Menus.ShortCut(VK_SPACE, [ssCtrl]);
  NewComp.OnExecute := @SynCompletionExecute;

  DetectAndApplyHighlighter(NewEditor, AFileName);

  FActivePageControl.ActivePage := NewTab;
  Result := NewEditor;
  UpdateTabCaption(NewEditor);

  CalculateStats;
  if Assigned(lblCaretPos) then lblCaretPos.Caption := 'Line: 1  |  Col: 1 ';
end;

procedure TfrmMain.CloseTab(ATabIndex: Integer);
var
  TargetTab: TTabSheet;
  TargetEditor: TSynEdit;
begin
  if (ATabIndex >= 0) and (ATabIndex < FActivePageControl.PageCount) then
  begin
    TargetTab := FActivePageControl.Pages[ATabIndex];
    TargetEditor := GetEditorFromTab(TargetTab);

    if Assigned(TargetEditor) then
    begin
      if PromptSaveTab(TargetEditor) then
      begin
        FSessionManager.RemoveSession(TargetEditor);

        TargetEditor.OnChange := nil;
        TargetEditor.OnStatusChange := nil;
        TargetEditor.OnSpecialLineColors := nil;
        TargetEditor.OnKeyDown := nil;
        TargetEditor.OnEnter := nil;
        TargetEditor.OnMouseWheel := nil;

        TargetTab.Free;
      end;
    end
    else
      TargetTab.Free;
  end;

  if (not (csDestroying in ComponentState)) and (PageControl1.PageCount = 0) and (PageControl2.PageCount = 0) then
  begin
    FActivePageControl := PageControl1;
    CreateNewTab;
  end;
end;

procedure TfrmMain.LoadRecoveredSessions;
var
  RecoveredList: TStringList;
  i: Integer;
  NewEditor: TSynEdit;
begin
  RecoveredList := TStringList.Create;
  try
    FSessionManager.GetRecoverableFiles(RecoveredList);
    if RecoveredList.Count > 0 then
    begin
      for i := 0 to RecoveredList.Count - 1 do
      begin
        NewEditor := CreateNewTab;
        NewEditor.Lines.LoadFromFile(RecoveredList[i]);
        NewEditor.Modified := True;
        FSessionManager.SetFileName(NewEditor, '');
        UpdateTabCaption(NewEditor);
        DetectAndApplyHighlighter(NewEditor, RecoveredList[i]);
        CalculateStats;
      end;
      ShowMessage(Format('%d sesi sebelumnya berhasil dipulihkan.', [RecoveredList.Count]));
    end;
  finally
    RecoveredList.Free;
  end;
end;

procedure TfrmMain.ApplyConfig;
var
  i: Integer;
  Editor: TSynEdit;
begin
  TVisualTheme.ApplyTheme(Self, Config.Theme);

  TVisualTheme.ApplyHighlighterTheme(FSynPas, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynHTML, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynXML, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynJS, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynCSS, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynPython, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynSQL, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynPHP, Config.Theme); // Diterapkan pada Tema
  TVisualTheme.ApplyHighlighterTheme(FCppSyn, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynCSharp, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynRust, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynGo, Config.Theme);
  TVisualTheme.ApplyHighlighterTheme(FSynDart, Config.Theme);

  for i := 0 to PageControl1.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl1.Pages[i]);
    if Assigned(Editor) then
    begin
      Editor.Font.Name := Config.FontName;
      Editor.Font.Size := Config.FontSize;
      Editor.Font.Quality := FFontQuality;
      Editor.TabWidth := Config.TabWidth;
      if Config.LineEnding = leCRLF then Editor.Lines.LineBreak := #13#10 else Editor.Lines.LineBreak := #10;
      TVisualTheme.ApplySynEditTheme(Editor, Config.Theme);
      Editor.Invalidate;
    end;
  end;

  for i := 0 to PageControl2.PageCount - 1 do
  begin
    Editor := GetEditorFromTab(PageControl2.Pages[i]);
    if Assigned(Editor) then
    begin
      Editor.Font.Name := Config.FontName;
      Editor.Font.Size := Config.FontSize;
      Editor.Font.Quality := FFontQuality;
      Editor.TabWidth := Config.TabWidth;
      if Config.LineEnding = leCRLF then Editor.Lines.LineBreak := #13#10 else Editor.Lines.LineBreak := #10;
      TVisualTheme.ApplySynEditTheme(Editor, Config.Theme);
      Editor.Invalidate;
    end;
  end;

  if Assigned(synMinimap) then
  begin
    synMinimap.Font.Name := Config.FontName;
    synMinimap.Font.Quality := FFontQuality;
    TVisualTheme.ApplySynEditTheme(synMinimap, Config.Theme);
    synMinimap.Gutter.Visible := False;
  end;

  tvExplorer.Invalidate;
end;

procedure TfrmMain.UpdateTabCaption(ASynEdit: TSynEdit);
var
  DocName, ModFlag, FullFileName: string;
begin
  if not Assigned(ASynEdit) then Exit;
  if not Assigned(ASynEdit.Parent) then Exit;
  if not Assigned(FSessionManager) then Exit;

  FullFileName := FSessionManager.GetFileName(ASynEdit);
  if FullFileName = '' then
    DocName := 'Untitled'
  else
    DocName := ExtractFileName(FullFileName);

  if ASynEdit.Modified then ModFlag := ' *' else ModFlag := '';
  TTabSheet(ASynEdit.Parent).Caption := DocName + ModFlag;

  if (FActivePageControl <> nil) and (FActivePageControl.ActivePage = ASynEdit.Parent) then
    Self.Caption := DocName + ModFlag + ' - FhazEditor';
end;

function TfrmMain.PromptSaveTab(ASynEdit: TSynEdit): Boolean;
var
  Res: Integer;
  TabName: string;
begin
  Result := True;
  if Assigned(ASynEdit) and ASynEdit.Modified then
  begin
    TabName := TTabSheet(ASynEdit.Parent).Caption;
    Res := MessageDlg('FhazEditor', 'Simpan perubahan pada "' + TabName + '" ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    case Res of
      mrYes:
        begin
          mnuSaveClick(nil);
          Result := not ASynEdit.Modified;
        end;
      mrNo: Result := True;
      mrCancel: Result := False;
    end;
  end;
end;

// ==========================================
// Event Handler Dinamis untuk Editor
// ==========================================

procedure TfrmMain.SynEditChange(Sender: TObject);
begin
  if not (Sender is TSynEdit) then Exit;
  UpdateTabCaption(TSynEdit(Sender));
  FNeedsUIUpdate := True;
  FMinimapDirty := True;
end;

procedure TfrmMain.SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
var
  Editor: TSynEdit;
begin
  if not (Sender is TSynEdit) then Exit;
  Editor := TSynEdit(Sender);

  if Editor <> GetActiveEditor then Exit;

  if ([scCaretX, scCaretY, scTopLine] * Changes <> []) then
  begin
    if Assigned(lblCaretPos) then
      lblCaretPos.Caption := Format('Line: %d  |  Col: %d ', [Editor.CaretY, Editor.CaretX]);

    if FFocusMode then
      Editor.Invalidate;

    if pnlMinimap.Visible and Assigned(synMinimap) then
    begin
      if synMinimap.LinesInWindow > 0 then
        synMinimap.TopLine := (Editor.TopLine + (Editor.LinesInWindow div 2)) - (synMinimap.LinesInWindow div 2);

      synMinimap.Invalidate;
    end;
  end;
end;

procedure TfrmMain.SynEditSpecialLineColors(Sender: TObject; Line: integer; var Special: boolean; var FG, BG: TColor);
var
  Editor: TSynEdit;
begin
  if not FFocusMode then Exit;
  if not (Sender is TSynEdit) then Exit;

  Editor := TSynEdit(Sender);
  Special := True;
  if Line = Editor.CaretY then
    FG := Editor.Font.Color
  else
  begin
    if Config.Theme = tmDark then FG := $00444444 else FG := $00CCCCCC;
  end;
end;

procedure TfrmMain.SynEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  AI: TAIAssistant;
  SelectedText, ImprovedText: string;
  Editor: TSynEdit;
begin
  if not (Sender is TSynEdit) then Exit;
  Editor := TSynEdit(Sender);

  if (Key = 13) and (ssCtrl in Shift) then
  begin
    SelectedText := Editor.SelText;
    if SelectedText <> '' then
    begin
      Screen.Cursor := crHourGlass;
      AI := TAIAssistant.Create;
      try
        AI.Engine := Config.AIEngine;
        AI.EndpointURL := Config.AIEndpoint;
        AI.APIKey := Config.AIApiKey;

        ImprovedText := AI.ProcessText(SelectedText, 'Perbaiki tata bahasa teks berikut secara profesional tanpa mengubah makna:');

        if (ImprovedText <> '') and (Pos('Error:', ImprovedText) = 0) then
          Editor.SelText := Trim(ImprovedText)
        else if Pos('Error:', ImprovedText) > 0 then
          ShowMessage(ImprovedText);
      finally
        AI.Free;
        Screen.Cursor := crDefault;
      end;
      Key := 0;
    end;
  end;
end;

procedure TfrmMain.PageControlChange(Sender: TObject);
var
  Editor: TSynEdit;
begin
  if Sender is TPageControl then
    FActivePageControl := TPageControl(Sender);

  Editor := GetActiveEditor;
  UpdateTabCaption(Editor);
  CalculateStats;

  if Assigned(Editor) then
  begin
    if Assigned(lblCaretPos) then lblCaretPos.Caption := Format('Line: %d  |  Col: %d ', [Editor.CaretY, Editor.CaretX]);
    SyncHighlighterMenu(Editor);
  end
  else
  begin
    if Assigned(lblCaretPos) then lblCaretPos.Caption := 'Line: 0  |  Col: 0 ';
  end;

  SyncMinimap;
end;

// ==========================================
// Menu Actions (Multi-Tab Aware)
// ==========================================

procedure TfrmMain.mnuNewClick(Sender: TObject);
begin
  CreateNewTab;
end;

procedure TfrmMain.mnuOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    OpenDocument(dlgOpen.FileName);
end;

procedure TfrmMain.mnuCloseTabClick(Sender: TObject);
begin
  CloseTab(FActivePageControl.ActivePageIndex);
end;

procedure TfrmMain.mnuSaveClick(Sender: TObject);
var
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  if FSessionManager.GetFileName(Editor) = '' then
    mnuSaveAsClick(Sender)
  else
  begin
    FSessionManager.SaveFile(Editor, FSessionManager.GetFileName(Editor));
    AddToRecentFiles(FSessionManager.GetFileName(Editor));
    UpdateTabCaption(Editor);
  end;
end;

procedure TfrmMain.mnuSaveAsClick(Sender: TObject);
var
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  if dlgSave.Execute then
  begin
    FSessionManager.SaveFile(Editor, dlgSave.FileName);
    AddToRecentFiles(dlgSave.FileName);

    UpdateTabCaption(Editor);
    DetectAndApplyHighlighter(Editor, dlgSave.FileName);
  end;
end;

procedure TfrmMain.mnuOpenFolderClick(Sender: TObject);
begin
  if dlgSelectDirectory.Execute then
  begin
    pnlSidebar.Visible := True;
    Splitter1.Visible := True;
    OpenFolder(dlgSelectDirectory.FileName);
  end;
end;

procedure TfrmMain.mnuToggleSidebarClick(Sender: TObject);
begin
  pnlSidebar.Visible := not pnlSidebar.Visible;
  Splitter1.Visible := pnlSidebar.Visible;
end;

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mnuUndoClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.Undo;
end;

procedure TfrmMain.mnuRedoClick(Sender: TObject);
begin
  if Assigned(GetActiveEditor) then GetActiveEditor.Redo;
end;

procedure TfrmMain.mnuFindClick(Sender: TObject); begin dlgFind.Execute; end;
procedure TfrmMain.mnuReplaceClick(Sender: TObject); begin dlgReplace.Execute; end;

procedure TfrmMain.dlgFindFind(Sender: TObject);
var
  SearchOptions: TSynSearchOptions;
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  SearchOptions := [];
  if frMatchCase in dlgFind.Options then Include(SearchOptions, ssoMatchCase);
  if frWholeWord in dlgFind.Options then Include(SearchOptions, ssoWholeWord);
  if not (frDown in dlgFind.Options) then Include(SearchOptions, ssoBackwards);

  // Tangkap Checkbox "Search entire file"
  if frEntireScope in dlgFind.Options then Include(SearchOptions, ssoEntireScope);

  if Editor.SearchReplace(dlgFind.FindText, '', SearchOptions) = 0 then
    ShowMessage('Pencarian selesai. Teks tidak ditemukan lagi.');
end;

procedure TfrmMain.dlgReplaceReplace(Sender: TObject);
var
  SearchOptions: TSynSearchOptions;
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;

  SearchOptions := [ssoReplace];
  if frMatchCase in dlgReplace.Options then Include(SearchOptions, ssoMatchCase);
  if frWholeWord in dlgReplace.Options then Include(SearchOptions, ssoWholeWord);
  if not (frDown in dlgReplace.Options) then Include(SearchOptions, ssoBackwards);

  // Tangkap Checkbox "Search entire file"
  if frEntireScope in dlgReplace.Options then Include(SearchOptions, ssoEntireScope);

  // Jika tombol "Replace All" ditekan
  if frReplaceAll in dlgReplace.Options then
  begin
    Include(SearchOptions, ssoReplaceAll);

    // TRIK JITU: Pindahkan kursor secara paksa ke Baris 1, Kolom 1
    // agar SynEdit memindai dan mengganti dari awal dokumen tanpa terlewat!
    Editor.CaretXY := Point(1, 1);
  end;

  if Editor.SearchReplace(dlgReplace.FindText, dlgReplace.ReplaceText, SearchOptions) = 0 then
    ShowMessage('Selesai. Teks tidak ditemukan lagi atau sudah diganti semua.');
end;
procedure TfrmMain.mnuDistractionFreeClick(Sender: TObject);
begin
  FDistractionFree := not FDistractionFree;
  if FDistractionFree then
  begin
    Self.WindowState := wsFullScreen;
    pnlStatus.Visible := False;
    pnlSidebar.Visible := False;
    Splitter1.Visible := False;
    pnlMinimap.Visible := False;
    Splitter2.Visible := False;
    pnlBottomResults.Visible := False;
    Splitter3.Visible := False;
    MainMenu1.Items.Visible := False;
    PageControl1.ShowTabs := False;
    PageControl2.ShowTabs := False;
  end
  else
  begin
    Self.WindowState := wsNormal;
    pnlStatus.Visible := True;
    MainMenu1.Items.Visible := True;
    PageControl1.ShowTabs := True;
    PageControl2.ShowTabs := True;
  end;
end;

procedure TfrmMain.mnFocusModeClick(Sender: TObject);
begin
  FFocusMode := not FFocusMode;
  mnFocusMode.Checked := FFocusMode;
  if Assigned(GetActiveEditor) then GetActiveEditor.Invalidate;
end;

procedure TfrmMain.mnuPreferencesClick(Sender: TObject);
begin
  frmPreferences := TfrmPreferences.Create(Self);
  try
    if frmPreferences.ShowModal = mrOk then ApplyConfig;
  finally
    frmPreferences.Free;
  end;
end;

// ==========================================
// Stats & Timer Logic
// ==========================================

procedure TfrmMain.tmrUIUpdateTimer(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
  begin
    if FNeedsUIUpdate then
    begin
      CalculateStats;
      FNeedsUIUpdate := False;
    end;

    if FMinimapDirty then
    begin
      SyncMinimap;
      FMinimapDirty := False;
    end;
  end;
end;

procedure TfrmMain.CalculateStats;
var
  S: string;
  WordCount, CharCount, i: Integer;
  InWord: Boolean;
  Editor: TSynEdit;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then
  begin
    if Assigned(lblStats) then lblStats.Caption := ' Words: 0  |  Chars: 0';
    if Assigned(lblCaretPos) then lblCaretPos.Caption := 'Line: 0  |  Col: 0 ';
    Exit;
  end;

  if not Assigned(lblStats) then Exit;

  S := Editor.Text;
  CharCount := Length(S);
  WordCount := 0;
  InWord := False;
  for i := 1 to CharCount do
  begin
    if S[i] in [' ', #9, #10, #13] then InWord := False
    else if not InWord then
    begin
      Inc(WordCount);
      InWord := True;
    end;
  end;
  lblStats.Caption := Format(' Words: %d  |  Chars: %d', [WordCount, CharCount]);
end;

// ==========================================
// File Explorer Logic (Multi-Tab Aware)
// ==========================================

procedure TfrmMain.OpenFolder(const APath: string);
var
  RootNode: TTreeNode;
begin
  FExplorerRoot := APath;
  tvExplorer.Items.BeginUpdate;
  try
    tvExplorer.Items.Clear;
    RootNode := tvExplorer.Items.Add(nil, ExtractFileName(ExcludeTrailingPathDelimiter(APath)));
    RootNode.ImageIndex := 0;
    RootNode.SelectedIndex := 0;
    PopulateTreeNode(RootNode, APath);
    RootNode.Expand(False);
  finally
    tvExplorer.Items.EndUpdate;
  end;
end;

function TfrmMain.GetNodePath(Node: TTreeNode): string;
var
  CurrNode: TTreeNode;
  Path: string;
begin
  Path := '';
  CurrNode := Node;
  while Assigned(CurrNode) and Assigned(CurrNode.Parent) do
  begin
    Path := DirectorySeparator + CurrNode.Text + Path;
    CurrNode := CurrNode.Parent;
  end;
  Result := ExcludeTrailingPathDelimiter(FExplorerRoot) + Path;
end;

procedure TfrmMain.PopulateTreeNode(ParentNode: TTreeNode; const Path: string);
var
  SR: TSearchRec;
  NewNode: TTreeNode;
begin
  ParentNode.DeleteChildren;

  if FindFirst(IncludeTrailingPathDelimiter(Path) + '*.*', faDirectory, SR) = 0 then
  begin
    try
      repeat
        if (SR.Name <> '.') and (SR.Name <> '..') and ((SR.Attr and faDirectory) <> 0) then
        begin
          NewNode := tvExplorer.Items.AddChild(ParentNode, SR.Name);
          NewNode.ImageIndex := 0;
          NewNode.SelectedIndex := 0;
          tvExplorer.Items.AddChild(NewNode, '');
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
  end;

  if FindFirst(IncludeTrailingPathDelimiter(Path) + '*.*', faAnyFile, SR) = 0 then
  begin
    try
      repeat
        if (SR.Name <> '.') and (SR.Name <> '..') and ((SR.Attr and faDirectory) = 0) then
        begin
          NewNode := tvExplorer.Items.AddChild(ParentNode, SR.Name);
          NewNode.ImageIndex := 1;
          NewNode.SelectedIndex := 1;
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
  end;
end;

procedure TfrmMain.tvExplorerExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  AllowExpansion := True;
  if (Node.Count = 1) and (Node.Items[0].Text = '') then
  begin
    tvExplorer.Items.BeginUpdate;
    try
      PopulateTreeNode(Node, GetNodePath(Node));
    finally
      tvExplorer.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.tvExplorerDblClick(Sender: TObject);
var
  Node: TTreeNode;
  FilePath: string;
begin
  Node := tvExplorer.Selected;
  if Assigned(Node) then
  begin
    FilePath := GetNodePath(Node);

    if FileExists(FilePath) then
    begin
      OpenDocument(FilePath);
    end
    else if DirectoryExists(FilePath) then
    begin
      Node.Expanded := not Node.Expanded;
    end;
  end;
end;

// ==========================================
// LOGIKA DRAG AND DROP OS (Zero-Bloat)
// ==========================================

procedure TfrmMain.FormDropFiles(Sender: TObject; const FileNames: array of string);
var
  i: Integer;
begin
  // Looping untuk memproses semua file/folder yang di-drag sekaligus
  for i := Low(FileNames) to High(FileNames) do
  begin
    if FileExists(FileNames[i]) then
    begin
      // Jika yang dilempar adalah File, buka di Editor
      OpenDocument(FileNames[i]);
    end
    else if DirectoryExists(FileNames[i]) then
    begin
      // Jika yang dilempar adalah Folder, buka di Explorer Sidebar
      pnlSidebar.Visible := True;
      Splitter1.Visible := True;
      OpenFolder(FileNames[i]);
    end;
  end;
end;

procedure TfrmMain.SetHightAnySyn;
begin
  // ==========================================
  // SETUP CUSTOM HIGHLIGHTER (DART)
  // ==========================================
  FSynDart := TSynAnySyn.Create(Self);
  FSynDart.Name:= 'Dart';
  // Daftar Keyword Utama Dart
  FSynDart.KeyWords.CommaText := 'abstract,as,assert,async,await,break,case,catch,class,const,continue,covariant,default,deferred,do,dynamic,else,enum,export,extends,extension,external,factory,false,final,finally,for,Function,get,if,implements,import,in,interface,is,late,library,mixin,new,null,on,operator,part,required,rethrow,return,set,show,static,super,switch,sync,this,throw,true,try,typedef,var,void,while,with,yield';
  // Daftar Tipe Data / Objek Dart
  FSynDart.Objects.CommaText := 'String,int,double,bool,num,List,Set,Map,Iterable,Future,Stream,Widget,StatelessWidget,StatefulWidget';
  // Secara otomatis TSynAnySyn akan mewarnai string ("" atau '') dan komentar (// atau /* */) ala keluarga bahasa C/Java.

  // ==========================================
  // SETUP CUSTOM HIGHLIGHTER (GOLANG)
  // ==========================================

  FSynGo := TSynAnySyn.Create(Self);
  FSynGo.Name := 'Go';
  // Daftar 25 Keyword Utama Go
  FSynGo.KeyWords.CommaText := 'break,case,chan,const,continue,default,defer,else,fallthrough,for,func,go,goto,if,import,interface,map,package,range,return,select,struct,switch,type,var';
  // Daftar Tipe Data Dasar, Konstanta Baku, dan Fungsi Built-in Go
  FSynGo.Objects.CommaText := 'bool,byte,complex64,complex128,error,float32,float64,int,int8,int16,int32,int64,rune,string,uint,uint8,uint16,uint32,uint64,uintptr,true,false,iota,nil,append,cap,close,complex,copy,delete,imag,len,make,new,panic,print,println,real,recover';
  // Secara otomatis TSynAnySyn akan mewarnai string ("" atau ``) dan komentar (// atau /* */) ala Go.

  // ==========================================
  // SETUP CUSTOM HIGHLIGHTER (C#)
  // ========================================

  FSynCSharp := TSynAnySyn.Create(Self);
  FSynCSharp.Name := 'CSharp';

  // Daftar Keyword Utama dan Contextual Keyword C#
  FSynCSharp.KeyWords.CommaText := 'abstract,add,alias,as,async,await,base,break,case,catch,checked,class,const,continue,default,delegate,do,else,enum,event,explicit,extern,false,finally,fixed,for,foreach,get,global,goto,if,implicit,in,interface,internal,is,lock,namespace,new,null,operator,out,override,params,partial,private,protected,public,readonly,ref,remove,return,sealed,set,sizeof,stackalloc,static,struct,switch,this,throw,true,try,typeof,unchecked,unsafe,using,value,var,virtual,void,volatile,where,while,yield';

  // Daftar Tipe Data Primitif dan Objek/Class Umum .NET
  FSynCSharp.Objects.CommaText := 'bool,byte,char,decimal,double,dynamic,float,int,long,object,sbyte,short,string,uint,ulong,ushort,Console,Exception,Task,Thread,List,Dictionary,IEnumerable,Action,Func,DateTime,Math,Convert';

  // ==========================================
  // SETUP CUSTOM HIGHLIGHTER (RUST)
  // ========================================

  FSynRust := TSynAnySyn.Create(Self);
  FSynRust.Name := 'Rust';

  // Daftar Keyword Utama Rust (termasuk edisi modern 2018+)
  FSynRust.KeyWords.CommaText := 'as,async,await,break,const,continue,crate,dyn,else,enum,extern,false,fn,for,if,impl,in,let,loop,match,mod,move,mut,pub,ref,return,self,Self,static,struct,super,trait,true,type,unsafe,use,where,while';

  // Daftar Tipe Data Skalar, Tipe Pointer, dan Enum/Struct Standar Bawaan Rust
  FSynRust.Objects.CommaText := 'bool,char,f32,f64,i8,i16,i32,i64,i128,isize,u8,u16,u32,u64,u128,usize,str,String,Option,Result,Some,None,Ok,Err,Vec,Box,Rc,Arc,Cell,RefCell';

  // TSynAnySyn akan secara otomatis menangani pewarnaan string dan komentar (// atau /* */) ala C/Rust.

end;

end.
