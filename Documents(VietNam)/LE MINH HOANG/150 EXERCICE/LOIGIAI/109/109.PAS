program SerieA;
const
  InputFile  = 'SERIEA.INP';
  OutputFile = 'SERIEA.OUT';
  max = 1000;
type
  Str3 = String[3];
  FC = record
    nWin, nLost, nDraw: Integer;
    nG, Diff, Point: Integer;
    Name: Str3;
  end;
var
  n: Integer;
  FCs: array[0..max] of FC;

procedure SortName;
var
  i, j, h: Integer;
  V: FC;
begin
  h := n div 2;
  while h > 0 do
    begin
      for i := 1 + h to n do
        begin
          j := i - h; V := FCs[i];
          while (j > 0) and (FCs[j].Name > V.Name) do
            begin
              FCs[j + h] := FCs[j];
              j := j - h;
            end;
          FCs[j + h] := V;
        end;
      h := h div 2;
    end;
end;

function FindByName(Nm: Str3): Integer;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := n;
  repeat
    median := (inf + sup) div 2;
    if FCs[median].Name < Nm then inf := median
    else sup := median;
  until inf + 1 >= sup;
  FindByName := sup;
end;

procedure Enter;
var
  f: Text;
  i: Integer;
  name1, name2: Str3;
  space: Char;
  i1, i2, g1, g2: Integer;
begin
  FillChar(FCs, SizeOf(FCs), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Readln(f, FCs[i].Name);
  SortName;
  while not SeekEof(f) do
    begin
      Readln(f, name1, space, name2, g1, g2);
      i1 := FindByName(name1);
      i2 := FindByName(name2);
      if g1 > g2 then
        begin
          FCs[i1].Point := FCs[i1].Point + 3;
          Inc(FCs[i1].nWin);
          Inc(FCs[i2].nLost);
        end
      else
        if g1 < g2 then
          begin
            FCs[i2].Point := FCs[i2].Point + 3;
            Inc(FCs[i2].nWin);
            Inc(FCs[i1].nLost);
          end
        else
          begin
            Inc(FCs[i1].Point); Inc(FCs[i2].Point);
            Inc(FCs[i2].nDraw);
            Inc(FCs[i1].nDraw);
          end;
      with FCs[i1] do
        begin
          nG := nG + g1;
          Diff := Diff + g2;
        end;
      with FCs[i2] do
        begin
          nG := nG + g2;
          Diff := Diff + g1;
        end;
    end;
  for i := 1 to n do
    with FCs[i] do Diff := nG - Diff;
  Close(f);
end;

function Higher(a, b: FC): Boolean;
begin
  if a.Point > b.Point then
    begin
      Higher := True;
      Exit;
    end;
  if a.Point < b.Point then
    begin
      Higher := False;
      Exit;
    end;
  Higher := (a.Diff > b.Diff) or
            (a.Diff = b.Diff) and (a.nG > b.nG) or
            (a.Diff = b.Diff) and (a.nG = b.nG) and (a.Name < b.Name);
end;

procedure Solve;
var
  i, j, h: Integer;
  V: FC;
begin
  h := n div 2;
  while h > 0 do
    begin
      for i := 1 + h to n do
        begin
          V := FCs[i]; j := i - h;
          while (j > 0) and Higher(V, FCs[j]) do
            begin
              FCs[j + h] := FCs[j];
              j := j - h;
            end;
           FCs[j + h] := V;
        end;
      h := h div 2;
    end;
end;

procedure PrintAll;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  for i := 1 to n do
    with FCs[i] do
      Writeln(f, Name, ' ', nWin + nLost + nDraw, ' ', Point, ' ',
                 nWin, ' ', nLost, ' ', nDraw, ' ',
                 nG, ' ', nG - Diff, ' ', Diff);
  Close(f);
end;

begin
  Enter;
  Solve;
  PrintAll;
end.
6
JUV
MIL
ROM
BAR
INT
LAZ
JUV MIL 3 3
ROM BAR 4 1
JUV INT 2 1
JUV ROM 2 2
LAZ BAR 6 0
ROM INT 1 2
MIL ROM 2 2