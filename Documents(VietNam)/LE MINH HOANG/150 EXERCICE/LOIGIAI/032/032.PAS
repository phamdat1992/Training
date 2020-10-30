program RelativeBoard;
const
  InputFile  = 'REL.INP';
  OutputFile = 'REL.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of ShortInt;
  t: array[1..max] of Integer;
  n: Integer;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  Close(f);
end;

function c(i, j: Integer): Integer;
begin
  if (a[i, j] = 1) or (a[j, i] = -1) then c := 1
  else
    if (a[i, j] = 2) or (a[j, i] = -2) then c := 0
    else c := -MaxInt;
end;

function Optimize: Boolean;
var
  i, j, new: Integer;
  ret: Boolean;
begin
  ret := False;
  for i := 1 to n do
    for j := 1 to n do
      begin
        new := T[i] + c(i, j);
        if T[j] < new then
          begin
            T[j] := new;
            ret := True;
          end;
      end;
  Optimize := ret;
end;

procedure Solve;
var
  i: Integer;
begin
  FillChar(T, SizeOf(T), 0);
  repeat
  until not Optimize;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  for i := 1 to n do Write(f, ' ', T[i] + 1);
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.