{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program RandomTest;
const
  fi = 'flowers.inp';
  n = 200;
var
  i, j: Integer;
  f: Text;

begin
  Assign(f, fi); Rewrite(f);
  WriteLn(f, n);
  for i := 1 to n - 1 do
    for j := i + 1 to n do WriteLn(f, i, ' ', j);
  Close(f);
end.