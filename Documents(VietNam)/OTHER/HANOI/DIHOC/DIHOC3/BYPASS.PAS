Program Bypass;
Uses crt;
Const
     Fi='bypass.inp';
     Fo='bypass.out';
     maxn=10000;
Var
   A:array[1..maxn] of 0..10000;
   pass:array[1..maxn] of integer;
   tt:array[1..maxn] of 0..2;
   i,j,m,n:integer;
   dau,cuoi:integer;
   khongduoc:boolean;
   kq:boolean;
Procedure Readf;
Var
   f:text;
Begin
     Assign(f,fi);
     reset(f);
     Readln(f,n);
     For i:=1 to n do read(f,a[i]);
     close(f);
End;

Procedure Init;
Begin
     Fillchar(a,sizeof(a),0);
     Fillchar(tt,sizeof(tt),0);
     Readf;
     dau:=1;
     cuoi:=0;
     khongduoc:=false;
     kq:=true;
End;

Function ok:boolean;
Var
   i:integer;
begin
     ok:=false;
     for i:=1 to n do
         if tt[i]<>1 then exit;
     ok:=true;
end;

Procedure Main;
Var
   i,j:integer;
   so:integer;
   p:boolean;
Begin
     for i:=1 to n do
     begin
          so:=a[i];
          if tt[so]=2 then
          begin
               if pass[dau]=so then
               begin
                    tt[so]:=1;
                    inc(dau);
               end
               else
               begin
                    kq:=false;
                    exit;
               end
          end
          else
          begin
               for j:=1 to so-1 do
                   if tt[j]=0 then
                   begin
                        tt[j]:=2;
                        inc(cuoi);
                        pass[cuoi]:=j;
                   end;
               tt[so]:=1;
          end;
     end;
End;

Procedure done;
Var
   f:text;
begin
     Assign(f,fo);
     rewrite(f);
     if kq=true then writeln(f,1) else writeln(f,0);
     close(f);
{     writeln;
     for i:=1 to n do write(tt[i]:5);
     writeln;
     writeln('KQ: ',kq);
     writeln(ok);
}
end;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
4
1 4 3 2









