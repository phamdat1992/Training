{$M 65000,0,0}
uses crt;
const
     fhs='luoi.out';
     dcd:array[-7..8] of shortint=(-1,-1,-1,0,1,1,1,0,-1,-1,-1,0,1,1,1,0);
     dcc:array[-7..8] of shortint=(-1,0,1,1,1,0,-1,-1,-1,0,1,1,1,0,-1,-1);
     so:array['P'..'S'] of shortint=(1,2,4,8);
     sh:array['0'..'9'] of word=(7,8,3,7,5,9,7,8,10,5);
var
   b,h:array[0..51,0..51,'P'..'S'] of shortint;
   tp:array[0..51,0..51,'P'..'S'] of word;
   dt,dths:array[1..2500] of word;
   s:word;fi,fo:string;test,c1:char;
   m,n,o1,o2:shortint;
   f:text;
   r:word;
procedure nhap;
var
   i,j,x:shortint;c:char;y:word;z:string;
begin
fillchar(b,sizeof(b),0);
assign(f,fi);reset(f);
readln(f,m,n);
for i:=1 to m do
begin
for j:=1 to n do
    begin
    read(f,x);
    for c:='P' to 'S' do
        begin
        if x mod 2>0 then b[i,j,c]:=1;x:=x div 2;
        end;
    end;
readln(f);
end;
close(f);
end;
procedure di(i,j:shortint;c:char);
var
   u,v,k:shortint;d:char;
begin
case c of
'P':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dths[r]);b[i,j,d]:=0;di(i,j,d);end;
    for k:=0 to 4 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=0)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=0)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=1)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=1)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=2)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=2)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=2)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=3)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=3)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=4)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=4)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        end;
    end;
'Q':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dths[r]);b[i,j,d]:=0;di(i,j,d);end;
    for k:=-2 to 2 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=-2)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=-2)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=-1)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=-1)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=0)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=0)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=0)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=1)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=1)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=2)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=2)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        end;
    end;
'R':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dths[r]);b[i,j,d]:=0;di(i,j,d);end;
    for k:=4 to 8 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=4)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=4)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=5)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=5)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=6)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=6)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=6)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=7)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=7)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=8)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=8)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        end;
    end;
'S':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dths[r]);b[i,j,d]:=0;di(i,j,d);end;
    for k:=2 to 6 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=2)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=2)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        if (k=3)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=3)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=4)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=4)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=4)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dths[r]);b[u,v,'R']:=0;di(u,v,'R');end;
        if (k=5)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=5)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dths[r]);b[u,v,'Q']:=0;di(u,v,'Q');end;
        if (k=6)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dths[r]);b[u,v,'P']:=0;di(u,v,'P');end;
        if (k=6)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dths[r]);b[u,v,'S']:=0;di(u,v,'S');end;
        end;
    end;
end;
end;
function bang:boolean;
var
   i1,j1:shortint;t1:char;
begin
bang:=true;
for i1:=1 to m do
for j1:=1 to n do
for t1:='P' to 'S' do if tp[i1,j1,t1]<>h[i1,j1,t1] then
    begin bang:=false;exit;end;
end;
procedure xh;
var
   i,j,x:shortint;c:char;d:word;
begin
for r:=1 to s do
begin
fillchar(h,sizeof(h),0);
readln(f,d);
o1:=0;o2:=0;
for i:=1 to m do
begin
for j:=1 to n do
    begin
    read(f,x);
    for c:='P' to 'S' do
        begin
        if x mod 2>0 then
           begin
           h[i,j,c]:=1;
           if o1*o2=0 then begin c1:=c;o1:=i;o2:=j;end;
           end;
        x:=x div 2;
        end;
    end;
readln(f);
end;
if (o1*o2=0)or(b[o1,o2,c1]=0) then
   begin
   writeln('        Hinh thu ',r,' khong dung!!!');
   close(f);exit;
   end;
fillchar(tp,sizeof(tp),0);
s:=1;tp[o1,o2,c1]:=s;dths[r]:=1;
di(o1,o2,c1);
if d<>dths[r] then
   begin
   writeln('        DT hinh thu ',r,' khong phu hop voi thong bao');
   writeln('        DT hinh cua HS thong bao: ',d);
   writeln('        DT hinh tinh theo DFS: ',dths[r]);
   close(f);exit;
   end;
if not(bang) then
   begin
   writeln('        Hinh thu ',r,' khong dung!!!');
   close(f);exit;
   end;
end;
writeln('        Ket qua dung!!!');
close(f);
end;
procedure cham;
begin
assign(f,fhs);reset(f);
readln(f,s);
if s<>sh[test] then
   begin
   writeln('        So hinh khong dung!!!');
   writeln('        So hinh cua HS ',s);
   writeln('        So hinh cua DA ',sh[test]);
   close(f);exit;
   end;
xh;
end;
BEGIN
clrscr;
writeln;
write('        CHAM TEST THU ');test:=readkey;writeln(test);
writeln;
fi:='luoi.in'+test;
nhap;cham;readln;
END.

