{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses Crt;
const
  fi = 'number.inp';
  fo = 'number.out';
  Bit: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);
  Max = 201;
type
  ArrayTrace = array[1..Max, 1..Max] of Byte;
var
  a, b, c: string;
  p: array[0..Max, 0..Max] of Byte;
  Trace: array[1..Max, 0..25] of Byte;
  l1, l2: Byte;
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
  j: Byte;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  FillChar(p[0], l1 + 1, 0);
  for j := 1 to l1 do p[0, j] := 0;
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
      if Boolean(Trace[i, j shr 3] and Bit[j and 7]) then Dec(j)
      else Dec(i);
  end;
  ReTrace := c;
end;

procedure Optimize;
var
  i, j: Byte;
begin
  for i := 1 to l1 do
    for j := 1 to l2 do
      if a[i] = b[j] then p[i, j] := p[i - 1, j - 1] + 1
      else
        if p[i - 1, j] > p[i, j - 1] then p[i, j] := p[i - 1, j]
        else
          if p[i, j - 1] > p[i - 1, j] then
          begin
            p[i, j] := p[i, j - 1];
            Trace[i, j shr 3] := Trace[i, j shr 3] or Bit[j and 7];
          end
          else
            if ReTrace(i - 1, j) > ReTrace(i, j - 1) then p[i, j] := p[i - 1, j]
            else
            begin
              p[i, j] := p[i, j - 1];
              Trace[i, j shr 3] := Trace[i, j shr 3] or Bit[j and 7];
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