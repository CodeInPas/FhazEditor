unit uVisualOperatorTheme;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Controls, Forms, ExtCtrls, StdCtrls,
  ComCtrls, SynEdit, SynEditHighlighter, uAppConfig,
  // Komponen penyusun Gutter agar bisa diwarnai latar belakangnya secara total
  SynGutter, SynGutterLineNumber, SynGutterChanges, SynGutterCodeFolding,
  SynGutterMarks, SynGutterLineOverview;

type
  { TVisualTheme: Kelas Utilitas statis untuk menerapkan tema }
  TVisualTheme = class
  public
    // Palet Warna - Dark Mode (Hanya untuk Editor)
    const
      DarkBG_Main    = $001E1E1E;
      DarkBG_Panel   = $00252526;
      DarkFG_Text    = $00D4D4D4;
      DarkAccent     = $00007ACC;
      DarkBorder     = $003E3E42;

      // --- KUSTOMISASI GUTTER EDITOR ---
      DarkGutterBG       = $00B05500; // Background Gutter (Biru klasik IDE)
      DarkGutterText     = clWhite;   // Warna angka baris (Putih)
      DarkGutterModified = $0000A5FF; // Garis Oranye (File diedit tapi belum disave)
      DarkGutterSaved    = $0000D000; // Garis Hijau (File sudah disave)
      DarkGutterFold     = clSilver;  // Garis lipatan kode / Code Folding Tree

    // Palet Warna - Light Mode (Hanya untuk Editor)
    const
      LightBG_Main   = clWhite;
      LightBG_Panel  = $00F3F3F3;
      LightFG_Text   = $00333333;
      LightAccent    = $00005C99;
      LightBorder    = $00CCCCCC;

    class procedure ApplyTheme(AForm: TForm; AThemeMode: TThemeMode);
    class procedure ApplySynEditTheme(ASynEdit: TSynEdit; AThemeMode: TThemeMode);
    class procedure ApplyHighlighterTheme(AHighlighter: TSynCustomHighlighter; AThemeMode: TThemeMode);
  end;

implementation

{ TVisualTheme }

class procedure TVisualTheme.ApplyTheme(AForm: TForm; AThemeMode: TThemeMode);
begin
  // Dikosongkan untuk menjaga stabilitas tema bawaan OS pada Form/Sidebar
end;

class procedure TVisualTheme.ApplySynEditTheme(ASynEdit: TSynEdit; AThemeMode: TThemeMode);
var
  i: Integer;
  PartBG: TColor;
begin
  // 1. Terapkan Warna Dasar Background Editor & Gutter
  if AThemeMode = tmDark then
  begin
    ASynEdit.Color := DarkBG_Main;
    ASynEdit.Font.Color := DarkFG_Text;

    ASynEdit.Gutter.Color := DarkGutterBG;
    PartBG := DarkGutterBG; // Simpan warna biru untuk ditimpakan ke elemen anak

    ASynEdit.LineHighlightColor.Background := $002A2D2E;
  end
  else
  begin
    ASynEdit.Color := LightBG_Main;
    ASynEdit.Font.Color := LightFG_Text;

    ASynEdit.Gutter.Color := LightBG_Panel;
    PartBG := LightBG_Panel;

    ASynEdit.LineHighlightColor.Background := $00E8E8E8;
  end;

  ASynEdit.RightEdgeColor := clNone;

  // 2. Looping Dinamis: Warnai setiap elemen penyusun Gutter (Background & Foreground)
  for i := 0 to ASynEdit.Gutter.Parts.Count - 1 do
  begin
    // A. Warnai Angka Baris
    if ASynEdit.Gutter.Parts[i] is TSynGutterLineNumber then
    begin
      TSynGutterLineNumber(ASynEdit.Gutter.Parts[i]).MarkupInfo.Background := PartBG; // <--- HAPUS ABU-ABU BAWAAN
      if AThemeMode = tmDark then
        TSynGutterLineNumber(ASynEdit.Gutter.Parts[i]).MarkupInfo.Foreground := DarkGutterText
      else
        TSynGutterLineNumber(ASynEdit.Gutter.Parts[i]).MarkupInfo.Foreground := $00999999;
    end

    // B. Warnai Garis Pelacak Perubahan
    else if ASynEdit.Gutter.Parts[i] is TSynGutterChanges then
    begin
      TSynGutterChanges(ASynEdit.Gutter.Parts[i]).MarkupInfo.Background := PartBG;
      if AThemeMode = tmDark then
      begin
        TSynGutterChanges(ASynEdit.Gutter.Parts[i]).ModifiedColor := DarkGutterModified;
        TSynGutterChanges(ASynEdit.Gutter.Parts[i]).SavedColor := DarkGutterSaved;
      end;
    end

    // C. Warnai Garis Lipatan Kode (Code Folding)
    else if ASynEdit.Gutter.Parts[i] is TSynGutterCodeFolding then
    begin
      TSynGutterCodeFolding(ASynEdit.Gutter.Parts[i]).MarkupInfo.Background := PartBG;
      if AThemeMode = tmDark then
        TSynGutterCodeFolding(ASynEdit.Gutter.Parts[i]).MarkupInfo.Foreground := DarkGutterFold;
    end

    // D. Warnai Area Markah (Bookmarks)
    else if ASynEdit.Gutter.Parts[i] is TSynGutterMarks then
    begin
      TSynGutterMarks(ASynEdit.Gutter.Parts[i]).MarkupInfo.Background := PartBG;
    end

    // E. Warnai Garis Pemisah (Separator)
    else if ASynEdit.Gutter.Parts[i] is TSynGutterSeparator then
    begin
      TSynGutterSeparator(ASynEdit.Gutter.Parts[i]).MarkupInfo.Background := PartBG;
      if AThemeMode = tmDark then
        TSynGutterSeparator(ASynEdit.Gutter.Parts[i]).MarkupInfo.Foreground := DarkGutterBG; // Sembunyikan garis dengan warna yang sama
    end;
  end;
end;

class procedure TVisualTheme.ApplyHighlighterTheme(AHighlighter: TSynCustomHighlighter; AThemeMode: TThemeMode);
var
  i: Integer;
  Attr: TSynHighlighterAttributes;
  SName: string;
begin
  if not Assigned(AHighlighter) then Exit;

  for i := 0 to AHighlighter.AttrCount - 1 do
  begin
    Attr := AHighlighter.Attribute[i];
    Attr.Background := clNone;
    SName := LowerCase(Attr.Name);

    if AThemeMode = tmDark then
    begin
      if (Pos('string', SName) > 0) or (Pos('char', SName) > 0) or (Pos('value', SName) > 0) then Attr.Foreground := $00CE9178
      else if (Pos('comment', SName) > 0) or (Pos('rem', SName) > 0) then Attr.Foreground := $00608B4E
      else if (Pos('number', SName) > 0) or (Pos('float', SName) > 0) or (Pos('hex', SName) > 0) then Attr.Foreground := $00B5CEA8
      else if (Pos('key', SName) > 0) or (Pos('element', SName) > 0) or (Pos('tag', SName) > 0) then Attr.Foreground := $00569CD6
      else if (Pos('symbol', SName) > 0) or (Pos('mark', SName) > 0) then Attr.Foreground := $00D4D4D4
      else if Pos('ident', SName) > 0 then Attr.Foreground := $00DCDCAA
      else if Pos('attrib', SName) > 0 then Attr.Foreground := $009CDCFE
      else Attr.Foreground := DarkFG_Text;
    end
    else
    begin
      if (Pos('string', SName) > 0) or (Pos('char', SName) > 0) or (Pos('value', SName) > 0) then Attr.Foreground := $001515A3
      else if (Pos('comment', SName) > 0) or (Pos('rem', SName) > 0) then Attr.Foreground := $00008000
      else if (Pos('number', SName) > 0) or (Pos('float', SName) > 0) or (Pos('hex', SName) > 0) then Attr.Foreground := clBlack
      else if (Pos('key', SName) > 0) or (Pos('element', SName) > 0) or (Pos('tag', SName) > 0) then Attr.Foreground := $000000FF
      else if (Pos('symbol', SName) > 0) or (Pos('mark', SName) > 0) then Attr.Foreground := clBlack
      else if Pos('ident', SName) > 0 then Attr.Foreground := clBlack
      else if Pos('attrib', SName) > 0 then Attr.Foreground := $000000FF
      else Attr.Foreground := LightFG_Text;
    end;
  end;
end;

end.
