{$M 65000,0,655360}
const
  Input  = 'Nc.i1';
  Output = 'Nc.out';
type
  PNode = ^TNode;
  TNode = record
            v: Integer;
            Link: PNode;
          end;
var
  List: array[1..2000] of PNode;
  a, Queue, b: array[1..2001] of Integer;
  Free: array[1..2000] of Boolean;
  n, first, last, m: Integer;

  procedure Enter;
  var
    f: Text;
    p: PNode;
  begin
    Assign(f, Input); Reset(f);
    while not SeekEof(f) do
      if not SeekEoln(f) then
        begin
          Inc(n); New(list[n]);
          Read(f, list[n]^.v); list[n]^.link := nil;
          a[n] := 1;
          while not SeekEoln(f) do
            begin
              New(p);
              Read(f, p^.v);
              p^.link := list[n];
              List[n] := p;
              Inc(a[n]);
            end;
        Readln(f);
        end
      else
        begin
          Inc(n);
          a[n] := 0;
        end;
    Close(f);
  end;

  procedure Init;
  var
    i, iMax, Max: Integer;
    p, q: PNode;
  begin
    FillChar(Free, SizeOf(Free), True);
    Max := 0;
    for i := 1 to n do
      if a[i] > Max then
        begin
          iMax := i;
          Max := a[i];
        end;
    first := 2;last := 0;
    Inc(last); Queue[last] := iMax;
    Free[iMax] := False;
    p := List[iMax];
    q := p;
    while q <> nil do
      begin
        Dec(a[q^.v]);
        q := q^.link;
      end;
    while p <> nil do
      begin
        Inc(last); Queue[last] := p^.v;
        Free[p^.v] := False;
        b[p^.v] := iMax;
        q := list[p^.v];
        while q <> nil do
          begin
            Dec(a[q^.v]);
            q := q^.link;
          end;
        p := p^.link;
      end;
  end;

  procedure Swap(var x, y: Integer);
  var
    t : Integer;
  begin
    t := x; x := y; y := t;
  end;

  procedure Solve;
  var
    p, q: PNode;
    u, i, c, iMax: Integer;
  begin
    repeat
      iMax := first;
      for i := first + 1 to last do
        if a[Queue[i]] > a[Queue[iMax]] then iMax := i;
      u := Queue[iMax];
      Swap(Queue[iMax], Queue[first]);
      Inc(first);
      if a[u] <> 0 then
        begin
          p := List[u];
          while p <> nil do
            begin
              if Free[p^.v] then
                begin
                  Inc(last); Queue[last] := p^.v;
                  Free[p^.v] := False;
                  b[p^.v] := u;
                  q := List[p^.v];
                  while q <> nil do
                    begin
                      Dec(a[q^.v]);
                      q := q^.link;
                    end;
                end;
              p := p^.link;
            end;
        end;
    until first > last;

    FillChar(a, SizeOf(a), 0);
    for i := 1 to n do
      if b[i] <> 0 then Inc(a[b[i]]);
    c := 0;
    for i := 1 to n do
      if ((a[i] = 1) and (b[i] <> 1)) or (a[i] > 1) then Inc(c);
    m := n - c;
  end;

  procedure PrintResult;
  var
    f: Text;
    i: Integer;
  begin
    Assign(f, Output); Rewrite(f);
    Writeln(f, m);
    for i := 1 to n do
      if b[i] <> 0 then Writeln(f, i, ' ', b[i]);
    Close(f);
  end;

begin
  Enter;
  Init;
  Solve;
  PrintResult;
end.