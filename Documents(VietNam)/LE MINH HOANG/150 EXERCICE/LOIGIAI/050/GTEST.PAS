program GTest;
uses crt, graph;
var
 gd, gm, i, j: Integer;
 m, n, k: Integer;
 f: Text;

procedure RandomRect;
var
 c, x1, y1, x2, y2: Integer;
begin
 x1 := Random(m); y1 := Random(n);
 x2 := x1 + Random(m - x1 + 1); y2 := y1 + Random(n - y1 + 1);
 if Random(2) = 1 then c := 1 else c := 14;
 SetColor(c); SetFillStyle(1, c);
 Bar(x1, y1, x2, y2);
end;

procedure RandomCircle;
var
 c, r: Integer;
begin
 if Random(2) = 1 then c := 1 else c := 14;
 SetColor(c); SetFillStyle(1, c);
 if m < n then r := m div 5 else r := n div 5;
 r := Random(r);
 Pieslice(Random(m), Random(n), 0, 360, r);
end;

begin
 Randomize;
 Write('m, n, k = '); readln(m, n, k);
 gd := 0;
 Initgraph(gd, gm, 'd:\dayhoc');
 for i := 1 to k do
   if Random(2) > 2 then RandomRect
   else RandomCircle;
 Assign(f, 'SQUARE.IN9'); Rewrite(f);
 Writeln(f, m, ' ', n);
 for i := 1 to m do
  begin
   for j := 1 to n do
    begin
      if GetPixel(i, j) = 14 then Write(f, '1 ')
      else Write(f, '0 ');
      PutPixel(i, j, 2);
    end;
   Writeln(f);
  end;
 Close(f);
end.
