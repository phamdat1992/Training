{$R+}
Uses crt;
const
  fi='bus.in7';
  fo='bus.out';
var
  a : array[1..100]of longint;
  n , L : longint;
  c , truoc : array[0..1000]of longint;

procedure docfile;
var
  i,j : longint;
  f : text;
begin
  assign(f,fi);
  reset(f);
  readln(f,n,L);
  for i:=1 to n do read(f,a[i]);
  close(f);
end;

procedure khoitao;
var
  i,j : longint;
begin
  fillchar(truoc,sizeof(truoc),0);
  for i:=1 to L do c[i] := maxInt;
  c[0] := 0;
end;

procedure lamviec;
var
  i,j : longint;
begin
  for i:=1 to n do
    for j:=0 to L - i do
      if c[ j+ i  ] > c[j] + a[i] then
        begin
          c[j + i] := c[j] + a[i];
          truoc[j+i] := i;
        end;
end;

procedure inkq;
var
  i,j , d : longint;
  f : text;
  di : array[1..200] of longint;
begin
  fillchar(di,sizeof(di),0);
  j := L; d:=0;
  while j<>0 do
    begin
      i := truoc[j];
      inc(d);
      inc(di[i]);
      dec(j,i);
    end;
  assign(f,fo);
  rewrite(f);
  writeln(f,c[L]);
  writeln(f,d);
  for i:=1 to n do
    for j:=1 to di[i] do write(f,i,'  ');
  close(f);
end;

procedure test;
var
  i,j : longint;
  f : text;
begin
  randomize;
  assign(f,fi);
  rewrite(f);
  n := 20;
  writeln(f,n,'  ',200);
  for i:=1 to n do write(f,19*random(10000)+1,'  ');
  close(f);
end;

begin
  docfile;
  khoitao;
  lamviec;
  inkq;
end.

10 15
12  21  31  40  49  58  69  79  90  101
