uses Graph;
var
 gd, gm: Integer;
 f: Text;
 i, j: Integer;
begin
 gd := 0;
 initgraph(gd, gm, 'd:\dayhoc');
 SetTextStyle(0, 0, 2);
 OuttextXY(0, 0, 'MW');
 OuttextXY(0, 12, '--');
 Assign(f, 'TL.IN0'); Rewrite(f);
 Writeln(f, '30 30');
 Writeln(f, 'O');
 for i := 1 to 30 do
  begin
   for j := 1 to 30 do
    if GetPixel(j, i) = 15 then Write(f, 'O')
    else Write(f, 'I');
   Writeln(f);
  end;
 Close(f);
 readln;
end.
