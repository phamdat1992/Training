PROGRAM MIEN_BA_MAU;
uses crt;
const fi='tricolor.inp';
      fo='tricolor.out';
type poiu=record
     x,y:integer;
     end;
var   diem:array[1..2,1..1000] of poiu;
      dau:array[-50..50,-50..50] of byte;
      mau:array[1..1000] of byte;
      f1,f2:text;
      n,i,j:integer;
      x1,x2,x3,x4,x5,luud,luur:integer;
      mind,minc,maxd,maxc:integer;
      sl:integer;
      luu1,luu2,luu3,luu4:integer;

procedure chuanbi;
begin
     fillchar(diem,sizeof(diem),0);
     fillchar(dau,sizeof(dau),0);
     n:= 0;
     mind:= maxint;   minc:= maxint;
     maxd:= -maxint;  maxc:=-maxint;

end;

procedure danhdau(n:integer);
var mau1:integer;
begin
     mau1:=mau[n];
     if mau[n]=2 then mau1:=3;
     if mau[n]=3 then mau1:=5;
     for i:=diem[1,n].x to diem[2,n].x do
     for j:=diem[1,n].y to diem[2,n].y do
     begin
          dau[i,j]:=dau[i,j]+mau1;
     end;
end;

procedure xuli;
begin
     luu1:=   maxint;    luu2:=   maxint;
     luu3:=  -maxint;    luu4:=  -maxint;
     for i:=mind to maxd do
     for j:=minc to maxc do
     if dau[i,j]=9 then
     begin
          luud:=i;
          luur:=j;
          if luu1>i then luu1:=i;
          if luu2>j then luu2:=j;
          if luu3<i then luu3:=i;
          if luu4<j then luu4:=j;
          inc(sl);
     end;
end;

procedure docdulieu;
begin
     assign(f1,fi);reset(f1);
     assign(f2,fo);rewrite(f2);
     chuanbi;
     while not eof(f1) do
     begin
                readln(f1,x1,x2,x3,x4,x5);

                if(x1<>-1)or(x2<>-1)or(x3<>-1)or(x4<>-1)or(x5<>-1) then
                begin

                     inc(n);

                     diem[1,n].x:= x1;   diem[1,n].y:= x2;
                     diem[2,n].x:= x3;   diem[2,n].y:= x4;

                     mau[n]:= x5;
                     danhdau(n);

                     if mind > x2 then mind:= x2;
                     if maxd < x3 then maxd:= x3;
                     if minc > x1 then minc:= x1;
                     if maxc < x4 then maxc:= x4;
                end
                else
                begin
                     if n<>0 then
                     begin
                          xuli;
                          writeln(f2,luu3-luu1,' ',luu4-luu2);
                     end;
                     chuanbi;
                end;
     end;

     close(f1);   close(f2);
end;

BEGIN
     clrscr;
     docdulieu;
END.


0 0 4 4 1
1 1 5 2 2
-1 -1 -1 -1 -1
0 0 2 2 1
1 1 3 3 2
2 2 4 4 3
-1 -1 -1 -1 -1
-1 -1 -1 -1 -1

-1 -4 1 4 1
-2 -2 3 0 1
0 -3 3 2 3
0 -2 5 0 2
3 -2 4 0 2
-1 -1 -1 -1 -1
-1 -1 -1 -1 -1



