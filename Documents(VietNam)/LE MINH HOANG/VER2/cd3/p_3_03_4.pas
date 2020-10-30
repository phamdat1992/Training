program StrOpt;
const
  InputFile  = 'STR.INP';
  OutputFile = 'STR.OUT';
  max = 100; 
var
  X, Y: String[2 * max];
  F: array[-1..max, -1..max] of Integer;
  m, n: Integer;

procedure Enter;	
var
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  ReadLn(fi, X); ReadLn(fi, Y);
  Close(fi);
  m := Length(X); n := Length(Y);
end;

function Min3(x, y, z: Integer): Integer;	
var
  t: Integer;
begin
  if x < y then t := x else t := y;
  if z < t then t := z;
  Min3 := t;
end;

procedure Optimize;
var
  i, j: Integer;
begin
  for i := 0 to m do F[i, -1] := max + 1;
  for j := 0 to n do F[-1, j] := max + 1;
  for j := 0 to n do F[0, j] := j;
  for i := 1 to m do F[i, 0] := i;
  for i := 1 to m do
    for j := 1 to n do
      if X[i] = Y[j] then F[i, j] := F[i - 1, j - 1]
      else F[i, j] := Min3(F[i, j - 1], F[i - 1, j - 1], F[i - 1, j]) + 1;
end;

procedure Trace;
var
  fo: Text;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  WriteLn(fo, F[m, n]);					
  while (m <> 0) or (n <> 0) do	
    if X[m] = Y[n] then		
      begin
        Dec(m); Dec(n);	
      end
    else		
      begin
        Write(fo, X, ' -> ');		
        if F[m, n] = F[m, n - 1] + 1 then				
          begin
            Write(fo, 'Insert(', m, ', ', Y[n], ')');
            Insert(Y[n], X, m + 1);
            Dec(n);											
          end
        else
          if F[m, n] = F[m - 1, n - 1] + 1 then		
            begin
              Write(fo, 'Replace(', m, ', ', Y[n], ')');
              X[m] := Y[n];
              Dec(m); Dec(n);							
            end
          else																
            begin
              Write(fo, 'Delete(', m, ')');
              Delete(X, m, 1);
              Dec(m);											
            end;
        WriteLn(fo, ' -> ', X);		
      end;
  Close(fo);
end;

begin
  Enter;
  Optimize;
  Trace;
end.
PBBCEFATZ
QABCDABEFA