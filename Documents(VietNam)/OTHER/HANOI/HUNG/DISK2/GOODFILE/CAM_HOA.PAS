(*
  viet chuong trinh cam hoa vao cac binh sao cho diem tham mi dat cao nhat
  va dam bao thu tu cao bong hoa khi cam vao binh tuc la hoa co chi so lon
  hon duoc cam vao binh co chi so lon hon

  THUAT TOAN:
   DUNG QUY HOACH DONG:
  *)

uses crt;
const fin='camhoa.inp';
      fou='camhoa.out';
type  mang=array[0..160,0..160] of byte;
      mang2=array[0..160,0..160] of integer;
var   a,luu:mang;
      maxd:^mang2;
      time1:longint  absolute 0:$46c;
      time2:longint;
      f:text;m,n:byte;

procedure  innit;
begin
 new(maxd);
 fillchar(maxd^,sizeof(maxd^),0);
 fillchar(luu,sizeof(luu),0);
end;

procedure  readfile;
var i,j:byte;
begin
 writeln('INPUT:');
 assign(f,fin);
 reset(f);
 readln(f,m,n);
 writeln(m,'   ',n);
 for i:=1 to m do
  begin
   for j:=1 to n do
    begin
      read(f,a[i,j]);
      write(a[i,j]:6);
    end;
  writeln;
  readln(f);
  end;
 close(f);
end;



procedure xuat;
begin
 while luu[m,n]>0 do
  begin
   write(luu[m,n],'  ');
   n:=luu[m,n]-1;
   dec(m);
 end;
end;

procedure  xu_li;
var i,j,k:byte;
begin
 TIME2:=TIME1;
 for i:=1 to m do
  for j:=1 to n do
   for k:=1 to j-1 do
    if maxd^[i,j]<maxd^[i-1,k]+a[i,k+1] then
     begin
      maxd^[i,j]:=maxd^[i-1,k]+a[i,+k+1];
      luu[i,j]:=k+1;
     end;
     writeln('OUTPUT:');
     writeln(maxd^[m,n]);
     xuat;
     WRITELN;
     writeln('TIME RUN:',((TIME1-TIME2)/18.21):6:6);
end;

begin  clrscr;
 readfile;
 innit;
 xu_li;
 readln;
 dispose(maxd);
end.
3 5
7   23  -5  -24  16
5   21  -4   10  23
-21 5   -4  -20  20

6 9
8 17 -90 5 6 -56 -90 19 21
6 -6 17 38 41 -21 -23 -79 11
13 46  -45 34 11 27 33 -13 -17
8 23 -105 -13 61 39 41 34  -27
34 -23 -61 -23 19 37 45 -16 -405
24 71 63 -24 -19 37 41 -29 -30
