program RandomTest;
var
  s: array[1..200] of string[25];
  i, n: Integer;
  max: Real;
  f: Text;

procedure RandomS(k: Integer);
var
  l, i, j: Integer;
  Stop: Boolean;
begin
  repeat
    l := 6 + Random(20);
    s[k] := '';
    for i := 1 to l do s[k] := s[k] + Chr(Ord('A') + Random(26));
    Stop := True;
    for j := 1 to k - 1 do
      if s[k] = s[j] then
        begin
          Stop := False;
          Break;
        end;
  until Stop;
end;

begin
  Write('n, max = '); Readln(n, max);
  for i := 1 to n do RandomS(i);
  Assign(Output, 'SCHOLAR.IN0'); Rewrite(Output);
  Writeln(n);
  for i := 1 to n do
    begin
      Writeln(S[i]);
      if Random(3) = 1 then Writeln(max:1:2)
      else Writeln(Random * max:1:2);
    end;
end.