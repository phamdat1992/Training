{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program Sign;
uses crt;
const
 InputFile  = 'SIGN.IN';
 OutputFile = 'SIGN.OUT';
 dx: array[1..4] of ShortInt = (1, -1, 0, 0);
 dy: array[1..4] of ShortInt = (0, 0, 1, -1);
 maxC = 1000000001;
var
 c: array[0..51, 0..101] of LongInt;
 d: array[0..51, 0..101] of LongInt;
 Trace: array[0..51, 0..101] of Byte;
 Free: array[0..51, 0..101] of Boolean;

 m, n, p, PermanentX, PermanentY: Byte;

procedure Enter;
var
 f: Text;
 i, j: Byte;
 ch: Char;
begin
 Clrscr;
 Write('Cham test thu '); ch := Readkey; Writeln(ch);
 Assign(f, InputFile + ch); Reset(f);
 Readln(f, m, n, p);
 for i := 0 to m + 1 do
  for j := 0 to n + 1 do c[i, j] := maxC;
 for i := 1 to m do
  begin
   for j := 1 to n do Read(f, c[i, j]);
   Readln(f);
  end;
 Close(f);
end;

procedure Init;
var
 i, j: Byte;
begin
 for i := 0 to m + 1 do
  for j := 0 to n + 1 do d[i, j] := maxC;
 d[m, p] := c[m, p];
 FillChar(Free, SizeOf(Free), True);
 Free[m, p] := False;
 for i := 1 to n do
  if i <> p then
   begin
    d[m, i] := d[m, p] + c[m, i];
    Trace[m, i] := 0;
   end;
end;

procedure FindPermanent;
var
 i, j: Byte;
 Min: LongInt;
begin
 Min := MaxC;
 PermanentX := 0;
 for i := 1 to m do
  for j := 1 to n do
   if Free[i, j] and (d[i, j] < Min) then
    begin
     Min := d[i, j];
     PermanentX := i;
     PermanentY := j;
    end;
end;

procedure ChangeLabel;
var
 k: Byte;
 X, Y: Byte;
begin
 for k := 1 to 4 do
  begin
   X := PermanentX + dx[k]; Y := PermanentY + dy[k];
   if Free[X, Y] and (d[X, Y] > d[PermanentX, PermanentY] + c[X, Y]) then
    begin
     d[X, Y] := d[PermanentX, PermanentY] + c[X, Y];
     Trace[X, Y] := k;
    end;
  end;
end;

procedure Dijkstra;
begin
 repeat
  FindPermanent;
  if PermanentX = 1 then Break;
  Free[PermanentX, PermanentY] := False;
  ChangeLabel;
 until False;
end;

procedure Result;
var
 f: Text;
 r, count, i, x, y, s: LongInt;
begin
 Assign(f, OutputFile); Reset(f);
 Readln(f, r, count);
 Writeln('Chi phi: ', r = d[PermanentX, PermanentY]);
 s := 0;
 for i := 1 to count do
  begin
   Readln(f, x, y);
   s := s + c[x, y];
  end;
 Writeln('Duong di: ', s = r);
 Close(f);
end;

begin
 Enter;
 Init;
 Dijkstra;
 Result;
 Readln;
end.
