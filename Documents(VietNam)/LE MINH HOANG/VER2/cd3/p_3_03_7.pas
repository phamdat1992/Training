program MatrixesMultiplier;
const
  InputFile  = 'MULTMAT.INP';
  OutputFile = 'MULTMAT.OUT';
  max = 100;
  MaxLong = 1000000000;
var
  a: array[1..max + 1] of Integer;
  F: array[1..max, 1..max] of LongInt;
  T: array[1..max, 1..max] of Byte;
  n: Integer;
  fo: Text;

procedure Enter;		
var
  i: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  ReadLn(fi, n);
  for i := 1 to n + 1 do Read(fi, a[i]);
  Close(fi);
end;

procedure Optimize;
var
  i, j, k, len: Integer;
  x, p, q, r: LongInt;
begin
  for i := 1 to n do
    for j := i to n do
      if i = j then F[i, j] := 0
      else F[i, j] := MaxLong;
  for len := 2 to n do
    for i := 1 to n - len + 1 do
      begin
        j := i + len - 1;
        for k := i to j - 1 do
          begin
            p := a[i]; q := a[k + 1]; r := a[j + 1];
            x := F[i, k] + F[k + 1, j] + p * q * r;		
            if x < F[i, j] then		
              begin
                F[i, j] := x;			
                T[i, j] := k;
              end;
          end;
      end;
end;

procedure Trace(i, j: Integer);
var
 k: Integer;
begin
  if i = j then Write(fo, 'M[', i, ']')
  else				
    begin
      Write(fo, '(');			
      k := T[i, j];			
      Trace(i, k);
      Write(fo, ' * ');		
      Trace(k + 1, j);		
      Write(fo, ')');
    end;
end;

begin
  Enter;
  Optimize;
  Assign(fo, OutputFile); Rewrite(fo);
  WriteLn(fo, F[1, n]);
  Trace(1, n);
  Close(fo);
end.
