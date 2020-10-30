program PaintTest;
type
 TRect = record
  x1, y1, x2, y2: Integer;
 end;

procedure Test1;
var
 f: Text;
 i: Byte;
begin
 Assign(f, 'PAINT.INP'); Rewrite(f);
 Writeln(f, 15);
 for i := 1 to 15 do
  Writeln(f, i, ' ', 0, ' ', i + 1, ' ', 10, ' ', i mod 2 + 1);
 Close(f);
end;

procedure GetRect(x1, y1, x2, y2: Integer; var r: TRect);
begin
 r.x1 := x1; r.y1 := y1;
 r.x2 := x2; r.y2 := y2;
end;

function Analyse(r: TRect; var r1, r2: TRect): Boolean;
var
 xdiv, ydiv: Integer;
begin
 case random(2) of
 1:
  if r.x1 + 1 < r.x2 then
   begin
    xdiv := r.x1 + random(r.x2 - r.x1 - 1) + 1;
    GetRect(r.x1, r.y1, xdiv, r.y2, r1);
    GetRect(xdiv, r.y1, r.x2, r.y2, r2);
    Analyse := True;
    Exit;
   end;
 0:
  if r.y1 + 1 < r.y2 then
   begin
    ydiv := r.y1 + random(r.y2 - r.y1 - 1) + 1;
    GetRect(r.x1, r.y1, r.x2, ydiv, r1);
    GetRect(r.x1, ydiv, r.x2, r.y2, r2);
    Analyse := True;
    Exit;
   end;
 end;
 Analyse := False;
end;

procedure Test3;
var
 f: Text;
 i, n, j: Byte;
 r: array[1..50] of TRect;
 r1, r2: TRect;
begin
 Assign(f, 'PAINT.INP'); Rewrite(f);
 Write('n = '); Readln(n);
 Writeln(f, n);
 GetRect(0, 0, 64, 48, r[1]);
 i := 1;
 repeat
  j := Random(i) + 1;
  if Analyse(r[j], r1, r2) then
   begin
    Inc(i);
    r[j] := r1;
    r[i] := r2;
   end;
 until i = n;
 for i := 1 to n do
  with r[i] do Writeln(f, x1, ' ', y1, ' ', x2, ' ', y2, ' ', Random(4) + 8);
 Close(f);
end;

begin
 randomize;
 Test1;
 Test3;
end.
