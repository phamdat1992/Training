{$R+,S+,Q+,B-}
Const
  inp='dark.inp';
  out='light.out';
  max=100;
  eps=0.00001;

  mid=max*max;
Type
  tree=record
    x,y,h:real;
  end;
  seg=record
    x,y:real;
  end;

  mang=array[1..max] of seg;
  mang2=array[1..mid] of real;
  mang3=array[mid+1..mid+mid] of real;
Var
  f:text;
  l,h:real;
  n:integer;
  a:array[1..max] of real;
  m:integer;
  t:array[1..max] of tree;

  (*------------------------*)
  s:array[1..max] of integer;
  c:array[1..max] of ^mang;

  (*------------------------*)
  top:integer;
  cx:^mang2;
  cy:^mang3;

  kq:real;


Function Equal(x,y:real):boolean;
Begin
  equal:=abs(x-y)<=eps;
End;

Procedure Input;
Var i:integer;
Begin
  assign(f,inp);reset(f);
  readln(f,l,n,h,m);
  for i:=1 to n do read(f,a[i]);
  readln(f);
  for i:=1 to m do read(f,t[i].x,t[i].y,t[i].h);
  close(f);
End;

Procedure Xet(den,cay:integer);
Var left,right:real;
Begin
  right:=(h*t[cay].y - t[cay].h*a[den])/(h-t[cay].h);
  left:= (h*t[cay].x - t[cay].h*a[den])/(h-t[cay].h);

  if right>l then right:=l;
  if left<0 then left:=0;
  if right<=left then exit;

  inc(s[den]);
  c[den]^[s[den]].x:=left;
  c[den]^[s[den]].y:=right;
End;

Procedure Init;
Var i,j:integer;
Begin
  fillchar(s,sizeof(s),0);
  for i:=1 to n do new(c[i]);

  for i:=1 to n do
  for j:=1 to m do xet(i,j);
End;

Procedure Sort1(Var u:mang;s:integer);
Var i,j:integer;
    z:seg;
Begin
  for i:=1 to s-1 do
  for j:=i+1 to s do
  if u[i].x>u[j].x then
  begin
    z:=u[i];u[i]:=u[j];u[j]:=z;
  end;
End;

Procedure Xet2(den:integer);
Var s2:integer;
    u:mang;
    i:integer;
Begin
  sort1(c[den]^,s[den]);
  u[1]:=c[den]^[1];s2:=1;

  for i:=2 to s[den] do
  if c[den]^[i].x>u[s2].y then
  begin
    inc(s2);u[s2]:=c[den]^[i];
  end else
  begin
    if c[den]^[i].y>u[s2].y then u[s2].y:=c[den]^[i].y;
  end;

  s[den]:=s2;
  c[den]^:=u;
End;

Procedure Init2;
Var i:integer;
Begin
  for i:=1 to n do
  xet2(i);
End;

(*-------------------------------------------------*)

Procedure Add(x:real);
Begin
  inc(top);
  if top>mid then cy^[top]:=x else cx^[top]:=x;
End;

Function Get(vt:integer):real;
Begin
  if vt>mid then get:=cy^[vt] else get:=cx^[vt];
End;

Procedure Swap(x,y:integer);
Var z:real;
Begin
  if x>mid then
    if y>mid then
    begin
      z:=cy^[x];cy^[x]:=cy^[y];cy^[y]:=z;
    end else
    begin
      z:=cy^[x];cy^[x]:=cx^[y];cx^[y]:=z;
    end
  else
    if y>mid then
    begin
      z:=cx^[x];cx^[x]:=cy^[y];cy^[y]:=z;
    end else
    begin
      z:=cx^[x];cx^[x]:=cx^[y];cx^[y]:=z;
    end;
End;

Procedure Sort2(dau,cuoi:integer);
Var i,j:integer;
    g:real;
    tg:real;
Begin
  i:=dau;j:=cuoi;
  g:=get((dau+cuoi) div 2);

  repeat
    while get(i)<g do inc(i);
    while get(j)>g do dec(j);
    if i<=j then
    begin
      swap(i,j);
      inc(i);dec(j);
    end;
  until i>j;
  if i<cuoi then Sort2(i,cuoi);
  if j>dau  then Sort2(dau,j );
End;

Procedure Init3;
Var i,j:integer;
Begin
  new(cx);new(cy);
  top:=0;

  for i:=1 to n do
  for j:=1 to s[i] do
  begin
    add(c[i]^[j].x);
    add(c[i]^[j].y);
  end;

  Sort2(1,top);
End;

(*-----------------------------------------------------*)

Function Namtrong(x,y:real;t:integer):boolean;
Var dau,cuoi:integer;
    g:integer;
Begin
  dau:=1;cuoi:=s[t];
  while dau<=cuoi do
  begin
    g:=(dau+cuoi) div 2;
    if c[t]^[g].y<x then dau:=g+1
    else
    if c[t]^[g].x>y then cuoi:=g-1
    else begin namtrong:=true;exit;end;
  end;
  namtrong:=false;
End;

Procedure Xuly3(x,y:real);
Var i:integer;
Begin
  if x<y then
  begin
    for i:=1 to n do
    if not namtrong(x,y,i) then exit;
    kq:=kq+y-x;
  end;
End;

Procedure Solve;
Var i:integer;
Begin
  for i:=2 to top do
  xuly3(get(i-1),get(i));
End;

Procedure Output;
Begin
  assign(f,out);rewrite(f);
  writeln(f,kq:0:0);
  close(f);
End;

BEGIN
  input;
  init;
  init2;
  init3;
  solve;
  output;
END.