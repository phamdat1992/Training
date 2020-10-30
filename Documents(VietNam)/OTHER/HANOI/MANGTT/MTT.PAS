{$R+,B-}
const
     fi='mtt4.inp';
     fo='mtt4.out';
var
   n,i,j,sc:byte;
   f:text;
   tc,tc1:array[1..20,1..20] of real;
   canh,cay:array[1..50,1..2] of byte;
   dtc,dtcmax:real;
   th:array[1..20] of byte;
   a:array[1..20,1..20] of byte;
procedure doc;
var
   x:real;
   u,v:byte;
begin
fillchar(canh,sizeof(canh),0);
fillchar(tc,sizeof(tc),0);
assign(f,fi);reset(f);
readln(f,n,i,j);
sc:=0;
for u:=1 to n do
for v:=1 to n do read(f,tc[u,v]);
for u:=1 to n-1 do
for v:=u+1 to n do if tc[u,v]>0 then
    begin inc(sc);canh[sc,1]:=u;canh[sc,2]:=v;end;
close(f);
end;
procedure c1;
var
   dd:array[1..20] of real;
   tcn:array[1..20] of byte;
   max:real;
   truoc:array[1..20] of byte;
   last,u,v,sn:byte;
begin
fillchar(truoc,sizeof(truoc),0);
fillchar(tcn,sizeof(tcn),0);
for u:=1 to 20 do dd[u]:=0;
last:=i;dd[last]:=1;truoc[last]:=100;
while truoc[j]<100 do
      begin
      for u:=1 to n do if (truoc[u]<100)and(dd[u]<dd[last]*tc[last,u]) then
          begin dd[u]:=dd[last]+tc[last,u];truoc[u]:=last;end;
      max:=0;
      for u:=1 to n do if (truoc[u]<100)and(dd[u]>max) then
          begin
          max:=dd[u];last:=u;
          end;
      inc(truoc[last],100);
      end;
assign(f,fo);rewrite(f);
writeln(f,dd[last]):0:10);
sn:=1;tcn[sn]:=j;
while last<>i do
      begin
      last:=truoc[last]-100;
      inc(sn);tcn[sn]:=last;
      end;
writeln(f,sn);
for u:=sn downto 1 do writeln(f,tcn[u]);
close(f);
end;
function lt:boolean;
var
   tp:array[1..20] of byte;
   c,z:byte;
procedure di(x:byte);
var
   y:byte;
begin
tp[x]:=c;
for y:=1 to n do if (tp[y]=0)and(a[x,y]>0) then di(y);
end;
begin
fillchar(tp,sizeof(tp),0);c:=0;
fillchar(a,sizeof(a),0);
for z:=1 to n-1 do
    begin
    a[canh[th[z],1],canh[th[z],2]]:=1;
    a[canh[th[z],2],canh[th[z],1]]:=1;
    end;
for z:=1 to n do if tp[z]=0 then begin inc(c);di(z);end;
lt:=(c=1);
end;
procedure floyd;
var
   x1,x2,x3,x4,gn1,gn2:byte;max:real;
   dd1:array[1..20,1..20] of real;
begin
for x1:=1 to n do
for x2:=1 to n do if a[x1,x2]>0 then tc1[x1,x2]:=tc[x1,x2];
for x1:=1 to n do
for x2:=1 to n do dd1[x1,x2]:=tc1[x1,x2];
for x1:=1 to n do dd1[x1,x1]:=1;
for x4:=1 to n do
for x2:=1 to n do
for x3:=1 to n do
    if dd1[x2,x3]<dd1[x2,x4]*dd1[x4,x3]
       then dd1[x2,x3]:=dd1[x2,x4]*dd1[x4,x3];
dtc:=1e38;
for x1:=1 to n do
for x2:=1 to n do if dd1[x1,x2]<dtc then dtc:=dd1[x1,x2];
end;
procedure xuly;
var
   z2:byte;
begin
floyd;
if dtc<dtcmax then
   begin
   fillchar(cay,sizeof(cay),0);cay:=canh;dtcmax:=dtc;
   end;
end;
procedure sinh;
var
   t1,t2:byte;
begin
for t1:=1 to n-1 do th[t1]:=t1;
dtcmax:=0;
while t1>0 do
      begin
      if lt then xuly;
      t1:=n-1;
      while (t1>=1)and(th[t1]=sc-n+1+t1) do dec(t1);
      if t1>0 then
         begin
         inc(th[t1]);
         if t1<n-1 then for t2:=t1+1 to n-1 do th[t2]:=th[t1]+t2-t1;
         end;
      end;
end;
procedure viet;
var
   i:byte;
begin
assign(f,fo);append(f);
writeln(f,dtcmax:0:10);
for i:=1 to n-1 do writeln(f,cay[i,1]:5,cay[i,2]:5);
close(f);
end;
BEGIN
doc;c1;sinh;viet;
END.
