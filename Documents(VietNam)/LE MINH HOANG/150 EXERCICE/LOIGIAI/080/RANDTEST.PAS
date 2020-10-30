program randomtest;
type
 TList = array[1..10000] of Integer;
var
 f: Text;
 Mark: array[-10000..10000] of Integer;
 c: array[1..10000] of Boolean;
 x, y: ^TList;
 i, j, n, r: Integer;
begin
 Randomize;
 FillChar(Mark, SizeOf(Mark), 0);
 New(x); New(y);
 Writeln('n chan la so diem xanh+do, r la ban kinh duong tron bao');
 Write('n, r = '); Readln(n, r);
 n := n div 2 * 2;
 for i := 1 to n do
  begin
   repeat
    j := Random(2 * r - 1) - r + 1;
   until Mark[j] < 3;
   x^[i] := j;
   case Mark[j] of
    0: if Random(2) = 1 then y^[i] := 1 else y^[i] := -1;
    1: y^[i] := -1;
    2: y^[i] := 1;
   end;
   case y^[i] of
    1: Mark[j] := Mark[j]  or 1;
    -1: Mark[j] := Mark[j] or 2;
   end;
  end;
 FillChar(c, SizeOf(c), True);
 for i := 1 to n div 2 do
  begin
   repeat
    j := Random(n) + 1;
   until c[j];
   c[j] := False;
  end;
 Assign(f, 'CHORDS.IN0'); Rewrite(f);
 Writeln(f, n div 2, ' ', r);
 for i := 1 to n do
  if c[i] then Writeln(f, 'R ', x^[i], ' ', y^[i])
  else Writeln(f, 'B ', x^[i], ' ', y^[i]);
 Close(f);
end.
