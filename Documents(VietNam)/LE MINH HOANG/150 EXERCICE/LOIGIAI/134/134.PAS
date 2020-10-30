{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program ScholarShip;
uses crt;
const
  InputFile  = 'SCHOLAR.IN0';
  OutputFile = 'SCHOLAR.OUT';
  max = 200;
type
  Real = Double;
  TStudent = record
    Name: string[25];
    Mark: Real;
  end;
  TList = array[1..max] of TStudent;
var
  a: TList;
  n, m, i: Integer;
  Threshold: Real;
  tmp: TStudent;

begin
  Assign(Input, InputFile); Reset(Input);
  Readln(n);
  ThresHold := -2E38; m := 0;
  for i := 1 to n do
    begin
      Readln(tmp.Name);
      Readln(tmp.Mark);
      if tmp.Mark > ThresHold then
        begin
          ThresHold := tmp.Mark;
          m := 1; a[1] := tmp;
        end
      else
        if tmp.Mark = ThresHold then
          begin
            Inc(m); a[m] := tmp;
          end;
    end;
  Assign(Output, OutputFile); Rewrite(Output);
  for i := 1 to m do Writeln(a[i].Name);
end.
4
a
7.9
b
9.0
c
8.1
d
9.0