{
Random Test:
Sinh ra mot day k hinh tron
- Nhung o co goc tren trai thuoc mot hinh tron nao do duoc danh so 1
- Nhung o khac danh so 0
Muc dich: Tao ra cac mien lien thong tuong doi lon
}
program SquareRandomTest;
var
 f: Text;
type
 TCircle = record
  x, y, r: LongInt;
 end;
var
 Circles: array[1..5000] of TCircle;
 m, n, t, k, i, j: Integer;

function Check(x, y: LongInt): Byte;
var
 i: Integer;
begin
 for i := 1 to k do
  if sqr(x - Circles[i].x) + sqr(y - Circles[i].y) < sqr(Circles[i].r) then
   begin
    Check := 1; Exit;
   end;
 Check := 0;
end;

begin
 Randomize;
 Write('m, n, so hinh tron k: '); Readln(m, n, k);
 if m > n then t := n else t := m;
 for i := 1 to k do
  with Circles[i] do
   begin
    x := Random(m); y := Random(n);
    r := Random(t div 4) + 1;
   end;
 Assign(f, 'SQUARE.IN0'); Rewrite(f);
 Writeln(f, m, ' ', n);
 for i := 1 to m do
  begin
   for j := 1 to n do Write(f, Check(i, j), ' ');
   Writeln(f);
  end;
 Close(f);
end.
