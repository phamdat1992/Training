uses crt;
const fin='damcuoi.inp';
      fou='out1.dat';
var  mang:array[1..50,1..50] of byte;
     a,b,c,dt:array[1..50] of byte;
     s:string;
     n,m:byte;
     f:text;
     time1:longint absolute 0:$46c;
     time2:longint;

procedure readfile;
var i,j:byte;
begin
 fillchar(mang,sizeof(mang),0);
 assign(f,fin);
 reset(f);
 readln(f,n,m);
 for i:=1 to n do
  for j:=1 to m do read(f,mang[i,j]);
 close(f);
end;

procedure xuli;
var i,j,k:byte;
begin
 time2:=time1;
 fillchar(a,sizeof(a),0);
 b:=a;
 for i:=1 to n do
  if a[i]=0 then
   begin
     s:=chr(i);
     fillchar(c,sizeof(c),0);
     repeat
       k:=ord(s[length(s)]);
       delete(s,length(s),1);
       j:=0;
        repeat
        inc(j);
        if (c[j]=0) and (mang[k,j]>0) then
         begin
           c[j]:=1;
           dt[j]:=k;
           if b[j]>0 then s:=s+chr(b[j])
           else
             repeat
                  b[j]:=dt[j];
                  k:=a[dt[j]];
                  a[dt[j]]:=j;
                  j:=k;
             until j=0;
         end;
       until (j=0) or (j>m);
    until (s='') or (j=0);
 end;
 assign(f,fou);
 rewrite(f);
 k:=0;
 for i:=1 to n do
  if a[i]<>0 then inc(k);writeln(f,k);
 for i:=1 to n do
  if a[i]<>0 then writeln(f,'  chang trai ',i,'  ','lay co gai ',a[i]);
  writeln(F,'TIME RUN:',(TIME1-TIME2)/18.21:0:6);
 close(f);
end;

begin  clrscr;
readfile;
xuli
end.
4 4
1 2 3 4
1 3 2 1
2 4 1 3
2 2 1 4
2
  chang trai 1  lay co gai 2
  chang trai 3  lay co gai 1
TIME RUN:0.000000


