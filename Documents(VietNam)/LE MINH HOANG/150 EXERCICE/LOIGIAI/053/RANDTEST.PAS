program MapRandomTest;
const
 dx: array[1..4] of ShortInt = (1, 0, 0, -1);
 dy: array[1..4] of ShortInt = (0, -1, 1, 0);
 Dirs: String = 'ESNW';
var
 f: Text;
 i, n, d: Integer;
 x, y, newX, newY: Integer;
begin
 Randomize;
 Write('So buoc: '); Readln(n);
 for i := 1 to n do
 Assign(f, 'MAP.INP'); Rewrite(f);
 x := 0;
 y := 0;
 for i := 1 to n do
  begin
   d := Random(4) + 1;
   NewX := x + dx[d]; NewY := y + dy[d];
   if (Abs(NewX) < 32) and (Abs(NewY) < 24) then
    begin
     x := NewX; Y := NewY;
     Write(f, Dirs[d]);
    end;
  end;
 Close(f);
end.
