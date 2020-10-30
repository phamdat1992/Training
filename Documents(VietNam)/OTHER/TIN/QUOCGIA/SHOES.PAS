{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65000,0,655360}
program  thue_day;
const        fi=        'shoes.inp';
             fo=        'shoes.out';
             nmax=100;
type         mang1=array[1..nmax] of integer;
             mang2=array[1..nmax,1..nmax] of integer;
var         s,h:mang1;
            c:mang2;
            m,n,u,v:integer;
            y,fx,fy,truoc:array[1..2*nmax] of integer;

procedure   docf;
var      f:text;
         i,j:integer;
begin
assign(f,fi);
reset(f);
readln(f,m,n);
for i:=1 to m do read(f,s[i]);
  readln(f);
  for i:=1 to n do read(f,h[i]);
close(f);
for i:=1 to n do
    for j:=1 to m do c[i,j]:=abs(h[i]-s[j]);
end;
procedure  init;
var   i,j:integer;
begin
for i:=1 to n do
begin
y[i]:=0;
fx[i]:=0;
end;
for i:=1 to n do
  begin
    fy[i]:=c[1,i];
    for j:=2 to m do if c[j,i]<fy[i] then fy[i]:=c[j,i];
  end;
end;
procedure  loang(u:byte);
var           dau,cuoi,x,i:integer;
               q:array[1..2*nmax] of integer;
begin
for i:=1 to m+n do  truoc[i]:=0;
dau:=1;
cuoi:=1;
q[cuoi]:=u;
truoc[u]:=u;
while dau<=cuoi do
  begin
    x:=q[dau];
    inc(dau);
    if x>n then
      begin
        inc(cuoi);
        q[cuoi]:=y[x-n];
        truoc[y[x-n]]:=x;
      end
      else
        begin
          for i:=n+1 to m+n do
              if truoc[i]=0 then
                if fx[x]+fy[i-n]=c[x,i-n] then
                    begin
                       inc(cuoi);
                       q[cuoi]:=i;
                       truoc[i]:=x;
                       if y[i-n]=0 then
                          begin
                            v:=i;
                            exit;
                          end;
                    end;
        end;
  end;
end;
procedure   suanhan;
var    i,j:integer;
       d:longint;
begin
d:=maxlongint;
for i:=1 to n do if truoc[i]>0 then
  for j:=1 to m do if truoc[j+n]=0 then
    if c[i,j]-fx[i]-fy[j]<d then d:=c[i,j]-fx[i]-fy[j];
for i:=1 to n do if truoc[i]>0 then inc(fx[i],d);
for j:=1 to m do if truoc[j+n]>0 then dec(fy[j],d);
end;
procedure    tangcapghep;
begin
while v<>u do
  begin
    y[v-n]:=truoc[v];
    v:=truoc[truoc[v]];
  end;
end;
procedure     ghep;
begin
for u:=1 to n do
  begin
    v:=0;
    loang(u);
    while v=0 do
      begin
         suanhan;
         loang(u);
      end;
      tangcapghep;
  end;
end;
procedure   xuat;
var       f:text;
          x:array[1..nmax] of integer;
          i:integer;
          tong:integer;
begin
assign(f,fo);
rewrite(f);
tong:=0;
for i:=1 to m do
  if y[i]<>0 then
    begin
      x[y[i]]:=i;
      inc(tong,c[y[i],i]);
    end;
writeln(f,tong);
for i:=1 to n do write(f,x[i],' ');
close(f);
end;
begin
docf;
init;
ghep;
xuat;
end.
