program TheLifts;
const
 InputFile  = 'LMOVE.INP';
 OutputFile = 'LMOVE.OUT';
 n = 100;
 maxD = 1000000;
type
 TDistance = Real;
var
 E, W: array[0..2] of TDistance;
 T: TDistance;
 d: array[-10..n + 10, 0..2] of TDistance; {0: di bo, 1: thang I, 2: thang II}
 Free: array[0..n, 0..2] of Boolean;
 X, Y: Integer;

procedure Enter;
var
 f: Text;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, E[1], W[1]);
 Readln(f, E[2], W[2]);
 Readln(f, E[0]); W[0] := 0;
 Readln(f, X, Y);
 Close(f);
end;

procedure Init;
var
 i, j: Integer;
begin
 FillChar(Free, SizeOf(Free), True);
 for i := 0 to n do
  for j := 0 to 2 do d[i, j] := maxD;
 d[x, 0] := 0;
end;

procedure FindPermanent(var layer, lift: Integer);
var
 i, j: Integer;
 minD: TDistance;
begin
 minD := maxD;
 for i := 0 to n do
  for j := 0 to 2 do
   if Free[i, j] and (d[i, j] < minD) then
    begin
     minD := d[i, j];
     Layer := i;
     Lift := j;
    end;
end;

function Min(a, b: TDistance): TDistance;
begin
 if a < b then Min := a else Min := b;
end;

procedure ChangeLabel(layer, lift: Integer);
var
 l: Integer;
begin
 for l := 0 to 2 do {Chuyen cach di}
  if Free[layer, l] then
    d[layer, l] := Min(d[layer, l], d[layer, lift] + W[l]);
 if lift < 2 then {Di tiep bang phuong tien lift}
  begin
   d[layer - 1, lift] := Min(d[layer - 1, lift], d[layer, lift] + E[lift]);
   d[layer + 1, lift] := Min(d[layer + 1, lift], d[layer, lift] + E[lift]);
  end
 else {lift = 2}
  if layer mod 10 = 0 then
   begin
    d[layer - 10, 2] := Min(d[layer - 10, 2], d[layer, 2] + E[2]);
    d[layer + 10, 2] := Min(d[layer + 10, 2], d[layer, 2] + E[2]);
   end;
end;

procedure Dijkstra;
var
 layer, lift: Integer;
begin
 repeat
  FindPermanent(layer, lift);
  if layer = y then Break;
  Free[layer, lift] := False;
  ChangeLabel(layer, lift);
 until False;
 T := d[layer, lift];
end;

procedure Result;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 if Frac(T) = 0 then Writeln(f, T:1:0)
 else Writeln(f, T);
 Close(f);
end;

begin
 Enter;
 Init;
 Dijkstra;
 Result;
end.
