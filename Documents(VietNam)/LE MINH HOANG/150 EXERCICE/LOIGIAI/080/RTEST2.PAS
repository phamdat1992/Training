var
 i: Integer;
 f: Text;
begin
 Assign(f, 'CHORDS.IN9'); Rewrite(f);
 Writeln(f, 4500);
 for i := 1 to 4500 do
  begin
   Writeln(f, 'R ', i - 2250, ' ', 1);
   Writeln(f, 'B ', i - 2250, ' ', -1);
  end;
 Close(f);
end.
