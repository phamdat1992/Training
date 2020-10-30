program WriteFilestoDisks;
const
  InputFile  = 'DISKS.INP';
  OutputFile = 'DISKS.OUT';
  max = 100;
  maxSpace = 10000;
  TIMEOVER = 5 * 18;
type
  TArray = array[1..max] of Integer;
var
  a, Index, Disk, Lab, Free, SaveLab: TArray;
  Res, n, m, minDisks, Tmin: Integer;
  Start: LongInt;
  Time: LongInt absolute 0:$46C;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Sort;
var
  i, j, temp1, temp2: Integer;
begin
  for i := 1 to n do Index[i] := i;
  for i := 2 to n do
    begin
      temp1 := a[i]; temp2 := Index[i];
      j := i - 1;
      while (j > 0) and (a[j] < temp1) do
        begin
          a[j + 1] := a[j];
          Index[j + 1] := Index[j];
          Dec(j);
        end;
      a[j + 1] := temp1;
      Index[j + 1] := temp2;
    end;
end;

procedure Init;
var
  i: Integer;
  S: LongInt;
begin
  for i := 1 to n do Free[i] := m;
  FillChar(Disk, SizeOf(Disk), 0);
  minDisks := n + 1;
  S := 0;
  for i := 1 to n do S := S + a[i];
  if S mod m = 0 then Tmin := S div m
  else Tmin := S div m + 1;
  writeln(tmin);
end;

function CheckByGreedy: Integer;
var
  i, jmin, j, minspace, nDisks: Integer;
  FreeS: TArray;
begin
  Move(Disk, Lab, n * SizeOf(Disk[1]));
  Move(Free, FreeS, n * SizeOf(Disk[1]));
  for i := 1 to n do
    if Lab[i] = 0 then
      begin
        minspace := maxspace + 1;
        for j := 1 to n do
          if (FreeS[j] >= a[i]) and (FreeS[j] < minspace) then
            begin
              minspace := FreeS[j];
              jmin := j;
            end;
        Lab[i] := jmin;
        FreeS[jmin] := FreeS[jmin] - a[i];
      end;
  nDisks := n;
  while FreeS[nDisks] = m do Dec(nDisks);
  CheckByGreedy := nDisks;
end;

procedure Update;
var
  t: Integer;
begin
  t := CheckByGreedy;
  if t < minDisks then
    begin
      minDisks := t;
      SaveLab := Lab;
    end;
end;

procedure Try(prev, d, nFiles: Integer);
var
  j: Integer;
  Stop: Boolean;
begin
  if (d >= minDisks) or (minDisks = Tmin) or (nFiles <= 0)
     or (Time - Start >= TIMEOVER) then Exit;
  Update;
  Stop := True;
  for j := prev + 1 to n do
    if (Disk[j] = 0) and (Free[d] >= a[j]) then
      begin
        Stop := False;
        Disk[j] := d;
        Free[d] := Free[d] - a[j];
        Try(j, d, nFiles - 1);
        Disk[j] := 0;
        Free[d] := Free[d] + a[j];
        if (d >= minDisks) or (minDisks = Tmin)
           or (Time - Start >= TIMEOVER) then Exit;
      end;
  if Stop then Try(0, d + 1, nFiles);
end;

procedure Result;
var
  i, d: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, minDisks);
  for d := 1 to minDisks do
    begin
      for i := 1 to n do
        if SaveLab[i] = d then Write(f, Index[i], ' ');
      Writeln(f);
    end;
  Close(f);
end;

begin
  Start := Time;
  Enter;
  Sort;
  Init;
  Try(0, 1, n);
  Result;
end.
8 14
9 7 4 3 3 2 8 6
