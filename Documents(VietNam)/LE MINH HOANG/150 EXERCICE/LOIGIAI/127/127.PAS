program SegmentsandPoints;
const
  InputFile  = 'PTS.INP';
  OutputFile = 'PTS.OUT';
  max = 60001;
type
  TArray = array[0..max] of Byte;
  PArray = ^TArray;
var
  LoLeft, HiLeft: PArray;
  MarkPtr: Pointer;
  res: Word;

function GetLeft(p: Word): Word;
begin
  GetLeft := Word(HiLeft^[p]) * 256 + LoLeft^[p];
end;

procedure SetLeft(p, Value: Word);
begin
  HiLeft^[p] := Value shr 8;
  LoLeft^[p] := Value and 255;
end;

procedure Enter;
var
  n, i, L, R: LongInt;
  f: Text;
begin
  Mark(MarkPtr);
  New(LoLeft); New(HiLeft);
  FillChar(LoLeft^, SizeOf(LoLeft^), 0);
  FillChar(HiLeft^, SizeOf(HiLeft^), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      Readln(f, L, R);
      L := L + 30001;
      R := R + 30001;
      if L > GetLeft(R) then SetLeft(R, L);
    end;
  Close(f);
end;

procedure Counting;
var
  L, R: Word;
  p1, p2: Word;
begin
  p1 := 0;
  p2 := 0;
  res := 0;
  for R := 2 to max do
    begin
      L := GetLeft(R);
      if L = 0 then Continue;
      if L > p2 then
        if L > p1 then
          begin
            p1 := R; p2 := R - 1;
            res := res + 2;
          end
        else
          begin
            p2 := p1; p1 := R;
            Inc(res);
          end;
    end;
end;

procedure Result;
var
  f: Text;
  L, R: Word;
  p1, p2: Word;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  p1 := 0;
  p2 := 0;
  for R := 2 to max do
    begin
      L := GetLeft(R);
      if L = 0 then Continue;
      if L > p2 then
        if L > p1 then
          begin
            p1 := R; p2 := R - 1;
            Write(f, LongInt(R) - 30002, ' ', LongInt(R) - 30001, ' ');
          end
        else
          begin
            p2 := p1; p1 := R;
            Write(f, LongInt(R) - 30001, ' ');
          end;
    end;
  Close(f);
end;

begin
  Enter;
  Counting;
  Result;
end.

3
6 10
1 6
4 9