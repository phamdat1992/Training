program Tiger;
const
  InputFile  = 'TIGER.INP';
  OutputFile = 'TIGER.OUT';
  max = 100;
var
  a, b: array[1..max, 1..max] of Byte;
  Trace: array[1..max] of Integer;
  CutS, CutF: set of Byte;
  fout: Text;
  Flow, Start, Finish, n: Integer;

procedure Enter;
var
  finp: Text;
  u, v: Integer;
begin
  Assign(finp, InputFile); Reset(finp);
  Readln(finp, n);
  FillChar(a, SizeOf(a), False);
  while not SeekEof(finp) do
    begin
      Readln(finp, u, v);
      a[u, v] := 1; a[v, u] := 1;
    end;
  Close(finp);
  b := a;
end;

procedure Check;
begin
  Assign(fout, OutputFile); Rewrite(fout);
  if a[1, n] <> 0 then
    begin
      Writeln(fout, 'NO');
      Close(fout); Halt;
    end
  else
    Writeln(fout, 'YES');
end;

procedure CreateMultiGraph;
var
  v: Integer;
begin
  for v := 1 to n do
    begin
      a[v, Start] := 0; a[Finish, v] := 0;
      if a[Start, v] <> 0 then a[Start, v] := 255;
    end;
end;

function FindPath: Boolean;
var
  Q: array[1..max] of Integer;
  u, v, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Start] := 1; {<>0}
  Q[1] := Start; first := 1; last := 1;
  repeat
    u := Q[first]; Inc(first);
    for v := 1 to n do
      if (Trace[v] = 0) and (a[u, v] <> 0) then
        begin
          Trace[v] := u;
          if v = Finish then
            begin
              FindPath := True; Exit;
            end;
          Inc(last); Q[last] := v;
        end;
  until first > last;
  FindPath := False;
end;

procedure IncFlow;
var
  t, prev: Integer;
begin
  t := Finish;
  repeat
    prev := Trace[t]; {prev -> t}
    Dec(a[prev, t]); Inc(a[t, prev]);
    t := prev;
  until t = Start;
end;

procedure GetMaxFlow;
var
  v: Integer;
begin
  Flow := 0;
  repeat
    if not FindPath then Break;
    IncFlow;
    Inc(Flow);
  until False;
end;

procedure GetCut; {Lay lat cat sat dinh thu nhat}

  procedure Visit(u: Integer);
  var
    v: Integer;
  begin
    CutS := CutS - [u]; CutF := CutF + [u];
    for v := 1 to n do
      if (v in CutS) and (a[v, u] <> 0) then Visit(v);
  end;

begin
  CutS := [1..n]; CutF := [];
  Visit(Finish);
end;

procedure PrintOutput;
var
  u, v: Integer;
begin
  Writeln(fout, Flow);
  for u := 1 to n do
    for v := 1 to n do
      if (b[u, v] <> 0) and (u in CutS) and (v in CutF) then
          Writeln(fout, u, ' ', v);
end;

procedure Refine;
var
  u, v: Integer;
begin
  {Them nhung canh tu lat cat phat toi thang dinh thu}
  for u := 1 to n do
    for v := 1 to n do
      if (b[u, v] <> 0) and (u in CutS) and (v in CutF) then
        begin
          b[u, Finish] := 1; b[Finish, u] := 1;
        end;
  {loai bo cac doan duong phia sau ho,
  chi xet nhung doan nam phia truoc ho + nhung doan moi them vao}
  CutS := CutS + [Finish];
  FillChar(a, SizeOf(a), 0);
  for u := 1 to n do
    for v := 1 to n do
      if (u in CutS) and (v in CutS) then a[u, v] := b[u, v];
end;

procedure Solve;
begin
  CreateMultiGraph;
  GetMaxFlow;
  GetCut;
  PrintOutput;
end;

begin
  Enter;
  Check;
  Start := 1; Finish := n;
  Solve; {Holes}
  Refine;
  Start := n; Finish := 1;
  Solve; {Beers}
  Close(fout);
end.
9
1 2
1 3
1 4
1 5
2 4
3 5
4 5
4 6
5 7
6 8
6 9
7 8
7 9
8 9

11
1 2
1 3
1 4
2 3
2 7
3 6
3 4
5 6
5 10
6 7
6 9
8 9
8 11
9 10
9 11
10 11
