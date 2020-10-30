program RandomTest;
var
  name: array[1..1000] of String[3];
  t, r, i, j, n: Integer;
  f: Text;

function RandomS: String;
var
  S: String;
  i: Integer;
begin
  S := '';
  for i := 1 to 3 do S := S + Chr(Ord('A') + Random(26));
  RandomS := S;
end;

function Check(i: Integer): Boolean;
var
  j: Integer;
begin
  for j := 1 to i - 1 do
    if Name[j] = Name[i] then
      begin
        Check := False;
        Exit;
      end;
  Check := True;
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  for i := 1 to n do
    repeat
      name[i] := RandomS;
    until Check(i);
  Assign(f, 'SERIEA.IN4'); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do Writeln(f, Name[i]);
  r := 1;
  for i := 1 to n do
    for j := i + 1 to n do
      begin
        if Random(r) = 0 then
          Writeln(f, Name[i], ' ', Name[j], ' ', 1, ' ', 1);
        if Random(r) = 0 then
          Writeln(f, Name[j], ' ', Name[i], ' ', 1, ' ', 1);
      end;
  Close(f);
end.