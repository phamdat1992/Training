program Activity;
const
  InputFile  = 'ACTIVITY.IN9';
  OutputFile = 'ACTIVITY.OU9';
  maxV = 32000;
type
  TArr = array[0..maxV] of Word;
var
  maxLeft, Lab: ^TArr;
  {Lab^[i] : i la thoi diem ket thuc cua cuoc hop lab^[i] }
  Count, n: Word;

procedure Enter;
var
  f: Text;
  i, v, a, b: Word;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  New(maxLeft);  New(Lab);
  FillChar(maxLeft^, SizeOf(maxLeft^), 0);
  FillChar(Lab^, SizeOf(Lab^), 0);
  for i := 1 to n do
    begin
      Readln(f, a, b);
      if a > maxLeft^[b] then
        begin
          maxLeft^[b] := a;
          Lab^[b] := i;
        end;
    end;
  Close(f);
end;

procedure Solve;
var
  i, v, endt: Word;
  f: Text;
begin
  Count := 0; endt := 0;
  for v := 0 to maxV do
    if (maxLeft^[v] >= endt) and (Lab^[v] <> 0) then
      begin
        Inc(Count);
        endt := v;
      end;
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Count);
  endt := 0;
  for v := 0 to maxV do
    if (maxLeft^[v] >= endt) and (Lab^[v] <> 0) then
      begin
        Writeln(f, Lab^[v]);
        endt := v;
      end;
  Close(f);
end;

begin
  Enter;
  Solve;
end.
5
7 9
2 4
1 3
1 6
3 5
