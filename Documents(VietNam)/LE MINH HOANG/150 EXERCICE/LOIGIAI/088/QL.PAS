program ParallelProgramme;
const
 InputFile  = 'SOFTWARE.INP';
 OutputFile = 'SOFTWARE.OUT';
 maxN = 100;
 maxT = 50;
var
 p, c: array[1..maxN] of Integer;
 Tp, Tc: array[0..maxN] of Integer;
 Mark, Save: array[0..maxN] of Boolean;
 n, Best: Integer;

procedure Enter;
var
 f: Text;
 i: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do Read(f, p[i]);
 for i := 1 to n do
  begin
   Read(f, c[i]);
  end;
 Close(f);
end;

procedure Init;
begin
 Tp[0] := 0; Tc[0] := 0;
 Best := maxInt;
end;

procedure Result;
begin
 Save := Mark;
 if Tp[n] < Tc[n] then Best := Tc[n]
 else  Best := Tp[n];
end;

procedure Try(i: Integer);
begin
 Mark[i] := True;
 Tp[i] := Tp[i - 1] + p[i];
 Tc[i] := Tc[i - 1];
 if Tp[i] < Best then
  if i = n then Result
  else Try(i + 1);
 Mark[i] := False;
 Tc[i] := Tc[i - 1] + c[i];
 Tp[i] := Tp[i - 1];
 if Tc[i] < Best then
  if i = n then Result
  else Try(i + 1);
end;

procedure Print;
var
 i, j: Integer;
begin
 Writeln(Best);
 for i := 1 to n do  if Save[i] then Write(i, ' ');
 Writeln;
 for j := 1 to n do  if not Save[j] then Write(j, ' ');
 Writeln;
end;

begin
 Enter;
 Init;
 Try(1);
 Print;
end.
3
1 2 3
1 2 3
6
1 20 3 4 5 9
20 3 4 5 6 10
