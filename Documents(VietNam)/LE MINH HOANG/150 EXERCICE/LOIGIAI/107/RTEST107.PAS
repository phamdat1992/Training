program RandomTest;
const
  narray: array[1..10] of LongInt =
         (10, 100, 1000, 5000, 9999, 10000, 10000, 50000, 99999, 100000);
  marray: array[1..10] of LongInt =
         (3, 9, 1000, 2, 10000, 1000000, 1000000, 999999, 1000, 1000000000);
  rarray: array[1..10] of LongInt =
         (3, 10, 2, 2, 100, 100, 40, 30, 20, 100);
  tarray: array[1..10] of Char = '1234567890';
var
  f: Text;
  t, i, m, n: LongInt;
begin
  Randomize;
  for t := 1 to 10 do
    begin
      m := marray[t]; n := narray[t];
      Writeln('IO.IN' + tarray[t]);
      Assign(f, 'IO.IN' + tarray[t]); Rewrite(f);
      for i := 1 to n do
        if Random(3) = 1 then Writeln(f, '-')
        else Writeln(f, '+', Round(Random * m));
      Close(f);
    end;
end.
