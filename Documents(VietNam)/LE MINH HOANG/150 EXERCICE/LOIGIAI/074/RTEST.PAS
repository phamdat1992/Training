{$A+,B-,D-,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
program Randomtest;
const
 InputFile: String = '.INP';
 na: array[0..19] of Integer =
 (10, 20, 30, 40, 50, 80, 100, 140, 200, 300,
 333, 400, 500, 555, 600, 700, 800, 900, 999, 1000);
 ca: array[0..19] of Integer =
 (1, 2, 3, 4, 5, 6, 6, 7, 5, 4,
 10, 11, 12, 13, 14, 15, 16, 17, 18, 19);
 Bit: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);
 max = 1000;

type
 TLine = array[0..1000 div 8] of Byte;
 PLine = ^TLine;
var
 a: array[1..1000] of PLine;
 S: String;
 i, t: Integer;
 fi: Text;
 L: array[1..1000] of Integer;
 Fix: array[1..20] of set of Byte;
 Index: array[1..1000] of Integer;

function Rn(a, b: Integer): Integer;
begin
 Rn := Random(b - a + 1) + a;
end;

procedure Put(i, j: Integer);
begin
 a[i]^[j shr 3] := a[i]^[j shr 3] or Bit[j and 7];
end;

procedure Save(n: Integer; Filename: String);
var
 i, j: Integer;
 c: Integer;
begin
 FillChar(Index, SizeOf(Index), 0);
 for i := 1 to n do
  begin
   repeat
    j := Rn(1, n);
   until Index[j] = 0;
   Index[j] := i;
  end;
 c := 0;
 for i := 1 to n do
  for j := i + 1 to n do
   if a[i]^[j shr 3] and Bit[j and 7] <> 0 then Inc(c);
 Assign(fi, Filename); Rewrite(fi);
 Writeln(fi, n, ' ', c);
 for i := 1 to n do
  for j := i + 1 to n do
   if a[i]^[j shr 3] and Bit[j and 7] <> 0 then
    Writeln(fi, Index[i], ' ', Index[j]);
 Close(fi);
end;

procedure Create(n, c: Integer);
var
 m, i, k, j, tcount: Integer;
begin
 for i := 1 to 1000 do FillChar(a[i]^, SizeOf(a[i]^), 0);
 for i := c + 1 to n do L[i] := Rn(1, c * 5);
 for i := 1 to c do
  begin
   Fix[i] := [i];
   for j := c + 1 to c * 5 do
   if Random(3) = 1 then Fix[i] := Fix[i] + [j];
  end;
 m := n * 20;
 if m > 10000 then m := 10000;
 for k := 1 to m do
  begin
   tcount := 0;
   repeat
    Inc(tcount);
    i := Rn(1, n); j := Rn(1, n);
    if i > j then Continue;
    if (i <= c) and (j <= c) then Continue;
    if (i <= c) and not (L[j] in Fix[i]) then Continue;
    if (i > c) and (j > c) and (L[i] <> L[j]) then Continue;
    Put(i, j);
    Break;
   until (tcount > 5555);
   if tcount > 5555 then Break;
  end;
end;

procedure Save2(n: Integer; Filename: String);
var
 i, j: Integer;
begin
 Assign(fi, Filename); Rewrite(fi);
 Writeln(fi, n, ' ', n * (n - 1) div 2);
 for i := 1 to n do
  if i <= n div 2 then Index[i] := n div 2 - i + 1
  else Index[i] := i;
 for i := 1 to n do
  for j := i + 1 to n do Writeln(fi, Index[i], ' ', Index[j]);
 Close(fi);
end;

procedure Save3(n: Integer; Filename: String);
var
 i, j: Integer;
begin
 Assign(fi, Filename); Rewrite(fi);
 Writeln(fi, n, ' ', n - 1);
 for i := 1 to n - 1 do Writeln(fi, i, ' ', i + 1);
 Close(fi);
end;

function GetName(t: Integer): String;
begin
 GetName := Chr(t div 10 + 48) + Chr(t mod 10 + 48);
end;

begin
 Randomize;
 for i := 1 to 1000 do New(a[i]);
 for t := 0 to 19 do
  begin
   S := GetName(t);
   Writeln(s + InputFile);
   case t of
    0..16, 19:
     begin
      Create(na[t], ca[t]);
      Save(na[t], S + InputFile);
     end;
    17: Save2(140, s + InputFile);
    18: Save3(999, s + InputFile);
   end;
  end;
end.