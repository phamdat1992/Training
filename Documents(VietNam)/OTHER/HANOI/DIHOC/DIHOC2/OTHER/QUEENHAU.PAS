Program conhau;
uses crt;
Const
	fi='queen.inp';
    Fo='queen.out';
Var
   A:array[1..maxn] of integer;
   i,j,m,n:integer;

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
          a[u,v]:=1;
     end;
end;

Procedure init;
begin
     fillchar(a,sizeof(a),0);
     readf;
end;
