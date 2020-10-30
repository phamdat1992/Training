program SegChange;
const
  InputFile  = 'SEQ.INP';
  OutputFile = 'SEQ.OUT';
  maxV = 100;
  max = 100;
var
  b: array[0..maxV * max] of Integer;
  a: array[1..max + 1] of Integer;
  Mark: array[1..max] of Boolean;
  n, k, m: Integer;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Init;
var
  S, i: Integer;
begin
  S := 0;
  for i := 1 to n do S := S + a[i];
  m := (S - k) div 2 - a[2];
  b[0] := 0;
  for i := 1 to m do b[i] := max + 1;
end;

procedure Optimize;
var
  i, V: Integer;
begin
  for V := 1 to m do
    for i := 3 to n do
      if (V >= a[i]) and (b[V - a[i]] < i) then
        begin
          b[V] := i;
          Break;
        end;
  FillChar(Mark, SizeOf(Mark), False);
  V := m;
  while v <> 0 do
    begin
      i := b[V];
      V := V - a[i];
      Mark[i] := True;
    end;
  Mark[2] := True;
end;

procedure Trace;
var
  i, t, j, c: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  t := n + 1; c := 0;
  for i := n downto 2 do
    if Mark[i] then
      begin
        {Xet day cac so mang dau "+" nam giua 2 so mang dau "-"}
        for j := i + 1 to t - 1 do
          begin
            Writeln(f, i);
            Inc(c);
          end;
        t := i;
      end;
  for i := c + 1 to n - 1 do Writeln(f, 1);
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Trace;
end.

5 3
5 3 2 4 1