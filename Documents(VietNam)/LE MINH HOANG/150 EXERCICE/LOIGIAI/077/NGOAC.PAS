{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
{uses ctest077, Crt;}
const
  fi = 'bracket s.inp';
  fo = 'brackets.out';
var
  d: array[1..20000] of Char;
  n, i, k, Last: Integer;
  f: Text;

begin
  Assign(f, fi); Reset(f);
  Readln(f, n);
  FillChar(d, n shl 1, ' ');
  Last := 1;
  for i := 1 to n do
  begin
    Read(f, k);
    while d[Last] <> ' ' do Inc(Last);
    d[Last] := '(';
    d[Last + k + 1] := ')';
    Inc(Last);
  end;
  Close(f);
  Assign(f, fo); Rewrite(f);
  for i := 1 to n shl 1 do Write(f, d[i]);
  Close(f);
end.