{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program DoanDuong;
const
  fi = 'segment.in1p';
  fo = 'segment.out';
  maxn = 30001;
  maxt = 10001;
type
  TArrMin = array[0..maxn] of Word;
  TArrT = array[0..maxt] of LongInt;
var
  Min: array[0..1] of ^TArrMin;
  T: array[0..5] of ^TArrT;
  n, Len, LPos, ll: LongInt;
  f: Text;

function GetT(p: LongInt): LongInt;
begin
  GetT := T[p div maxt]^[p mod maxt];
end;

procedure SetT(p, val: LongInt);
begin
  T[p div maxt]^[p mod maxt] := val;
end;

function GetM(p: LongInt): LongInt;
begin
  GetM := Min[p div maxn]^[p mod maxn];
end;

procedure SetM(p, val: LongInt);
begin
  Min[p div maxn]^[p mod maxn] := val;
end;

function Min2(x, y: LongInt): LongInt;
begin
  if x < y then Min2 := x
  else Min2 := y;
end;

procedure ReadFile;
var
  i: LongInt;
begin
  Assign(f, fi); Reset(f);
  ReadLn(f, n);
  t[0]^[0] := 0;
  Min[0]^[0] := 0;
  for i := 1 to n do
  begin
    Read(f, T[i div maxt]^[i mod maxt]);
    SetT(i, GetT(i) + GetT(i - 1));
    if GetT(GetM(i - 1)) < GetT(i) then SetM(i, GetM(i - 1))
    else SetM(i, i);
  end;
  Close(f);
end;

procedure Process;
var
  r, l: LongInt;
begin
  r := n;
  l := n;
  repeat
    l := GetM(l);
    while (r >= l) and (GetT(r) <= GetT(l)) do Dec(r);
    if r - l > Len then
    begin
      Len := r - l;
      ll := l;
    end;
    l := l - 1;
  until l < 0;
end;

procedure WriteFile;
begin
  Assign(f, fo); Rewrite(f);
  Write(f, ll + 1, ' ', ll + Len);
  Close(f);
end;

begin
  New(t[0]); New(t[1]); New(t[2]);
  New(t[3]); New(t[4]); New(t[5]);
  New(Min[1]); New(Min[0]);
  ReadFile;
  Process;
  WriteFile;
  Dispose(t[0]); Dispose(t[1]); Dispose(t[2]);
  Dispose(t[3]); Dispose(t[4]); Dispose(t[5]);
  Dispose(Min[0]); Dispose(Min[1]);
end.