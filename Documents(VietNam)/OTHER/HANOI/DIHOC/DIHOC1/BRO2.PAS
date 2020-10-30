Program bro;
Uses crt;
Const
     Fi='bro.in';
     Fo='bro.out';
     Maxn=10000;
Type
    mang = array[1..maxn] of 0..maxlongint;
Var
   z,d:^mang;
   chiphi:^mang;
   c:integer;
   n,i,j,m,k,l:longint;
Procedure readf;
Var
   f:text;
Begin
     Assign(f,fi);
     reset(f);
     Readln(f,n);
     readln(f,c);
     For i:=1 to n do readln(f,c^[i],d^[i]);
     close(f);
End;