{$A+,B-,D+,E-,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 65520,0,655360}
program HardTestCreator;
const
 dx: array[1..8] of Integer = (1, -1, 1, -1, 2, -2, 2, -2);
 dy: array[1..8] of Integer = (2, 2, -2, -2, 1, 1, -1, -1);
var
 a: array[-1..102, -1..102] of Word;
 b: array[-1..102, -1..102] of Char;
 m: Integer;

procedure Init;
var
 i, j: Integer;
begin
 FillChar(a, SizeOf(a), $FF);
 for i := 1 to 100 do
  for j := 1 to 100 do a[i, j] := 0;
 m := 0;
end;

function Check(x, y, i: Integer): Boolean;
var
 d: Integer;
 nx, ny: Integer;
begin
 if a[x, y] <> 0 then
  begin
   Check := False;
   Exit;
  end;
 for d := 1 to 8 do
  begin
   nx := x + dx[d]; ny := y + dy[d];
   if a[nx, ny] = $FFFF then Continue;
   if (a[nx, ny] <> 0) and (a[nx, ny] <> i - 1) then
    begin
     Check := False; exit;
    end;
  end;
 Check := True;
end;

procedure Save;
var
 f: Text;
 i, j, m1, m2: Integer;
begin
 assign(f, 'HORSES.INP'); Rewrite(f);
 Writeln(f, 100);
 for i := 1 to 100 do
  for j := 1 to 100 do
    if a[i, j] = 0 then b[i, j] := 'C'
    else b[i, j] := '.';

 m1 := 0; m2 := 0;
 for i := 1 to 100 do
  for j := 1 to 100 do
   if a[i, j] <> 0 then
    begin
     if a[i, j] <= 100 then
      begin
       Inc(m1); b[i, j] := 'S';
      end;
     if m - a[i, j] + 1 <= 100 then
      begin
       Inc(m2); b[i, j] := 'D';
      end;
    end;
 for i := 1 to 100 do
  begin
   for j := 1 to 100 do Write(f, b[i, j]);
   Writeln(f);
  end;
 Close(f);
end;

procedure Try(x, y: Integer);
var
 d: Integer;
begin
 if a[x, y] > m then
  begin
   m := a[x, y];
   Write(m:5);
   if m > 2500 then Save;
  end;
 for d := 1 to 8 do
  if Check(x + dx[d], y + dy[d], a[x, y] + 1) then
   begin
    a[x + dx[d], y + dy[d]] := a[x, y] + 1;
    Try(x + dx[d], y + dy[d]);
    a[x + dx[d], y + dy[d]] := 0;
   end;
end;

begin
 Init;
 a[40, 80] := 1;
 Try(40, 80);
end.
