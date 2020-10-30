Program matrantong;
Uses crt;
Const
     Fi='latinh.inp';
     Fo='latinh.out';
     maxn=5;
     tong:array[3..5] of integer=(15,34,65);
Var
   a:array[1..maxn,1..maxn] of integer;
   b:array[1..maxn*maxn] of boolean;

   cot,hang:array[1..5] of integer;
   cheop,cheot:integer;

   u,v,gt:integer;
   e,i,j,m,k,n:integer;
   f:text;

Procedure readf;
var
   f:text;
begin
     Assign(f,fi);
     Reset(f);
     Readln(f,n,e);

     For i:=1 to e do
     begin
          readln(f,u,v,gt);
          a[u,v]:=gt;

          hang[u]:=hang[u]+gt;
          cot[v]:=cot[v]+gt;

          if u=v then cheop:=cheop+gt;
          If u+v=n+1 then cheot:=cheot+gt;
          b[gt]:=false;
     end;

{     for i:=1 to n do
          writeln('tong hang ',i,': ',hang[i],' Tong cot ',i,': ',cot[i]);

     writeln('Cheo p: ',cheop,' cheoT: ',cheot);
}
     Close(f);
end;

Procedure init;
begin
     Fillchar(a,sizeof(a),0);
     Fillchar(b,sizeof(b),True);
     Fillchar(cot,sizeof(cot),0);
     Fillchar(hang,sizeof(hang),0);
     cheot:=0;cheop:=0;

     Readf;
     Assign(f,fo);
     Rewrite(F);
end;

Function on:boolean;
Var
   i,j:integer;
begin
     on:=false;

     for i:=1 to n do
         for j:=i+1 to n do
         begin
              if hang[i]<>hang[j] then exit;
              if cot[i]<>cot[j] then exit;
              if hang[i]<>cheop then exit;
              if hang[i]<>cheot then exit;
              if cot[i]<>cheop then exit;
              if cot[i]<>cheot then exit;
         end;

     on:=true;
end;

Procedure update;
Var
   i,j:integer;
begin
     if not on then exit;

     writeln;
     for i:=1 to n do
     begin
          for j:=1 to n do write(a[i,j]:5);
          writeln;
     end;
     readln;
     rewrite(f);
     writeln(f,1);
     close(F);
     halt;
end;

procedure try(i,j:integer);
var
   k:integer;
begin
     If i>n then
     begin
          update;
          exit;
     end;

     If j>n then
     begin
          try(i+1,1);
          exit;
     end;

     if a[i,j]<>0 then
     begin
          try(i,j+1);
          exit;
     end;

     For k:=1 to n*n do
     if (b[k]) and (k<=(tong[n]-hang[i])) and (k<=(tong[n]-cot[j])) then
     begin
          a[i,j]:=k;
          hang[i]:=hang[i]+k;
          cot[j]:=cot[j]+k;
          if i=j then cheop:=cheop+k;
          if i+j=n+1 then cheot:=cheot+k;

          b[k]:=false;

          try(i,j+1);

          hang[i]:=hang[i]-k;
          cot[j]:=cot[j]-k;
          if i=j then cheop:=cheop-k;
          if i+j=n+1 then cheot:=cheot-k;

          a[i,j]:=0;
          b[k]:=true;
     end;
end;

procedure main;
Var
   i,j:integer;
begin
     For i:=1 to n do
     begin
          for j:=1 to n do write(a[i,j]:5);
          writeln;
     end;

     try(1,1);
end;

procedure done;
begin
     rewrite(f);
     writeln(f,0);
     close(f);
end;

BEGIN
     clrscr;
     Init;
     Main;
     Done;
END.
3 2
1 3 6
2 1 3



4 0

5 10
1 2 24
3 3 13
5 2 18
3 5 22
2 5 10
5 1 11
5 3 21
2 4 14
3 2 6
1 5 15

4 3
3 3 12
1 4 3
2 4 7

5 7
3 5 4
2 3 3
2 5 25
1 2 15
5 5 7
4 3 21
1 3 10


2 0
3 0
