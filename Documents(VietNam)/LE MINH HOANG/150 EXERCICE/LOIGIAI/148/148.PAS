program LongestSubSequence;
const
  InputFile  = 'INCSEQ.IN0';
  OutputFile = 'INCSEQ.OUT';
const
  max = 10000;
type
  TArr = array[0..max + 1] of Integer;
var
  a, StartOf: TArr;
  Length, Trace: ^TArr;
  n, m: Integer;

procedure Enter;
var
  i: Word;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Init;
begin
  a[0] := -32768;
  a[n + 1] := 32767;
  m := 1;
  new(Length);
  New(Trace);
  Length^[n + 1] := 1;
  StartOf[1] := n + 1;
end;

function Find(i: Integer): Integer;
var
  inf, sup, median, j: Integer;
begin
  inf := 1; sup := m + 1;
  repeat
    median := (inf + sup) div 2;
    j := StartOf[median];
    if a[j] > a[i] then inf := median
    else sup := median;
  until inf + 1 = sup;
  Find := StartOf[inf];
end;

procedure Optimize;
var
  i, j, t: Integer;
begin
  for i := n downto 0 do
    begin
      j := Find(i);
      t := Length^[j] + 1;
      if t > m then
        begin
          m := t;
          StartOf[m] := i;
        end
      else
        if a[StartOf[t]] < a[i] then
          StartOf[t] := i;
      Length^[i] := t;
      Trace^[i] := j;
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Length^[0] - 2);
  i := Trace^[0];
  while i <> n + 1 do
    begin
      Writeln(f, i, ' ');
      i := Trace^[i];
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Result;
end.
