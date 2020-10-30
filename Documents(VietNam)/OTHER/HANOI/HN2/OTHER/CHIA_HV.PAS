 uses  crt;
 type  mang=array[0..120,0..120] of byte;
 var a,a1:mang;
     b:array[0..100] of byte;
     f:text;
     time1:longint absolute 0:$46c;
     time2:longint;
     front:array[0..120,0..120,1..2] of byte;
     m,n:integer;

 procedure innit;
 var i:integer;
 begin
 i:=m;
 if m>n then begin m:=n;n:=i;end;
 fillchar(a,sizeof(a),0);
 fillchar(front,sizeof(front),0);
 for i:=1 to n do a[i,i]:=1;
 end;

 procedure  xuat(i,j:integer);
 begin
   if i=j then write('[',i,'.',j,']')
   else
    begin
      if front[i,j,1]*front[i,j,2]>0 then xuat(front[i,j,1],front[i,j,2]);
      if (i-front[i,j,1])*front[i,j,2]>0 then xuat(i-front[i,j,1],front[i,j,2]);
      if front[i,j,1]*(j-front[i,j,2])>0 then xuat(front[i,j,1],j-front[i,j,2]);
      if (i-front[i,j,1])*(j-front[i,j,2])>0 then xuat(i-front[i,j,1],j-front[i,j,2]);
    end;
 end;

 procedure xu_li;
 var i,j,k,d:integer;
 begin
  time2:=time1;
  for i:=1 to m do
   for j:=i+1 to n do
    for k:=1 to i do
     for d:=1 to j do
       if (a[i,j]=0) or (a[i,j]>a[k,d]+a[k,j-d]+a[i-k,d]+a[i-k,j-d]) then
        begin
          a[i,j]:=a[k,d]+a[k,j-d]+a[i-k,d]+a[i-k,j-d];
          a[j,i]:=a[i,j];
          front[i,j,1]:=k;
          front[i,j,2]:=d;
          front[j,i,1]:=d;
          front[j,i,2]:=k;
        end;
        writeln('OUTPUT:');writeln(a[m,n]);
    xuat(m,n);writeln;
    writeln('TIME RUN:',((TIME1-TIME2)/18.21):6:6);
 end;

 begin  clrscr;
 write('m,n=');readln(m,n);
 innit;
 xu_li;
 readln
 end.
