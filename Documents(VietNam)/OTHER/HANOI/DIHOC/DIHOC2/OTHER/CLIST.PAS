Program danhsach;
Uses crt;
Const
     fi='clist.inp';
     Fo='clist.out';
     maxn=100;
Var
   A,B:array[1..maxn] of integer;
   k,l,n:integer;
   x:longint;
   f:text;
   i:integer;
Procedure readf;
Var
   f:text;
begin
     assign(f,fi);
     reset(f);
     Readln(f,n,k,l);
     for i:=1 to n do read(f,a[i]);
     Readln(f,x);
     close(f);
end;

procedure init;
begin
     Fillchar(a,sizeof(a),0);
     Fillchar(b,sizeof(b),0);

     readf;
     assign(f,fo);
     rewrite(f);
end;

Procedure main;
var
   i,j:longint;
   chuyen:longint;
   h,soluong:longint;
begin
     if k=l then
     begin
          for i:=1 to n do write(f,a[i],' ');
          exit;
     end;

     If k>l then
     begin
          i:=0;
          chuyen:=k-l;
          x:=x mod (chuyen*n);

          while i<x do
          begin
                inc(i);
                Move(a[1],b,(n-chuyen+1)*2);
                Move(a[chuyen+1],a[1],n*2);
                Move(b,a[n-chuyen+1],(n-chuyen+1)*2);
          end;

          for i:=1 to n do write(f,a[i],' ');
     end;

     If k<l then
     begin
          i:=0;
          chuyen:=l-k;
          if x>chuyen*n then
          begin
               h:=x div (chuyen*n);
               x:=x-h*chuyen*n;
          end;
          Repeat
                inc(i);
                Move(a[n-chuyen+1],b,(n-chuyen+1)*2);
                Move(a[1],a[chuyen+1],n*2);
                move(b,a[1],chuyen*2);
          until i>=x;

          for i:=1 to n do write(f,a[i],' ');
     end;
end;

Procedure done;
begin
     close(f);
end;

Procedure sinhtest;
Var
   x,n,k,l:longint;
   f:text;
Begin
     assign(f,fi);
     rewrite(f);
     n:=100;
     k:=30;
     l:=2;
     x:=20000000;
     writeln(f,n,' ',k,' ',l);
     for i:=1 to n do write(f,i,' ');
     writeln(f);
     writeln(f,x);
     close(f);
end;

BEGIN
     Clrscr;
{     sinhtest;
      end.
}
     Init;
     Main;
     Done;
END.
5 1 3
1 2 3 4 5
10
