program ScheduleProblemSolver;
const
  InputFile  = 'SCHEDULE.INP';
  OutputFile = 'SCHEDULE.OUT';
  maxC = 10001;
  maxN = 100;
  maxM = maxN * (MaxN - 1) div 2;
type
  TArray = array[1..maxN, 1..maxN] of Integer;
var
  a, Mark: TArray;
  day: ^TArray;
  Tree, STD: array[1..maxN] of Integer;
  Lab: array[1..maxN] of Integer;
  n, m, k, dayCount, Count: Integer;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), 0);
  Readln(f, n, m, k);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := 1; a[v, u] := 1;
    end;
  Close(f);
end;

procedure GetTree;
var
  Count, u: Integer;

  procedure Visit(u: Integer);
  var
    v: Integer;
  begin
    Lab[u] := Count;
    for v := 1 to n do
      if (Lab[v] = 0) and (a[u, v] <> 0) then
        begin
          Tree[v] := u;
          Visit(v);
        end;
  end;

begin
  FillChar(Lab, SizeOf(Lab), 0);
  FillChar(Tree, SizeOf(Tree), 0);
  Count := 0;
  for u := 1 to n do
    if Lab[u] = 0 then
      begin
        Inc(Count);
        Visit(u);
      end;
end;

procedure RemoveDFSTree;
var
  v: Integer;
begin
  for v := 2 to n do
    begin
      a[Tree[v], v] := 0;
      a[v, Tree[v]] := 0;
    end;
end;

procedure GetPriority;
var
  v: Integer;
begin
  for v := 2 to n do
    if Lab[Std[v]] <> Lab[v] then
      begin
        a[Std[v], v] := 3;
        a[v, Std[v]] := 3;
      end
    else
      begin
        a[Std[v], v] := 2;
        a[v, Std[v]] := 2;
      end;
end;

procedure InitLab;
var
  v: Integer;
begin
  for v := 1 to n do Lab[v] := -1;
end;

function GetRoot(v: Integer): Integer;
begin
  while Lab[v] > 0 do v := Lab[v];
  GetRoot := v;
end;

procedure Union(r1, r2: Integer);
var
  x: Integer;
begin
  x := Lab[r1] + Lab[r2];
  if Lab[r1] < Lab[r2] then
    begin
      Lab[r1] := x;
      Lab[r2] := r1;
    end
  else
    begin
      Lab[r1] := r2;
      Lab[r2] := x;
    end;
end;

function GetPermanent: Integer;
var
  w, u, v, r1, r2, c, p: Integer;
begin
  InitLab;
  c := 0; w := 0;
  for u := 1 to n do
    for v := u + 1 to n do
      if (day^[u, v] <> 0) and (a[u, v] <> 0) then
        begin
          r1 := GetRoot(u); r2 := GetRoot(v);
          if r1 <> r2 then
            begin
              Mark[u, v] := 1;
              Inc(c);
              if c = n - 1 then
                begin
                  GetPermanent := 0;
                  Exit;
                end;
              Union(r1, r2);
            end;
        end;
  for p := 1 to 3 do
    for u := 1 to n do
      for v := u + 1 to n do
        if (a[u, v] = p) and (day^[u, v] = 0) then
          begin
            r1 := GetRoot(u); r2 := GetRoot(v);
            if r1 <> r2 then
              begin
                Mark[u, v] := 1;
                Inc(c); Inc(w);
                if c = n - 1 then
                  begin
                    GetPermanent := w;
                    Exit;
                  end;
                Union(r1, r2);
              end;
          end;
  GetPermanent := maxC;
end;

procedure Solve;
var
  w: Integer;

  procedure Repair;
  var
    p, u, v: Integer;
  begin
    for p := 3 downto 1 do
      for u := 1 to n do
        for v := u + 1 to n do
          if (Mark[u, v] = 0) and (a[u, v] = p) and (day^[u, v] = 0) then
            begin
              day^[u, v] := dayCount;
              Inc(Count);
              if Count = k then Exit;
            end;
    for u := 1 to n do
      for v := u + 1 to n do
        if Mark[u, v] = 0 then
          begin
            day^[u, v] := dayCount;
            Inc(Count);
            if Count = k then Exit;
          end;
  end;

  procedure Greedy;
  var
    u, v: Integer;
  begin
    for u := 1 to n do
      for v := u + 1 to n do
        if (a[u, v] <> 0) and (day^[u, v] = 0) then
          begin
            Inc(count);
            if count > k then
              begin
                Inc(dayCount); count := 1;
              end;
            day^[u, v] := dayCount;
          end;
  end;

begin
  New(day);
  FillChar(day^, SizeOf(day^), 0);
  dayCount := 0;
  repeat
    Inc(dayCount);
    Count := 0;
    FillChar(Mark, SizeOf(Mark), 0);
    w := GetPermanent;
    if w = 0 then Break;
    Repair;
  until False;
  Greedy;
end;

procedure Result;
var
  f: Text;
  u, v: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, dayCount);
  for u := 1 to n do
    for v := u + 1 to n do
      if a[u, v] <> 0 then Writeln(f, u, ' ', v, ' ', day^[u, v]);
  Close(f);
end;

begin
 Enter;
 GetTree;
 STD := Tree;
 RemoveDFSTree;
 GetTree;
 GetPriority;
 Solve;
 Result;
end.

5 10 5
1 2
2 3
3 4
4 5
5 1
1 3
2 4
3 5
4 1
5 2

9 17 9
1 2
1 3
2 3
2 8
3 4
3 5
3 6
4 5
4 7
4 8
5 6
6 4
6 7
6 8
6 9
7 8
8 9

5 10 5
1 2
1 3
1 4
1 5
2 3
2 4
2 5
3 4
3 5
4 5
