unit uos_httpgetthread;

{This is HTTP Thread Getter done by
   Andrew Haines => andrewd207@aol.com }

{Modifications for uos done by
  Fred van Stappen => fiens@hotmail.com }

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, unix, BaseUnix;

type

  { TThreadHttpGetter }

  TThreadHttpGetter = class(TThread)
  private
    FWantedURL: String;
    FIsRunning: Boolean;
    FOutHandle: THandle;
    function GetRedirectURL(AResponseStrings: TStrings): String;
   protected
    procedure Execute; override;
   public
    InHandle: THandle;
    constructor Create();
    procedure  WantedURL(AWantedURL: String);
    property IsRunning: Boolean read FIsRunning;
  end;

implementation
uses
  fphttpclient;

{ TThreadHttpGetter }

procedure TThreadHttpGetter.WantedURL(AWantedURL: String);
begin
   FWantedURL:=AWantedURL;
   FIsRunning:=True;
   Start;
end;

function TThreadHttpGetter.GetRedirectURL(AResponseStrings: TStrings): String;
var
  S: String;
  F: Integer;
  Search: String = 'location:';
begin
  Result := '';
  for S In AResponseStrings do
  begin
    WriteLn(S);
    F := Pos(Search, Lowercase(s));

    if F > 0 then
    begin
      Inc(F, Length(Search));
      Exit(Trim(Copy(S, F, Length(S)-F+1)));
    end;
  end;
end;

procedure TThreadHttpGetter.Execute;
var
  Http: TFPHTTPClient;
  Output: THandleStream = nil;
  URL: String;
begin
  Http := TFPHTTPClient.Create(nil);
  Output := THandleStream.Create(FOutHandle);
  URL := FWantedURL;
  repeat
  try
    Http.RequestHeaders.Clear;
    Http.Get(URL, Output);
  except
    on e: EHTTPClient do
    begin
      if Http.ResponseStatusCode = 302 then
      begin
        URL := GetRedirectURL(Http.ResponseHeaders);
        if URL <> '' then
          Continue;
      end
      else
        raise E;
    end
    else
      Raise;
  end;
  Break;
  until False;

  try
    Output.Free;
    Http.Free;
  finally
   // make sure this is set to false when done
    FIsRunning:=False;
    FpClose(FOutHandle);
    FpClose(InHandle);
  end;
end;

constructor TThreadHttpGetter.Create();
begin
  inherited Create(True);
   FIsRunning:=False;
   AssignPipe(InHandle, FOutHandle);
end;

end.

