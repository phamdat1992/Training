program RollingCube;
uses crt;
const
  InputFile: string = 'ROLL.IN';
  OutputFile = 'ROLL.OUT';
  max = 300;
  maxLong = 10000000;
  LeftCode: array[1..6, 1..6] of Byte =     {LeftCode[Bottom, Up]}
  (
  (0, 4, 2, 5, 3, 0),
  (3, 0, 6, 1, 0, 4),
  (5, 1, 0, 0, 6, 2),
  (2, 6, 0, 0, 1, 5),
  (4, 0, 1, 6, 0, 3),
  (0, 3, 5, 2, 4, 0)
  );
type
  THeapCmp = record
    x, y, code: Integer;
  end;
  TBUL = record
    B, U, L: Integer;
  end;
var
  map: array[0..max + 1, 0..max + 1] of Byte;
  Trace: array[1..max, 1..max, 1..24] of Byte;
  d: array[1..max, 1..max, 1..24] of LongInt;
  pos: array[1..max, 1..max, 1..24] of Integer;
  heap: array[1..max * max * 24] of THeapCmp;
  Index: array[1..6, 1..6, 1..6] of Integer; {index[bottom, up, left]}
  State: array[1..24] of TBUL;
  m, n, xStart, yStart, nHeap: Word;
  res: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Word;
begin
  FillChar(map, SizeOf(map), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, xStart, yStart);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, map[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure GetIndex;
var
  bottom, up, count: Integer;
begin
  count := 0;
  for bottom := 1 to 6 do
    for up := 1 to 6 do
      if LeftCode[bottom, up] <> 0 then
        begin
          Inc(count);
          with State[count] do
            begin
              B := bottom; U := up; L := LeftCode[bottom, up];
              Index[B, U, L] := count;
            end;
        end;
end;

function Less(p1, p2: THeapCmp): Boolean;
begin
  Less := d[p1.x, p1.y, p1.code] < d[p2.x, p2.y, p2.code];
end;

function LessEqual(p1, p2: THeapCmp): Boolean;
begin
  LessEqual := d[p1.x, p1.y, p1.code] <=
               d[p2.x, p2.y, p2.code];
end;

procedure SetHeap(id: Integer; Value: THeapCmp);
begin
  heap[id] := Value;
  with Value do
    pos[x, y, code] := id;
end;

function Getd(p: THeapCmp): LongInt;
begin
  with p do
    Getd := d[x, y, code];
end;

procedure Push(p: THeapCmp);
var
  c, r: Word;
begin
  c := Pos[p.x, p.y, p.code];
  if c = 0 then {Add}
    begin
      Inc(nHeap);
      c := nHeap;
    end;
  r := c div 2;
  while r <> 0 do
    begin
      if LessEqual(heap[r], p) then Break;
      SetHeap(c, heap[r]);
      c := r;
      r := c div 2;
    end;
  SetHeap(c, p);
end;

procedure Pop(var p: THeapCmp);
var
  r, c: Word;
  tmp: THeapCmp;
begin
  p := heap[1];
  tmp := heap[nHeap];
  Dec(nHeap);
  r := 1;
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and (Less(heap[c + 1], heap[c])) then Inc(c);
      if LessEqual(tmp, heap[c]) then Break;
      SetHeap(r, heap[c]);
      r := c;
    end;
  SetHeap(r, tmp);
end;

procedure DijkstraInit;
var
  tmp: THeapCmp;

  procedure Check(tmp: THeapCmp);
  begin
    with tmp do
      if (map[x, y] = 7) or (map[x, y] = State[code].B) then
        begin
          d[x, y, code] := 7 - State[Code].B;
          Push(tmp);
        end;
  end;

begin
  with tmp do
   for x := 1 to m do
     for y := 1 to n do
       for code := 1 to 24 do
         d[x, y, code] := MaxLong;
  nHeap := 0;
  with tmp do
    for code := 1 to 24 do
      begin
        y := 1;
        for x := 1 to m do Check(tmp);
        y := n;
        for x := 1 to m do Check(tmp);
        x := 1;
        for y := 2 to n - 1 do Check(tmp);
        x := m;
        for y := 2 to n - 1 do Check(tmp);
      end;
  FillChar(Trace, SizeOf(Trace), 0);
end;

function ChangeState(CurrentState: Integer; Direction: Integer): Integer;
var
  BUL, res: TBUL;
begin
  BUL := State[CurrentState]; res := BUL;
  case Direction of
    1: {UP}
      begin
        res.B := BUL.U; res.U := 7 - BUL.B;
      end;
    2: {DOWN}
      begin
        res.B := 7 - BUL.U; res.U := BUL.B;
      end;
    3: {LEFT}
      begin
        res.L := 7 - BUL.B; res.B := BUL.L;
      end;
    4: {RIGHT}
      begin
        res.L := BUL.B; res.B := 7 - BUL.L;
      end;
  end;
  ChangeState := Index[res.B, res.U, res.L];
end;

function CanMove(var p, q: THeapCmp; direction: Integer): Boolean;
const
  dx: array[1..4] of Integer = (-1, 1, 0, 0);
  dy: array[1..4] of Integer = (0, 0, -1, 1);
var
  newstate: Integer;
begin
  newstate := ChangeState(p.code, direction);
  q.x := p.x + dx[direction];
  q.y := p.y + dy[direction];
  q.Code := newstate;
  with q do
    CanMove := (map[x, y] = 7) or (map[x, y] = State[Code].B);
end;

procedure Update(p: THeapCmp);
var
  q: THeapCmp;
  dp: LongInt;
  di: Integer;
begin
  dp := Getd(p);
  for di := 1 to 4 do
    if CanMove(p, q, di) and (Getd(q) > dp + 7 - State[q.code].B) then
      begin
        with q do
          begin
            d[x, y, code] := dp + 7 - State[q.code].B;
            Trace[x, y, code] := di;
          end;
        Push(q);
      end;
end;

procedure DijkstraSolve;
var
  p: THeapCmp;
  EndCode: Integer;
begin
  Endcode := Index[6, 2, 3];
  repeat
    Pop(p);
    if (p.Code = EndCode) and (p.x = xStart) and (p.y = yStart) then Break;
    Update(p);
  until nHeap = 0;
end;

procedure Result;
begin
  Res := d[Xstart, Ystart, Index[6, 2, 3]];
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  ReadKey;
  System.Halt;
end;

procedure Correct;
begin
  Writeln;
  Writeln('             $$$$$$$$$$$$$$$$$$$$$$$$$$');
  Writeln('             $$   CORRECT! CORRECT!  $$');
  Writeln('             $$$$$$$$$$$$$$$$$$$$$$$$$$');
  Halt;
end;

procedure Wrong;
begin
  Writeln;
  Writeln('             ??????????????????????????');
  Writeln('             ??   ERROR  ! ERROR  !  ??');
  Writeln('             ??????????????????????????');
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Writeln('                     Bai 141: "Rolling Cube"');
  Writeln('                     ßßßßßßßßßßßßßßßßßßßßßßß');
  Write('                         ROLL.IN'); ch := ReadKey;  Write(ch);
  InputFile := InputFile + ch;
end;

procedure Test;
var
  di, i, Sum: Word;
  c: Char;
  p, q: THeapCmp;
begin
  Writeln('Kiem tra duong lan:');
  Assign(f, OutputFile); Reset(f);
  with p do
    begin
      x := XStart; y := YStart; Code := Index[6, 2, 3];
    end;
  i := 0;
  Sum := 1;
  while not SeekEoln(f) do
    begin
      Inc(i);
      Read(f, c);
      case c of
        'L': di := 3;
        'R': di := 4;
        'U': di := 1;
        'D': di := 2;
      end;
      if not CanMove(p, q, di) then
        begin
          Writeln;
          Writeln('Phep lan thu ', i, ' khong hop le!');
          Wrong;
        end;
      Write(c);
      Sum := Sum + 7 - State[q.code].B;
      p := q;
    end;
  if (p.x <> 1) and (p.x <> m) and (p.y <> 1) and (p.y <> n) then
    begin
      Writeln;
      Writeln('O ket thuc: (', p.x, ', ', p.y, ')');
      Writeln('Khong lan duoc ra bien!');
      Wrong;
    end;
  Writeln;
  Writeln('Trong so phep lan: ');
  Writeln('  + Dap an  : ', res);
  Writeln('  + Hoc sinh: ', Sum);
  if Sum > Res then
    begin
      Writeln('Khong toi uu!');
      Wrong;
    end;
  Writeln('Ket qua dung!');
  Correct;
end;

begin
  Clrscr;
  AskTest;
  Enter;
  GetIndex;
  DijkstraInit;
  DijkstraSolve;
  Result;
  Test;
end.

9 6 3 3
0 0 0 0 0 0
0 0 2 4 0 0
1 4 6 6 6 6
0 0 2 3 0 0
0 0 0 1 0 0
0 0 0 4 0 0
0 0 0 6 0 0
0 0 0 3 0 0
