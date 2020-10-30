{
 Cho hcn cat da giac. tim cac mien duoc tao thanh. phan bi cat khong duoc tinh
}
uses crt;
const   fi='poli.inp';
        fo='poli.out';
type    toado=record
             x,y:integer;
        end;
var     a:array[1..10000] of toado;
        f:text;
        n,d,tx,ty,px,py:longint;


procedure  readfile;
var  i:integer;
begin
         assign(f,fi);
         reset(f);
              readln(f,n);
              for i:=1 to n do readln(f,a[i].x,a[i].y);
              readln(f,tx,ty,px,py);
              a[n+1]:=a[1];
              n:=n+1;
         close(f);
end;

function   min(i,j:integer):integer;
begin
      min:=i;
      if j<i then min:=j;
end;

function   max(i,j:integer):integer;
begin
      max:=i;
      if j<i then max:=j;
end;

function  trong(i:integer):boolean;
begin
      trong:=true;
         if (a[i].x>tx) and (a[i].x<px) and (a[i].y<ty) and (a[i].y>py) then exit;
      trong:=false;
end;

function  soluong(I:integer):byte;
begin
       soluong:=0;
       if (trong(i) and  not trong(i+1) ) or (trong(i+1) and  not trong(i) ) then soluong:=1;
	   if not trong(i) and not trong(i+1) then
	      if (max(a[i].y,a[i+1].y)>=max(ty,py)) and (max(a[i].x,a[i+1].x)>=max(tx,px)) and
             (min(a[i].x,a[i+1].x)<=min(tx,px)) and (min(a[i].y,a[i+1].y)<=min(ty,py)) then soluong:=2
end;

function  thuoc(i:integer):boolean;
begin
       thuoc:=true;
          if (a[i].x=a[i+1].x) and ((a[i].x=px) or (a[i].x=tx)) then exit;
          if (a[i].y=a[i+1].y) and ((a[i].y=py) or (a[i].y=ty)) then exit;
       thuoc:=false;
end;

procedure   dem_giao_diem;
var  i:integer;
begin
      d:=0;
      for i:=1 to n do
        if not thuoc(i) then
        d:=d+soluong(i);
end;

procedure  xuat;
begin
      assign(f,fo);
      rewrite(f);
          writeln(f,d div 2);
      close(f);
end;

begin  clrscr ;
      readfile;
      dem_giao_diem;
      xuat;
end.


