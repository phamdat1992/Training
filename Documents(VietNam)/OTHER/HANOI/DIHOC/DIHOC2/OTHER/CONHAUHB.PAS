{$R+}
Program conhau;
uses crt;
Const
	fi='queen.inp';
    Fo='queen.out';
    maxn=100;
Var
   A:array[0..maxn,0..maxn] of boolean;
   b:array[0..maxn,0..maxn] of integer;
   hang,cot:array[1..maxn] of boolean;
   cheot:array[1..maxn*2] of boolean;
   cheop:array[-maxn*2..maxn*2] of boolean;
   i,j,m,n:integer;
   dem:integer;
   so:integer;
   sophep:integer;
Procedure readf;
Var
   f:text;
   u,v:integer;
Begin
     assign(f,fi);
     reset(f);
     Readln(f,n);
     For i:=1 to n do
     begin
          readln(f,u,v);
          inc(dem);
          a[u,v]:=True;
     end;
end;

Procedure init;
begin
     fillchar(a,sizeof(a),False);
     Fillchar(cheop,sizeof(cheop),True);
     Fillchar(cheot,sizeof(cheot),True);
     Fillchar(hang,sizeof(hang),True);
     Fillchar(cot,sizeof(cot),True);
     Fillchar(b,sizeof(b),0);

     dem:=0;
     readf;
     so:=0;
     sophep:=0;
end;

function thaydoi:integer;
Var
   i,j,t:integer;
begin
     t:=0;
     For i:=1 to n do
         for j:=1 to n do
             if (a[i,j]) and (b[i,j]<>0) then inc(t);
     thaydoi:=n-t;
end;

Procedure update;
Var
   i,j:integer;
begin
     inc(sophep);

     for i:=1 to n do
     begin
          for j:=1 to n do write(b[i,j]:5);
          writeln;
     end;

     writeln('So vi tri thay doi',thaydoi);
     writeln;
     readln;
end;

Procedure try(i:integer);
Var
   j:integer;
begin
     if (i>=n) and (thaydoi=3) then
     begin
          update;
          exit;
     end;


     for j:=1 to n do
         if hang[i] and cot[j] and cheot[i+j] and cheop[i-j] and (b[i,j]=0) then
         begin
              inc(so);
              b[i,j]:=so;
              hang[i]:=false;
              cot[j]:=false;
              cheot[i+j]:=false;
              cheop[i-j]:=false;

              try(i+1);

              dec(so);
              b[i,j]:=0;
              hang[i]:=true;
              cot[j]:=true;
              cheot[i+j]:=true;
              cheop[i-j]:=true;
         end;
end;

Procedure main;
begin
     so:=0;
     TRY(1);
end;

Procedure done;
Var
   f:text;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,sophep);
     close(f);
end;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
4
2 1
1 3
3 4
4 2

