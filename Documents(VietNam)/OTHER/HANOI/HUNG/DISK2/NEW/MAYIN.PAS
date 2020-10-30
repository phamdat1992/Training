{$M 65000,0,655360}
const
     fi='print.inp';
     fo='print.out';
type
    mang=array[1..200,201..400] of shortint;
var
   a:^mang;
   xa:array[1..200,201..400] of shortint;
   vao:array[1..200] of integer;
   ra:array[200..400] of integer;
   dd:array[0..401] of integer;
   cap:array[1..400] of integer;
   xv:array[0..401] of integer;
   chua:array[0..401] of boolean;
   m,n:integer;
   f:text;
procedure nhap;
var
   p,q:integer;
begin
fillchar(a^,sizeof(a^),0);
assign(f,fi);reset(f);
readln(f,m,n);
while not(seekeof(f)) do
      begin readln(f,p,q);a^[p,200+q]:=1;end;
close(f);
end;
procedure taomang;
{dinh s=0;dinh t=200+n+1}
var
   u,x,y,f,c:integer;
   q:array[1..500] of integer;
begin
fillchar(xv,sizeof(xv),0);
fillchar(xa,sizeof(xa),0);
fillchar(vao,sizeof(vao),0);
fillchar(ra,sizeof(ra),0);
for u:=0 to m do dd[u]:=maxint;
for u:=201 to 200+n+1 do dd[u]:=maxint;
xv[0]:=1;dd[0]:=0;f:=1;c:=0;
for x:=1 to m do if cap[x]=0 then
    begin
    vao[x]:=1;dd[x]:=1;xv[x]:=1;
    inc(c);q[c]:=x;
    end;
while f<=c do
      begin
      u:=q[f];inc(f);
      if u>200 then
         if cap[u]=0 then{Neu u la dinh tu do thuoc Y}
            begin ra[u]:=1;xv[200+n+1]:=1;dd[200+n+1]:=dd[u]+1;end
         else {Neu u la dinh khong tu do thuoc Y}
             begin
             x:=cap[u];
             if dd[200+n+1]=maxint then
                begin
                inc(c);q[c]:=x;xv[x]:=1;dd[x]:=dd[u]+1;
                xa[x,u]:=-1;
                end;
             end
      else {Neu u thuoc X}
      for y:=201 to 200+n do if (a^[u,y]=1)and(dd[u]<dd[y]) then
          begin
          if dd[y]=maxint then begin inc(c);q[c]:=y;end;
          xa[u,y]:=1;xv[y]:=1;
          dd[y]:=dd[u]+1;
          end;
      end;
end;
procedure luong;
var
   u,x,y,xet,top:integer;
   st:array[1..500] of integer;
begin
fillchar(st,sizeof(st),0);
fillchar(chua,sizeof(chua),false);
for u:=0 to m do if xv[u]=1 then chua[u]:=true;
for u:=201 to 200+n+1 do if xv[u]=1 then chua[u]:=true;
top:=1;st[top]:=0;chua[0]:=false;
while top>0 do
      begin
      u:=st[top];
      if u=0 then
      begin
      xet:=1;
      while xet<=m do
            if (chua[xet]) and (vao[xet]=1) then break else inc(xet);
      if xet>m then dec(top)
      else begin inc(top);st[top]:=xet;chua[xet]:=false;end;
      end;
      if (1<=u)and(u<=m) then
      begin
      xet:=201;
      while xet<=200+n do
            if chua[xet] and(xa[u,xet]=1) then break else inc(xet);
      if xet>200+n then dec(top) else
         begin inc(top);st[top]:=xet;chua[xet]:=false;end;
      end;
      if (201<=u)and(u<=200+n) then
      if ra[u]=1 then while st[top]<>0 do
             begin
             x:=st[top];dec(top);y:=st[top];dec(top);
             cap[x]:=y;cap[y]:=x;
             end
      else
          begin
          xet:=1;
          while xet<=m do
            if (chua[xet]) and (xa[xet,u]=-1) then break else inc(xet);
            if xet>m then dec(top) else
               begin inc(top);st[top]:=xet;chua[xet]:=false;end;
          end;
      end;{While TOP>0}
end;
procedure viet;
var
   t,u,v,dem:integer;
   k:integer;
begin
assign(f,fo);rewrite(f);dem:=0;
for u:=1 to m do if cap[u]<>0 then inc(dem);
t:=m-dem;
writeln(f,t);
k:=0;
if t>0 then
for u:=1 to m do if cap[u]=0 then
    for v:=201 to 200+n do if cap[v]=0 then
        begin cap[u]:=v;cap[v]:=u;break;end;
for u:=1 to m do writeln(f,cap[u]-200);
close(f);
end;
BEGIN
new(a);
nhap;
fillchar(cap,sizeof(cap),0);
taomang;
repeat
luong;
taomang;
until dd[200+n+1]=maxint;
viet;
dispose(a);
END.
