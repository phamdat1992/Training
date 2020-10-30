{ chuong trinh con sai }
uses crt;
const fi='tudien.IN3';
	  fo='tudien.OUT';

var a				:array[1..23,1..23] of shortint;
    i,j,k,l,m,n		:integer;
    mx				:array[1..100] of string;
    co				:array[1..23] of boolean;
    f				:text;
    f1				:text;

procedure vn;
begin
write(f1,0);close(f1);
halt;
end;

procedure nhap(var n:integer);
var i,j:byte;
begin
readln(f,n);
for i:=1 to n do
   begin
    readln(f,mx[i]);
    for j:=1 to length(mx[i]) do  co[ord(mx[i,j])-96]:=true;
  end;
end;

procedure sosanh(i,j:integer);
var q,p,k:integer;

begin
k:=1;
while (k<=length(mx[i])) and (k<=length(mx[j]))
  and (mx[i,k]=mx[j,k]) do inc(k);

  p:=ord(mx[i,k])-96;
  q:=ord(mx[j,k])-96;

 if a[p,q]=-1 then vn;

  a[p,q]:=1;
  a[q,p]:=-1;
end;

procedure xaclap;
begin
fillchar(co,sizeof(co),false);
while not eof(f) do
 begin
	nhap(n);
	for i:=1 to n do
  		for j:=i+1 to n do   sosanh(i,j);
 end;
close(f);
end;


procedure chuanbi;
begin
assign(f,fi);reset(f);
assign(f1,fo);rewrite(f1);
fillchar(a,sizeof(a),0);
end;

procedure timvong;
var i:integer;
    ba,roi:array[1..23] of boolean;

procedure try(i:integer);
var j:integer;
begin
ba[i]:=true;
for j:=1 to 23 do
    if a[i,j]=1 then
      begin
       if roi[j] then vn;
       roi[J]:=true;
	   try(j);
       ROI[J]:=FALSE;
      end;
end;

begin
fillchar(ba,sizeof(ba),false);
for i:=1 to 23 do
  if not ba[i] then
		   BEGIN
			 fillchar(roi,sizeof(roi),false);
             ROI[I]:=TRUE;
		     try(i);
           END;

end;

procedure layra;
var tg			:array[1..23] of byte;
    CHUA		:ARRAY[1..23] OF BOOLEAN;
    can,spt,dem	:byte;
    s,luu		:string;

procedure thu(i:byte);
var j:byte;
begin
if spt=can then begin
				inc(dem);
                luu:=s;
                exit;
                end;

for j:=1 to 23 do
 IF NOT CHUA[J] THEN
  if co[j] then
     if a[i,j]>-1 then
        begin
          s:=s+chr(j+96);
          inc(spt);
          CHUA[J]:=TRUE;

          thu(j);

          if spt=can then exit;
          CHUA[J]:=FALSE;

          delete(s,length(s),1);
          dec(spt);
       end;
end;

begin
timvong;
{tim  bd}
FILLCHAR(TG,SIZEOF(TG),0);
for i:=1 to 23 do
  if co[i] then
       for j:=1 to 23 do
	      if co[j] then
		     if a[i,j]=1 then
                     inc(tg[j]);

can:=0;
for i:=1 to 23 do
   if co[i] then inc(can);

dem:=0;
luu:='';
-]e
for i:=1 to 23 do
   if co[i] and (tg[i]=0)  and (dem<2) then
      begin
      FILLCHAR(CHUA,SIZEOF(CHUA),FALSE);
      CHUA[I]:=TRUE;
      spt:=1;
      s:=CHR(I+96);
	  thu(i);
      end;

writeln(f1,dem);
writeln(f1,luu);
CLOSE(F1);
end;

begin
chuanbi;
xaclap;
layra;
end.
4
ai
an
ip
ing
6
hai
ip
pha
pho
phong
no
3
ionef
ong
gai

2
i
j
2
j
k
2
k
i

0
2
eafghinop
