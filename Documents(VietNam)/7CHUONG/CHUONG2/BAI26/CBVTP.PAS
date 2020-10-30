uses crt;
{$M 65000,0,655360}
const
     fi='bv.in';
     fhs='bv.out';
     bb='b.';
type
    canh=array[1..10000,1..3] of word;
var
   c:^canh;
   tp:array[1..5000] of byte;
   dau,cuoi:array[1..5000] of word;
   f:text;tb:boolean;
   t:char;mm:pointer;
   m,n:word;s,shs,da:longint;
procedure doc;
var
   i,u,v,w:word;
begin
assign(f,fi+t);reset(f);
readln(f,n);
for i:=1 to n do begin dau[i]:=n;cuoi[i]:=0;end;
m:=0;
while not(seekeof(f)) do
      begin
      inc(m);
      readln(f,u,v,w);
      if dau[u]>m then dau[u]:=m;
      if cuoi[u]<m then cuoi[u]:=m;
      c^[m,1]:=u;c^[m,2]:=v;c^[m,3]:=w;
      end;
close(f);
assign(f,bb+t);reset(f);
readln(f,da);
close(f);
end;
function co(u,v,w:word):boolean;
var
   x:word;
begin
for x:=dau[u] to cuoi[u] do
    if (c^[x,1]=u)and(c^[x,2]=v)and(c^[x,3]=w) then
       begin co:=true;exit;end;
co:=false;
end;
procedure di(i:word);
var
   j:word;
begin
if tb then exit;
for j:=dau[i] to cuoi[i] do
    if (c^[j,1]=i)and(tp[c^[j,2]]=0) then
       begin
       if c^[j,2]=1 then begin tb:=true;exit;end;
       tp[c^[j,2]]:=1;di(tp[c^[j,2]]);
       end;
end;
procedure cham;
var
   y,u,v,w:word;
begin
assign(f,fhs);reset(f);
readln(f,shs);s:=0;tb:=false;
while not(seekeof(f)) do
      begin
      readln(f,u,v,w);
      if (u<1)and(u>n) then
         begin
         writeln('So hieu thanh pho sai: ',u);
         close(f);exit;
         end;
      if not(co(u,v,w)) then
         begin
         writeln('Khong co duong tu ',u,' den ',v,' voi so quan ',w);
         close(f);exit;
         end;
      for y:=dau[u] to cuoi[u] do
          if (c^[y,1]=u)and(c^[y,2]=v)and(c^[y,3]=w) then
             begin c^[y,1]:=0;c^[y,2]:=0;inc(s,w);end;
      end;
close(f);
for y:=1 to n do tp[y]:=0;
tp[n]:=1;di(n);
if tb then
   begin
   writeln('Khong chan duoc quan dich');
   writeln('So quan can dung thong bao: ',shs);
   exit;
   end
else
    begin
    writeln('So quan can dung thong bao: ',shs);
    writeln('So quan can dung tinh theo duong: ',s);
    writeln('So quan can dung cua DA: ',da);
    end;
end;
BEGIN
clrscr;
writeln;
write('CHAM TEST THU ');T:=READKEY;WRITELN(T);
writeln;
new(c);
doc;cham;
readln;
dispose(c);
END.