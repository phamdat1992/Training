Uses crt;
const
  fi='mavach.in0';
  fo='maVach.out';
  maxN = 40;
type
  Mavach = array[1..maxN]of byte;
var
  c : array[0..maxN , 0..MaxN ]of longint;
  n , m , kk : integer;
  a : MaVach;
  tt : longint;
  inp , out : text;

procedure mofile;
begin
  assign(inp,fi);
  reset(inp);
  readln(inp , n , m , kk);
  assign(out,fo);
  rewrite(out);
end;

procedure dongfile;
begin
  close(inp);
  close(out);
end;

function min(a,b : integer):integer;
begin
  if a>b then min := b else min := a;
end;

procedure tinh(i1,j1 : integer);
var
  i,j : integer;
  t : longint;
begin
  t := 0;
  for i:=1 to min(j1,kk) do
    t := t + c[i1-1 , j1 - i] ;
  c[i1,j1] := t;
end;

procedure tinhtoan;
var
  i,j : integer;
begin
  for i:=1 to m do c[i,0]:=0;
  for j:=1 to n do c[0,j]:=0;
  c[0,0]:=1;

  for i:=1 to m do
    for j:=1 to n do
      tinh(i,j);
  writeln(out , c[m,n]);
end;

procedure docdl;
var
  i,j :integer;
  kt : char;
begin
  if seekeoln(inp) then {;}
  for i:=1 to n do
    begin
      read(inp , kt);
      a[i] := ord(kt) - 48 ;
    end;
  readln(inp);
end;

function GT(nn , mm , k : integer):longint;
var
  i:integer;
  t : longint;
begin
  t:= 0;
  if (mm > 0) then
  for i:=0 to min(k,nn) do
    t := t + C[mm - 1 , nn - i];
  GT := t;
end;

procedure timThuTu(a : Mavach ; var tt : longint);
var
  i,j,k : integer;
begin
  tt := 0;
  j := 0;k:=0;
  for i:=2 to n do
    begin
      if a[i]=1 then
        begin
          if k=0 then tt := tt + GT(n-i , m-j-1 , kk-1) else
                      tt := tt + GT(n-i , m - j , kk - k -1);
          if k>0 then begin
                        inc(j);
                        k:=0;
                      end;
        end else
      if a[i]=0 then
        begin
          if k=0 then inc(j);
          inc(k);
        end;
    end;
  tt := tt + 1;
end;

procedure cau1;
begin
  docdl;
  timThuTu(a , tt);
  writeln(out,tt );
end;

procedure TimMaVach(tt : longint ; var a : MaVach);
var
  i,j,k : integer;
  t : longint;
begin
  a[1]:=1;
  j:=0;k:=0;
  for i:=2 to n do
    begin
      if k=0 then t := GT(n-i , m - j - 1 , kk - 1) else
                  t := GT(n-i , m - j , kk - k - 1) ;
      if t < tt then
        begin
          tt := tt - t;
          a[i]:=1;
          if k>0 then begin inc(j) ; k:=0 end;
        end else
        begin
          a[i] := 0;
          if k=0 then inc(j);
          inc(k);
        end;
    end;
end;

procedure vietkq;
var
  i,j : integer;
begin
  for i:=1 to n do write(out , a[i]);
  writeln(out);
end;

procedure cau2;
begin
  readln(inp,tt);
  timMaVach(tt , a );
  vietkq;
end;

procedure lamviec;
var
  cau : byte;
begin
  while not seekeof(inp) do
    begin
      read(inp,cau);
      if cau=1 then cau1 else cau2;
    end;
end;

begin
  mofile;
  tinhtoan;
  lamviec;
  dongfile;
end.
