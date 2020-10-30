program Encode_Decode;
uses crt, visual;
const
  InputFile: String = 'PERMUTE.IN';
  OutputFile = 'PERMUTE.OUT';
  max = 12;
var
  Fac: array[0..max] of LongInt;
  a, b: array[1..max] of Integer;
  n: Integer;
  p, q: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  n := 0;
  while not SeekEoln(f) do
    begin
      Inc(n); Read(f, a[n]);
    end;
  Readln(f);
  Readln(f, p);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  Fac[0] := 1;
  for i := 1 to n do Fac[i] := Fac[i - 1] * i;
end;

procedure Solve1;
var
  Free: array[1..max] of Boolean;
  i, j, k: Integer;
begin
  q := 0;
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to n do
    begin
      k := 0;
      for j := 1 to a[i] - 1 do
        if Free[j] then Inc(k);
      q := q + LongInt(k) * Fac[n - i];
      Free[a[i]] := False;
    end;
  Inc(q);
end;

procedure Solve2;
var
  i, j, k, t: Integer;
  Free: array[1..max] of Boolean;
begin
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to n do
    begin
      j := (p - 1) div Fac[n - i] + 1;
      for k := 1 to n do
        if Free[k] then
          begin
            Dec(j);
            if j = 0 then Break;
          end;
      b[i] := k;
      Free[k] := False;
      p := (p - 1) mod Fac[n - i] + 1;
    end;
end;

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
  T: String[1];
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
var
  hsq: LongInt;
  hs: array[1..max] of Integer;
  mark, i: Integer;
  bc: Boolean;
begin
  Enter;
  Caption('Ch m bµi: "SË hi÷u vµ gi∏ trﬁ"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsq);
  Writeln('Ho∏n vﬁ -> SË hi÷u:');
  Write('  Ho∏n vﬁ cho lµ: (');
  for i := 1 to n do Write(a[i], ' ');
  Writeln(');');
  Writeln('    + SË hi÷u cÒa Æ∏p ∏n  : ', q);
  Writeln('    + SË hi÷u cÒa h‰c sinh: ', hsq);
  Mark := 0;
  if q <> hsq then Writeln('K’t qu∂ sai!')
  else
    begin
      Writeln('K’t qu∂ ÆÛng!');
      Inc(Mark);
    end;
  Writeln;
  Writeln('SË hi÷u -> Ho∏n vﬁ:');
  Writeln('  SË hi÷u Æ∑ cho lµ: ', p);
  for i := 1 to n do Read(f, hs[i]);
  Write('    + Ho∏n vﬁ cÒa Æ∏p ∏n  : (');
  for i := 1 to n do Write(b[i], ' ');
  Writeln(');');
  Write('    + Ho∏n vﬁ cÒa h‰c sinh: (');
  for i := 1 to n do Write(hs[i], ' ');
  Writeln(');');
  bc := True;
  for i := 1 to n do
    if hs[i] <> b[i] then
      begin
        Writeln('K’t qu∂ sai!');
        bc := False;
        Break;
      end;
  if bc then
    begin
      Writeln('K’t qu∂ ÆÛng!');
      Inc(Mark);
    end;
  if Mark = 2 then Correct
  else Wrong(Mark / 2);
end;

begin
  AskTest;
  Enter;
  Init;
  Solve1;
  Solve2;
  Test;
end.