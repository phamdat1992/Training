{$R-,S-,Q-}
program Fair; {Dijkstra voi cau truc Heap}
uses crt, visual;
const
  InputFile: String  = 'FAIR.IN';
  OutputFile = 'FAIR.OUT';
  dx: array[1..4] of Integer = (1, -1, 0, 0);
  dy: array[1..4] of Integer = (0, 0, 1, -1);
  max = 100;
  maxC = 10001;
type
  TMatrix = array[0..max + 1, 0..max + 2] of Integer;
  Tarray = array[1..max * (max + 1), 1..2] of Integer;
var
  a, d: TMatrix;
  Heap: ^Tarray; {Heap^ luu toa do cac o dang duoc toi uu nhan}
  p: ^TMatrix;   {p^[i, j] la vi tri o (i, j) trong mang Heap^}
  resx, resy, distance, m, n, nHeap: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 0 to m + 1 do
    for j := 0 to n + 2 do a[i, j] := -1;
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  for i := 1 to m do a[i, n + 1] := 0;
  Inc(n);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  New(p); New(Heap);
  FillChar(p^, SizeOf(p^), 0);
  for i := 1 to m do
    for j := 1 to n - 1 do d[i, j] := maxC;
  nHeap := 0;
  for i := 1 to m do
    begin
      d[i, n] := a[i, n];
      Inc(nHeap);
      Heap^[nHeap, 1] := i;
      Heap^[nHeap, 2] := n;
      p^[i, n] := nHeap;
    end;
end;

procedure Adjust(r: Integer);
var
  c: Integer;
  kx, ky, dkey: Integer;
begin
  kx := Heap^[r, 1]; ky := Heap^[r, 2];
  dkey := d[kx, ky];
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and
         (d[Heap^[c, 1], Heap^[c, 2]] > d[Heap^[c + 1, 1], Heap^[c + 1, 2]])
           then Inc(c);
      if dkey <= d[Heap^[c, 1], Heap^[c, 2]] then Break;
      Heap^[r] := Heap^[c];
      p^[Heap^[r, 1], Heap^[r, 2]] := r;
      r := c;
    end;
  Heap^[r, 1] := kx; Heap^[r, 2] := ky;
  p^[Heap^[r, 1], Heap^[r, 2]] := r;
end;

procedure ChangeLabel(x, y, newLab: Integer);
var
  r, c, kx, ky, dkey: Integer;
begin
  if p^[x, y] = 0 then
    begin
      Inc(nHeap);
      Heap^[nHeap, 1] := x; Heap^[nHeap, 2] := y;
      p^[x, y] := nHeap;
      c := nHeap;
    end
  else c := p^[x, y];
  d[x, y] := newLab;
  dkey := d[x, y];
  r := c div 2;
  while (r > 0) and (d[Heap^[r, 1], Heap^[r, 2]] > dkey) do
    begin
      Heap^[c] := Heap^[r];
      p^[Heap^[c, 1], Heap^[c, 2]] := c;
      c := r; r := r div 2;
    end;
  Heap^[c, 1] := x; Heap^[c, 2] := y;
  p^[x, y] := c;
end;

procedure Dijkstra;
var
  di, ux, uy, vx, vy: Integer;
begin
  repeat
    ux := Heap^[1, 1]; uy := Heap^[1, 2];
    Heap^[1] := Heap^[nHeap];
    Dec(nHeap);
    Adjust(1);
    if uy = 1 then
      begin
        resx := ux;
        resy := uy;
        Exit;
      end;
    a[ux, uy] := -1;
    for di := 1 to 4 do
      begin
        vx := ux + dx[di]; vy := uy + dy[di];
        if (a[vx, vy] >= 0) and (d[vx, vy] > d[ux, uy] + a[vx, vy]) then
          begin
            ChangeLabel(vx, vy, d[ux, uy] + a[vx, vy]);
          end;
      end;
  until False;
end;

procedure Result;
begin
  Distance := d[resx, resy];
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
  Caption('Bµi 108: "Héi chî"');
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
  x, y, nextx, nexty: Integer;
  cost, cc: Integer;
begin
  Enter;
  Dec(n);
  Caption('ChÊm bµi 108: "Héi chî"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, cost);
  Writeln('Chi phÝ ph¶i tr¶: ');
  Writeln('  + §¸p ¸n  : ', Distance);
  Writeln('  + Häc sinh: ', cost);
  if cost > Distance then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Readln(f, x, y);
  if (x < 1) or (x > m) then
    begin
      Writeln('Sai khu«n d¹ng d÷ liÖu!');
      Wrong;
    end;
  if y <> 1 then
    begin
      Writeln('¤ xuÊt ph¸t sai!');
      Wrong;
    end;
  cc := a[x, y];
  while not SeekEof(f) do
    begin
      Readln(f, nextx, nexty);
      if (nextx < 1) or (nextx > m) or (nexty < 1) or (nexty > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if Abs(x - nextx) + Abs(y - nexty) <> 1 then
        begin
          Writeln('§i ®­êng rõng (', x, ', ', y, ') -> (', nextx, ', ', nexty, ')');
          Wrong;
        end;
      x := nextx; y := nexty;
      cc := cc + a[x, y];
    end;
  if y <> n then
    begin
      Writeln('¤ kÕt thóc sai!');
      Wrong;
    end;
  Writeln('Chi phÝ tÝnh theo ®­êng ®i: ', cc);
  if cc <> cost then
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
  Init;
  Dijkstra;
  Result;
  Test;
end.
6 5
 5  1  1  1 17
 9  7  7  1 12
 9  2  1  1 10
10 10  1 10 10
10 10  1  2  3
10 10 10 10 10
