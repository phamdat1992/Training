var
 f, g: Text;
 l: LongInt;
begin
 Assign(f, 'BOTTLES.INP'); Reset(f);
 Assign(g, 'BOTTLES.IN2'); Rewrite(g);
 repeat
  Read(f, l);
  Writeln(g, l);
 until Seekeof(f);
 Close(f);
 Close(g);
end.
