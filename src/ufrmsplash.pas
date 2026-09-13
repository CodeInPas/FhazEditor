unit ufrmSplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TfrmSplash }
  TfrmSplash = class(TForm)
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblLoading: TLabel;
    procedure FormPaint(Sender: TObject);
  private
  public
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

{ TfrmSplash }

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  // Melukis garis aksen elegan di atas dan bawah form tanpa file gambar!
  Canvas.Pen.Color := $00D47A00; // Warna Biru Aksen khas UI kita
  Canvas.Pen.Width := 4;
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(Width, 0);
     Sleep(100);
  Canvas.Pen.Color := $0067C0E4; // Warna Krem Emas
  Canvas.MoveTo(0, Height - 4);
  Canvas.LineTo(Width, Height - 4);
end;

end.
