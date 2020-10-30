{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Subtract;
uses crt;
const
 InputFile  = 'SUBTRACT.INP';
 OutputFile = 'SUBTRACT.OUT';
 max = 100;
var
 a: array[1.. max] of Integer;
 f: array[0..20000] of Integer;
 Sign: array[1..max] of ShortInt;
 n, t: Integer;

procedure Enter;
var
 f: Text;
 i: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, t);
 for i := 1 to n do Readln(f, a[i]);
 Close(f);
end;

procedure Optimize;
var
 S, M, i, j, k, x: Integer;
begin
 S := 0;
 for i := 1 to n do S := S + a[i];
 M := S + T - 2 * a[1];
 M := M div 2;
 F[0] := 0;
 for i := 1 to M do F[i] := MaxInt;
 for i := 1 to M do
  begin
   for j := n downto 3 do
    begin
     x := i - a[j];
     if (x >= 0) and (F[x] < j) and (j < F[i]) then F[i] := j;
    end;
  end;
 {Trace optimization}
 for k := 1 to n do Sign[k] := -1;
 i := M; j := n;
 while i <> 0 do
  begin
   x := F[i];
   Sign[x] := 1;
   i := i - a[x];
  end;
 Sign[1] := 1;
end;

procedure R(P: Integer);
begin
 a[P] := a[P] - a[P + 1];
 Move(a[P + 2], a[P + 1], (n - P - 1) * SizeOf(a[1]));
 Move(Sign[P + 2], Sign[P + 1], (n - P - 1) * SizeOf(Sign[1]));
 Dec(n);
end;

procedure Result;
var
 f: Text;
 t, i: Integer;
begin
 Assign(f, OutputFile); Rewrite(f);
 for t := n downto 2 do
  if (Sign[t] = -1) and (t < n) then
   while (t < n) and (Sign[t + 1] = 1) do
    begin
     Writeln(f, t);
     R(t);
    end;
 for t := 1 to n - 1 do Writeln(f, 1);
 Close(f);
end;

procedure SelfTest;
var
 f: Text;
 i, k: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, T);
 for i := 1 to n do Readln(F, a[i]);
 Close(f);
 Assign(f, OutputFile); Reset(f);
 for i := 1 to n - 1 do
  begin
   Readln(f, k);
   R(k);
  end;
 Writeln(a[1] = T);
 Close(f);
end;

begin
 Clrscr;
 Enter;
 Optimize;
 Result;
 SelfTest;
end.
7 15
5
6
7
1
2
3
5

4 5
10
2
5
2

4 -9
5
6
1
7
