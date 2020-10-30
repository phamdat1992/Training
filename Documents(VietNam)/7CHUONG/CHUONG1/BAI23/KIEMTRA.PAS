{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const fi='TRANH.IN2';
  	   fo='TRANH.OUt';
      max=50;
var   c,q,kq:array[1..max] of byte;
	  v:array[1..max,1..100] of byte;
      m,n,sl,u:integer;
      f:text;
procedure Thu;
var i,j,gt:integer;
begin
   Clrscr;
   assign(f,fi); reset(f);
   readln(f,n,m);
   for i:=1 to n do read(f,c[i]);
   readln(f);
   for i:=1 to n do
   begin
	  for j:=1 to m do read(f,v[i,j]);
      readln(f);
   end;
   close(f);
   assign(f,fo); reset(f);
   readln(f,sl);
   readln(f,u);
   for i:=1 to n-1 do read(f,q[i]);
   gt:=c[u];
   for i:=1 to u-1 do gt:=gt+v[i,q[i]];
   for i:=u to n-1 do gt:=gt+v[i+1,q[i]];
   close(f);
   writeln(gt=sl);
   readln;
end;
begin
     Thu;
end.