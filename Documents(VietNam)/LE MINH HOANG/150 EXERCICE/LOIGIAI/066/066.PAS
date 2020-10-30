program Traffic;
const
 InputFile  = 'TRAFFIC.INP';
 OutputFile = 'TRAFFIC.OUT';
 max = 100;
 maxLong = 1000000000;
 dx: array[1..4] of ShortInt = (0, 1, -1, 0);
 dy: array[1..4] of ShortInt = (1, 0, 0, -1);
 Symbol: array[1..4] of Char = 'ESNW';
type
 TList = array[1..max * max] of Byte;
 PList = ^TList;
 TDistance = array[1..max, 1..max] of LongInt;
 PDistance = ^TDistance;
var
 a: array[1..max, 1..max] of Word;
 F: PDistance;
 Free: array[0..max + 1, 0..max + 1] of Boolean;
 Trace: array[1..max, 1..max] of Byte;
 ListX, ListY: PList;
 m, n, nList: Integer;

procedure Enter;
var
 f: Text;
 i, k, x, y: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, m, n);
 Readln(f, k);
 FillChar(a, SizeOf(a), 0);
 for i := 1 to k do Readln(f, x, y, a[x, y]);
 Close(f);
end;

procedure Update(x, y: Byte; d: Word);
var
 i: Integer;
begin
 if F^[x, y] <= d then Exit;
 if F^[x, y] = maxLong then
  begin
   Inc(nList);
   ListX^[nList] := x; ListY^[nList] := y;
  end;
 F^[x, y] := d;
end;

procedure GetPermanent(var x, y: Byte);
var
 i, imin: Integer;
begin
 imin := 1;
 for i := 1 to nList do
  if F^[ListX^[i], ListY^[i]] < F^[ListX^[imin], ListY^[imin]] then imin := i;
 x := ListX^[imin]; y := ListY^[imin];
 ListX^[imin] := ListX^[nList];
 ListY^[imin] := ListY^[nList];
 Dec(nList);
end;

procedure Init;
var
 i, j: Integer;
begin
 FillChar(Free, SizeOf(Free), False);
 for i := 1 to m do
  for j := 1 to n do Free[i, j] := True;
 New(F);
 for i := 1 to m do
  for j := 1 to n do F^[i, j] := maxLong;
 nList := 0;
 New(ListX); New(ListY);
 Update(1, 1, 0);
end;

function WaitTime(x, y, d: Byte; Time: Word): Word;
var
 SN, DirSN: Boolean;
begin
 if a[x, y] = 0 then WaitTime := 0
 else
  begin
   SN := Odd(Time div a[x, y]);
   DirSN := d in [2, 3];
   if DirSN = SN then WaitTime := 0
   else WaitTime := a[x, y] - Time mod a[x, y];
  end;
end;

procedure Dijkstra;
var
 xp, yp, x, y: Byte;
 dp: Word;
 d: Byte;
begin
 repeat
  GetPermanent(xp, yp);
  if (xp = m) and (yp = n) then Break;
  Free[xp, yp] := False;
  dp := F^[xp, yp] + 1;
  for d := 1 to 4 do
   begin
    x := xp + dx[d]; y := yp + dy[d];
    if Free[x, y] and (F^[x, y] > dp + WaitTime(x, y, d, dp)) then
     begin
      Update(x, y, dp + WaitTime(x, y, d, dp));
      Trace[x, y] := d;
     end;
   end;
 until False;
end;

procedure Result;
var
 Path: array[1..max * max] of Byte;
 x, y, i, j, nPath: Integer;
 Time: Word;
 d: Byte;
 fout: Text;
begin
 nPath := 0;
 x := m; y := n;
 repeat
  d := Trace[x, y];
  Inc(nPath); Path[nPath] := d;
  x := x - dx[d]; y := y - dy[d];
 until (x = 1) and (y = 1);
 Assign(fout, OutputFile); Rewrite(fout);
 Writeln(fout, F^[m, n]);
 Time := 0;
 for i := nPath Downto 1 do
  begin
   d := Path[i];
   Write(fout, Symbol[d]);
   Inc(Time);
   x := x + dx[d]; y := y + dy[d];
   for j := 1 to WaitTime(x, y, d, Time) do Write(fout, 'w');
   Time := Time + WaitTime(x, y, d, Time);
  end;
 Close(fout);
end;

begin
 Enter;
 Init;
 Dijkstra;
 Result;
end.
