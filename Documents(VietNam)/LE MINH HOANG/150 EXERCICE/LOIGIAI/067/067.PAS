program GroupByKey;
const
 InputFile  = 'GROUP.INP'; {PHANNHOM.INP}
 OutputFile = 'GROUP.OUT'; {PHANNHOM.OUT}
 maxN = 100;
 maxM = 10;
 Bit: array[0..9] of Word = (1, 2, 4, 8, 16, 32, 64, 128, 256, 512);
type
 TSetArr = array[1..1 shl maxM] of Word;
 PSetArr = ^TSetArr; {Khai mang dong cho nhanh chu thuc ra khong can}
var
 Count: array[0..1 shl maxM - 1] of Word;
 Rec: array[1..maxN] of Word;
 Index: array[1..maxN] of Word;
 Current, Next: PSetArr;
 n, m, nCurrent, nNext: Integer;
 GroupCount: Word;
 Key: Word;

 Time: LongInt absolute 0:$46C;
 Start: LongInt;

procedure Enter;
var
 f: Text;
 i, j, k: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m);
 for i := 1 to n do
  begin
   Rec[i] := 0;
   for j := 0 to m - 1 do
    begin
     Read(f, k);
     Rec[i] := Rec[i] or k * Bit[j];
    end;
   Readln(f);
  end;
 Close(f);
end;

function Creator(Mask: Word): Word;
var
 i: Integer;
 r, Pos: Word;
begin
 FillChar(Count, SizeOf(Count), 0);
 r := 0;
 for i := 1 to n do
  begin
   Pos := Rec[i] and Mask;
   Inc(Count[Pos]);
   if Count[Pos] > r then r := Count[Pos];
  end;
 Creator := r;
end;

procedure Init;
begin
 GroupCount := Creator(1 shl m - 1);
 New(Current); New(Next);
 Current^[1] := 0; nCurrent := 1;
end;

function BFSSearch: Word;
var
 Step, Highest, i, j: Integer;
 tmp: PSetArr;
begin
 for Step := 1 to m do
  begin
   nNext := 0;
   for i := 1 to nCurrent do
    begin
     Highest := m - 1;
     while (Highest >= 0) and (Current^[i] and Bit[Highest] = 0) do
           Dec(Highest);
     for j := Highest + 1 to m - 1 do
      begin
       Inc(nNext);
       Next^[nNext] := Current^[i] or Bit[j];
       if Creator(Next^[nNext]) <= GroupCount then
        begin
         BFSSearch := Next^[nNext];
         Exit;
        end
      end;
    end;
   tmp := Current; Current := Next; Next := tmp;
   nCurrent := nNext;
  end;
end;

procedure Swap(i, j: Integer);
var
 tmp: Integer;
begin
 tmp := Rec[i]; Rec[i] := Rec[j]; Rec[j] := tmp;
 tmp := Index[i]; Index[i] := Index[j]; Index[j] := tmp;
end;

procedure QSort(L, R: Integer);
var
 i, j, T: Integer;
begin
 if L >= R then Exit;
 i := L; j := R; T := Rec[L];
 repeat
  while Rec[j] > T do Dec(j);
  while (i < j) and (Rec[i] <= T) do Inc(i);
  Swap(i, j);
 until i = j;
 Swap(L, i);
 QSort(L, i - 1); QSort(i + 1, R);
end;

procedure Sort;
var
 i: Integer;
begin
 for i := 1 to n do
  begin
   Index[i] := i;
   Rec[i] := Rec[i] and Key;
  end;
 QSort(1, n);
end;

procedure Result;
var
 f: Text;
 i, j: Integer;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, GroupCount);
 for i := 0 to m - 1 do
  if Key and Bit[i] <> 0 then Write(f, i + 1, ' ');
 Writeln(f);
 Sort;
 for i := 1 to GroupCount do
  begin
   j := i;
   repeat
    Write(f, Index[j], ' ');
    j := j + GroupCount;
   until j > n;
   Writeln(f);
  end;
 Close(f);
end;

begin
 Start := Time;
 Enter;
 Init;
 Key := BFSSearch;
 Result;
 Writeln((Time - Start) / 18.2:1:2, ' (s)');
end.
