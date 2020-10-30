{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt{, ctest074};
const
    maxn=1000;
    fi='cnode.inp';
    fo='cnode.out';
var f:text;
    n,m,sm,dem,first,last:integer;
    cx,lay:array[1..maxn]of boolean;
    c,bac:array[0..maxn]of integer;
    a:array[1..20000]of integer;
    q,sl,mien:array[1..maxn]of integer;
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

procedure chuanbi(i:integer);
var j:integer;
begin
   fillchar(cx,sizeof(cx),1);
   for j:=1 to n do
      if (i<>j) and (mien[i]=mien[j]) then
         begin
            q[1]:=j;
            cx[j]:=false;
            break;
         end;
   sm:=mien[i];
   cx[i]:=false;
   first:=0;
   last:=1;
end;

procedure chuanbiloang(i:integer);
begin
   fillchar(cx,sizeof(cx),1);
   q[1]:=i;
   first:=0;
   last:=1;
   inc(sm);
   mien[i]:=sm;
   cx[i]:=false;
end;

procedure add(i:integer);
begin
   inc(last);
   q[last]:=i;
   cx[i]:=false;
   mien[i]:=sm;
end;

procedure ditiep(i:integer);
var j:integer;
begin
   for j:=c[i-1]+1 to c[i] do
      if cx[a[j]] then add(a[j]);
end;

procedure loang;
begin
   while first<last do
      begin
         inc(first);
         ditiep(q[first]);
      end;
end;

procedure xuly;
var i:integer;
begin
   fillchar(cx,sizeof(cx),1);

   for i:=1 to n do
      if mien[i]=0 then
         begin
            chuanbiloang(i);
            loang;
            sl[sm]:=last;
         end;

   for i:=1 to n do
      if (sl[mien[i]]>1) and (bac[i]>1) then
         begin
            chuanbi(i);
            loang;
            if sl[mien[i]]<>last+1 then
               begin
                  inc(dem);
                  lay[i]:=true;
               end;
         end;
end;

procedure inkq;
var i:integer;
begin
   assign(f,fo);
   rewrite(f);

   writeln(f,dem);

   for i:=1 to n do
      if lay[i] then writeln(f,i);

   close(f);
end;

Begin
   ftime:=ltime;
   clrscr;
   timcuoi;
   nhap;
   xuly;
   inkq;
   write(ltime-ftime);
End.