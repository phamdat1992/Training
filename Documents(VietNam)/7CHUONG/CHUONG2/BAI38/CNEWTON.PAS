{$R+}
const
     fhs='newton.out';
var
   ten,fi,s:string;
   schs,sp,sphs,snhhs,saths,snh,sat,n,m,c,test:integer;
   md,cd,nhhs,nh,at,aths:array[1..100] of integer;
   cm,cc:array[1..100,1..100] of integer;
   ht:array[1..10000] of byte;
   qua:array[1..100,1..100] of boolean;
   pqua:array[1..100] of boolean;
   f:text;
procedure nhap;
var
   x,y:integer;
begin
assign(f,fi);reset(f);
readln(f,n,m,c);
fillchar(cm,sizeof(cm),0);
fillchar(cc,sizeof(cc),0);
repeat
readln(f,x,y);
if x<>-1 then cm[x,y]:=1;
until (x=-1);
while not(eof(f)) do
      begin
      readln(f,x,y);cc[x,y]:=1;
      end;
close(f);
end;
procedure doc;
var
   i,j:integer;
begin
assign(f,fhs);reset(f);
readln(f,snhhs);
if snhhs>0 then for i:=1 to snhhs do begin readln(f,j);nhhs[j]:=1;end;
readln(f,saths);
if schs>0 then
   begin
   readln(f,schs);
   for i:=1 to schs do readln(f,ht[i]);
   end;
close(f);
end;
procedure loangm(i:integer);
var
   j:integer;
begin
for j:=1 to n do
    if (md[j]=0)and(cm[i,j]=1) then
       begin
       md[j]:=1;
       loangm(j);
       end;
end;
procedure xetm;
begin
fillchar(md,sizeof(md),0);md[m]:=1;
loangm(m);
end;
procedure loangc(i:integer);
var
   j:integer;
begin
for j:=1 to n do
    if (cd[j]=0)and(cc[i,j]=1) then
       begin
       cd[j]:=1;
       loangc(j);
       end;
end;
procedure xetc;
begin
fillchar(cd,sizeof(cd),0);cd[c]:=1;
loangc(c);
end;
procedure cham;
var
   x,y,z:integer;
begin
xetm;xetc;
snh:=0;
for x:=1 to n do if (md[x]=1)and(cd[x]=1) then
    begin inc(snh);nh[x]:=1;end;
writeln('So phong nguy hiem ',snh);
if snh<>snhhs then
   begin
   writeln('Tinh so phong nguy hiem khong dung!!!');
   exit;end;
for x:=1 to n do if nhhs[x]<>nh[x] then
    begin writeln('Ghi nhan phong ',x,' nguy hiem la sai');exit;end;
if saths>1 then
   begin
   fillchar(qua,sizeof(qua),false);
   fillchar(pqua,sizeof(pqua),false);sp:=0;
   for x:=1 to schs-1 do
       begin
       if md[ht[x]]=1 then
          begin
          writeln('Hanh trinh an toan gap meo!!!');
          exit;
          end;
       if cc[ht[x],ht[x+1]]=0 then
          begin
          writeln('Khong co cua tu ',ht[x],' den ',ht[x+1],'!!!');
          exit;
          end;
       if qua[ht[x],ht[x+1]] then
          begin
          writeln('Cua tu ',ht[x],' den ',ht[x+1],' qua roi!!!');
          exit;
          end;
       qua[ht[x],ht[x+1]]:=true;
       if not(pqua[ht[x]]) then begin inc(sp);pqua[ht[x]]:=true;end;
       end;
     if cc[ht[schs],ht[1]]=0 then
          begin
          writeln('Khong co cua quay ve nha tu phong ',ht[schs],'!!!');
          exit;
          end;
     if qua[ht[schs],ht[1]] then
          begin
          writeln('Cua tu ',ht[schs],' den ',ht[1],' qua roi!!!');
          exit;
          end;
     if not(pqua[ht[schs]]) then begin inc(sp);pqua[ht[x]]:=true;end;
   end;
if sp<>sphs then
          begin
          writeln('So phong khac nhau khong phu hop hanh trinh!!!');
          exit;
          end;
writeln('So phong dao choi an toan: ',saths);
end;
BEGIN
write('Cham bai hoc sinh: ');readln(ten);
write('Test thu: ');readln(test);str(test,s);
fi:='newton'+s+'.inp';
nhap;doc;cham;readln;
END.