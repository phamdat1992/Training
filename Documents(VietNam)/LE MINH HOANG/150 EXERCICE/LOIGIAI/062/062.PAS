program Area;
const
 InputFile  = 'SZERO.INP';
 OutputFile = 'SZERO.OUT';
 max = 100;
 dx: array[1..4] of ShortInt = (1, -1, 0, 0);
 dy: array[1..4] of ShortInt = (0, 0, 1, -1);
var
 a: array[0..max + 1, 0..max + 1] of Char;
 Queue: array[1..max * max, 1..2] of ShortInt;
 m, n, First, Last, Count: Integer;

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
 FillChar(a, SizeOf(a), 1);
 Assign(f, InputFile); Reset(f);
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

procedure Result;
var
 i, j, c: Integer;
 f: Text;
begin
 Writeln;
 c := 0;
 for i := 1 to m do
  begin
   for j := 1 to n do
    begin
     if a[i, j] = '0' then Inc(c);
     Write(a[i, j]:2);
    end;
   Writeln;
  end;
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, c);
 Close(f);
end;

begin
 InitQueue;
 Enter;
 Init;
 BreadthFirstSearch;
 Result;
end.
