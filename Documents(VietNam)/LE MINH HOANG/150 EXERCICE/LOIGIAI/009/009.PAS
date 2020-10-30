program SubCircle;
const
 InputFile  = 'CIRCLE.INP';
 OutputFile = 'CIRCLE.OUT';
 max = 100;
type
 TArray = array[1..max] of Integer;
 PArray = ^TArray;
var
 Buffer: array[1..2 * max] of Integer;
 a: PArray;
 b, c: TArray;
 F: array[0..max, 0..max] of Integer;
 m, n, p, SaveStart: Integer;

procedure Enter;
var
 f: Text;
 i: Integer;
begin
 Assign(f,InputFile); Reset(f);
 Readln(f, m, n);
 for i := 1 to m do Readln(f, Buffer[i]);
 Move(Buffer[1], Buffer[m + 1], m * SizeOf(Buffer[1]));
 for i := 1 to n do Readln(f, b[i]);
 Close(f);
end;

function MaxV(x, y, z: Integer): Integer;
begin
 if x > y then
  begin
   if x > z then MaxV := x else MaxV := z;
  end
 else
  begin
   if y > z then MaxV := y else MaxV := z;
  end;
end;

function GetMaxCircle: Integer;
var
 i, j: Integer;
begin
 FillChar(F, SizeOf(F), 0);
 for i := 1 to m do
  for j := 1 to n do
   if a^[i] = b[j] then F[i, j] := F[i - 1, j - 1] + 1
   else F[i, j] := MaxV(F[i - 1, j - 1], F[i - 1, j], F[i, j - 1]);
 GetMaxCircle := F[m, n];
end;

procedure Solve;
var
 StartA, Long: Integer;
begin
 p := 0;
 for StartA := 1 to m do
  begin
   a := @Buffer[StartA];
   Long := GetMaxCircle;
   if Long > p then
    begin
     p := Long;
     SaveStart := StartA;
    end;
  end;
end;

procedure Trace;
var
 i, j, Count: Integer;
begin
 A := @Buffer[SaveStart];
 Count := GetMaxCircle;
 i := m; j := n;
 while Count <> 0 do
  if a^[i] = b[j] then
   begin
    c[Count] := b[j]; Dec(Count);
    Dec(i); Dec(j);
   end
  else
   if F[i, j] = F[i - 1, j - 1] then
    begin
     Dec(i); Dec(j);
    end
   else
    if F[i, j] = F[i - 1, j] then Dec(i)
    else Dec(j);
end;

procedure Result;
var
 f: Text;
 k: Integer;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, p);
 for k := 1 to p do Writeln(f, c[k]);
 Close(f);
end;

begin
 Enter;
 Solve;
 Trace;
 Result;
end.

8 7
1
2
3
4
5
6
7
8
2
4
6
8
1
2
3
