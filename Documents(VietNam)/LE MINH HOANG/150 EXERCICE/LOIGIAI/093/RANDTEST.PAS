{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program RandomTest;
const
  fi = 'circle.in1';
  n = 1000;
var
  i: Integer;
  f: Text;

begin
  Randomize;
  Assign(f, fi); Rewrite(f);
  WriteLn(f, n);
  for i := 1 to n do WriteLn(f, Random(10000), ' ', Random(10000));
  Close(f);
end.