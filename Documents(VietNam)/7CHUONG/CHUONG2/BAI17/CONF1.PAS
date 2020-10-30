{ $A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
uses crt;
const fileinp='conf.inp';
      fileout='conf.out';
      maxn=100;
      vc=30000;
type  tarr1=array[1..maxn] of integer;
      tarr2=array[1..maxn] of tarr1;
      tc=array[1..2] of integer;
var time:longint absolute 0:$46c;
    net,vnet:tarr2;
    n,sc:integer;
    a,b,c:integer;
    nhan,back,min,way:tarr1;
    lway:integer;
    no,run:array[1..200] of tc;
    lno,lrun,best,cur:integer;
procedure readinp;
var inp:text;t,i,j,g:integer;
begin
 assign(inp,fileinp);
 reset(inp);
 readln(inp,n,sc);
 for i:=1 to n do
 for j:=1 to n do
 if i<>j then
 begin
  net[i,j]:=vc;
  net[j,i]:=vc;
 end
 else
 begin
  net[i,j]:=0;
  net[j,i]:=0;
 end;
 for t:=1 to sc do
 begin
  readln(inp,i,j,g);
  net[i,j]:=g;
  net[j,i]:=g;
 end;
 readln(inp,a,b,c);
 close(inp);
end;
procedure init;
begin
 lno:=0;
 best:=vc;
end;
procedure daytra(a,b:integer);
var i,j,t:integer;cu:integer;
begin
 for i:=1 to n do back[i]:=a;
 fillchar(nhan,sizeof(nhan),0);
 nhan[a]:=1;
 for i:=1 to n do min[i]:=net[a,i];
 cu:=a;
 repeat
  for i:=1 to n do
  if min[i]>min[cu]+net[i,cu] then
  begin
   min[i]:=min[cu]+net[i,cu];
   back[i]:=cu;
  end;
  cu:=0;
  for i:=1 to n do
  if nhan[i]=0 then
  begin
   if cu=0 then cu:=i
   else
   if min[cu]>min[i] then
   begin
    cu:=i;
   end;
  end;
  nhan[cu]:=1;
 until nhan[b]=1;
end;
procedure makeway(a,b:integer);
var i,j:integer;
begin
 i:=b;
 lway:=1;
 way[lway]:=b;
 repeat
  i:=back[i];
  inc(lway);
  way[lway]:=i;
 until i=a;
end;
procedure process;
var i,j,t:integer;
procedure lap(a,b,c:integer);
var t:integer;
begin
 net:=vnet;
 cur:=0;
 lrun:=0;
 daytra(a,b);
 makeway(a,b);
 for t:=lway downto 2 do
 begin
  i:=way[t];
  j:=way[t-1];
  cur:=cur+net[i,j];
  net[i,j]:=0;
  inc(lrun);
  run[lrun][1]:=i;
  run[lrun][2]:=j;
 end;
 daytra(a,c);
 makeway(a,c);
 for t:=lway downto 2 do
 begin
  i:=way[t];
  j:=way[t-1];
  cur:=cur+net[i,j];
  if net[i,j]<>0 then
  begin
   inc(lrun);
   run[lrun][1]:=i;
   run[lrun][2]:=j;
  end;
 end;
end;
procedure phantich;
begin
 if cur<best then
 begin
  best:=cur;
  lno:=lrun;
  no:=run;
 end;
end;
begin
 vnet:=net;
 lap(a,b,c);
 phantich;
 lap(a,c,b);
 phantich;
 lap(b,c,a);
 phantich;
end;
procedure output;
var out:text;i:integer;
begin
 assign(out,fileout);
 rewrite(out);
 writeln(out,best,' ',lno);
 for i:=1 to lno do writeln(out,no[i][1],' ',no[i][2]);
 close(out);
end;
begin
 readinp;
 init;
 process;
 output;
end.
8 12
1 2 20
2 3 8
2 4 3
2 5 3
2 6 6
3 5 2
3 6 9
4 7 5
5 6 1
5 7 7
6 8 4
7 8 6
1 4 6