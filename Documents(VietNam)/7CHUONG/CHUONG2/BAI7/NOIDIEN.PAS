{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program NOI_DAY_DIEN_PHUC_VU_THI_OLYPIC_TIN_HOC;
const fi='NOIDIEN.INP';
       fo='NOIDAY.OUT';
      max=100;
var	  cx:array[0..max] of boolean;
	  c:array[0..max,0..max] of real;
      x,y:array[0..max] of real;
      near:array[0..max] of integer;
      q:array[1..max+1,1..2] of byte;
      d:array[0..max] of real;
      n:integer;
      kcmin:real;
	  f:text;
procedure Nhap;
var   i:integer;
begin
   assign(f,fi); reset(f);
   readln(f,n);
   x[0]:=0; y[0]:=0;
   for i:=1 to n do readln(f,x[i],y[i]);
   close(f);
end;
function kc(i,j:integer):real;
begin
     kc:=sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j]));
end;
procedure Chuan_bi;
var  i,j:integer;
begin
   for i:=0 to n-1 do
    for j:=i+1 to n do
	begin
       c[i,j]:=kc(i,j); c[j,i]:=c[i,j];
	end;
end;
procedure Xu_Ly;
var  i,j,k,u:integer;
     min:real;
begin
   kcmin:=0;
   for i:=1 to n do cx[i]:=true;
   for i:=1 to n do
   begin
      d[i]:=c[0,i]; near[i]:=0;
   end;
   k:=0;
   while true do
   begin
      min:=1e30;
      for i:=1 to n do
       if (cx[i])and(d[i]<min) then
       begin
          u:=i; min:=d[i];
       end;
     cx[u]:=false;
     inc(k); kcmin:=kcmin+min;
     q[k,1]:=u; q[k,2]:=near[u];
     if k=n then break;
	 for i:=1 to n do
      if (cx[i])and(c[u,i]<d[i]) then
      begin
         d[i]:=c[u,i]; near[i]:=u;
      end;
   end;
end;
procedure Inkq;
var i:integer;
begin
   assign(f,fo); rewrite(f);
   writeln(f,kcmin:0:2);
   for i:=1 to n do writeln(f,q[i,1],' ',q[i,2]);
   close(f);
end;
begin
   Nhap;
   Chuan_bi;
   Xu_Ly;
   Inkq;
end.