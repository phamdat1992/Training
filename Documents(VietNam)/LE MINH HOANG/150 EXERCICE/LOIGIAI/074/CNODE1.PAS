{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
    maxn=1000;
    fi='cnode.inp';
    fo='cnode.out';

var f:text;
    n,m,sl:integer;
    cx:array[1..maxn]of boolean;
    c,bac:array[0..maxn]of integer;
    a:array[1..20000]of integer;
    tt,cn:array[1..maxn]of integer;
    ftime:longint;
    ltime:longint absolute 0:$46c;

procedure timcuoi;
var i,x,y:integer;
begin
   assign(f,fi);
   reset(f);

   readln(f,n,m);

   for i:=1 to m do
      begin
         readln(f,x,y);
         inc(c[x]);
         inc(c[y]);
      end;

   for i:=1 to n do inc(c[i],c[i-1]);

   close(f);
end;

procedure themcanh(x,y:integer);
begin
   inc(bac[x]);
   a[c[x-1]+bac[x]]:=y;
end;

procedure nhap;
var i,x,y:integer;
begin
   assign(f,fi);
   reset(f);

   readln(f,n,m);

   for i:=1 to m do
      begin
         readln(f,x,y);
         themcanh(x,y);
         themcanh(y,x);
      end;

   close(f);
end;

procedure di(i:integer);
var j:integer;
begin
   cx[i]:=false;
   inc(sl);
   tt[i]:=sl;

   for j:=c[i-1]+1 to c[i] do
      if cx[a[j]] then
         begin
            cn[a[j]]:=i;
            di(a[j]);
         end;
end;

procedure chuanbi;
var i:integer;
begin
   fillchar(cx,sizeof(cx),1);

   for i:=1 to n do
      if cx[i] then di(i);

   fillchar(cx,sizeof(cx),1);
end;

procedure xuly;
var i:integer;
begin
   for i:=1 to n do
      if cx[i] then
         begin



         end;
end;

procedure inkq;
var i:integer;
begin
   assign(f,fo);
   rewrite(f);

   close(f);
end;

Begin
   ftime:=ltime;

   clrscr;

   timcuoi;

   nhap;

   chuanbi;

   xuly;

   inkq;

   write(ltime-ftime);
End.



13 14
1 3
3 6
6 4
4 1
4 2
2 5
5 7
7 4
6 9
9 8
8 4
8 10
11 12
5 12

