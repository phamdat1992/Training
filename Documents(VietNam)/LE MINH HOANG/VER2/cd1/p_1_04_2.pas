program ABC_STRING;
const
  InputFile  = 'ABC.INP';
  OutputFile = 'ABC.OUT';
  max = 100;
var
  N, MinC: Integer;
  X, Best: array[1..max] of 'A'..'C';
  T: array[0..max] of Integer;	 
  f: Text;

function Same(i, l: Integer): Boolean;
var
  j, k: Integer;
begin
  j := i - l;
  for k := 0 to l - 1 do
    if X[i - k] <> X[j - k] then
      begin
        Same := False; Exit;
      end;
  Same := True;
end;

function Check(i: Integer): Boolean;
var
  l: Integer;
begin
  for l := 1 to i div 2 do
    if Same(i, l) then
      begin
        Check := False; Exit;
      end;
  Check := True;
end;

procedure KeepResult;
begin
  MinC := T[N];
  Best := X;
end;

procedure Try(i: Integer);
var
  j: 'A'..'C';
begin
  for j := 'A' to 'C' do
    begin
      X[i] := j;
      if Check(i) then
        begin
          if j = 'C' then T[i] := T[i - 1] + 1
          else T[i] := T[i - 1];
          if T[i] + (N - i) div 4 < MinC then
            if i = N then KeepResult
            else Try(i + 1);
        end;
    end;
end;

procedure PrintResult;
var
  i: Integer;
begin
  for i := 1 to N do Write(f, Best[i]);
  WriteLn(f);
  WriteLn(f, '"C" Letter Count  : ', MinC);
end;

begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, N);
  Close(f);
  Assign(f, OutputFile); Rewrite(f);
  T[0] := 0;
  MinC := N;
  Try(1);
  PrintResult;
  Close(f);
end.
