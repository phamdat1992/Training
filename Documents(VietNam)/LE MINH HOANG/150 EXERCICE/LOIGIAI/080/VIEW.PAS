{$N+,E+}
program View;
uses crt, graph;
const
 InputFile  = 'CHORDS.INP';
 OutputFile = 'CHORDS.OUT';
 max = 10000;
 IRadius = 230;
var
 x, y: array[1..max] of Integer;
 Color: array[1..max] of Char;
 gd, gm: Integer;
 n: Integer;
 maxX: Integer;
 r: Real;

procedure Enter;
var
 f: Text;
 ch: Char;
 px, py, i, radius: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n); n := n shl 1;
 maxX := 0;
 for i := 1 to n do
  begin
   Readln(f, Color[i], x[i], y[i]);
   if Abs(x[i]) > maxX then maxX := Abs(x[i]);
  end;
 Close(f);
 Inc(maxX);
 r := Iradius / maxX;
 for i := 1 to n do
  begin
   x[i] := Round(x[i] * r);
   y[i] := -y[i] * Round(Sqrt(Sqr(IRadius + 0.0) - Sqr(x[i] + 0.0)));
  end;
end;

procedure Draw;
var
 f: Text;
 i, i1, i2, c: Integer;
begin
 gd := 0;
 InitGraph(gd, gm, 'd:\dayhoc');
 SetBKColor(3);
 SetViewPort(320, 240, 321, 241, False);
 SetColor(1);
 Line(-320, 0, 320, 0); Line(0, -240, 0, 240);
 Circle(0, 0, Iradius);
 SetColor(10);
 Assign(f, OutputFile); Reset(f);
 for i := 1 to n div 2 do
  begin
   Readln(f, i1, i2);
   Line(x[i1], y[i1], x[i2], y[i2]);
  end;
 Close(f);
 for i := 1 to n do
  begin
   if Color[i] = 'B' then c := 9 else c := 12;
   SetColor(c); SetFillStyle(1, c);
   PieSlice(x[i], y[i], 0, 360, 2);
  end;
end;

begin
 Enter;
 Draw;
 Readln;
end.
