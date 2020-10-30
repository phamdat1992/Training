program HeapDemo; {Queue with priority}
const
  InputFile  = 'IO.IN0';
  OutputFile = 'IO.OU0';
  max = 15000;
type
  TArr = array[1..max] of LongInt;
var
  a: TArr;
  b: ^TArr;
  n, nRes: Integer;
  Flag: Byte;

procedure Init;
begin
  n := 0;
  Flag := 0;
end;

procedure Push(V: LongInt);
var
  r, c: Integer;
begin
  if n = max then Exit;
  c := n + 1;
  r := c shr 1;
  while (r >= 1) and (a[r] < V) do
    begin
      a[c] := a[r]; c := r; r := r shr 1;
    end;
  a[c] := V;
  Inc(n);
end;

procedure Adjust;
var
  r, c: Integer;
  Key: LongInt;
begin
  Key := a[1];
  r := 1;
  while r shl 1 <= n do
    begin
      c := r shl 1;
      if (c < n) and (a[c] < a[c + 1]) then Inc(c);
      if a[c] <= Key then Break;
      a[r] := a[c]; r := c;
    end;
  a[r] := Key;
end;

procedure Pop;
var
  Value: LongInt;
begin
  if n = 0 then Exit;
  Value := a[1];
  while (n > 0) and (a[1] = Value) do
    begin
      a[1] := a[n]; Dec(n);
      Adjust;
    end;
end;

procedure Solve;
var
  ch: Char;
  i: Integer;
  V, Last: LongInt;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  while not SeekEof(f) do
    begin
      Read(f, ch);
      if ch = '-' then
        begin
          Pop;
          Readln(f);
        end
      else
        begin
          Readln(f, V);
          Push(V);
        end;
    end;
  Close(f);
  Last := -1;
  nRes := 0;
  New(b);
  for i := n downto 1 do
    begin
      V := a[1]; a[1] := a[n];
      Dec(n);
      Adjust;
      if V <> Last then
        begin
          Inc(nRes);
          b^[nRes] := V;
        end;
      Last := V;
    end;
end;

procedure Result;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nRes);
  for i := 1 to nRes do Write(f, b^[i], ' ');
  Close(f);
end;

begin
  Init;
  Solve;
  Result;
end.
+1
+3
+2
+3
-
+4
+4
-
+2
+7
+8
+9
-
