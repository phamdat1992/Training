{$R+,B-}
uses crt;
const
   max          =  100;
   fi           =  'lichd.in3';
   fo           =  'lichd.out';
type
   arr          =  array[1..max] of integer;
var
   f            :  text;
   p,d,cs,st    :  arr;
   n            :  integer;
   time,top     :  integer;
   cx           :  array[1..max] of boolean;

procedure nhap;
var i : integer;
begin
   assign(f,fi);
   reset(f);
   readln(f,n);
   for i:=1 to n do read(f,p[i]);
   for i:=1 to n do read(f,d[i]);
   close(f);
end;

procedure doicho(var a,b : integer);
var tg : integer;
begin
   tg:=a;
   a:=b;
   b:=tg;
end;

procedure sort;
var i,j : integer;
begin
   for i:=1 to n-1 do
      for j:=i+1 to n do
         if d[i]>d[j] then
            begin
               doicho(p[i],p[j]);
               doicho(d[i],d[j]);
               doicho(cs[i],cs[j]);
            end;
end;

procedure khoitao;
var i : integer;
begin
   time:=0;
   for i:=1 to n do cs[i]:=i;
   sort;
   top:=0;
end;

procedure xep(x : integer);
var i,t,cs : integer;
    min    : integer;
begin
   inc(top);
   st[top]:=x;
   if time+p[x]<=d[x] then
      begin
         time:=time+p[x];
         exit;
      end;
   min:=time;
   cs:=top;
   for i:=1 to top-1 do
      begin
         t:=time+p[x]-p[st[i]];
         if (t<min) and (t<=d[x]) then
            begin
               min:=t;
               cs:=i;
            end;
      end;
   dec(top);
   for i:=cs to top do
      st[i]:=st[i+1];
   time:=min;
end;

procedure xuly;
var i : integer;
begin
   for i:=1 to n do
      xep(i);
end;

procedure inkq;
var i : integer;
begin
   assign(f,fo);
   rewrite(f);
   for i:=1 to top do
      cx[st[i]]:=false;
   writeln(f,top);
   for i:=1 to top do
      begin
         write(f,cs[st[i]],' ');
         cx[st[i]]:=true;
      end;
   for i:=1 to n do
      if not cx[i] then write(f,cs[i],' ');
   close(f);
end;

BEGIN
   clrscr;
   nhap;
   khoitao;
   xuly;
   inkq;
END.
6
2 4 1 2 3 1
3 5 6 6 7 8