unit SortA;

interface

uses
  Windows, Classes, SysUtils;
const
  Radix = 256;
  KeySize = SizeOf(Integer);
  BitCount = 31;
type
  TKey = Integer;
  TnKey = Integer;
  TBitIndex = Integer;
  TArray =  array of TKey;
  TCountArray = array of TnKey;
  TRadixCountArray = array[0..Radix - 1] of TnKey;
  TMaskBits = array[0..BitCount - 1] of TKey;

  TSortRef = class of TSort;
  TSort = class
  private
    { Private declarations }
    StartTime, EndTime: DWORD;
    procedure Swap(var x, y: TKey);
    procedure Sort; virtual; abstract;
  protected
    k: TArray;
  public
    ExecutionTime: DWORD;
    DStr: String;
    n: TnKey;
    SupV: TKey;
    Active: TArray;
    constructor Create(const source: TArray; const pn: TnKey; const pSupV: TKey); virtual;
    destructor Destroy; override;
    procedure Start;
  end;

  TSelectionSort = class(TSort)
  public
    procedure Sort; override;
  end;

  TBubbleSort = class(TSort)
  public
    procedure Sort; override;
  end;

  TInsertionSort = class(TSort)
  public
    procedure Sort; override;
  end;

  TShellSort = class(TSort)
  public
    procedure Sort; override;
  end;

  TQuickSort = class(TSort)
  public
    procedure Sort; override;
  end;

  THeapSort = class(TSort)
  public
    procedure Sort; override;
  end;

  TDistributionCounting = class(TSort)
  private
    t: TArray;
    c: TCountArray;
  public
    procedure Sort; override;
    constructor Create(const source: TArray; const pn: TnKey; const pSupV: TKey); override;
    destructor Destroy; override;
  end;

  TRadixSort = class(TSort)
  public
    procedure Sort; override;
  end;

  TStraightRadixSort = class(TSort)
  private
    t: TArray;
    c: TRadixCountArray;
  public
    procedure Sort; override;
    constructor Create(const source: TArray; const pn: TnKey; const pSupV: TKey); override;
    destructor Destroy; override;
  end;

  TMergeSort = class(TSort)
  private
    t: TArray;
  public
    procedure Sort; override;
    constructor Create(const source: TArray; const pn: TnKey; const pSupV: TKey); override;
    destructor Destroy; override;
  end;

  TSortThread = class(TThread)
  private
    FSortRef: TSortRef;
  protected
    procedure Execute; override;
  public
    SortObject: TSort;
    tag: Integer;
    Stopped: Boolean;
    constructor Create(SortRef: TSortRef);
    destructor Destroy; override;
    procedure LoadData(const source: TArray; const pn: TnKey; const pSubV: TKey);
    procedure FreeData;
    property Terminated;
  end;

const
  ListSortA: array[0..9] of TSortRef = (
    TSelectionSort,
    TBubbleSort,
    TInsertionSort,
    TShellSort,
    TQuickSort,
    THeapSort,
    TDistributionCounting,
    TRadixSort,
    TStraightRadixSort,
    TMergeSort
  );
implementation
{ TSort }

constructor TSort.Create(const source: TArray; const pn: TnKey; const pSupV: TKey);
begin
  n := pn;
  SupV := pSupV;
  k := Copy(source, 0, Length(source));
  Active := k;
end;

destructor TSort.Destroy;
begin
  inherited;
  k := nil;
end;

procedure TSort.Start;
begin
  StartTime := GetTickCount;
  Sort;
  EndTime := GetTickCount;
  ExecutionTime := EndTime - StartTime;
  Str(ExecutionTime / 1000:1:4, DStr);
  DStr := DStr + ' (secs)';
end;

procedure TSort.Swap(var x, y: TKey);
var
  t: TKey;
begin
  t := x; x := y; y := t;
end;

{ TSelectionSort }

procedure TSelectionSort.Sort;
var
  i, j, jmin: TnKey;
begin
  for i := 1 to Pred(n) do
    begin
      jmin := i;
      for j := Succ(i) to n do
        if k[j] < k[jmin] then jmin := j;
      if jmin <> i then Swap(k[i], k[jmin]);
    end;
end;

{ TBubbleSort }

procedure TBubbleSort.Sort;
var
  i, j: TnKey;
begin
  for i := 2 to n do
    for j := n downto i do
      if k[Pred(j)] > k[j] then
        Swap(k[Pred(j)], k[j]);
end;

{ TInsertionSort }

procedure TInsertionSort.Sort;
var
  i, inf, sup, median: TnKey;
  tmp: TKey;
begin
  for i := 2 to n do
    begin
      tmp := k[i];
      inf := 1; sup := Pred(i);
      while inf <= sup do
        begin
          median := (inf + sup) shr 1;
          if tmp < k[median] then sup := Pred(median)
          else inf := Succ(Median);
        end;
        Move(k[inf], k[Succ(inf)], (i - inf) * KeySize);
        k[inf] := tmp;
    end;
end;

{ TShellSort }

procedure TShellSort.Sort;
var
  tmp: TKey;
  i, j, h: TnKey;
begin
  h := n shr 1;
  while h <> 0 do
    begin
      for i := Succ(h) to n do
        begin
          tmp := k[i]; j := i - h;
          while (j > 0) and (k[j] > tmp) do
            begin
              k[j + h] := k[j];
              j := j - h;
            end;
          k[j + h] := tmp;
        end;
      h := h shr 1;
    end;
end;

{ TQuickSort }

procedure TQuickSort.Sort;

  procedure Partition(L, H: TnKey);
  var
    i, j: TnKey;
    Pivot: TKey;
  begin
    if L >= H then Exit;
    Pivot := k[L + Random(H - L + 1)];
    i := L; j := H;
    repeat
      while k[i] < Pivot do Inc(i);
      while k[j] > Pivot do Dec(j);
      if i <= j then
        begin
          if i < j then Swap(k[i], k[j]);
          Inc(i); Dec(j);
        end;
    until i > j;
    Partition(L, j); Partition(i, H);
  end;

begin
  Partition(1, n);
end;

{ THeapSort }

procedure THeapSort.Sort;
var
  r, i: TnKey;

  procedure Adjust(root, endnode: TnKey);
  var
    key: TKey;
    c: TnKey;
  begin
    key := k[root];
    while root shl 1 <= endnode do
      begin
        c := root shl 1;
        if (c < endnode) and (k[c] < k[Succ(c)]) then Inc(c);
        if k[c] <= key then Break;
        k[root] := k[c]; root := c;
      end;
    k[root] := key;
  end;

begin
  for r := n shr 1 downto 1 do Adjust(r, n);
  for i := n downto 2 do
    begin
      Swap(k[1], k[i]);
      Adjust(1, Pred(i));
    end;
end;

{ TDistributionCounting }
constructor TDistributionCounting.Create(const source: TArray; const pn: TnKey; const pSupV: TKey);
begin
  inherited;
  SetLength(c, SupV + 1);
  SetLength(t, pn + 1);
end;

destructor TDistributionCounting.Destroy;
begin
  t := nil;
  c := nil;
  inherited;
end;

procedure TDistributionCounting.Sort;
var
  V: TKey;
  i: TnKey;
  temp: TArray;
begin
  SetLength(c, SupV + 1);
  SetLength(t, n + 1);
  ZeroMemory(@c[0], (SupV + 1) * KeySize);
  for i := 1 to n do Inc(c[k[i]]);
  for V := 1 to SupV - 1 do c[V] := c[Pred(V)] + c[V];
  Active := t;
  for i := n downto 1 do
    begin
      V := k[i];
      t[c[V]] := k[i];
      Dec(c[V]);
    end;
  temp := t; t := k; k := temp;
  Active := k;
end;

{ TRadixSort }

procedure TRadixSort.Sort;
var
  MaskBit: TMaskBits;
  bi: TBitIndex;

  procedure Partition(const L, H: TnKey; BIndex: TBitIndex);
  var
    i, j: TnKey;
    Mask: TKey;
  begin
    if L >= H then Exit;
    i := L; j := H; Mask := MaskBit[BIndex];
    repeat
      while (i < j) and (k[i] and Mask = 0) do Inc(i);
      while (i < j) and (k[j] and Mask <> 0) do Dec(j);
      Swap(k[i], k[j]);
    until i = j;
    if k[j] and Mask = 0 then Inc(j);
    if BIndex > 0 then
      begin
        Partition(L, Pred(j), Pred(BIndex)); Partition(j, H, Pred(BIndex));
      end;
  end;

begin
  for bi := 0 to BitCount - 1 do MaskBit[bi] := 1 shl bi;
  bi := Trunc(ln(SupV) / ln(2));
  Partition(1, n, bi);
end;

{ TStraightRadixSort }
constructor TStraightRadixSort.Create(const source: TArray; const pn: TnKey; const pSupV: TKey);
begin
  inherited;
  SetLength(t, n + 1);
end;

destructor TStraightRadixSort.Destroy;
begin
  t := nil;
  inherited;
end;

procedure TStraightRadixSort.Sort;
var
  p, nDigit: TBitIndex;
  Flag: Boolean;
  temp: TArray;

  function GetDigit(key: TKey; p: TBitIndex): TKey; //This function has to be changed whenever the value of Radix changes
  begin
    GetDigit := (key shr (p shl 3)) and $FF;
  end;

  procedure DCount(var x, y: TArray; p: TBitIndex);
  var
    i: TnKey;
    d: TKey;
  begin
    ZeroMemory(@c, SizeOf(c));
    for i := 1 to n do
      begin
        d := GetDigit(x[i], p); Inc(c[d]);
      end;
    for d := 1 to Radix - 1 do c[d] := c[Pred(d)] + c[d];
    for i := n downto 1 do
      begin
        d := GetDigit(x[i], p);
        y[c[d]] := x[i];
        Dec(c[d]);
      end;
  end;

begin
  Flag := True;
  nDigit := Trunc(ln(SupV) / ln(Radix));
  for p := 0 to nDigit do
    begin
      if Flag then DCount(k, t, p)
      else DCount(t, k, p);
      Flag := not Flag;
      if Flag then Active := k else Active := t;
    end;
  temp := nil;
  if not Flag then
    begin
      temp := t; t := k; k := temp;
    end;
  Active := k;
end;

{ TMergeSort }

constructor TMergeSort.Create(const source: TArray; const pn: TnKey; const pSupV: TKey);
begin
  inherited;
  SetLength(t, pn + 1);
end;

destructor TMergeSort.Destroy;
begin
  t := nil;
  inherited;
end;

procedure TMergeSort.Sort;
var
  Flag: Boolean;
  len: TnKey;
  temp: TArray;

  procedure Merge(const Source: TArray; var Dest: TArray; a, b, c: TnKey);
  var
    i, j, p: TnKey;
  begin
    p := a; i := a; j := Succ(b);
    while (i <= b) and (j <= c) do
      begin
        if Source[i] <= Source[j] then
          begin
            Dest[p] := Source[i]; Inc(i);
          end
        else
          begin
            Dest[p] := Source[j]; Inc(j);
          end;
        Inc(p);
      end;
    if i <= b then
      Move(Source[i], Dest[p], (b - i + 1) * KeySize)
    else
      Move(Source[j], Dest[p], (c - j + 1) * KeySize);
  end;

  procedure MergeByLength(const Source: TArray; var Dest: TArray; len: TnKey);
  var
    a, b, c: TnKey;
  begin
    a := 1; b := len; c := len shl 1;
    while c <= n do
      begin
        Merge(Source, Dest, a, b, c);
        a := a + len shl 1; b := b + len shl 1; c := c + len shl 1;
      end;
    if b < n then Merge(Source, Dest, a, b, n)
    else
      if a <= n then
         Move(Source[a], Dest[a], (n - a + 1) * KeySize);
  end;

begin
  len := 1; Flag := True;
  while len < n do
    begin
      if Flag then MergeByLength(k, t, len)
      else MergeByLength(t, k, len);
      len := len shl 1;
      if Flag then Active := k else Active := t;
      Flag := not Flag;
    end;
  temp := nil;
  if not Flag then
    begin
      temp := t; t := k; k := temp;
    end;
  Active := k;
end;

{ TSortThread }

constructor TSortThread.Create(SortRef: TSortRef);
begin
  inherited Create(True);
  FSortRef := SortRef;
  SortObject := nil;
  Stopped := False;
end;

destructor TSortThread.Destroy;
begin
  if Assigned(SortObject) then SortObject.Free;
  inherited Destroy;
end;

procedure TSortThread.Execute;
begin
  if Assigned(SortObject) then SortObject.Start;
  Stopped := True;
end;

procedure TSortThread.FreeData;
begin
  if Assigned(SortObject) then SortObject.Free;
  SortObject := nil;
end;

procedure TSortThread.LoadData(const source: TArray; const pn: TnKey; const pSubV: TKey);
begin
  if Assigned(SortObject) then SortObject.Free;
  SortObject := FSortRef.Create(source, pn, pSubV);
end;

end.



