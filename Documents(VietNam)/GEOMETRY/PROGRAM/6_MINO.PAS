{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65384,0,655360}

const	maxn	= 6;
		fi		= '6_mino.in7';
        fo		= 'hop.out';
        dt      : array[1..2] of integer=(-1,1);

type	m1	=array[0..maxn+1,0..maxn+1]of byte;
	m2	=array[1..maxn]of byte;

var	a	:m1;
	kq	:m2;

Procedure	Print_vn;
var	f	:text;
begin
    Assign(f,fo); rewrite(f);

    writeln(f,-1);

    close(f);
end;

procedure	readinp;
var	f	: text;
	i,j	: integer;
    d,c	: m2;
begin
    assign(f,fi); reset(f);

    fillchar(a,sizeof(a),0);
    fillchar(d,sizeof(d),0);
    fillchar(c,sizeof(c),0);
    for i:=1 to 6 do
    for j:=1 to 6 do
	begin
		read(f,a[i,j]);
        if a[i,j]>0 then
        begin
            inc(d[i]);  inc(c[j]);
            if (d[i]>4) or (c[j]>4) then
			begin
				print_vn;
                close(f);
                halt;
             end;
        end;
    end;
    close(f);
end;

Procedure	Xuly(i,j :integer);
var     i1,j1,dau,cuoi,k,kk	:integer;
begin
    for k:=1 to 2 do
    begin
        i1:=i+dt[k];  j1:=j;
        if (a[i1,j1]>0) then
        begin
            dau:=j1;  cuoi:=j1;
            while a[i1,dau-1]>0 do  dec(dau);
            while a[i1,cuoi+1]>0 do inc(cuoi);

            for kk:=dau to cuoi do
            if (a[i1+dt[k],kk]>0) and (kq[ a[i1+dt[k],kk ] ]=0) then
            begin
                kq[ a[i,j] ]:=a[i1+dt[k],kk ];
                kq[ kq[ a[i,j] ] ]:=a[i,j];
                break;
            end;
        end;

        if kq[ a[i,j] ]>0 then  exit;
    end;

    for k:=1 to 2 do
    begin
        i1:=i;  j1:=j+dt[k];

        if (a[i1,j1]>0) then
        begin
            dau:=i1;  cuoi:=i1;
            while a[dau,j1]>0 do  dec(dau);
            while a[cuoi,j1]>0 do inc(cuoi);

            for kk:=dau to cuoi do
                if (a[kk,j1+dt[k]]>0) and (kq[ a[kk,j1+dt[k] ] ]=0) then
                begin
                    kq[ a[i,j] ]:=a[kk,j1+dt[k] ];
                    kq[ kq[ a[i,j] ] ]:=a[i,j];
                    break;
                end;
        end;

        if kq[ a[i,j] ]>0 then  exit;
    end;
end;

Procedure	Process;
var	i,j	:integer;
begin
    fillchar(kq,sizeof(kq),0);
    for i:=1 to 6 do
    	for j:=1 to 6 do
            if (a[i,j]<>0) and (kq[ a[i,j] ]=0) then  Xuly(i,j);
end;

Procedure	Print;
var	f	:text;
	i	:integer;
begin
    for i:=1 to 6 do
    	if kq[i]=0 then
	begin
		Print_vn;
                exit;
        end;

    Assign(f,fo);  rewrite(f);

    for i:=1 to 6 do
        if kq[i]>0 then
        begin
            write(f,i,' ',kq[i],' ');
            kq[ kq[i] ]:=0;
            kq[i]:=0;
        end;

    close(f);
end;

begin
    Readinp;
    Process;
    Print;
end.