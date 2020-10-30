{$R+}{$M 65000,0,0}
uses crt;
const
     fhs='vuon.out';
     dcd:array['A'..'F'] of shortint=(0,0,1,-1,1,-1);
     nd:array['A'..'F'] of shortint=(0,0,-1,1,-1,1);
     dcc:array['A'..'F'] of shortint=(-2,2,0,0,2,-2);
     nc:array['A'..'F'] of shortint=(2,-2,0,0,-2,2);
     doi:array['A'..'F'] of char=('B','A','D','C','F','E');
var
   fi,fo,test:string;
   ok1,ok2:boolean;
   a,qua,chua:array[0..31,-1..70] of boolean;
   hoa:array[1..1800,1..2] of shortint;
   truoc:array[0..31,-1..70] of char;
   m,n,u,v,d,c:shortint;so,sohs,dem,demhs:word;
   sdc,sdchs:word;
   hths:array[1..20000] of char;
   f,g:text;
   sb,sbhs:byte;
   sco,dem1:word;
   dc,cc:shortint;
procedure nhap;
var
   i,j,k:shortint;
begin
fillchar(a,sizeof(a),false);
assign(f,fi);reset(f);
readln(f,n,m);
for i:=1 to n do
for j:=1 to 2*i-1 do a[i,j]:=true;
for i:=1 to m do
    begin
    readln(f,j,k);a[j,k]:=false;
    hoa[i,1]:=j;hoa[i,2]:=k;
    end;
close(f);
sco:=n*n-m;
end;
function ct(c:char;i,j:shortint):boolean;
{Dinh ro bot dang o o [i,j], xet kha nang di chuyen theo huong c
      Neu co the di chuyen, CT = TRUE}
begin
case c of
'A':ct:=a[i,j-1] and a[i,j-2] and a[i+1,j-1] and a[i+1,j-2];
'B':ct:=a[i,j+1] and a[i,j+2] and a[i+1,j+4] and a[i+1,j+3];
'C':ct:=a[i+2,j] and a[i+2,j+1] and a[i+2,j+2] and a[i+2,j+3];
'D':ct:=a[i,j+1] and a[i,j+2] and a[i-1,j] and a[i+1,j+3];
'E':ct:=a[i+2,j+1] and a[i+2,j+2] and a[i+2,j+3] and a[i+2,j+4];
'F':ct:=a[i,j-2] and a[i,j-1] and a[i-1,j-2] and a[i+1,j-1];
end;
end;
procedure ghinhan(c:char;i,j:shortint);
begin
    case c of
    {Ghi nhan cac o co bi cat khi di chuyen tu o [i,j]
    theo huong c, nhieu nhat la bon o}
    'A':
        begin
        qua[i,j-1]:=true;qua[i,j-2]:=true;
        qua[i+1,j-1]:=true;qua[i+1,j-2]:=true;
        end;
    'B':
        begin
        qua[i,j+1]:=true;qua[i,j+2]:=true;
        qua[i+1,j+4]:=true;qua[i+1,j+3]:=true;
        end;
    'C':
        begin
        qua[i+2,j]:=true;qua[i+2,j+1]:=true;
        qua[i+2,j+2]:=true;qua[i+2,j+3]:=true;
        end;
    'D':
        begin
        qua[i,j+1]:=true;qua[i,j+2]:=true;
        qua[i-1,j]:=true;qua[i+1,j+3]:=true;
        end;
    'E':
        begin
        qua[i+2,j+1]:=true;qua[i+2,j+2]:=true;
        qua[i+2,j+4]:=true;qua[i+2,j+3]:=true;
        end;
    'F':
        begin
        qua[i,j-2]:=true;qua[i,j-1]:=true;
        qua[i-1,j-2]:=true;qua[i+1,j-1]:=true;
        end;
    end;{Case}
end;
function cat(c:char;i,j:shortint):boolean;
begin
case c of
'A':cat:=not(qua[i,j-1] and qua[i,j-2] and qua[i+1,j-1] and qua[i+1,j-2]);
'B':cat:=not(qua[i,j+1] and qua[i,j+2] and qua[i+1,j+4] and qua[i+1,j+3]);
'C':cat:=not(qua[i+2,j] and qua[i+2,j+1] and qua[i+2,j+2] and qua[i+2,j+3]);
'D':cat:=not(qua[i,j+1] and qua[i,j+2] and qua[i-1,j] and qua[i+1,j+3]);
'E':cat:=not(qua[i+2,j+1] and qua[i+2,j+2] and qua[i+2,j+3] and qua[i+2,j+4]);
'F':cat:=not(qua[i,j-2] and qua[i,j-1] and qua[i-1,j-2] and qua[i+1,j-1]);
end;
end;
procedure dochs1;
begin
{$I-}assign(f,fhs);reset(f);
if IOResult<>0 then
   begin
   writeln('Khong co file OUT!!!');readln;halt;
   end;{$I+}
writeln;
dem:=0;
while not(seekeoln(f)) do
      begin
      inc(dem);read(f,hths[dem]);
      end;
readln(f);
end;
procedure cau1;
var
   r,s,tam:word;h:char;
   d,c:shortint;
begin
writeln('        CHAM CAU 1');
writeln;
fillchar(qua,sizeof(qua),false);
r:=1;d:=1;c:=1;
qua[1,1]:=true;qua[2,1]:=true;qua[2,2]:=true;qua[2,3]:=true;
while r<=dem do
      begin
      h:=hths[r];
      if not(ct(h,d,c)) then
         begin
         writeln('        Hanh trinh sai!!!');
         writeln('        Buoc di chuyen thu ',r,' xen hoa!!!');
         exit;
         end;
      ghinhan(h,d,c);
      inc(r);d:=d+dcd[h];c:=c+dcc[h];
      end;
writeln('        Hanh trinh ro bot dung dan!!!');
tam:=0;
for r:=1 to n do
for s:=1 to 2*r-1 do if qua[r,s] then inc(tam);
writeln('        So o co cat duoc cua hoc sinh: ',tam);
end;
procedure dochs2;
var
   kt,u:word;
begin
readln(f,sbhs);
if sbhs>0 then for kt:=1 to sbhs do
   begin
   readln(f,u);a[hoa[u,1],hoa[u,2]]:=true;
   end;
inc(sco,sbhs);
close(f);
end;
procedure di(i,j:shortint);
{Xem xet kha nang di chuyen cua ro bot khi dinh ro bot tai o [i,j]}
var
   dong,cot:shortint;ch:char;
begin
for ch:='A' to 'F' do if ct(ch,i,j) then
    begin
    dong:=i+dcd[ch];cot:=j+dcc[ch];
    {Theo huong ch, dinh ro bot di chuyen den o [dong,cot]}
    if (truoc[dong,cot]=' ')or cat(ch,i,j) then
    {Neu o nay chua di qua hoac co cat o co chua cat}
       begin
       writeln(g,ch);
       ghinhan(ch,i,j);
       if truoc[dong,cot]=' ' then truoc[dong,cot]:=ch;
       {Ghi nhan huong di den}
       di(dong,cot);
       end;{If}
    end;
end;
procedure cau2;
var
   d,c:shortint;
begin
writeln;
writeln('        CHAM CAU 2');
writeln;
fillchar(truoc,sizeof(truoc),' ');
fillchar(qua,sizeof(qua),false);
truoc[1,1]:='*';
qua[1,1]:=true;qua[2,1]:=true;qua[2,2]:=true;qua[2,3]:=true;
writeln('        So o hoa HS bo di: ',sbhs);
assign(g,'h.h');rewrite(g);
di(1,1);
close(g);
dem:=0;
for d:=1 to n do
for c:=1 to 2*d-1 do if qua[d,c] then inc(dem);
writeln('        So o co cat duoc: ',dem);
if dem<>sco then
   begin
   writeln('        Chua cat het co!!!');exit;
   writeln('        So o co can cat: ',sco);exit;
   end
else
    begin
    writeln('        Bo di ',sbhs,' o hoa');
    writeln('        So o co can cat: ',sco);exit;
    end;
end;
procedure cham;
begin
dochs1;cau1;
dochs2;cau2;
readln;
end;
BEGIN
clrscr;
write('     CHAM TEST THU ');readln(test);
fi:='vuon'+test+'.inp';
nhap;cham;
END.