program Area;
uses crt;
const
 InputFile  = 'SZERO.IN';
 OutputFile = 'SZERO.OUT';
 max = 100;
 dx: array[1..4] of ShortInt = (1, -1, 0, 0);
 dy: array[1..4] of ShortInt = (0, 0, 1, -1);
var
 a: array[0..max + 1, 0..max + 1] of Char;
 Queue: array[1..max * max, 1..2] of ShortInt;
 m, n, First, Last, Count: Integer;
 ch: Char;

procedure InitQueue;
begin
 First := 1; Last := 0;
end;

procedure Push(x, y: ShortInt);
begin
 Inc(Last);
 Queue[Last, 1] := x; Queue[Last, 2] := y;
end;

procedure Pop(var x, y: ShortInt);
begin
 x := Queue[First, 1]; y := Queue[First, 2];
 Inc(First);
end;

procedure Enter;
var
 f: Text;
 i, j: Integer;
begin
 Clrscr;
 Writeln('                         CHAM BAI TINH DIEN TICH');
 Writeln('                         ßßßßßßßßßßßßßßßßßßßßßßß');
 Write('                         Test SZERO.IN'); ch := Readkey; Writeln(ch);
 FillChar(a, SizeOf(a), 1);
 Assign(f, InputFile + ch); Reset(f);
 Readln(f, m, n);
 for i := 0 to m + 1 do
  begin
   a[i, 0] := '1'; a[i, n + 1] := '1';
  end;
 for j := 0 to n + 1 do
  begin
   a[0, j] := '1'; a[m + 1, j] := '1';
  end;
 for i := 1 to m do
  begin
   for j := 1 to n do Read(f, a[i, j]);
   Readln(f);
  end;
 Close(f);
end;

procedure Init;
var
 i, j: Integer;
begin
 for i := 1 to m do
  begin
   if a[i, 1] = '0' then
    begin
     a[i, 1] := '.'; Push(i, 1);
    end;
   if a[i, n] = '0' then
    begin
     a[i, n] := '.'; Push(i, n);
    end;
  end;
 for j := 1 to n do
  begin
   if a[1, j] = '0' then
    begin
     a[1, j] := '.'; Push(1, j);
    end;
   if a[m, j] = '0' then
    begin
     a[m, j] := '.'; Push(m, j);
    end;
  end;
end;

procedure BreadthFirstSearch;
var
 x, y, NewX, NewY, d: ShortInt;
begin
 repeat
  Pop(x, y);
  for d := 1 to 4 do
   begin
    NewX := x + dx[d]; NewY := y + dy[d];
    if a[NewX, NewY] = '0' then
     begin
      a[NewX, NewY] := '.';
      Push(NewX, NewY);
     end;
   end;
 until First > Last;
end;

procedure Test;
var
 i, j, c, cout: Integer;
 f: Text;
 p: Integer;
begin
 Writeln;
 c := 0;
 for i := 1 to m do
  for j := 1 to n do
   if a[i, j] = '0' then Inc(c);
 Assign(f, OutputFile); Reset(f);
 Readln(f, cout);
 Close(f);
 if cout = c then
  begin
   Writeln('Correct: ');
   p := 1;
  end
 else
  begin
   Writeln('Error: ');
   p := 0;
  end;
 Writeln('Ket qua dung        : ', c);
 Writeln('Ket qua cua hoc sinh: ', cout);
 Writeln;
 Writeln;
 TextAttr := 78;
 Writeln('Diem: ', p);
 TextAttr := 7;
 Writeln;
 Assign(f, 'BIENBAN.TXT');
 if ch = '1' then Rewrite(f) else Append(f);
 Writeln(f, 'Diem cho test SZERO.IN', ch, ': ', p);
 Close(f);
end;

begin
 InitQueue;
 Enter;
 Init;
 BreadthFirstSearch;
 Test;
 Readln;
end.
