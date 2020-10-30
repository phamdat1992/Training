const
     fi='subset.inp';
     fo='subset.out';
     lt:array[0..30] of longint=(1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,
     1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824);
type
    tc=array[0..30] of longint;
var
   f,g:text;
   n,s,yc,k:longint;
   a:tc;
function sh(a:tc):longint;
var
   dem:longint;
   i,j,m:longint;
begin
dem:=1;a[0]:=0;
for i:=1 to k do
    begin
    j:=a[i]-a[i-1]-1;
    if j=0 then inc(dem);
    if j>0 then
       begin
       for m:=a[i-1]+1 to a[i]-1 do inc(dem,lt[n-m]);
       inc(dem);
       end;
    end;
sh:=dem;
end;
procedure timsh;
begin
read(f,n);
k:=0;
while not(seekeoln(f)) do
      begin
      	inc(k);read(f,a[k]);
      end;

readln(f);

writeln(g,sh(a));
end;
procedure tim(s:longint);
var
   dem,j:longint;
begin
	if s=0 then exit;
	inc(k);j:=a[k-1]+1;
	if (k=1) and(s=2) then 
	begin 
		a[k]:=j;
		exit;
	end;
	if s=1 then 
	begin 
		a[k]:=j;
		exit;
	end;
	if k=1 then dem:=2 else dem:=1;
	repeat 
		inc(dem,lt[n-j]);
		inc(j);
	until (j>n)or(dem>=s);
	if j>n then 
	begin 
		a[k]:=n;
		exit;
	end;
	if dem=s then 
	begin 
		a[k]:=j;
		exit;
	end;
	dec(dem,lt[n-j+1]);
	dec(s,dem);
	a[k]:=j-1;tim(s);
end;

procedure timtc;
var
   i:longint;
begin
	readln(f,n,s);
	k:=0;a[k]:=0;tim(s);
	for i:=1 to k do write(g,a[i]:3);writeln(g);
end;

procedure lam;
begin
	assign(f,fi);reset(f);
	assign(g,fo);rewrite(g);
	while not(seekeof(f)) do
      	begin
      		read(f,yc);
      		if yc=2 then timsh;
      		if yc=1 then timtc;
	end;
	close(f);
	close(g);
end;
Begin
BEGIN
	lam;
END.