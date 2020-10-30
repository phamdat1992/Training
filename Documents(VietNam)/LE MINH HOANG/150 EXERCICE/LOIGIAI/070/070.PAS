program Assignment;
const
  InputFile  = 'ASSIGN.IN0';
  OutputFile = 'ASSIGN.OUT';
  maxM = 100;
  maxN = 500;
var
  a: array[1..maxM, 1..maxN] of Boolean; {a[i, j] <=> nguoi i lam duoc viec j}
  match: array[1..maxN] of Integer; {match[j] = nguoi phan cong lam viec j}
  Trace: array[1..maxM] of Integer;
  deg: array[1..maxM] of Integer; {deg[i] = so viec phan cho nguoi i}
  n, m: Integer;
  threshold: Integer;
  rstr: string[3];

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
  Threshold := 0;
end;

function FindAugmentingPath: Integer;
var
  x, y, nexty: Integer;
  first, last: Integer;
  Queue: array[1..maxN] of Integer;
begin
  Last := 0;
  for y := 1 to n do
    if match[y] = 0 then
      begin
        Inc(last);
        Queue[last] := y;
      end;
  first := 1;
  FillChar(Trace, SizeOf(Trace), 0);
  while first <= last do
    begin
      y := Queue[first]; Inc(first);
      for x := 1 to m do
        if (Trace[x] = 0) and a[x, y] then
          begin
            Trace[x] := y;
            if deg[x] < Threshold then
              begin
                FindAugmentingPath := x;
                Exit;
              end;
            for nexty := 1 to n do
              if match[nexty] = x then
                begin
                  Inc(last);
                  Queue[last] := nexty;
                end;
          end;
    end;
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

procedure Solve;
var
  finish, Count: Integer;
  Stop: Boolean;
begin
  Count := 0;
  repeat
    Inc(Threshold);
    Stop := True;
    repeat
      finish := FindAugmentingPath;
      if finish <> 0 then
        begin
          Enlarge(finish);
          Inc(count);
          Stop := False;
          if count = n then Break;
        end
      else Break;
    until False;
  until Stop or (count = n);
  if count = n then rstr := 'YES'
  else rstr := 'NO';
end;

procedure Result;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, rstr);
  if rstr = 'YES' then
    begin
      Writeln(f, Threshold);
      for i := 1 to m do
        begin
          for j := 1 to n do
            if match[j] = i then Write(f, j, ' ');
          Writeln(f, 0);
        end;
    end;
  Close(f);
end;

begin
  Enter;
  InitMatch;
  Solve;
  Result;
end.
4 10
1 2 3 4 5 0
4 5 6 7 8 0
1 2 3 4 5 7 8 9 0
1 2 3 4 5 6 7 8 9 10 0
