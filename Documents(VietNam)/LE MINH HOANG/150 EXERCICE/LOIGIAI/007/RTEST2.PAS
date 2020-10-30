var
  f: Text;
  i, j: Integer;
begin
  Assign(f, 'FRIEND.IN8'); Rewrite(f);
  Writeln(f, 100, ' ', 50 * 99);
  Writeln(f, '1 99 2 98');
  for i := 1 to 100 do
    for j := i + 1 to 100 do
      Writeln(f, i, ' ', j, ' ', Random(1000) + 1);
  Close(f);
end.