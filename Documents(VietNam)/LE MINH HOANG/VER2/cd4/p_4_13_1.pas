program MatchingInGeneralGraph;
const
  InputFile  = 'GMATCH.INP';
  OutputFile = 'GMATCH.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  match, Queue, b, T: array[1..max] of Integer;
  InQueue: array[1..max] of Boolean;
  n, first, last, start, finish: Integer;

procedure Enter;
var
  i, m, u, v: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), False);
  ReadLn(f, n, m);
  for i := 1 to m do
    begin
      ReadLn(f, u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
  Close(f);
end;

procedure Init;		
begin
  FillChar(match, SizeOf(match), 0);
end;

procedure InitBFS;	
var
  i: Integer;
begin
  first := 1; last := 1;
  Queue[1] := start;
  FillChar(InQueue, SizeOf(InQueue), False);
  InQueue[start] := True;
  FillChar(T, SizeOF(T), 0);
  for i := 1 to n do b[i] := i;
  finish := 0;
end;

procedure Push(v: Integer);
begin
  Inc(last);
  Queue[last] := v;
  InQueue[v] := True;
end;

function Pop: Integer;
begin
  Pop := Queue[first];
  Inc(first);
end;

procedure BlossomShrink(p, q: Integer);
var
  i, NewBase: Integer;
  Mark: array[1..max] of Boolean;

  function FindCommonAncestor(p, q: Integer): Integer;
  var
    InPath: array[1..max] of Boolean;
  begin
    FillChar(InPath, SizeOf(Inpath), False);
    repeat
      p := b[p];
      Inpath[p] := True;
      if p = start then Break;
      p := T[match[p]];
    until False;
    repeat
      q := b[q];
      if InPath[q] then Break;
      q := T[match[q]];
    until False;
    FindCommonAncestor := q;
  end;

  procedure ResetTrace(x: Integer);
  var
    u, v: Integer;
  begin
    v := x;
    while b[v] <> NewBase do
      begin
        u := match[v];
        Mark[b[v]] := True;
        Mark[b[u]] := True;
        v := T[u];
        if b[v] <> NewBase then T[v] := u;
      end;
  end;

begin
  FillChar(Mark, SizeOf(Mark), False);
  NewBase := FindCommonAncestor(p, q);
  ResetTrace(p); ResetTrace(q);
  if b[p] <> NewBase then T[p] := q;
  if b[q] <> NewBase then T[q] := p;
  for i := 1 to n do
    if Mark[b[i]] then b[i] := NewBase;
  for i := 1 to n do
    if not InQueue[i] and (b[i] = NewBase) then
      Push(i);
end;


procedure FindAugmentingPath;
var
  u, v: Integer;
begin
  InitBFS;
  repeat
    u := Pop;
    for v := 1 to n do
      if (T[v] = 0) and (a[u, v]) and (b[u] <> b[v]) then
        begin
          if match[v] = 0 then
            begin
              T[v] := u;
              finish := v;
              Exit;
            end;
          if (v = start) or (T[match[v]] <> 0) then
            BlossomShrink(u, v)
          else
            begin
              T[v] := u;
              Push(match[v]);
            end;
        end;
  until first > last;
end;

procedure Enlarge;
var
  v, next: Integer;
begin
  repeat
    v := T[finish];
    next := match[v];
    match[v] := finish;
    match[finish] := v;
    finish := next;
  until finish = 0;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if match[u] = 0 then
      begin
        start := u;
        FindAugmentingPath;
        if finish <> 0 then Enlarge;
      end;
end;

procedure Result;
var
  u, count: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  count := 0;
  for u := 1 to n do
    if match[u] > u then
      begin
        Inc(count);
        WriteLn(f, count, ') ', u, ' ', match[u]);
      end;
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  Result;
end.
10 11
1 2
1 6
2 4
2 8
3 4
3 6
5 6
5 9
5 10
7 8
7 9