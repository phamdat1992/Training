{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 16384,0,655360}

 uses crt;
 type  mang=array[1..70,1..70] of longint;
 var  a,best:mang;
      b:array[1..70] of byte;
      n:byte;
      f,f1:text;

 procedure  readfile;
 var i:byte;
 begin
   assign(f1,'nhan_mt.out');
   rewrite(f1);
   assign(f,'nhan_mt.inp');
   reset(f);
   readln(f,n);
   writeln(f1,'INPUT:');
   writeln(f1,n);
   for i:=1 to n+1 do begin read(f,b[i]);write(f1,b[i]:5);end;
   close(f);
 end;

 procedure  xuat(i,j:byte);
 begin
  if i=j then
     write(f1,'[',b[i],'.',b[i+1],']')
  else
   begin
    write(f1,'(');
    xuat(i,best[i,j]-1);
    write(f1,'*');
    xuat(best[i,j],j);
    write(f1,')');
    end;
 end;

 procedure  xu_li;
 var  i,j,k:byte;
      min:longint;
 begin
  readfile;
  fillchar(a,sizeof(a),0);
  best:=a;
  for j:=1 to n-1 do
   for i:=1 to n-j do
    for k:=i+1 to i+j do
     begin
        min:=a[i,k-1]+a[k,i+j]+b[i]*b[k]*b[i+j+1];
        if (min<a[i,i+j]) or (a[i,i+j]=0) then
         begin
           a[i,i+j]:=min;
           best[i,i+j]:=k;
         end;
     end;
     writeln(f1);
     writeln(f1,'OUTPUT:');
     writeln(f1,a[1,n]);
     xuat(1,n);
     writeln(f1);
     close(f1);
  end;

 begin  clrscr;
 xu_li;
 end.

 3
 2 3 1 3
 6
 3 2 3 1 2 2 3
 20
 2 3 3 4 5 6 1 2 3 1 5 10 2 5 4 7 8 9 10 1 2


INPUT:
6
    3    2    3    1    2    2    3
OUTPUT:
31
(([3.2]*([2.3]*[3.1]))*(([1.2]*[2.2])*[2.3]))
