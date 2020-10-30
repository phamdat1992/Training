program Traffic;
uses crt, visual;
const
  InputFile: string = 'TRAFFIC.IN';
  OutputFile = 'TRAFFIC.OUT';
  max = 100;
  maxC = 60000;
  dx: array[1..4] of Integer = (0, 0, 1, -1);
  dy: array[1..4] of Integer = (1, -1, 0, 0);
  direction: array[1..4] of Char = 'EWSN';
  cc: Integer = 99;
type
  Tdistance = array[1..max, 1..max] of Word;
  TTrace = array[1..max, 1..max] of ShortInt;
  THeap = array[1..max * max, 1..2] of Byte;
var
  a: array[1..max, 1..max] of Byte;
  pos: array[1..max, 1..max] of Word;
  t1, t2, Trace: ^TTrace;
  d1, d2, din, dout: ^Tdistance;
  heap: ^THeap;
  m, n, S, nHeap, resX, resY: Integer;
  res: Word;

  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, cc, S);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure Init(x, y: Integer);
var
  i, j: Integer;
begin
  for i := 1 to m do
    for j := 1 to n do
      begin
        din^[i, j] := maxC;
        dout^[i, j] := MaxC;
      end;
  din^[x, y] := S;
  dout^[x, y] := S;
  nHeap := 1;
  heap^[nHeap, 1] := x; heap^[nHeap, 2] := y;
  FillChar(pos, SizeOf(pos), 0);
  pos[x, y] := 1;
end;

function GetD(i: Integer): Word;
begin
  GetD := dout^[heap^[i, 1], heap^[i, 2]];
end;

procedure Pop(var x, y: Integer);
var
  tmp: Word;
  r, c: Integer;
begin
  x := heap^[1, 1]; y := heap^[1, 2];
  tmp := GetD(nHeap);
  r := 1;
  while r * 2 < nHeap do
    begin
      c := r * 2;
      if (c + 1 < nHeap) and (GetD(c + 1) < GetD(c)) then Inc(c);
      if tmp <= GetD(c) then Break;
      heap^[r] := heap^[c];
      pos[heap^[r, 1], heap^[r, 2]] := r;
      r := c;
    end;
  heap^[r] := heap^[nHeap];
  pos[heap^[r, 1], heap^[r, 2]] := r;
  Dec(nHeap);
end;

procedure Push(x, y: Integer);
var
  r, c: Integer;
  tmp: Word;
begin
  c := Pos[x, y];
  if c = 0 then
    begin
      Inc(nHeap); c := nHeap;
    end;
  tmp := dout^[x, y];
  r := c div 2;
  while (r > 0) and (GetD(r) > tmp) do
    begin
      heap^[c] := heap^[r];
      pos[heap^[c, 1], heap^[c, 2]] := c;
      c := r;
      r := c div 2;
    end;
  heap^[c, 1] := x; heap^[c, 2] := y;
  pos[x, y] := c;
end;

procedure Update(x, y: Integer);
var
  d, newx, newy, signal: Integer;
  newd: Word;

  function Inside(i, j: Integer): Boolean;
  begin
    Inside := (i >= 1) and (i <= m) and (j >= 1) and (j <= n);
  end;

begin
  for d := 1 to 4 do
    begin
      newx := x + dx[d]; newy := y + dy[d];
      if Inside(newx, newy) then
        begin
          newd := dout^[x, y] + cc;
          if newd < din^[newx, newy] then
            begin
              din^[newx, newy] := newd;
              Trace^[newx, newy] := Trace^[newx, newy] and $0F or (d shl 4);
            end;
          if a[newx, newy] <> 0 then
            begin
              signal := newd div a[newx, newy];
              if odd(signal) and (d <= 2)
                 or not odd(signal) and (d >= 3) then
                   newd := (signal + 1) * a[newx, newy];
            end;
          if newd < dout^[newx, newy] then
            begin
              dout^[newx, newy] := newd;
              Trace^[newx, newy] := Trace^[newx, newy] and $F0 or d;
              Push(newx, newy);
            end;
        end;
    end;
end;

procedure Dijkstra(startX, startY: Integer);
var
  x, y: Integer;
begin
  Init(startX, startY);
  repeat
    Pop(x, y);
    Update(x, y);
  until nHeap = 0;
end;

procedure GetPos;
var
  i, j: Integer;
  time1, time2, Local: Word;
begin
  Res := MaxC;
  for i := 1 to m do
    for j := 1 to n do
      begin
        time1 := d1^[i, j]; time2 := d2^[i, j];
        if time1 > time2 then Local := time1 else Local := time2;
        if Local < Res then
          begin
            Res := Local;
            resX := i; resY := j;
          end;
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

{$R+,Q+}

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 136: "TÝn hiÖu giao th«ng"');
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

function GetTimeOut(x, y: Integer; c: Char; TimeIn: LongInt): LongInt;
var
  signal: Integer;
  TimeOut: LongInt;
begin
  TimeOut := TimeIn;
  if a[x, y] <> 0 then
    begin
      signal := TimeIn div a[x, y];
      if odd(signal) and (c in ['E','W'])
         or not odd(signal) and (c in ['S', 'N']) then
           TimeOut := (signal + 1) * a[x, y];
    end;
  GetTimeOut := TimeOut;
end;

procedure Test;
var
  hsRes: LongInt;
  TimeIn, TimeOut, x, y, x1, y1, x2, y2, t1, t2, di: LongInt;
  c: Char;
begin
  Caption('ChÊm bµi 136: "TÝn hiÖu giao th«ng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsRes);
  Writeln('Thêi ®iÓm hÑn sím nhÊt: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', hsRes);
  if hsRes > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  TimeOut := S; TimeIn := S;
  x := 1; y := 1;
  while not SeekEoln(f) do
    begin
      Read(f, c);
      di := System.Pos(c, direction);
      if not (c in ['E', 'W', 'S', 'N']) then
        begin
          Writeln('Sai format output!');
          Wrong;
        end;
      x := x + dx[di]; y := y + dy[di];
      if (x < 1) or (x > m) or (y < 1) or (y > n) then
        begin
          Writeln('§i ra ngoµi thµnh phè, nót (', x, ', ', y, ')');
          Wrong;
        end;
      TimeIn := TimeOut + cc;
      TimeOut := GetTimeOut(x, y, c, TimeIn);
    end;
  Readln(f);
  Writeln('+ Xe 1 ®Õn nót (', x, ', ', y, ') vµo thêi ®iÓm: ', TimeIn);
  x1 := x; y1 := y; t1 := TimeIn;
  TimeOut := S; TimeIn := S;
  x := m; y := n;
  while not SeekEoln(f) do
    begin
      Read(f, c);
      di := System.Pos(c, direction);
      if not (c in ['E', 'W', 'S', 'N']) then
        begin
          Writeln('Sai format output!');
          Wrong;
        end;
      x := x + dx[di]; y := y + dy[di];
      if (x < 1) or (x > m) or (y < 1) or (y > n) then
        begin
          Writeln('§i ra ngoµi thµnh phè, nót (', x, ', ', y, ')');
          Wrong;
        end;
      TimeIn := TimeOut + cc;
      TimeOut := GetTimeOut(x, y, c, TimeIn);
    end;
  Writeln('+ Xe 2 ®Õn nót (', x, ', ', y, ') vµo thêi ®iÓm: ', TimeIn);
  x2 := x; y2 := y; t2 := TimeIn;
  if (x1 <> x2) or (y1 <> y2) then
    begin
      Writeln('Hai xe kh«ng gÆp nhau!');
      Wrong;
    end;
  if t1 < t2 then t1 := t2;
  Writeln('Thêi ®iÓm gÆp nhau: ', t1);
  if t1 <> hsRes then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  New(heap);
  New(dout);
  New(din); New(Trace);
  Dijkstra(1, 1);
  d1 := din; t1 := Trace;

  New(din); New(Trace);
  Dijkstra(m, n);
  d2 := din; t2 := Trace;
  GetPos;
  Test;
end.
3 4 100
0   100 100 100
100 0   0   0
100 0   0   0