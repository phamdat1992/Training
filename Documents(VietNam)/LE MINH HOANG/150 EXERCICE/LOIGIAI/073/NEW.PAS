{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses Crt;
const
  fi = 'number.inp';
  fo = 'number.out';
  Next: array[1..2] of Byte = (2, 1);
  Max = 201;
type
  ArrayTrace = array[1..Max, 1..Max] of Byte;
  StringMax = string[Max];
var
  a, b, c: string;
  TraceStr: array[1..2, 0..Max] of ^StringMax;
  Trace: array[1..Max, 1..Max] of Byte;
  l1, l2, First, Last: Byte;
  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;
  f: Text;

procedure ReadFile;
begin
  Assign(f, fi); Reset(f);
  Readln(f, a);
  Readln(f, b);
  while (Length(a) > 0) and (a[1] = '0') do Delete(a, 1, 1);
  while (Length(b) > 0) and (b[1] = '0') do Delete(b, 1, 1);
  l1 := Length(a);
  l2 := Length(b);
  Close(f);
end;

procedure Init;
var
  i, j: Byte;
begin
  for i := 1 to 2 do
    for j := 0 to Max do
    begin
      New(TraceStr[i, j]);
      TraceStr[i, j]^ := '';
    end;
  FillChar(Trace, SizeOf(Trace), 0);
  First := 1;
  Last := 2;
end;

function ReTrace(i, j: Word): string;
begin
  c := '';
  while (i > 0) and (j > 0) do
  begin
    if a[i] = b[j] then
    begin
      c := a[i] + c;
      Dec(i);
      Dec(j);
    end
    else
      if Trace[i, j] = 1 then Dec(j)
      else Dec(i);
  end;
  ReTrace := c;
end;

function Ok(s1, s2: StringMax): Boolean;
begin
  if Length(s1) < Length(s2) then Ok := True
  else
    if Length(s1) > Length(s2) then Ok := False
    else Ok := s1 < s2;
end;

procedure Optimize;
var
  i, j: Byte;
begin
  for i := 1 to l1 do
  begin
    for j := 1 to l2 do
      if a[i] = b[j] then TraceStr[Last, j]^ := TraceStr[First, j - 1]^ + a[i]
      else
      begin
        if Ok(TraceStr[First, j]^, TraceStr[Last, j - 1]^) then
        begin
          Trace[i, j] := 1;
          TraceStr[Last, j]^ := TraceStr[Last, j - 1]^;
        end
        else TraceStr[Last, j]^ := TraceStr[First, j]^;
      end;
    First := Next[First];
    Last := Next[Last];
  end;
end;

procedure WriteFile;
begin
  Assign(f, fo); Rewrite(f);
  Write(f, ReTrace(l1, l2));
  Close(f);
end;

begin
  OldTime := Time;
  ReadFile;
  Init;
  Optimize;
  WriteFile;
  Writeln(Time - OldTime);
end.