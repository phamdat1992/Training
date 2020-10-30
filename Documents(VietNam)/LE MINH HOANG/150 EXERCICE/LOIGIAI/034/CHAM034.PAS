program Exchange;
uses crt, visual;
const
  InputFile: String  = 'COIN.IN';
  OutputFile = 'COIN.OUT';
  maxCoin  = 20;
  maxMoney = 6666;
var
  Value: array[1..maxCoin] of Word;
  Count: array[0..maxMoney] of LongInt;
  Min: array[0..MaxMoney] of Integer;
  C: array[0..maxCoin] of Integer;
  N: Word;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, N);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to maxCoin do Value[i] := Sqr(i);
end;

procedure Optimize1;
var
  t: Word;
  i: Integer;
begin
  FillChar(Count, SizeOf(Count), 0);
  Count[0] := 1;
  for i := 1 to maxCoin do
    for t := 0 to N do {Tinh Count[i, t]}
      if t >= Value[i] then
        Count[t] := Count[t] + Count[t - Value[i]];
end;

procedure Optimize2;
var
  t: Word;
  i: Integer;
begin
  Min[0] := 0;
  for t := 1 to N do
    begin
      Min[t] := 255;
      for i := 1 to MaxCoin do
        if (t >= Value[i]) and (Min[t] > Min[t - Value[i]] + 1) then
          Min[t] := Min[t - Value[i]] + 1;
    end;
  FillChar(C, SizeOf(C), 0);
  t := N;
  while t <> 0 do
    begin
      for i := 1 to MaxCoin do
        if (t >= Value[i]) and (Min[t] = Min[t - Value[i]] +  1) then Break;
      Inc(C[i]);
      t := t - Value[i];
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Count[N]);
  Writeln(f, Min[N]);
  for i := 1 to MaxCoin do
    if C[i] <> 0 then Writeln(f, C[i], ' ', i);
  Close(f);
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
    Assign(f, 'POINT.PNT'); Reset(f);
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
    MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
    Visual.Color := 47;
    MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
    WriteP(ReadP + 1);
    ShowP;
    if ReadP = 10 then
        Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
    Halt;
end;

procedure Wrong;
begin
    Visual.Color := 78;
    MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
    ShowP;
    Halt;
end;

procedure AskTest;
begin
    Caption('Bµi "Tr¶ tiÒn"');
    MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
    ch := ReadKey;
    Write(ch);
    if ch = '1' then WriteP(0);
    if ch = #13 then
        begin
            MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
            Write(ReadP);
            Halt;
        end;
    InputFile := InputFile + ch;
end;

procedure Test;
var
    a, b, c, s, sc: LongInt;
begin
    Caption('ChÊm bµi: "Tr¶ tiÒn"');
    Visual.Color := 159;
    FlatFrame(3, 7, 78, 23, 'KiÓm tra');
    Assign(f, OutputFile); Reset(f);
    Readln(f, c);
    Writeln('Sè c¸ch tr¶ ', N, ' xu: ');
    Writeln('  + §¸p ¸n  : ', Count[N]);
    Writeln('  + Häc sinh: ', c);
    if c <> Count[N] then
        begin
            Writeln('KÕt qu¶ sai!'); Wrong;
        end;
    Writeln('KÕt qu¶ ®óng!');
    Writeln('Sè c¸ch tr¶ Ýt ®ång xu nhÊt: ');
    Readln(f, c);
    Writeln('  + §¸p ¸n  : ', Min[N]);
    Writeln('  + Häc sinh: ', c);
    if c > Count[N] then
        begin
            Writeln('KÕt qu¶ sai!'); Wrong;
        end;
    s := 0; sc := 0;
    while not SeekEof(f) do
        begin
            Readln(f, a, b);
            s := s + a * Sqr(b);
            sc := sc + a;
        end;
    if sc <> c then
        begin
            Writeln('TÝnh sè xu sai!');
            Wrong;
        end;
    if s <> n then
        begin
            Writeln('TÝnh tiÒn sai!');
            Wrong;
        end;
    Writeln('KÕt qu¶ ®óng!');
    Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize1;
  Optimize2;
  Test;
end.
10
50
99
100
200
300
400
500
600
666
