program Mine_Sweeper;
uses crt;
const
 max = 120;
 InputFile  = 'MINE.INP';
 OutputFile = 'MINE.OUT';
type
 TBoard = array[0..max + 1, 0..max + 1] of ShortInt;
var
 Map: TBoard;
 Density: array[0..1] of TBoard;
 nCount: TBoard; {nCount[i, j] la so o ke o (i, j) trong ban do : hop le
                  € tat nhien}
 m, n: Byte; {okie}
 Found: Boolean;
 Time: LongInt absolute $0000:$046C;{okie}
 OldTime: LongInt;       {okie}

procedure Enter;
var
 f: Text;
 i, j: Byte;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, m, n);
 for i := 1 to m do
  begin
   for j := 1 to n do Read(f, Density[1][i, j]);
   Readln(f);
  end;
 Close(f);
end;

{Ham nay dem so o ke voi o (x, y) trong ban do}
function NeighbourCount(X, Y: Byte): Byte;
var
 i, j, k: Byte;
begin
 k := 0;
 for i := X - 1 to X + 1 do
  for j := Y - 1 to Y + 1 do
   if (Map[i, j] <> $F) and ((i <> X) or (j <> Y)) then Inc(k);
 NeighbourCount := k;
end;

procedure Init;
var
 i, j: Byte;
begin
 for i := 0 to m + 1 do
  for j := 0 to n + 1 do
   if (i > 0) and (i <= m) and (j > 0) and (j <= n) then Map[i, j] := 2
   else Map[i, j] := $F;
 for i := 1 to m do
  for j := 1 to n do
   begin
    nCount[i, j] := NeighBourCount(i, j);
    Density[0][i, j] := nCount[i, j] - Density[1][i, j];
   end;
 Found := False;
end;

function Put(X, Y, V: Byte): Boolean;
var
 i, j: Byte;
 b: Boolean;
begin
 Map[X, Y] := V;
 b := True;
 for i := X - 1 to X + 1 do
  for j := Y - 1 to Y + 1 do
   if (Map[i, j] <> $F) and ((i <> X) or (j <> Y)) then
    begin
     Dec(Density[V][i, j]);
     b := b and (Density[V][i, j] >= 0)
    end;
 Put := b;
end;

procedure Leave(X, Y: Byte);
var
 i, j: Byte;
 V: Byte;
begin
 V := Map[X, Y];
 for i := X - 1 to X + 1 do
  for j := Y - 1 to Y + 1 do
   if (Map[i, j] <> $F) and ((i <> X) or (j <> Y)) then
     Inc(Density[V][i, j]);
 Map[X, Y] := 2;
end;

function Fill(Row: Byte): Byte;
var
 j, v: Byte;
begin
 for j := 2 to n do
  begin
   if Density[1][Row - 1, j - 1] = 1 then v := 1
   else v := 0;
   if not Put(Row, j, v) then
    begin
     Fill := j;
     Exit;
    end;
  end;
 Fill := 0;
end;

procedure Restore(Row: Byte);
var
 j: Byte;
begin
 for j := n downto 2 do
  if Map[Row, j] <> 2 then Leave(Row, j);
end;

procedure TryCol(Row: Byte);
var
 k: Byte;
begin
 for k := 0 to 1 do
  begin
   if Put(Row, 1, k) then
    begin
     if Fill(Row) = 0 then
      if Row = m then Found := True
      else TryCol(Row + 1);
      if Found then Exit;
     Restore(Row);
    end;
   Leave(Row, 1);
  end;
end;

procedure RowGenerated;
var
 X: array[1..max] of Byte;
 ECode, i, j: Byte;

 function Check: Byte;
  var
   i, t: Byte;
   ECode: Byte;
  begin
   for i := 1 to n do
    if not Put(1, i, X[i]) then
     begin
      Check := i; Exit;
     end;
   ECode := 0;
   for i := 0 to 1 do
    begin
     if Put(2, 1, i) then
      begin
       t := Fill(2);
       {Cho nay phai can than; minh lam nhung minh cung thay ky di}
       if t = 0 then t := n + 1
       else
        begin
         Inc(t, 2);
         if t > n then t := n;
        end;
       if ECode < t then ECode := t;
       Restore(2);
      end;
     Leave(2, 1);
    end;
   if ECode = 0 then ECode := 3; {Neu khong co cach dat vao (2, 1) }
   Check := ECode;
  end;
begin
 FillChar(X, n, 0);
 repeat
  ECode := Check;
  if ECode = n + 1 then
   begin
    TryCol(2);
    if Found then Exit;
    ECode := n;
   end;
  i := ECode;
  while (X[i] = 1)  do Dec(i);
  X[i] := 1;
  FillChar(X[i + 1], n - i, 0);
  Restore(1);
  Leave(1, 1);
  if (Time - OldTime) > 600 then exit;
 until False;
end;

procedure PrintResult;
var
 i, j: Byte;
 f: Text;
 c: Word;
begin
 Assign(f, OutputFile); Rewrite(f);
 c := 0;
 for i := 1 to m do
  for j := 1 to n do
   if Map[i, j] = 1 then Inc(C);
 Writeln(f, c);
 for i := 1 to m do
  begin
   for j := 1 to n do Write(f, Map[i, j], ' ');
   Writeln(f);
  end;
 Close(f);
end;

function MineCount(X, Y: Byte): Byte;
var
 i, j, k: Byte;
begin
 k := 0;
 for i := X - 1 to X + 1 do
  for j := Y - 1 to Y + 1 do
   if (Map[i, j] = 1) and ((i <> X) or (j <> Y)) then Inc(k);
 MineCount := k;
end;

procedure CheckResult;
var
 i, j: Byte;
 b: Boolean;
begin
 Enter;
 b := True;
 for i := 1 to m do
  for j := 1 to n do
   B := B and (MineCount(i, j) = Density[1][i, j]);
 Writeln(B);
{ if not B then
  repeat
  until Keypressed;}
end;

begin
 Writeln('MINE SWEEPER');
 OldTime := Time;
 Enter;
 Init;
 RowGenerated;
 PrintResult;
 Writeln((Time - OldTime) / 18.2 : 1 : 2);
 CheckResult;
end.
