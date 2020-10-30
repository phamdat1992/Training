{$R+}
{$M 65000,0,655360}
Program robot_quet_voi;
Uses crt;
Const
	Fi='robot.inp';
    fo='robot.out';
    n=9;
    tam:string[n]='123456789';
    t:string[n]='TTTTTTTTT';
Var
	a:array[1..n] of string[n];
  	i,j,m:integer;
    mau:string;
    mau2:string;
    chuoi,lchuoi:string;
    solan,lsolan:integer;

Procedure readf;
Var
	f:text;
Begin
     assign(f,fi);
     reset(f);
     For i:=1 to n do readln(f,a[i]);
     readln(f,mau);
end;

Procedure init;
begin
     For i:=1 to n do a[i]:='';
     Readf;
     solan:=0;
     lsolan:=maxint;
     chuoi:='';
     lchuoi:='';
end;

Procedure biendoi(j:integer);
Var
   i,l:integer;
begin
     for i:=1 to n do
     begin
          l:=pos(tam[i],a[j]);
          if l<>0 then
          case mau[i] of
               'T': mau[i]:='X';
               'X': mau[i]:='V';
               'V': mau[i]:='T';
          end;
     end;
end;

Procedure xoa(j:integer);
Var
   i,l:integer;
begin
     for i:=1 to n do
     begin
          l:=pos(tam[i],a[j]);
          if l<>0 then
          case mau[i] of
               'V': mau[i]:='X';
               'T': mau[i]:='V';
               'X': mau[i]:='T';
          end;
     end;
end;

Procedure update;
begin
     if solan<lsolan then
     begin
          writeln(mau);
          lchuoi:=chuoi;
          lsolan:=solan;
     end;
end;

Procedure try(i:integer);
Var
   j:integer;
Begin
     if mau=t then
     begin
          update;
          exit;
     end;

     if (solan>=lsolan) then exit;
     if solan>10 then exit;

     For j:=1 to n do
     begin
          chuoi:=chuoi+tam[j];
          biendoi(j);
          solan:=solan+1;
{          writeln(solan);
          writeln(chuoi);
          writeln(mau);}
          writeln(mau);
          try(i+1);
          Xoa(j);
          solan:=solan-1;
          delete(chuoi,length(chuoi),1);
     end;
end;

Procedure main;
begin
     try(1);
end;

Procedure done;
Var
   f:text;
begin
     assign(f,fo);
     rewrite(f);
     if lsolan<>0 then
     writeln(f,lchuoi)
     else writeln(f,0);
     close(f);
end;

BEGIN
     clrscr;
     init;
     main;
     done;
END.
159
123
357
147
5
369
456
789
258
VTTTVTTTV

XVXVXVTXT
