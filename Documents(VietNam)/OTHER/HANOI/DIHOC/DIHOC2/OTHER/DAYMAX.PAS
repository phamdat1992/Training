{$R+}
Program Dayconmax;
Uses crt;
Const
	Fi='day.inp';
    Fo='day.out';
Var
	f2:text;
    dau,cuoi,n,m:longint;
	i,j:longint;
    tong,ltong:real;
    ldau,lcuoi:longint;
	so:longint;
	f3:text;
Procedure xulyvong;
Var
	u:longint;
begin
	assign(f3,fi);
    reset(f3);
	readln(f3,u);
    cuoi:=0;
    while not eof(f3) do
    begin
	    inc(cuoi);

        if cuoi>=so then
        begin
            close(f3);
			exit;
        end;

		readln(f3,u);
		tong:=tong+u;

        if (ltong<tong) then
        begin
            ldau:=dau;
            ltong:=tong;
            lcuoi:=cuoi;
        end;
    end;
    close(f3);
end;


Procedure xuly(so:longint);
Var
	u,i:longint;
begin
	assign(f2,fi);
    reset(f2);
	readln(f2,u);
    tong:=0;

    dau:=so;
    cuoi:=so-1;

    For i:=1 to so-1 do
		readln(f2,u);

    while not eof(f2) do
    begin
        inc(cuoi);
		readln(f2,u);
		tong:=tong+u;

        if (ltong<tong) then
        begin
            ldau:=dau;
            ltong:=tong;
            lcuoi:=cuoi;
        end;
        if (cuoi=n) then xulyvong;
    end;
    close(f2);
end;


Procedure xuly1;
Var
	u,i:longint;
begin
	assign(f2,fi);
    reset(f2);
	readln(f2,u);
    tong:=0;

    dau:=1;
    cuoi:=0;

    while not eof(f2) do
    begin
        inc(cuoi);
		readln(f2,u);
		tong:=tong+u;

        if (ltong<tong) then
        begin
            ldau:=dau;
            ltong:=tong;
            lcuoi:=cuoi;
        end;
    end;
    close(f2);
end;


Procedure readf;
Var
	f:text;
begin
    Assign(f,fi);
    Reset(f);
    readln(f,n);
    so:=0;
    ltong:=0;
    while not eof(f) do
	begin
		inc(so);
      	readln(f,j);

        if so=1 then xuly1
		else

      	xuly(so);
    end;
    Close(f);
end;

Procedure done;
Var
	f:text;
    so:longint;
begin
	assign(f,fo);
    rewrite(f);
    if lcuoi<ldau then
    begin
    	so:=(n-ldau)+1+lcuoi;
        writeln(f,so);
        For i:=ldau to n do writeln(f,i);
        for i:=1 to lcuoi do writeln(f,i);
    end
    else
    begin
        so:=(lcuoi-ldau)+1;
        writeln(f,so);
        for i:=ldau to lcuoi do writeln(f,i);
    end;
    Close(f);
end;

BEGIN
	Clrscr;
    readf;
    done;
END.
11
10
-1
-3
5
6
-4
-9
20
-5
6
-3

7
2
-3
5
-7
4
6
-1
