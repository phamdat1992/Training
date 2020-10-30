{$M 65000,0,0}
const
     fi='luoi.inp';
     fo='luoi.out';
     dcd:array[-7..8] of shortint=(-1,-1,-1,0,1,1,1,0,-1,-1,-1,0,1,1,1,0);
     dcc:array[-7..8] of shortint=(-1,0,1,1,1,0,-1,-1,-1,0,1,1,1,0,-1,-1);
     so:array['P'..'S'] of shortint=(1,2,4,8);
var
   b:array[0..51,0..51,'P'..'S'] of shortint;
   tp:array[0..51,0..51,'P'..'S'] of word;
   dt:array[1..2500] of word;
   s:word;t:char;
   m,n:shortint;
   f:text;
procedure nhap;
var
   i,j,x:shortint;c:char;
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
        begin tp[i,j,d]:=s;inc(dt[s]);di(i,j,d);end;
    for k:=0 to 4 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=0)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=0)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=1)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=1)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=2)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=2)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=2)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=3)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=3)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=4)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=4)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        end;
    end;
'Q':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dt[s]);di(i,j,d);end;
    for k:=-2 to 2 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=-2)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=-2)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=-1)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=-1)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=0)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=0)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=0)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=1)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=1)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=2)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=2)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        end;
    end;
'R':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dt[s]);di(i,j,d);end;
    for k:=4 to 8 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=4)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=4)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=5)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=5)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=6)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=6)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=6)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=7)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=7)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=8)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=8)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        end;
    end;
'S':
    begin
    for d:='P' to 'S' do if (d<>c)and(b[i,j,d]=1)and(tp[i,j,d]=0) then
        begin tp[i,j,d]:=s;inc(dt[s]);di(i,j,d);end;
    for k:=2 to 6 do
        begin
        u:=i+dcd[k];v:=j+dcc[k];
        if (k=2)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=2)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        if (k=3)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=3)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=4)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=4)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=4)and(b[u,v,'R']=1)and(tp[u,v,'R']=0) then
           begin tp[u,v,'R']:=s;inc(dt[s]);di(u,v,'R');end;
        if (k=5)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=5)and(b[u,v,'Q']=1)and(tp[u,v,'Q']=0) then
           begin tp[u,v,'Q']:=s;inc(dt[s]);di(u,v,'Q');end;
        if (k=6)and(b[u,v,'P']=1)and(tp[u,v,'P']=0) then
           begin tp[u,v,'P']:=s;inc(dt[s]);di(u,v,'P');end;
        if (k=6)and(b[u,v,'S']=1)and(tp[u,v,'S']=0) then
           begin tp[u,v,'S']:=s;inc(dt[s]);di(u,v,'S');end;
        end;
    end;
end;
end;
procedure tim;
var
   i,j:shortint;c:char;
begin
fillchar(tp,sizeof(tp),0);
fillchar(dt,sizeof(dt),0);s:=0;
for i:=1 to m do
for j:=1 to n do
for c:='P' to 'S' do if (b[i,j,c]=1)and(tp[i,j,c]=0) then
    begin inc(s);inc(dt[s]);tp[i,j,c]:=s;di(i,j,c);end;
end;
procedure viet;
var
   i,j,u:shortint;c:char;k:word;
begin
assign(f,fo);rewrite(f);
writeln(f,s);
for k:=1 to s do
    begin
    writeln(f,dt[k]);
    for i:=1 to m do
        begin
        for j:=1 to n do
            begin
            u:=0;
            for c:='P' to 'S' do if tp[i,j,c]=k then u:=u+so[c];
            write(f,u:3);
            end;
        writeln(f);
        end;
    end;
close(f);
end;
BEGIN
nhap;tim;viet;
END.