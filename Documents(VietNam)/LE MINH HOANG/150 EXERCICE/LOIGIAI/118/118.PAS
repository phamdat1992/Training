program Cover;
const
  InputFile  = 'COVER.INP';
  OutputFile = 'COVER.OUT';
  maxV = 30000;
type
  TArray = array[1..maxV] of Integer;
var
  Right: TArray;
  HiID, LoID: ^TArray;
  n: LongInt;
  a, b, res: Integer;

procedure Init;
begin
  New(LoID); New(HiID);
  FillChar(LoID^, SizeOf(LoID^), 0);
  FillChar(HiID^, SizeOf(HiID^), 0);
  FillChar(Right, SizeOf(Right), 0);
end;

procedure SetID(i: Integer; ID: LongInt);
begin
  {Lo = ID mod 1024, Hi = ID div 1024}
  LoID^[i] := ID and 1023;
  HiID^[i] := ID shr 10;
end;

function GetID(i: Integer): LongInt;
begin
  {ID = Hi * 1024 + Lo}
  GetID := LongInt(HiID^[i]) shl 10 or LongInt(LoID^[i]);
end;

procedure ReadInput;
var
  f: Text;
  i: LongInt;
  l, r: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, a, b);
  for i := 1 to n do
    begin
      Readln(f, l, r);
      if l < a then l := a;
      if r > b then r := b;
      if l > r then Continue;
      if Right[l] < r then
        begin
          Right[l] := r;
          SetID(l, i);
        end;
    end;
  Close(f);
end;

procedure Count;
var
  t, Covered, Expect: Integer;
begin
  Covered := a - 1;
  Expect := Right[a];
  res := 0;
  for t := a to b do
    begin
      if t > Covered then {diem t chua duoc phu}
        begin
          if t > Expect then {Khong the phu duoc t}
            begin
              res := -1; Exit;
            end;
          Inc(res);          {Can them 1 doan de:}
          Covered := Expect; {Phu qua t, den tan Expect}
        end;
      if Right[t] > Expect then Expect := Right[t]; {Lay Expect moi}
    end;
end;

procedure Result;
var
  fo: Text;
  t, Covered, Expect: Integer;
  id: LongInt;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, res);
  if res = -1 then
    begin
      Close(fo);
      Exit;
    end;
  Covered := a - 1;
  Expect := Right[a];
  id := GetID(a);
  res := 0;
  for t := a to b do
    begin
      if t > Covered then {diem t chua duoc phu}
        begin
          Inc(res);
          Covered := Expect;
          Writeln(fo, id);
        end;
      if Right[t] > Expect then
        begin
          Expect := Right[t]; {Lay Expect moi}
          id := GetID(t);
        end;
    end;
  Close(fo);
end;

begin
  Init;
  ReadInput;
  Count;
  Result;
end.

7 2 10
4 8
1 3
2 3
1 4
3 4
7 10
9 11