{$M 65000,0,655360}
const
     m=10000;
     fi='dckt.inp';
     fo='dckt.out';
type
    day=array[1..m] of longint;
var
   x:day;
   cs:array[1..m] of word;
   n,k:word;
   f:text;
procedure nhap;
begin
assign(f,fi);reset(f);
n:=0;while not(seekeof(f)) do begin inc(n);readln(f,x[n]);end;
close(f);
end;
procedure quicksort(d,c:word);
var
   t,i,j:word;tg:longint;
begin
if d>=c then exit;
i:=d+1;
while (i<=c)and(x[i]<=x[d]) do inc(i);
j:=c;
while (j>d)and(x[j]>=x[d]) do dec(j);
while i<j do
      begin
      tg:=x[i];x[i]:=x[j];x[j]:=tg;
      t:=cs[i];cs[i]:=cs[j];cs[j]:=t;
      inc(i);
      while (i<=c)and(x[i]<=x[d]) do inc(i);
      dec(j);
      while (j>d)and(x[j]>=x[d]) do dec(j);
      end;
tg:=x[d];x[d]:=x[j];x[j]:=tg;
t:=cs[d];cs[d]:=cs[j];cs[j]:=t;
quicksort(d,j-1); quicksort(j+1,c);
end;
procedure tim;
var
   s,s3:longint;i:word;
begin
for i:=1 to n do cs[i]:=i;
quicksort(1,n);
k:=0;s:=0;
for i:=1 to n-3 do
    begin
    s:=s+x[i];
    s3:=0;s3:=s3+x[i+1]+x[i+2]+x[i+3];
    if s3<=s then k:=i+3;
    end;
end;
procedure viet;
var
   i:word;
begin
assign(f,fo);rewrite(f);
writeln(f,k);
if k>0 then for i:=1 to k do writeln(f,cs[i]);
close(f);
end;
BEGIN
nhap;tim;viet;
END.

