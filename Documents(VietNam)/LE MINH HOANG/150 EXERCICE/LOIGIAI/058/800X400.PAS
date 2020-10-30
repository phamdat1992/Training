program Ngoac;
const
 InputFile  = 'NGOAC.IN9';
 OutputFile = 'NGOAC.OUT';
 maxn = 800;
 maxk = 400;
 maxDigit = 30;
 Billion = 1000000000;
 GroupDigit = 9;
type
 TNumber = array[1..maxDigit] of LongInt;
 TLine = array[0..maxk] of TNumber;
 PLine = ^TLine;
var
 n, k: Integer;
 F, Next: PLine;
 Below_Equal, Below: TNumber;
 Start: LongInt;
 Time: LongInt absolute 0:$46C;

procedure Enter;
var
 f: Text;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, k);
 Close(f);
end;

procedure Add(a, b: TNumber; var c: TNumber);
var
 i: Integer;
 t, m, l: LongInt;
begin
 FillChar(c, SizeOf(c), 0);
 l := maxDigit;
 while (l > 1) and (a[l] = 0) and (b[l] = 0) do Dec(l);
 m := 0;
 for i := 1 to l + 1 do
  begin
   t := a[i] + b[i] + m;
   c[i] := t mod Billion;
   m := t div Billion;
  end;
end;

procedure Sub(a, b: TNumber; var c: TNumber);
var
 i: Integer;
 t, m: LongInt;
begin
 FillChar(c, SizeOf(c), 0);
 m := 0;
 for i := 1 to maxDigit do
  begin
   t := a[i] - b[i] - m;
   if t < 0 then
    begin
     t := t + Billion;
     m := 1;
    end
   else
    m := 0;
   c[i] := t mod Billion;
  end;
end;

procedure WriteNumber(var f: Text; a: TNumber);
var
 i, j: Integer;
 S: string;
begin
 i := maxDigit;
 while (i > 1) and (a[i] = 0) do Dec(i);
 Write(f, a[i]);
 for j := i - 1 downto 1 do
  begin
   Str(a[j], s);
   while Length(s) < GroupDigit do s := '0' + s;
   Write(f, s);
  end;
end;

procedure Init;
begin
 New(F); New(Next);
 FillChar(F^, SizeOf(F^), 0);
 F^[0][1] := 1;
end;

procedure Destroy;
begin
 Dispose(F); Dispose(Next);
end;

procedure Optimize;
var
 i, j: Integer;
 temp: PLine;
begin
 for i := 1 to n do
  begin
   for j := 0 to k do
    begin
     if (j > 0) then Next^[j] := F^[j - 1]
     else FillChar(Next^[j], SizeOf(Next^[j]), 0);
     if (j < k) then Add(F^[j + 1], Next^[j], Next^[j]);
    end;
   temp := F; F := Next; Next := temp;
  end;
end;

procedure Solve;
var
 Result: TNumber;
 fo: Text;
begin
 Init;
 Optimize;
 Below_equal := F^[0];
 Destroy;
 Dec(k);
 Init;
 Optimize;
 Below := F^[0];
 Destroy;
 Sub(Below_Equal, Below, Result);
 Assign(fo, OutputFile); Rewrite(fo);
 WriteNumber(fo, Result);
 Close(fo);
end;

begin
 Enter;
 Start := Time;
 Solve;
 Writeln('Time = ', (Time - Start) / 18.2:1:2, ' (s)');
end.
