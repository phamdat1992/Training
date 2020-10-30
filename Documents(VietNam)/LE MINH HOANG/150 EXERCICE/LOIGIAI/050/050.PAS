program MaxSquare;
const
  InputFile  = 'SQUARE.INP';
  OutputFile = 'SQUARE.OUT';
  max = 1000;
var
  m, n, maxSize, x, y: Integer;
  Line: array[0..max] of Integer;
  Column: array[1..max] of Integer;

procedure Init;
begin
  FillChar(Line, SizeOf(Line), $FF);
  maxSize := 1;
  x := 1; y := 1;
end;

procedure Solve;
var
  f: Text;
  i, j, Count, Data: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, Data);
          if Data <> Line[j] then Column[j] := 1
          else Inc(Column[j]);
          Line[j] := Data;
        end;
      Readln(f);
      Count := 0;
      for j := 1 to n do
        if Column[j] <= maxSize then Count := 0
        else
          if Line[j] <> Line[j - 1] then Count := 1
          else
           begin
             Inc(Count);
             if Count > maxSize then
               begin
                 x := i; y := j; Inc(maxSize);
                 Break;
               end;
           end;
    end;
  Close(f);
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, maxSize);
  Writeln(f, x - maxSize + 1, ' ', y - maxSize + 1, ' ', x, ' ', y);
  Close(f);
end;

begin
  Init;
  Solve;
  Result;
end.
7 8
1 1 0 1 1 1 1 1
0 0 1 0 0 0 0 1
1 1 0 1 1 1 1 1
0 0 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
5 4
0 0 0 1
0 0 1 0
0 1 1 1
1 1 1 1
0 1 1 1

5 5
0 0 1 0 0
0 1 1 1 0
1 1 1 1 1
0 1 1 1 0
0 0 1 0 0

11 11
0 0 0 0 0 1 0 0 0 0 0
0 0 0 0 1 1 1 0 0 0 0
0 0 0 1 1 1 1 1 0 0 0
0 0 1 1 1 1 1 1 1 0 0
0 1 1 1 1 1 1 1 1 1 0
1 1 1 1 1 1 1 1 1 1 1
0 1 1 1 1 1 1 1 1 1 0
0 0 1 1 1 1 1 1 1 0 0
0 0 0 1 1 1 1 1 0 0 0
0 0 0 0 1 1 1 0 0 0 0
0 0 0 0 0 1 0 0 0 0 0
11 13
0 0 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 1 1 1 0 0 0 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0 0
0 1 1 1 1 1 1 1 1 1 0 0 0
1 1 1 1 1 1 1 1 1 1 1 0 0
0 1 1 1 1 1 1 1 1 1 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0 0
0 0 0 0 1 1 1 0 0 0 0 1 1
0 0 0 0 0 1 0 0 0 0 0 1 1
