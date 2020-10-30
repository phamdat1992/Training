Program thamhiem;
Uses crt;
Const
     Fi='input.inp';
     Fo='output.out';
     Maxn=30;
     U:array[1..4] of shortint=(-1,0,1,0);
     V:array[1..4] of shortint=(0,1,0,-1);
Var
   A:array[0..maxn+1,0..maxn+1] of 0..1;
   B:array[0..maxn+1,0..maxn+1] of integer;
   C:array[0..maxn+1,0..maxn+1] of boolean;
   phu:array[0..maxn+1,0..maxn+1] of boolean;
   kq:array[1..1000,1..2] of integer;
   i,j,m,n,r,x,y,t1,t2:integer;
   dem:integer;
   dau,cuoi:integer;
Procedure readf;
Var
   f:text;
   i,j:integer;
Begin
     Assign(f,fi);
     Reset(f);
     Readln(f,m,n,r,x,y,t1,t2);

     For i:=1 to m do
          for j:=1 to n do read(f,a[i,j]);
End;

Procedure init;
Begin
     Fillchar(a,sizeof(a),0);
     Fillchar(b,sizeof(b),0);
     Fillchar(c,sizeof(c),True);
     Fillchar(phu,sizeof(phu),False);
     Readf;

     For i:=0 to m+1 do
     begin
          a[0,i]:=1;a[i,0]:=1;
          c[0,i]:=false;c[i,0]:=false;
          a[m+1,i]:=1;a[i,m+1]:=1;
          c[m+1,i]:=false;c[i,m+1]:=false;
     end;
     dau:=1;
     cuoi:=0;
End;

Procedure hanhtrinh(i,j:integer);
Var
    q,p,k:integer;
Begin
     if b[i,j]=0 then
     begin
          b[i,j]:=dem;
          c[i,j]:=false;
     end;
     for k:=1 to 4 do
         if (a[i+u[k],j+v[k]]=0)
        and (b[i+u[k],j+v[k]]=0)
        and (c[i+u[k],j+v[k]])
       then
       begin
            b[i+u[k],j+v[k]]:=dem;
            c[i+u[k],j+v[k]]:=false;
       end;
End;

Procedure timhanhtrinh;
Var
   i,j,l:integer;
Begin
     i:=1;
     dem:=1;
     hanhtrinh(x,y);
     repeat
           inc(i);
           dem:=i;
           for j:=1 to m do
               for l:=1 to n do
                   if (a[j,l]<>1) and (b[j,l]=dem-1) and (not c[j,l]) then Hanhtrinh(j,l);
     until i>=t1-1;

     For i:=1 to m do
     begin
          for j:=1 to n do write(b[i,j]:5);
          writeln;
     end;
End;


Procedure hanhtrinhtiep;
Var
   j,l:integer;
Begin
     inc(dem);
     for j:=1 to m do
         for l:=1 to n do
           if (a[j,l]=0) and (b[j,l]=dem-1) and (not c[j,l]) then Hanhtrinh(j,l);
End;

Procedure phutim(x1,y1:integer);
Var
   i,j:integer;
Begin
     for i:=1 to m do
         for j:=1 to n do
             if (abs(i-x1)+abs(j-y1)<=r) and (b[i,j]<>0) then phu[i,j]:=true;
end;

Function sophu(x1,y1:integer):integer;
Var
   i,j,dem:integer;
Begin
     dem:=0;
     for i:=1 to m do
         for j:=1 to n do
             if (abs(i-x1)+abs(j-y1)<=r) and (b[i,j]<>0) then inc(dem);
     sophu:=dem;
End;

Procedure timchodat;
Var
   i,j,l:integer;
   max:integer;
   chisoi,chisoj:integer;
Begin
     max:=0;

     For i:=1 to m do
         for j:=1 to n do
             if (b[i,j]<>0) and (not c[i,j]) and (phu[i,j]=false) then
             begin
                  l:=sophu(i,j);
                  if l>max then
                  begin
                       max:=l;
                       chisoi:=i;
                       chisoj:=j;
                  end;
             end;
     inc(cuoi);
     kq[cuoi,1]:=chisoi;
     kq[cuoi,2]:=chisoj;
     phutim(chisoi,chisoj);
End;


Function ok:boolean;
Var
   i,j:integer;
begin
     ok:=false;
     For i:=1 to m do
         for j:=1 to n do
             if (not phu[i,j]) and (b[i,j]<>0) then exit;
     ok:=true;
end;

Procedure main;
Var
   i,j,l:integer;
Begin
     timhanhtrinh;

     repeat
           timchodat;
     until ok;
End;

Procedure done;
Var
   f:text;
Begin
     assign(f,fo);
     rewrite(f);
     writeln(f,cuoi);
     while dau<=cuoi do
     begin
          writeln(f,kq[dau,1],' ',kq[dau,2]);
          inc(dau);
     end;
     close(f);
End;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
7 7 2 4 4 3 2
0 0 1 0 1 0 0
0 1 0 0 0 1 0
1 0 0 0 0 0 1
0 0 0 0 0 0 0
1 0 0 0 0 0 1
0 1 0 0 0 1 0
0 0 1 0 1 0 0
