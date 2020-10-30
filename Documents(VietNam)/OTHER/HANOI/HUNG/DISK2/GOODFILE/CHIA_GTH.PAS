 uses  crt;
 type  mang=array[0..100,0..100] of byte;
 var a,a1:mang;
     b:array[0..100] of byte;
     f:text;
     front:array[0..100,0..100,1..2] of byte;
     m,n:byte;


 function min(i,j:byte):byte;
 begin
  min:=i;
  if j<i then min:=j;
 end;

 procedure readfile;
 var  i,j:byte;
 begin
    assign(f,'chia_hv.inp');
    reset(f);
    readln(f,m,n);
    writeln('INPUT:');
    writeln(m,'  ',n);
    for i:=1 to min(m,n) do
     read(f,b[i]);
    close(f);
 end;

 function max(i,j:byte):byte;
 begin
  max:=i;
  if j>i then max:=j;
 end;

 procedure innit;
 var i:byte;
 begin
 fillchar(a,sizeof(a),0);
 fillchar(front,sizeof(front),0);
 for i:=1 to max(m,n) do begin a[i,1]:=b[1]*i;a[1,i]:=i*b[1];end;
 end;

 procedure  xuat(i,j:byte);
 begin
  if front[i,j,1]*front[i,j,2]>0 then
   begin
    if front[i,j,2]=i then
     begin
        xuat(i,j-front[i,j,1]);
        xuat(i-front[i,j,1],front[i,j,1]);
        write('[',front[i,j,1],'.',front[i,j,1],']');
     end;
    if front[i,j,2]=j then
     begin
        xuat(front[i,j,1],j-front[i,j,1]);
        xuat(i-front[i,j,1],j);
        write('[',front[i,j,1],'.',front[i,j,1],']');
     end;
   end;
 end;

 procedure xu_li;
 var i,j,k,d:byte;
 begin
  for i:=2 to m do
   for j:=2 to n do
    for k:=1 to min(i,j) do
      begin
        if (a[i,j]=0) or (a[i,j]>b[k]+a[k,j-k]+a[i-k,j]) then
         begin
           a[i,j]:=b[k]+a[k,j-k]+a[i-k,j];
           front[i,j,1]:=k;
           front[i,j,2]:=j;
         end;
      if (a[i,j]=0) or (a[i,j]>b[k]+a[i,j-k]+a[i-k,k]) then
        begin
            a[i,j]:=b[k]+a[i,j-k]+a[i-k,k];
            front[i,j,1]:=k;
            front[i,j,2]:=i;
        end;
      end;
        writeln('OUTPUT:');
       writeln(a[m,n]);
       xuat(m,n);
 end;

 begin  clrscr;
 readfile;
 innit;
 xu_li;
 readln
 end.

13 27
5 6
2 4 3 2 1

3 2
1 10
