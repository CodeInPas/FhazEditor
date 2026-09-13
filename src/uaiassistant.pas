unit uAIAssistant;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fphttpclient, fpjson, jsonparser, opensslsockets,
  uAppConfig; // <-- Tambahan uAppConfig agar bisa mengenali tipe data TAIEngine

type
  { TAIAssistant: Modul klien HTTP untuk pemrosesan teks AI }
  TAIAssistant = class
  private
    FEngine: TAIEngine; // <-- Sekarang TAIEngine dibaca dari uAppConfig
    FEndpointURL: string;
    FAPIKey: string;
    FTimeout: Integer;

    // Fungsi internal perakit HTTP & JSON berdasarkan engine
    function ProcessLocalLlama(const AFullPrompt: string): string;
    function ProcessGemini(const AFullPrompt: string): string;
  public
    constructor Create;
    destructor Destroy; override;

    function ProcessText(const APrompt: string; const AInstruction: string = ''): string;

    property Engine: TAIEngine read FEngine write FEngine;
    property EndpointURL: string read FEndpointURL write FEndpointURL;
    property APIKey: string read FAPIKey write FAPIKey;
    property Timeout: Integer read FTimeout write FTimeout;
  end;

implementation

{ TAIAssistant }

constructor TAIAssistant.Create;
begin
  FEngine := aeLocalLlama; // Default bawaan
  FEndpointURL := 'http://127.0.0.1:8080/completion';
  FAPIKey := '';
  FTimeout := 30000;
end;

destructor TAIAssistant.Destroy;
begin
  inherited Destroy;
end;

function TAIAssistant.ProcessText(const APrompt: string; const AInstruction: string): string;
var
  FullPrompt: string;
begin
  if AInstruction <> '' then
    FullPrompt := AInstruction + LineEnding + APrompt
  else
    FullPrompt := APrompt;

  // Alihkan pemrosesan berdasarkan Engine yang dipilih
  case FEngine of
    aeLocalLlama: Result := ProcessLocalLlama(FullPrompt);
    aeGeminiCloud: Result := ProcessGemini(FullPrompt);
  end;
end;

function TAIAssistant.ProcessLocalLlama(const AFullPrompt: string): string;
var
  HTTPClient: TFPHttpClient;
  JSONPayload: TJSONObject;
  ResponseRaw: string;
  ResponseJSON: TJSONData;
begin
  Result := '';
  HTTPClient := TFPHttpClient.Create(nil);
  JSONPayload := TJSONObject.Create;
  try
    HTTPClient.IOTimeout := FTimeout;
    HTTPClient.AddHeader('Content-Type', 'application/json');
    if FAPIKey <> '' then
      HTTPClient.AddHeader('Authorization', 'Bearer ' + FAPIKey);

    JSONPayload.Add('prompt', AFullPrompt);
    JSONPayload.Add('n_predict', 512);
    JSONPayload.Add('temperature', 0.3);

    try
      ResponseRaw := HTTPClient.FormPost(FEndpointURL, JSONPayload.AsJSON);
      ResponseJSON := GetJSON(ResponseRaw);
      try
        if ResponseJSON is TJSONObject then
          Result := TJSONObject(ResponseJSON).Get('content', '');
      finally
        ResponseJSON.Free;
      end;
    except
      on E: Exception do
        Result := 'Error: Local AI gagal. ' + E.Message;
    end;
  finally
    JSONPayload.Free;
    HTTPClient.Free;
  end;
end;

function TAIAssistant.ProcessGemini(const AFullPrompt: string): string;
var
  HTTPClient: TFPHttpClient;
  JSONPayload, JSONPart, JSONContent: TJSONObject;
  JSONPartsArr, JSONContentsArr: TJSONArray;
  ResponseRaw, GeminiURL: string;
  ResponseJSON: TJSONData;
  Candidates, Parts: TJSONArray;
begin
  Result := '';

  if FAPIKey = '' then
  begin
    Result := 'Error: API Key Gemini belum diatur.';
    Exit;
  end;

  // Endpoint standar untuk model Gemini Flash yang cepat
  GeminiURL := 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=' + FAPIKey;

  HTTPClient := TFPHttpClient.Create(nil);

  // Susun hierarki JSON spesifik Gemini: {"contents": [{"parts": [{"text": "prompt"}]}]}
  JSONPayload := TJSONObject.Create;
  JSONContentsArr := TJSONArray.Create;
  JSONContent := TJSONObject.Create;
  JSONPartsArr := TJSONArray.Create;
  JSONPart := TJSONObject.Create;
  try
    JSONPart.Add('text', AFullPrompt);
    JSONPartsArr.Add(JSONPart);
    JSONContent.Add('parts', JSONPartsArr);
    JSONContentsArr.Add(JSONContent);
    JSONPayload.Add('contents', JSONContentsArr);

    HTTPClient.IOTimeout := FTimeout;
    HTTPClient.AddHeader('Content-Type', 'application/json');

    try
      ResponseRaw := HTTPClient.FormPost(GeminiURL, JSONPayload.AsJSON);
      ResponseJSON := GetJSON(ResponseRaw);
      try
        // Parsing aman (*safe extraction*) dari struktur respons Gemini
        if ResponseJSON is TJSONObject then
        begin
          Candidates := TJSONObject(ResponseJSON).Arrays['candidates'];
          if Assigned(Candidates) and (Candidates.Count > 0) then
          begin
            Parts := TJSONObject(Candidates[0]).Objects['content'].Arrays['parts'];
            if Assigned(Parts) and (Parts.Count > 0) then
              Result := TJSONObject(Parts[0]).Strings['text'];
          end
          else
            Result := 'Error: Format balasan API tidak dikenali atau diblokir.';
        end;
      finally
        ResponseJSON.Free;
      end;
    except
      on E: Exception do
        Result := 'Error: Cloud AI gagal. ' + E.Message;
    end;
  finally
    JSONPayload.Free;
    HTTPClient.Free;
  end;
end;

end.
