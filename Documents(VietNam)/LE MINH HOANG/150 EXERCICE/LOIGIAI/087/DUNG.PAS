{$M 60000,0,655360}
{$R+,S+,Q+,B-}
Const
  inp='house.inp';
  out='house.ou2';
  max=101;

  xx:array[1..4] of integer=(-1,0,1,0);
  yy:array[1..4] of integer=(0,1,0,-1);
Type
  link=^o;
  o=record
    x,y:integer;
    next:link;
  end;

  mang=array[1..10000] of integer;
  mang2=array[1..5000] of integer;

  bana=record
    x,y,u,v:byte;
  end;
  mangbana=array[1..5000] of bana;
Var
  f:text;
  n:integer;
  a:array[1..max,1..max] of integer;

  (*--------------------*)
  top:integer;
  h:array[1..5000] of link;
  s:^mang;
  l:array[1..5000] of integer;
  dx:array[0..max,0..max] of boolean;

  kq:integer;


  b:^mangbana;


Procedure Input;
Var i,j:integer;
Begin
  assign(f,inp);reset(f);
  readln(f,n);
  for i:=1 to n do
  begin
    for j:=1 to n do read(f,a[i,j]);
    readln(f);
  end;
  close(f);
End;

Procedure Add(x,y:integer);
Var temp:link;
Begin
  new(temp);
  temp^.x:=x;
  temp^.y:=y;
  temp^.next:=h[top];
  h[top]:=temp;
  dx[x,y]:=false;
  inc(s^[top]);

  if b^[top].u<x then b^[top].u:=x;
  if b^[top].v<y then b^[top].v:=y;
  if b^[top].y>y then b^[top].y:=y;
End;

Procedure Loang(x,y:integer);
Var i:integer;
Begin
  for i:=1 to 4 do
  if dx[x+xx[i],y+yy[i]] and (a[x+xx[i],y+yy[i]]=1) then
  begin
    add(x+xx[i],y+yy[i]);
    loang(x+xx[i],y+yy[i]);
  end;
End;

Procedure Init2;
Var i,j:integer;
Begin
  fillchar(dx,sizeof(dx),true);
  for i:=1 to n do
  begin
    dx[0,i]:=false;dx[n+1,i]:=false;
    dx[i,0]:=false;dx[i,n+1]:=false;
  end;
  top:=0;
  new(s);  new(b);
  for i:=1 to n do
  for j:=1 to n do
  if dx[i,j] and (a[i,j]=1) then
  begin
    inc(top);
    h[top]:=nil;
    s^[top]:=0;
    b^[top].x:=i;b^[top].y:=150;
    b^[top].v:=0;b^[top].u:=0;
    add(i,j);
    loang(i,j);
  end;
End;

Procedure Doc1(x:integer;var u:mang);
Var p:link;
    top:integer;
Begin
  p:=h[x];
  top:=0;
  while p<>nil do
  begin
    inc(top);
    u[top]:=(p^.x-1)*n+p^.y;
    p:=p^.next;
  end;
End;

Procedure Doc2(x:integer;var u:mang);
Var p:link;
    top:integer;
Begin
  p:=h[x];
  top:=0;
  while p<>nil do
  begin
    inc(top);
    u[top]:=(n-p^.y)*n+p^.x;
    p:=p^.next;
  end;
End;

Procedure Doc3(x:integer;var u:mang);
Var p:link;
    top:integer;
Begin
  p:=h[x];
  top:=0;
  while p<>nil do
  begin
    inc(top);
    u[top]:=(n-p^.x)*n+n-p^.y+1;
    p:=p^.next;
  end;
End;

Procedure Doc4(x:integer;var u:mang);
Var p:link;
    top:integer;
Begin
  p:=h[x];
  top:=0;
  while p<>nil do
  begin
    inc(top);
    u[top]:=(p^.y-1)*n+n-p^.x+1;
    p:=p^.next;
  end;
End;

Procedure Qsort(Var u:mang;top:integer);
    Procedure Q(dau,cuoi:integer);
    Var i,j,g,tg:integer;
    Begin
      i:=dau;j:=cuoi;g:=u[(i+j) div 2];
      repeat
        while u[i]<g do inc(i);
        while u[j]>g do dec(j);
        if i<=j then
        begin
          tg:=u[i];u[i]:=u[j];u[j]:=tg;
          inc(i);dec(j);
        end;
      until i>j;
      if i<cuoi then Q(i,cuoi);
      if j>dau then Q(dau,j);
    End;
Begin
  Q(1,top);
End;

Function Bangnhau(x,y:integer):boolean;
Var u,v:mang;
    m1,m2,n1,n2:integer;
    Function ss:boolean;
    Var i:integer;
    Begin
      for i:=2 to s^[x] do
      if u[i]-u[i-1]<>v[i]-v[i-1] then
      begin
        ss:=false;exit;
      end;
      ss:=true;
    End;
Begin
  bangnhau:=false;
  if s^[x]<>s^[y] then exit;

  m1:=b^[x].u-b^[x].x;
  m2:=b^[y].u-b^[y].x;
  n1:=b^[x].v-b^[x].y;
  n2:=b^[y].v-b^[y].y;

  doc1(x,u);
  if (m1=m2) and (n1=n2) then
  begin
    doc1(y,v);
    Qsort(u,s^[x]);Qsort(v,s^[y]);
    if ss then begin bangnhau:=true;exit;end;
  end;

  if (m1=n2) and (m2=n1) then
  begin
    doc2(y,v);
    Qsort(u,s^[x]);Qsort(v,s^[y]);
    if ss then begin bangnhau:=true;exit;end;
  end;

  if (m1=m2) and (n1=n2) then
  begin
    doc3(y,v);
    Qsort(u,s^[x]);Qsort(v,s^[y]);
    if ss then begin bangnhau:=true;exit;end;
  end;

  if (m1=n2) and (m2=n1) then
  begin
    doc4(y,v);
    Qsort(u,s^[x]);Qsort(v,s^[y]);
    if ss then begin bangnhau:=true;exit;end;
  end;
End;

Procedure Solve;
Var i,j:integer;
Begin
  fillchar(l,sizeof(l),0);
  kq:=0;
  for i:=1 to top do
  if l[i]=0 then
  begin
    inc(kq);l[i]:=kq;
    for j:=i+1 to top do
    if (l[j]=0) and (bangnhau(i,j)) then l[j]:=kq;
  end;
End;

Procedure Output;
Var c:array[1..max,1..max] of integer;
    i,j:integer;
    p:link;
    x,y:integer;
Begin
  assign(f,out);rewrite(f);
  writeln(f,kq);
  fillchar(c,sizeof(c),0);

  for i:=1 to top do
  begin
    p:=h[i];
    while p<>nil do
    begin
      x:=p^.x;
      y:=p^.y;
      c[x,y]:=l[i];
      p:=p^.next;
    end;
  end;
  for i:=1 to n do
  begin
    for j:=1 to n do write(f,c[i,j],' ');
    writeln(f);
  end;
  close(f);
End;

BEGIN
  input;
  init2;
  solve;
  output;
END.