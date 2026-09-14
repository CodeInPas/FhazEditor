program FhazEditor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  // Pastikan unit ufrmSplash terdaftar di sini!
  ufrmMain, ufrmPreferences, uAppConfig, SysUtils, uVisualOperatorTheme,
  uSessionManager, uAIAssistant, ufrmSplash;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;

  // ==========================================
  // LOGIKA SPLASH SCREEN (Zero-Bloat)
  // ==========================================

  // 1. Buat dan tampilkan Splash Screen SECARA INSTAN di memori
  frmSplash := TfrmSplash.Create(nil);
  try
    frmSplash.Show;
    frmSplash.Update; // Paksa OS untuk melukis UI ini sekarang juga

    // 2. Beri jeda 800 milidetik agar user bisa melihat form ini!
    // (Karena kompilasi Pascal terlalu cepat, tanpa jeda ini form hanya akan berkedip)
    Sleep(800);

    frmSplash.lblLoading.Caption := 'Membangun antarmuka utama...';
    frmSplash.Update;

    // 3. Muat aplikasi raksasa kita di latar belakang
    Application.CreateForm(TfrmMain, frmMain);

    Sleep(300); // Jeda tambahan 0.3 detik untuk transisi mulus
  finally
    // 4. Hancurkan Splash Screen dari RAM secara bersih
    frmSplash.Hide;
    frmSplash.Free;
  end;
  // ==========================================
  // Jalankan Aplikasi Utama
  Application.Run;
end.
