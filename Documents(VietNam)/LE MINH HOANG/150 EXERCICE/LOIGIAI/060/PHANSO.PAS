{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
const
  fi = 'decimal.inp';
  fo = 'decimal.out';
  dau: Byte = 1;

var
  a, b, nguyen, le, temp: LongInt;
  c: array[1..60000] of Byte;
  f, g: Text;
  t, scs: LongInt;

procedure Prepare;
begin
  Assign(f, fi); Reset(f);
  Assign(g, fo); Rewrite(g);
end;

function U(a, b: LongInt): LongInt;
begin
  repeat
    while a >= b do Dec(a, b);
    if a = 0 then Break;
    while b >= a do Dec(b, a);
    if b = 0 then Break;
  until False;
  U := a + b;
end;

procedure Init;
var
  ucln, c: LongInt;
begin
  Read(f, a, b);
  if a / b < 0 then Write(g, '-');
  nguyen := a div b;
  a := a mod b;
  ucln := U(a, b);
  a := a div ucln;
  b := b div ucln;
  temp := b;
  c := 0;
  while temp mod 2 = 0 do
  begin
    Inc(c);
    temp := temp shr 1;
  end;
  le := c;
  c := 0;
  while temp mod 5 = 0 do
  begin
    Inc(c);
    temp := temp div 5;
  end;
  if c > le then le := c;
end;

procedure Chia;
var
  j, s: LongInt;
begin
  if (le = 0) and (temp = 1) then
  begin
    Write(g, nguyen);
    Exit;
  end;
  Write(g, nguyen, '.');
  while le > 0 do
  begin
    Dec(le);
    a := a * 10;
    Write(g, a div b);
    a := a mod b;
  end;
  if temp = 1 then Exit;
  FillChar(c, SizeOf(c), 0);
  Write(g, '(');
  s := a;
  repeat
    a := a * 10;
    Write(g, a div b);
    a := a mod b;
  until a = s;
  Write(g, ')');
end;

begin
  t := Meml[0:$46C];
  Prepare;
  repeat
    Init;
    Chia;
    Writeln(g);
  until SeekEof(f);
    Writeln((Meml[0:$46C] - t) / 18.23:0:4);
  Close(f);
  Close(g);
end.