{$R+,N+}
{ROBOT TREN HANH TINH BETA,  THAY TUNG}

Program robot;
Uses crt;
Const
	Fi='robot.inp';
    Fo='robot.out';
    maxn=52;
Var
   luu,lop:array[1..maxn] of extended;
   nam:array[1..maxn] of integer;
   chet:array[1..maxn] of boolean;

   k,n,i,j,m:integer;
   cuoi:integer;

Procedure Readf;
Var
	f:text;
Begin
	Assign(f,fi);
    Reset(f);
    readln(f,k,n);
    Close(f);
End;

Procedure Init;
Begin
     Fillchar(lop,sizeof(lop),0);
     Fillchar(chet,sizeof(chet),False);

     Readf;
     lop[1]:=k;
     nam[1]:=0;
End;

function  sl_robot(i:extended):extended;
var sl,j,l:extended;
begin
      sl:=0;
      j:=int(i / 5);
      l:=i-j*5;
      sl:=9*(j-1);

      if l=0 then sl:=sl+9;
      if l=1 then sl:=sl+10;
      if l=2 then sl:=sl+12;
      if l=3 then sl:=sl+14;
      if l=4 then sl:=sl+15;

      sl_robot:=sl;
end;

Procedure chetchoc(sn:integer);
Var
   i,j:integer;
begin
     for i:=1 to sn do
     begin
          if (nam[i]>=i) and (sn<15) then chet[i]:=true;
          if (i>=15) and (nam[i]>=15) then chet[i]:=true;
     end;
end;

Procedure tangrobot(sn:integer);
var
   i:integer;
begin
     luu:=lop;

     for i:=1 to sn-1 do
         if (luu[i]<>0) and (not chet[i]) then lop[sn]:=lop[sn]+sl_robot(lop[i]);
end;

Procedure Main;
Var
   i,sn:integer;
Begin
     sn:=1;
     Repeat
           inc(sn);

           for i:=1 to sn do
               if lop[i]<>0 then nam[i]:=nam[i]+1;

           tangrobot(sn);
           chetchoc(sn);

{           writeln('Nam thu ',sn-1);
           for i:=1 to sn do write(chet[i]:5);
           writeln;

           For i:=1 to sn do write(nam[i]:5);
           writeln;

           for i:=1 to sn do write(lop[i]:5:0);
           writeln;

           readln;
}
     until sn=n+1;
End;

Procedure Done;
Var
   f:text;
   tong:extended;
   p:boolean;
Begin
     assign(f,fo);
     rewrite(f);

     tong:=0;

     clrscr;

     for i:=1 to n+1 do
         if not chet[i] then write(lop[i]:0:0,' ');
     writeln;
     readln;

     for i:=1 to n+1 do
         if not chet[i] then
         begin
              writeln(f,lop[i]:0:0);
              tong:=tong+lop[i];
         end;

     writeln(tong:0:0);
     writeln(f,tong:0:0);
     readln;

     close(f);
End;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
4 3

3 3

2 5

50 20