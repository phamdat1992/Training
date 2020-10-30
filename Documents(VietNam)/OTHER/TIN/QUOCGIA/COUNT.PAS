{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65000,0,655360}
program  dem;
const        fi=        'count.inp';
             fo=        'count.out';
             nmax=16000;
type         mang1=array[1..nmax+1] of byte;
var           n,min:integer;
              d:mang1;
procedure     ql(k:byte;i,t:integer);
var   j:integer;
begin
if k=1 then
  for j:=i to i+t-1 do d[j]:=1;
if k=2 then
   for j:=i to i+t-1 do d[j]:=0;
end;
procedure  ktra;
var       vitri,m,i:integer;
begin
min:=-maxint;
i:=1;
while i<=n do
   begin
   if d[i]=0 then
     begin
       m:=i;
       while d[m]=0 do inc(m);
       if m-i>min then
           min:=m-i;
       i:=m+1;
     end
    else inc(i);
    end;
end;
procedure   docf;
var      f:text;   g:text;
         i,k1,k2,k3,k4:integer;
begin
assign(g,fo);rewrite(g);
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do d[i]:=0;
d[n+1]:=1;
while not seekeof(f) do
 begin
      read(f,k1);
      if k1<>3 then
        begin
           read(f,k2,k3);
           readln(f);
           ql(k1,k2,k3);
        end;
        if k1=3 then
          begin
            ktra;
            writeln(g,min);
          end;
end;
close(f); close(g);
end;
begin
docf;
end.

