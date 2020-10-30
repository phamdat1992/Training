{$R-,Q-}
program Stagnant_Water;
uses crt, visual;
const
  InputFile: string  = 'WATER.IN';
  OutputFile = 'WATER.OUT';
  max = 100;
  dx: array[1..4] of ShortInt = (1, -1, 0, 0);
  dy: array[1..4] of ShortInt = (0, 0, 1, -1);
type
  TLayer = array[0..max, 0..max] of Byte;
var
  H: array[1..max, 1..max] of Word;
  Layer: TLayer;
  Queue: array[1..max * max, 1..2] of Byte;
  First, Last: Word;
  m, n: Byte;
  Sum: LongInt;
  Height: Word;
  Time: LongInt absolute 0:$46C;
  OldTime: LongInt;
  f: Text;
  ch: Char;


procedure Enter;
var
  f: Text;
  i, j: Byte;
begin
  Assign(f, InputFile); Reset(f);
  Height := 0;
  Readln(f, m, n);
  for i := 1 to m do
    for j := 1 to n do
      begin
        Read(f, H[i, j]);
        if H[i, j] > Height then Height := H[i, j];
      end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Layer, SizeOf(Layer), 255);
end;

procedure GetLayer(Index: Word);
var
  i, j: Byte;
begin
  for i := 1 to m do
    for j := 1 to n do
      if H[i, j] >= Index then Layer[i, j] := 1
      else Layer[i, j] := 0;
end;

procedure Push(X, Y: Byte);
begin
  Inc(Last);
  Queue[Last, 1] := X;
  Queue[Last, 2] := Y;
end;

procedure Pop(var X, Y: Byte);
begin
  X := Queue[First, 1];
  Y := Queue[First, 2];
  Inc(First);
end;

procedure InitStack;
var
  x, y: Byte;
begin
  Last := 0;
  for x := 1 to m do
    begin
      if Layer[x, 1] = 0 then
        begin
          Layer[x, 1] := 2; Push(x, 1);
        end;
      if Layer[x, n] = 0 then
        begin
          Layer[x, n] := 2; Push(x, n);
        end;
    end;
  for y := 1 to n do
    begin
      if Layer[1, y] = 0 then
        begin
          Layer[1, y] := 2; Push(1, y);
        end;
      if Layer[m, y] = 0 then
        begin
          Layer[m, y] := 2; Push(m, y);
        end;
    end;
  First := 1;
end;

function Count: Word;
var
  x, y, d, x0, y0: Byte;
  OK: Boolean;
  S: Word;
begin
  InitStack;
  while First <= Last do
    begin
      Pop(x, y);
      for d := 1 to 4 do
        begin
          x0 := x + dx[d];
          y0 := y + dy[d];
          if Layer[x0, y0] = 0 then
            begin
              Layer[x0, y0] := 2;
              Push(x0, y0);
            end;
        end;
    end;
  S := 0;
  for x := 1 to m do
    for y := 1 to n do
      if Layer[x, y] = 0 then Inc(S);
  Count := S;
end;

procedure Process;
var
  LayerIndex: Word;
begin
  Sum := 0;
  for LayerIndex := 1 to Height do
    begin
      GetLayer(LayerIndex);
      Sum := Sum + Count;
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
var
  S: String[1];
begin
  Caption('Bµi ""');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
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
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  SumHS: LongInt;
begin
  Caption('ChÊm bµi: ""');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, SumHS);
  Writeln;
  Writeln('  L­îng n­íc ®äng gi÷a c¸c cét:');
  Writeln('      + §¸p ¸n  : ', Sum);
  Writeln('      + Häc sinh: ', SumHS);
  Writeln;
  if Sum <> SumHS then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  OldTime := Time;
  Enter;
  Init;
  Process;
  Test;
end.
3 3
9 9 9
9 1 9
9 9 9
