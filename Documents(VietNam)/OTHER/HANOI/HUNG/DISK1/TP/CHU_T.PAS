 Uses Crt;
 Const fi='Chu_T.inp';
       fo='Chu_T.out';
       c1:array[1..4] of shortint=(0,-1,1,0);
       c2:array[1..4] of shortint=(1,0,0,-1);
       maxm=170;maxn=70;
 Type  mang=array[0..170,0..70] of 0..1;
 Var a,b,tg:mang;
     val:array[0..170,0..70] of word;
     m,n,m1,n1,minx,miny,maxx,maxy,dem:integer;
     soluong:integer;
     ok:array[0..1000] of boolean;
     f,f1:text;

 Procedure  DocFileDuLieu;
 Var  i,j:byte;ch:char;
 Begin
  randomize;
  fillchar(a,sizeof(a),0);
  m:=maxm;n:=maxn;
  for i:=1 to m do
   for j:=1 to n do a[i,j]:=random(2); {
   assign(f,fi);
   reset(f);
   readln(f,m,n);
    for i:=1 to m do
     begin
      for j:=1 to n do read(f,a[i,j]);
      readln(f);
     end;
     close(f);                          }
 End;

 Procedure QuayMang;
 Var  i,j:byte;
 Begin
   tg:=b;
   for I:=1 to n1 do
    for j:=1 to m1 do
     b[i,j]:=tg[j,n1-i+1];
     i:=m1;m1:=n1;n1:=i;
 End;

 Function XuLiMang:boolean;
 Var i,j:byte;
 Begin
   XuLiMang:=false;
   i:=1;
   while (i<=4) and ((b[1,1]=0) or (b[1,n1]=0)) do begin QuayMang;inc(i);end;
   if i>4 then  exit;
   XuLiMang:=true;
 End;

 Procedure  ChuyenMang;
 Var  i,j:byte;
 Begin
    fillchar(b,sizeof(b),0);
    m1:=0;n1:=0;
    for i:=minx to maxx do
     for j:=miny to maxy do
      if val[i,j]=dem then
        b[i-minx+1,j-miny+1]:=a[i,j];
        m1:=maxx-minx+1;n1:=maxy-miny+1;
 End;

 Procedure Visit(i,j:byte);
 Var k:byte;
 Begin
   val[i,j]:=dem;
   inc(soluong);
   if i>maxx then maxx:=i;
   if i<minx then minx:=i;
   if J>maxy then maxy:=j;
   if j<miny then miny:=j;
   for k:=1 to 4 do
    if (i+c1[k]>0) and (i+c1[k]<=m) and (j+c2[k]>0) and (j+c2[k]<=n) then
     if (val[i+c1[k],j+c2[k]]=0) and (a[i+c1[k],j+c2[k]]=1) then visit(i+c1[k],j+c2[k]);
 End;

 Function KiemTraChuT:boolean;
 Var  i,j,j1,i2,j2:byte;
 Begin
      KiemTraChuT:=false;
      i:=1;
      while (b[i,1]=1) and (i<=m1) do inc(i);
      if i>m1 then exit;
      j:=1;
      while (b[m1,j]=0) and (j<=n1) do inc(j);
      if (j=1) or (j>n1) then exit;
      j1:=j;
      while (j1<=n1) and (b[m1,j1]=1) do inc(j1);
      if j1>n1 then exit;
      for i2:=i to m1 do
          for j2:=1 to n1 do
        if (b[i2,j2]=1) and ((j2<j) or (j2>=j1)) then exit;
      if (m1-i+1)*(j-1)+(m1-i+1)*(n1-j1+1)+soluong<>m1*n1 then exit;
      KiemTraChuT:=true;
 End;

 Procedure XuLi;
 Var i,j:byte;
 Begin
   fillchar(val,sizeof(val),0);
   fillchar(ok,sizeof(ok),false);
   dem:=0;
   for i:=1 to m do
    for j:=1 to n do
      if (a[i,j]=1) and (val[i,j]=0) then
       begin
          m1:=0;n1:=0;
          minx:=200;miny:=200;maxx:=0;maxy:=0;
          inc(dem);soluong:=0;
          Visit(i,j);
          ChuyenMang;
          ok[dem]:=XuLiMang;
          if ok[dem] then  ok[dem]:=KiemTraChuT;
       end;
 End;

 Procedure Xuat;
 Var  i,j:byte;
 Begin
  for i:=1 to m do
   begin
   for j:=1 to n do
     begin
      if ok[val[i,j]] then textcolor(green)
      else textcolor(white);
      write(a[i,j]);
     end;
     delay(90);
     writeln;
   end;
   readln;
 End;

 Procedure Main;
 Begin
   DocFileDuLieu;
   XuLi;
   Xuat;
 End;

 Begin  clrscr;
  Main;
 End.
 5 6
 1 0 0 1 0 1
 1 1 1 1 0 1
 1 0 0 1 0 1
 0 0 0 0 1 1
 0 0 0 0 0 1
