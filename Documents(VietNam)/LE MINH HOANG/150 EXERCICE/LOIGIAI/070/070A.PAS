program Assignment;
const
 InputFile  = 'ASSIGN.IN5';
 OutputFile = 'ASSIGN.OUT';
 maxM = 100;
 maxN = 500;
var
 a: array[1..maxM, 1..maxN] of Boolean; {a[i, j] <=> nguoi i lam duoc viec j}
 match: array[1..maxN] of Integer; {match[j] = nguoi phan cong lam viec j}
 Queue: array[1..maxN] of Integer;
 Trace: array[1..maxM] of Integer;
 deg: array[1..maxM] of Integer; {deg[i] = so viec phan cho nguoi i}
 n, m, First, Last: Integer;

procedure Enter;
var
 f: Text;
 i, j: Integer;
begin
 FillChar(a, SizeOf(a), False);
 Assign(f, InputFile); Reset(f);
 Readln(f, m, n);
 for i := 1 to m do
  begin
   repeat
    Read(f, j);
    if j <> 0 then a[i, j] := True;
   until j = 0;
   Readln(f);
  end;
 Close(f);
end;

procedure InitMatch;
begin
 FillChar(match, SizeOf(match), 0);
 FillChar(deg, SizeOf(deg), 0);
end;

procedure InitQueue;
begin
 First := 0;
 Last := 0;
end;

procedure Push(V: Integer);
begin
 Inc(Last); Queue[Last] := V;
end;

function Pop:Integer;
begin
 Inc(First);
 Pop := Queue[First];
end;

function QueueEmpty: Boolean;
begin
 QueueEmpty := First = Last;
end;

function FindAugmentingPath(StartY, Time: Integer): Integer;
var
 x, y, nexty: Integer;
begin
 FillChar(Trace, SizeOf(Trace), 0);
 InitQueue; Push(StartY);
 repeat
  y := Pop;
  for x := 1 to m do
   if (Trace[x] = 0) and a[x, y] and (match[y] <> x) then
    begin
     Trace[x] := y;
     if deg[x] < Time then
      begin
       FindAugmentingPath := x;
       Exit;
      end;
     for nexty := 1 to n do
      if match[nexty] = x then Push(nexty);
    end;
 until QueueEmpty;
 FindAugmentingPath := 0;
end;

procedure Enlarge(f: Integer);
var
 y, next: Integer;
begin
 Inc(deg[f]);
 repeat
  y := Trace[f];
  next := match[y];
  match[y] := f;
  f := next;
 until f = 0;
end;

function FindMatch(Time: Integer): Boolean;
var
 k, p: Integer;
begin
 InitMatch;
 for k := 1 to n do
  begin
   p := FindAugmentingPath(k, Time);
   if p = 0 then
    begin
     FindMatch := False;
     Exit;
    end
   else
    Enlarge(p);
  end;
end;

procedure Solve;
var
 inf, sup, median, i, j: Integer;
 f: Text;
begin
 inf := n div m;
 if inf > 0 then Dec(inf);
 sup := n;
 repeat {Thuat toan tim kiem nhi phan}
  median := (inf + sup) div 2;
  if FindMatch(median) then sup := median
  else inf := median;
 until inf + 1 >= sup;
 Assign(f, OutputFile); Rewrite(f);
 if FindMatch(sup) then
  begin
   Writeln(f, 'YES');
   Writeln(f, sup);
   for i := 1 to m do
    begin
     for j := 1 to n do
      if match[j] = i then Write(f, j, ' ');
     Writeln(f, '0');
    end;
  end
 else
  Writeln(f, 'NO');
 Close(f);
end;

begin
 Enter;
 Solve;
end.
4 10
1 2 3 4 5 0
3 4 5 0
6 7 8 0
1 2 3 4 5 6 7 8 9 10 0
