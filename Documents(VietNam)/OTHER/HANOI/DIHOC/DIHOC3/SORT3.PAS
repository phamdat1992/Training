Program sort3;
Uses crt;
Const
	Fi='input.txt';
    Fo='output.out';
    maxn=1000;
Var
	A: Array[1..maxn] of integer;
    KQ:array[1..maxn,1..2] of integer;
    so1,so2,so3:integer;
    solan,i,j,m,n:integer;
Procedure Readf;
Var
	f:text;
Begin
	Assign(f,fi);
    reset(f);
    Readln(f,n);
    so1:=0;
    so3:=0;
    so2:=0;
    For i:=1 to n do
    begin
		readln(f,a[i]);
        if a[i]=1 then inc(so1);
        if a[i]=2 then inc(so2);
        if a[i]=3 then inc(so3);
    end;
end;

Procedure init;
Begin
	Fillchar(a,sizeof(a),0);
    Readf;
    solan:=0;
End;

Procedure main;
Var
	l,i,j:integer;
    tg:integer;
Begin
	For i:=1 to n do
    begin
        {So 1}
    	If (1<=i) and (i<=so1) then
        begin
        	if a[i]=2 then
        	   for j:=so1+1 to so1+so2 do
               begin
               	   if a[j]=1 then
				   begin
                		tg:=a[i];
                        a[i]:=a[j];
                        a[j]:=tg;
                        inc(solan);
                        kq[solan,1]:=i;
                        kq[solan,2]:=j;
                        break;
				   end;

                   if a[j]=3 then
                   	for l:=so1+so2+1 to so1+so2+so3 do
                    	if a[l]=1 then
                        begin
                        	tg:=a[l];
                            a[l]:=a[j];
                            a[j]:=tg;
                        	inc(solan);
                            kq[solan,1]:=j;
                            kq[solan,2]:=l;


                            tg:=a[j];
                            a[j]:=a[i];
                            a[i]:=tg;
                            inc(solan);
                            kq[solan,1]:=i;
                            kq[solan,2]:=j;
                            break;

                        end;
               end;

            if a[i]=3 then
        	   for j:=so1+so2+1 to so1+so2+so3 do
               	   if a[j]=1 then
				   begin
                		tg:=a[i];
                        a[i]:=a[j];
                        a[j]:=tg;
                        inc(solan);
                        kq[solan,1]:=i;
                        kq[solan,2]:=j;
                        break;
				   end;
        end;

		{so 2}
        If (so1+1<=i) and (i<=so1+so2) then
        begin
        	if a[i]=3 then
        	   for j:=so1+so2+1 to so1+so2+so3 do
               	   if a[j]=2 then
				   begin
                		tg:=a[i];
                        a[i]:=a[j];
                        a[j]:=tg;
                        inc(solan);
						kq[solan,1]:=i;
                        kq[solan,2]:=j;
                        break;
				   end;
        end;

    end;
End;

Procedure Done;
Var
	f:text;
Begin
	Assign(f,fo);
    rewrite(f);
    Writeln(f,solan);
    For i:=1 to solan do writeln(f,kq[i,1]:5,kq[i,2]:5);
    close(F);
End;

BEGIN
    Clrscr;
	Init;
    Main;
    Done;
END.
9
2
2
1
3
3
3
2
3
1


