uses crt;
const
     fi='obstacle.in';
     fo='obstacle.ou';
     fhs='obstacle.out';
type
    diem=record x,y:real;end;
var
   f:text;t:char;
   kc,kchs,a1,b1,c1,a2,b2,c2:real;
   vc:array[0..31,1..4] of diem;
   h:array[0..200] of diem;
   sth,m,d:word;
procedure nhap;
var
   x,y,z:real;i:word;
begin
assign(f,fi+t);reset(f);
vc[0,1].x:=0;vc[0,2].x:=0;vc[0,3].x:=0;vc[0,4].x:=0;
vc[0,1].y:=0;vc[0,2].y:=0;vc[0,3].y:=0;vc[0,4].y:=0;
readln(f,m);
for i:=1 to m do
    begin
    readln(f,x,y,z);
    vc[i,1].x:=x;vc[i,1].y:=y;
    vc[i,2].x:=x;vc[i,2].y:=y+z;
    vc[i,3].x:=x+z;vc[i,3].y:=y+z;
    vc[i,4].x:=x+z;vc[i,4].y:=y;
    end;
close(f);
vc[m+1,1].x:=100;vc[m+1,2].x:=100;vc[m+1,3].x:=100;vc[m+1,4].x:=100;
vc[m+1,1].y:=100;vc[m+1,2].y:=100;vc[m+1,3].y:=100;vc[m+1,4].y:=100;
assign(f,fo+t);reset(f);
readln(f,kc);
close(f);
end;
procedure pt(p,q:diem;var a,b,c:real);
begin
a:=q.y-p.y;b:=p.x-q.x;c:=p.y*q.x-q.y*p.x;
end;
function gt(p:diem;a,b,c:real):real;
begin
gt:=a*p.x+b*p.y+c;
end;
function cat(i:word;p,q:diem):boolean;
{Doan noi P va Q cat vat can thu i}
var
   cat1,cat2,cat3,cat4:boolean;
begin
pt(p,q,a1,b1,c1);
pt(vc[i,1],vc[i,3],a2,b2,c2);
cat1:=(gt(p,a2,b2,c2)*gt(q,a2,b2,c2)<0);
cat2:=(gt(vc[i,1],a1,b1,c1)*gt(vc[i,3],a1,b1,c1)<0);
pt(vc[i,2],vc[i,4],a2,b2,c2);
cat3:=(gt(p,a2,b2,c2)*gt(q,a2,b2,c2)<0);
cat4:=(gt(vc[i,2],a1,b1,c1)*gt(vc[i,4],a1,b1,c1)<0);
cat:=(cat1 and cat2) or (cat3 and cat4);
end;
function duoc(p,q:diem):boolean;
var
   i:word;
begin
if (p.x=q.x)and(p.y=q.y) then begin duoc:=false;exit;end;
duoc:=true;
for i:=1 to m do if cat(i,p,q) then begin duoc:=false;exit;end;
end;
function khc(p,q:diem):real;
begin
khc:=sqrt(sqr(p.x-q.x)+sqr(p.y-q.y));
end;
function kt(p:diem):boolean;
begin
kt:=not((0<=p.x)and(p.x<=100)and(0<=p.y)and(p.y<=100));
end;
function th(p,q,r:diem):boolean;
begin
th:=((p.x-q.x)*(r.y-q.y)=(p.y-q.y)*(r.x-q.x));
end;
procedure cham;
var
   i,j,k:word;kct:real;
begin
assign(f,fhs);reset(f);
readln(f,kchs);
if kchs<100*sqrt(2) then
   begin
   writeln('        Ket qua sai: do dai HT ngan hon duong cheo!!!');
   writeln('        Do dai HT: ',kchs:0:3);
   writeln('        Do dai duong cheo: ',100*sqrt(2):0:3);
   close(f);exit;
   end;
readln(f,d);kct:=0;
h[0].x:=0;h[0].y:=0;
for i:=1 to d do
    begin
    readln(f,h[i].x,h[i].y);
    if kt(h[i]) then
       begin
       writeln('        Ket qua sai: diem thu ',i,' khong thuoc Hinh vuong!!!');
       writeln('        Hoanh do: ',h[i].x:0:3,' - Tung do: ',h[i].y:0:3);
       close(f);exit;
       end;
    if not(duoc(h[i-1],h[i])) then
       begin
       writeln('        Doan thu ',i,' di xuyen qua vat can!!!');
       writeln('        Ket qua sai!!!');
       close(f);exit;
       end;
    kct:=kct+khc(h[i-1],h[i]);
    end;
close(f);
h[d+1].x:=100;h[d+1].y:=100;
if not(duoc(h[d],h[d+1])) then
   begin
   writeln('        Doan cuoi cung di xuyen qua vat can!!!');
   writeln('        Ket qua sai!!!');
   exit;
   end;
kct:=kct+khc(h[d],h[d+1]);
if abs(kct-kchs)>0.01 then
   begin
   writeln('        Do dai HT thong bao: ',kchs:0:3);
   writeln('        Do dai HT tinh theo cac moc cua HT: ',kct:0:3);
   writeln('        Ket qua sai!!!');exit;
   end;
writeln('        Hanh trinh dung dan!!!');
writeln('        Do dai HT cua HS: ',kchs:0:3);
writeln('        Do dai HT cua DA: ',kc:0:3);
sth:=0;
for i:=0 to d-1 do if th(h[i],h[i+1],h[i+2]) then inc(sth);
if sth>0 then
   writeln('        Thua ',sth,' diem tren hanh trinh vi khong doi huong');
end;
BEGIN
clrscr;
writeln;
write('CHAM TEST THU ');t:=readkey;writeln(t);
writeln;
nhap;cham;readln;
END.