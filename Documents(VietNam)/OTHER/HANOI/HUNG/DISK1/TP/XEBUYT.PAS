(* Mot day cac tuyen xe va cac nha ga
   tim duong di tu ga 1 tuyen 1 den ga y tuyen x voi it lan chuyen tuyen nhat
     Thuat Toan: dijsktra
      Lap Trinh Vien :RONALDO  Khoi Chuyen Toan Tin PbC
    *)

uses crt;
const  fin='xebuyt.inp';
type  mang=array[0..100,0..100] of 1..1000;
var   mind,a:mang;
      front:array[1..100,1..100,1..2] of byte;
      m,x,y:byte;
      f:text;


procedure init;
begin
     fillchar(a,sizeof(a),0);
end;

procedure readfile;
var  i,j:byte;
begin
 writeln('INPUT:');
 assign(f,fin);
 reset(f);
 readln(f,m,x,y);
 writeln(m,'  ',x,'  ',y);
 for i:=1 to m do
  begin
   read(f,a[i,0]);
   write(a[i,0],'   ');
   for j:=1 to a[i,0] do begin read(f,a[i,j]);write(a[i,j],'   ');end;
   readln(f);
   writeln;
  end;
 close(f);
 writeln('OUTPUT:');
end;

function dodai(i1,j1,i2,j2:byte):integer;
begin
  dodai:=0;
  if (a[i1,j1]=a[i2,j2])  then   dodai:= 200;
  if (i1=i2) and (j1+1=j2) then dodai:=1;
end;

procedure  init1;
var  i,j:byte;
begin
 fillchar(mind,sizeof(mind),0);
 fillchar(front,sizeof(front),1);
 front[1,1,1]:=0;front[1,1,2]:=0;
 mind[1,2]:=1;
 for i:=2 to m do
  for j:=1 to a[i,0] do
   begin
    mind[i,j]:=dodai(1,1,i,j);
   end;
end;

procedure  xuat;
var kp:byte;
begin
  writeln('So Lan Chuyen Tuyen It Nhat La: ',mind[x,y] div 200);
  while (x>0) and (y>0) do
   begin
      write('[',x,'.',y,']  ');
      kp:=x;
      x:=front[x,y,1];
      y:=front[kp,y,2]
   end;
end;

procedure  dijsktra;
var  i,j,luu1,luu2,min:integer;
     chuaxet:array[1..100,1..100] of boolean;
begin
  fillchar(chuaxet,sizeof(chuaxet),true);
  chuaxet[1,1]:=false;
  repeat
    min:=maxint;luu1:=0;luu2:=0;
    for i:=1 to m do
     for j:=1 to a[i,0] do
      if (chuaxet[i,j])and (mind[i,j]>0) and (mind[i,j]<min) then
           begin
               min:=mind[i,j];
               luu1:=i;
               luu2:=j;
            end;
       chuaxet[luu1,luu2]:=false;
       if min<maxint then
        begin
          for i:=1 to m do
           for j:=1 to a[i,0] do
            if dodai(luu1,luu2,i,j)>0 then
              if (chuaxet[i,j]) and ((mind[i,j]>mind[luu1,luu2]+dodai(luu1,luu2,i,j)) or (mind[i,j]=0)) then
               begin
                     mind[i,j]:=mind[luu1,luu2]+dodai(luu1,luu2,i,j);
                     front[i,j,1]:=luu1;
                     front[i,j,2]:=luu2
               end;
        end
      else begin xuat;exit;end;
  until maxint<=min;
  xuat;
end;

begin  clrscr;
 init;
 readfile;
 init1;
 dijsktra;
 readln
end.
4 4 4
4 5 4 6 2
3 1 2 3
4 5 6 4 2
4 1 2 3 7
4 4 4
4 5 4 6 2
3 1 2 3
4 5 6 4 2
4 1 8 3 7