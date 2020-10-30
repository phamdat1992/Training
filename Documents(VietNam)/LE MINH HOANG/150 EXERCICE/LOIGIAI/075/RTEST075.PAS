program RandomTestCreator;
const
 InputFile = 'HORSES.IN';
 na: array[1..10] of Integer = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100);
 ka: array[1..10] of Integer = (9, 19, 29, 39, 49, 59, 69, 100, 100, 99);
 ca: array[1..10] of Integer = (20, 40, 60, 80, 100, 120, 0, 160, 180, 200);
 S: String = '1234567890';
var
 f: Text;
 a: array[1..100, 1..100] of Char;
 i, x, y: Integer;

procedure Create(n, k, c: Integer);
var
 i, j, t: Integer;
 ch: Char;
 x1, y1, x2, y2: Integer;
begin
 FillChar(a, SizeOf(a), '.');
 i := 1; j := 1;
 t := k;
 while t <> 0 do
  begin
   a[i, j] := 'S';
   if j = n then
    begin
     Inc(i); j := 1;
    end
   else Inc(j);
   Dec(t);
  end;
 t := k;
 while t <> 0 do
  begin
   a[i, j] := 'D';
   if j = n then
    begin
     Inc(i); j := 1;
    end
   else Inc(j);
   Dec(t);
  end;
 t := c;
 while t <> 0 do
  begin
   a[i, j] := 'C';
   if j = n then
    begin
     Inc(i); j := 1;
    end
   else Inc(j);
  Dec(t);
  end;
 for t := 1 to 10000 do
  begin
   x1 := Random(n) + 1; y1 := Random(n) + 1;
   x2 := Random(n) + 1; y2 := Random(n) + 1;
   ch := a[x1, y1]; a[x1, y1] := a[x2, y2]; a[x2, y2] := ch;
  end;
end;

begin
 Randomize;
 for i := 1 to 10 do
  begin
   Writeln(InputFile + S[i]);
   Create(na[i], ka[i], ca[i]);
   Assign(f, InputFile + S[i]); Rewrite(f);
   Writeln(f, na[i]);
   for x := 1 to na[i] do
    begin
     for y := 1 to na[i] do Write(f, a[x, y]);
     Writeln(f);
    end;
   Close(f);
  end;
end.
