unit ufrmPreferences;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin, ExtCtrls,
  uAppConfig, uVisualOperatorTheme;

type
  TfrmPreferences = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    cbTheme: TComboBox;
    cbFontName: TComboBox;
    cbLineEnding: TComboBox;
    chkWordWrap: TCheckBox;

    gbAppearance: TGroupBox;
    gbEditor: TGroupBox;
    gbAI: TGroupBox; // Grup AI baru

    lblTheme: TLabel;
    lblFontName: TLabel;
    lblFontSize: TLabel;
    lblTabWidth: TLabel;
    lblLineEnding: TLabel;
    lblAIEngine: TLabel;
    lblAIEndpoint: TLabel;
    lblAIApiKey: TLabel;

    cbAIEngine: TComboBox;
    edtAIEndpoint: TEdit;
    edtAIApiKey: TEdit;

    pnlBottom: TPanel;
    seFontSize: TSpinEdit;
    seTabWidth: TSpinEdit;

    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbAIEngineChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LoadSettingsToUI;
    procedure SaveSettingsFromUI;
  public
  end;

var
  frmPreferences: TfrmPreferences;

implementation

{$R *.lfm}

procedure TfrmPreferences.FormShow(Sender: TObject);
begin
  TVisualTheme.ApplyTheme(Self, Config.Theme);

  if cbFontName.Items.Count = 0 then
    cbFontName.Items.Assign(Screen.Fonts);

  LoadSettingsToUI;
end;

procedure TfrmPreferences.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPreferences.btnSaveClick(Sender: TObject);
begin
  SaveSettingsFromUI;
  ModalResult := mrOk;
end;

procedure TfrmPreferences.cbAIEngineChange(Sender: TObject);
begin
  // Dinamis: Nonaktifkan field yang tidak relevan dengan engine terpilih
  if cbAIEngine.ItemIndex = 0 then // Local Llama
  begin
    edtAIEndpoint.Enabled := True;
    edtAIApiKey.Enabled := False;
  end
  else // Gemini Cloud
  begin
    edtAIEndpoint.Enabled := False;
    edtAIApiKey.Enabled := True;
  end;
end;

procedure TfrmPreferences.LoadSettingsToUI;
begin
  cbTheme.ItemIndex := Ord(Config.Theme);
  cbFontName.Text := Config.FontName;
  seFontSize.Value := Config.FontSize;
  seTabWidth.Value := Config.TabWidth;
  cbLineEnding.ItemIndex := Ord(Config.LineEnding);
  chkWordWrap.Checked := Config.WordWrap;

  // Muat AI Settings
  cbAIEngine.ItemIndex := Ord(Config.AIEngine);
  edtAIEndpoint.Text := Config.AIEndpoint;
  edtAIApiKey.Text := Config.AIApiKey;

  // Picu pembaruan status enable/disable pertama kali form dibuka
  cbAIEngineChange(nil);
end;

procedure TfrmPreferences.SaveSettingsFromUI;
begin
  Config.Theme := TThemeMode(cbTheme.ItemIndex);
  Config.FontName := cbFontName.Text;
  Config.FontSize := seFontSize.Value;
  Config.TabWidth := seTabWidth.Value;
  Config.LineEnding := TLineEndingStyle(cbLineEnding.ItemIndex);
  Config.WordWrap := chkWordWrap.Checked;

  // Simpan AI Settings
  Config.AIEngine := TAIEngine(cbAIEngine.ItemIndex);
  Config.AIEndpoint := edtAIEndpoint.Text;
  Config.AIApiKey := edtAIApiKey.Text;

  Config.Save;
end;

end.
