{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

const	n	= 6;
		fi	= '6_mino.in4';
        fo	=   'giap.out';

type	m1	= array[1..n,1..n]of byte;
		m2	= array[0..n]of byte;

var		a	: m1;
		d,c	: m2;
		kq	: m2;
        dx	: m2;

Procedure	Rutgon(var  s:string);
var     x   :string;
	i   :integer;
begin
    x:='';
    for i:=1 to length(s) do
    	if s[i]<>' ' then  x:=x+s[i];
    s:=x;
end;

Procedure	Readinp;
var 	f	 :text;
	s	 :string;
        i,j,vt	:integer;
        k	:integer;
begin
    Assign(f,fi);  reset(f);

    for i:=1 to n do
    begin
        readln(f,s);
        Rutgon(s);

        for j:=1 to n do
        begin
            k:=j;

                    a[i,j]:=ord( s[k] )-48;
                    d[ a[i,j] ]:=i;
                    c[ a[i,j] ]:=j;

        end;
    end;

    close(f);
end;

Procedure	Vonghiem;
var	 f	:text;
begin
    Assign(f,fo);  rewrite(f);

    writeln(f,0);

    close(f);
    Halt;
end;

Function        Somin(x,y :byte):byte;
begin
    if x<y then Somin:=x
    else  Somin:=y;
end;

Function	Thoaman(i,j :byte):boolean;
var	 k	:byte;
	 u,v	:byte;
         i1,j1,i2,j2 :byte;
begin
    Thoaman:=false;
    if (d[i]=d[j]) and (c[i]=c[j]) then   exit;

    if ( abs(d[i]-d[j]) <>2 ) and ( abs(c[i]-c[j]) <>2 ) then  exit;

    if abs(d[i]-d[j])=2 then
    begin
        i1:=Somin(d[i],d[j])+1;
        i2:=i1;
        j1:=c[i];
        j2:=c[j];
    end
    else   begin
               j1:=Somin(c[i],c[j])+1;
               j2:=j1;
               i1:=d[i];
               i2:=d[j];
           end;

    If (i1=i2) and (j1=j2) then  Thoaman:=true
    else    if (a[i1,j1]>0) and (a[i2,j2]>0) then
    		if (kq[ a[i1,j1] ]=0) or ( kq[ a[i1,j1] ]<>kq[ a[i2,j2] ] ) then
    	    	Thoaman:=true;
end;

Procedure       Process;
var	 i,j	:integer;
    	 dau,cuoi	:integer;
         dem	:integer;
begin
    fillchar(kq,sizeof(kq),0);

    for i:=1 to n do
    begin
        dau:=0;   cuoi:=0;

        for j:=1 to n do
        	if a[i,j]>0 then
                	if dau=0 then  dau:=j
                        else    cuoi:=j;

        if cuoi-dau+1<3 then  continue;
        if cuoi-dau+1>4 then  Vonghiem;
    	dem:=0;
        for j:=dau+2 to cuoi do
        begin
            inc(dem);
            kq[ a[i,j] ]:=a[i,j-2];
            kq[ a[i,j-2] ]:=a[i,j];
        end;
    end;

    for i:=1 to n do
    	if kq[i]=0 then
        	for j:=1 to n do
                        if (j<>i) and (kq[j]=0) then
                                If Thoaman(i,j) then
                                begin
                                    kq[i]:=j;
                                    kq[j]:=i;
                                end;
end;

Procedure	Print;
var	 f	:text;
	i	:byte;
begin
    Assign(f,fo);  rewrite(f);

    for i:=1 to n do
    	if kq[i]=0 then  Vonghiem;

    writeln(f,1);
    fillchar(dx,sizeof(dx),0);
    for i:=1 to n do
    	if dx[i]=0 then
        begin
            write(f,a[d[i],c[i]],' ',a[ d[kq[i]],c[kq[i]] ] ,' ');
            dx[i]:=1;
            dx[kq[i]]:=1;
        end;


    close(f);
end;

Begin
    Readinp;
    Process;
    Print;
end.