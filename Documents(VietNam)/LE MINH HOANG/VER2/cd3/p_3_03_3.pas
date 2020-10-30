program The_Bag;
const
  InputFile  = 'BAG.INP';
  OutputFile = 'BAG.OUT';
  max = 100;
var
  W, V: Array[1..max] of Integer;
  F: array[0..max, 0..max] of Integer;
  n, M: Integer;

procedure Enter;		
var
  i: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  ReadLn(fi, n, M);
  for i := 1 to n do ReadLn(fi, W[i], V[i]);
  Close(fi);
end;

procedure Optimize;		
var
  i, j: Integer;
begin
  FillChar(F[0], SizeOf(F[0]), 0);		
  for i := 1 to n do
    for j := 0 to M do
      begin		
        F[i, j] := F[i - 1, j];	
        if (j >= W[i]) and
              (F[i, j] < F[i - 1, j - W[i]] + V[i]) then
                      F[i, j] := F[i - 1, j - W[i]] + V[i];
      end;
end;

procedure Trace;			
var
  fo: Text;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  WriteLn(fo, F[n, M]);	
  while n <> 0 do		
    begin
      if F[n, M] <> F[n - 1, M] then		
        begin
          Write(fo, n, ' ');
          M := M - W[n];	
        end;
      Dec(n);
    end;
  Close(fo);
end;

begin
  Enter;
  Optimize;
  Trace;
end.
5 11
3 3
4 4
5 4
9 10
4 4