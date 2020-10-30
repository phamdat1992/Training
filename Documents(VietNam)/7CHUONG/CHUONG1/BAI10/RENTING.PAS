{$R+,B-}
program Hoa_Tra_my ;
uses crt;
const
    fi           =  'renting.in9';
    fo           =  'renting.out';
    max          =  1500;
type
    arr          =  array[0..max] of longint;
    arr1         =  array[0..max] of real;
var
    f            :  text;
    d, c, cs, a  :  arr;
    cost         :  arr1;
    tr           :  array[1..max] of integer;
    n            :  longint;
    chon         :  char;

procedure Nhap;
var i : integer;
begin
   assign(f,fi);
   reset(f);
   readln(f,n);
   for i:=1 to n do
      read(f,d[i],c[i],a[i]);
   close(f);
end;

procedure doicho(var a,b : longint);
var tg : longint;
begin
   tg:=a;
   a:=b;
   b:=tg;
end;

procedure sort(f,l : integer);
var i,j      : integer;
    giua     : longint;
begin
   i:=f;
   j:=l;
   giua:=c[(i+j) div 2];
   repeat
      while c[i]<giua do inc(i);
      while c[j]>giua do dec(j);
      if i<=j then
      begin
         doicho(c[i],c[j]);
         doicho(cs[i],cs[j]);
         doicho(d[i],d[j]);
         doicho(a[i],a[j]);
         inc(i);
         dec(j);
      end;
   until i>j;
   if i<l then sort(i,l);
   if j>f then sort(f,j);
end;

procedure khoitao;
var i : integer;
begin
   d[0]:=0;
   c[0]:=0;
   for i:=1 to n do cs[i]:=i;
   sort(1,n);
end;

procedure inkq;
var i, c, c1, num: integer;
    max : real;
begin
   max:=0;
   for i:=1 to n do
      if max<cost[i] then
      begin
         max:=cost[i];
         c:=i;
      end;
   c1:=c; num:=0;
   while c1<>0 do
   begin
      num:=num+1;
      c1:=tr[c1];
   end;
   assign(f,fo); rewrite(f);
   writeln(f,num,' ',max:0:0);
   while c<>0 do
   begin
       writeln(f,cs[c],' ');
       c:=tr[c];
   end;
   close(f);
end;

procedure Solve;
var i,j : integer;
begin
   for i:=1 to n do cost[i]:=-1;
   for i:=1 to n do
   begin
      for j:=0 to i-1 do
         if (c[j]<d[i]) and (cost[j]>cost[i]) then
         begin
             cost[i]:=cost[j];
             tr[i]:=j;
         end;
      cost[i]:=cost[i]+a[i];
   end;
end;


BEGIN
   Nhap;
   Khoitao;
   Solve;
   Inkq;
END.
