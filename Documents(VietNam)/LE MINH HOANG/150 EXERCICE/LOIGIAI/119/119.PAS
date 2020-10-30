program Tower;
const
  InputFile  = 'TOWER.INP';
  OutputFile = 'TOWER.OUT';
  maxH = 30;
  maxM = 10;
  maxK = maxM + maxH - 1;
  maxN = (maxM + maxK) * maxH div 2;
type
  TLine = array[0..maxN] of LongInt;
  PLine = ^TLine;
  TBoard = array[0..maxK] of PLine;
var
  fb: array[1..2] of TBoard;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to 2 do
    for j := 0 to maxK do New(fb[i][j]);
end;

begin
  Init;
end.