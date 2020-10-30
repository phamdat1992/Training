{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
const
  fi = 'cp.inp';
  MaxN = 10000;
var
  Index, Eye, Count: array[1..MaxN] of Integer;
  i, j, k, n, m: Integer;
  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;
  f: Text;

procedure InitIndex;
var
  i: Integer;
begin
  for i := 1 to n do Index[i] := i;
end;

procedure InitCount;
var
  i, n1: Integer;
begin
  n1 := n;
  for i := 1 to m - 1 do
  begin
    Count[i] := Random(n1 div ((m - i + 1) div 2));
    Dec(n1, Count[i]);
  end;
  Count[m] := n1;
end;

begin
  OldTime := Time;
  Randomize;
  n := 10000;
  m := 1000;
  InitIndex;
  for i := 1 to m do
  begin
    k := Random(n - i + 1) + 1;
    Eye[i] := Index[k];
    Move(Index[k + 1], Index[k], (n - k) shl 1);
    Dec(n);
  end;
  InitCount;
  Assign(f, fi); Rewrite(f);
  Writeln(f, n + m);
  for i := 2 to m do Writeln(f, Eye[i], ' ', Eye[i - 1]);
  for i := 1 to m do
    for j := 1 to Count[i] do
    begin
      k := Random(n) + 1;
      Writeln(f, Eye[i], ' ', Index[k]);
      Move(Index[k + 1], Index[k], (n - k) shl 1 );
      Dec(n);
    end;
  Close(f);
  Writeln(Time - OldTime);
end.