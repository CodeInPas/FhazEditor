unit ufrmAbout;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  uAppConfig, uVisualOperatorTheme;

type
  { TfrmAbout }
  TfrmAbout = class(TForm)
    btnClose: TButton;
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblDesc: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
  public
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.lfm}

{ TfrmAbout }

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  // Terapkan tema secara dinamis (Gelap / Terang) sesuai konfigurasi saat ini!
  TVisualTheme.ApplyTheme(Self, Config.Theme);
end;

procedure TfrmAbout.FormPaint(Sender: TObject);
begin
  // Lukis aksen logo di atas dan bawah form (Sama dengan Splash Screen)
  Canvas.Pen.Color := $00D47A00; // Biru Aksen
  Canvas.Pen.Width := 4;
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(Width, 0);

  Canvas.Pen.Color := $0067C0E4; // Krem Emas
  Canvas.MoveTo(0, Height - 4);
  Canvas.LineTo(Width, Height - 4);
end;

procedure TfrmAbout.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
