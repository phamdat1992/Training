program Recover;
uses crt, visual;
const
  InputFile: String  = 'BRACKETS.IN';
  OutputFile = 'BRACKETS.OUT';
  max = 10000;
var
  c: array[1..max + max] of Char;
  k, i, n: Integer;
  fr, fw: Text;
  ch: Char;

procedure Halt;
begin
  {$I-}
  Close(fr); if IOResult = 0 then;
  Close(fw); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

procedure WriteP(p: Integer);
var
  f: file of Integer;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  {$I-}
  Assign(f, 'POINT.PNT'); Reset(f);
  if IOResult <> 0 then
    begin
      WriteP(0);
      Reset(f);
    end;
  {$I+}
  Read(f, p);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP, S);
  if Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   Bπn c„ 1 Æi”m   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('ßÛng h’t c∏c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   Bπn c„ 0 Æi”m   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi ""');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
type
  T = array[1..max + max] of Char;
var
  c: ^T;
  f: Text;
  ct: char;
  i, n, k: Integer;
  S: String;
  b: Boolean;
begin
  Caption('Ch m bµi 077: "Kh´i phÙc ngo∆c"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  New(c);
  FillChar(c^, 2 * n, '?');
  for i := 1 to 2 * n do
    begin
      if c^[i] = '?' then
        begin
          Read(f, k); c^[i] := '('; c^[i + k + 1] := ')';
        end;
    end;
  Close(f);
  Color := 233;
  Assign(f, OutputFile); Reset(f);
  b := True;
  Writeln('K’t qu∂ h‰c sinh:');
  for i := 1 to 2 * n do
   begin
     Read(f, ct);
     Write(ct);
     b := b and (ct = c^[i]);
   end;
  Close(f); Dispose(c);
  Color := 47;
  Writeln;
  if b then
    begin
      Writeln('K’t qu∂ ch›nh x∏c!');
      Correct;
    end
  else
    begin
      Writeln('K’t qu∂ sai!');
      Wrong;
    end;
end;

begin
  AskTest;
  Test;
end.
