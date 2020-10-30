{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 64384,0,655360}
program Bay_tranh;
uses crt;
const fi='TRANH.I1';
  	   fo='TRANH.O0';
      maxn=50;
      maxm=400;
var   c 	     : array[1..maxn] of byte;
      q,kq       : array[1..maxn] of word;
	  v		 	 : array[1..maxn,1..maxm] of byte;
      d		     : array[0..maxn,0..maxm] of word;
      n,m,dmax,u : integer;
      f:text;
procedure Nhap;
var  i,j:integer;
begin
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
end;
procedure Xu_Ly;
var  i,j,k,x,y,l:integer;
begin
   dmax:=-1;
   for k:=1 to n do
   begin
   	  for i:=0 to n do
       for j:=0 to m do d[i,j]:=0;
      for i:=1 to k-1 do
       for j:=1 to m do
        begin
           if i<=j then
         	begin
               if (d[i-1,j-1]+v[i,j])>d[i,j-1] then d[i,j]:=d[i-1,j-1]+v[i,j]
                 else d[i,j]:=d[i,j-1];
            end
           else
            d[i,j]:=d[i-1,j];
       end;
      for j:=1 to m do d[k,j]:=d[k-1,j];
      for i:=k+1 to n do
       for j:=1 to m do
        begin
           if (i-1)<=j then
         	begin
               if (d[i-1,j-1]+v[i,j])>d[i,j-1] then d[i,j]:=d[i-1,j-1]+v[i,j]
                 else d[i,j]:=d[i,j-1];
            end
           else
            d[i,j]:=d[i,j-1];
       end;
      if (d[n,m]+c[k])>dmax then
      begin
	  	 dmax:=d[n,m]+c[k]; u:=k;
         x:=n; y:=m;
         for i:=1 to n do q[i]:=0;
         l:=0;
         while (x<>k) do
         begin
            if d[x,y]=d[x,y-1] then dec(y)
             else
              begin
                 inc(l); q[x]:=y; dec(x); dec(y);
              end;
		 end;
         dec(x);
         while (x<>0)and(y<>0) do
         begin
            if d[x,y]=d[x,y-1] then dec(y)
             else
              begin
                 inc(l); q[x]:=y; dec(x); dec(y);
              end;
		 end;
         kq:=q;
      end;
   end;
end;
procedure Inkq;
var  i:integer;
begin
   assign(f,fo); rewrite(f);
   writeln(f,dmax);
   writeln(f,u);
   for i:=1 to n do
    if i<>u then write(f,q[i],' ');
   close(f);
end;
begin
   Clrscr;
   Nhap;
   Xu_Ly;
   Inkq;
end.
