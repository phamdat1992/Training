USES crt;
CONST	fn='activity.in4';
	fkq='activity.out';

TYPE	mang=array[1..10000] of integer;

VAR	n:integer;
	s,f,ll:mang;
        luu:^mang;
        dem:integer;

PROCEDURE	chuanbi;
Var		i:integer;
Begin
  fillchar(ll,sizeof(ll),0);
  fillchar(s,sizeof(s),0);
  fillchar(f,sizeof(f),0);
  new(luu);
  fillchar(luu^,sizeof(luu^),0);
End;

PROCEDURE	input;
Var		f1:text;
		i:integer;
Begin
  assign(f1,fn);
  reset(f1);
  readln(f1,n);
  for i:=1 to n do readln(f1,s[i],f[i]);
  close(f1);
   for i:=1 to n do ll[i]:=i;
End;

PROCEDURE   Sort(l,r:Integer);
Var         i,j,x,y:integer;
Begin
  i:=l;
  j:=r;
  x:=ll[(l+r) div 2];
  repeat
    while f[ll[i]] < f[x] do i:=i+1;
    while f[x] < f[ll[j]] do j:=j-1;
    if i<=j then
    	begin
      	y:=ll[i];
      	ll[i]:=ll[j];
      	ll[j]:=y;
      	i:=i+1;
      	j:=j-1;
    	end;
  until i>j;
  if l<j then Sort(l,j);
  if i<r then Sort(i,r);
End;

PROCEDURE	sapxep;
Var		tam,i,j:integer;
Begin
  for i:=1 to n-1 do
      for j:=i+1 to n do
          if f[ll[i]] > f[ll[j]] then
             begin
             tam:=ll[i];
             ll[i]:=ll[j];
             ll[j]:=tam;
             end;
End;

PROCEDURE	xuli;
Var		k,i:integer;
		t:boolean;
Begin
  k:=1;
  luu^[1]:=ll[k];
  dem:=1;
  t:=true;
  while (k<=n) and t do
	begin
        t:=false;
        for i:=k+1 to n do
            if s[ll[i]]>=f[ll[k]] then
            	begin
                k:=i;
                inc(dem);
                luu^[dem]:=ll[k];
                t:=true;
                end;
        end;
End;

PROCEDURE	output;
Var         	f1:text;
		i:integer;
Begin
  assign(f1,fkq);
  rewrite(f1);
  writeln(f1,dem);
  for i:=1 to dem do writeln(f1,luu^[i]);
  close(f1);
End;

BEGIN    clrscr;
  chuanbi;
  input;
 sort(1,n);
  xuli;
  output;
END.
