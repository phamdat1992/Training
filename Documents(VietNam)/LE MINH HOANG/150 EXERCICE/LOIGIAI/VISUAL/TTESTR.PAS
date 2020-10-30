procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

procedure WriteP(p: Real);
var
  f: file of Real;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Real;
var
  f: file of Real;
  P: Real;
begin
  Assign(f, 'POINT.PNT'); Reset(f);
  Read(f, P);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP:5:2, S);
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

procedure Wrong(P: Real);
var
  S: String;
begin
  Visual.Color := 78;
  Str(P:5:2, S);
  MSG(20, 3, InputFile, '   Bπn c„ ' + S + ' Æi”m   '#7);
  WriteP(ReadP + P);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String;
  T: String[1]
begin
  Caption('Bµi ""');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      T := ParamStr(1);
      ch := T[1];
    end
  else
    ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      Str(ReadP:5:2, S);
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
begin
  Caption('Ch m bµi: ""');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
end;