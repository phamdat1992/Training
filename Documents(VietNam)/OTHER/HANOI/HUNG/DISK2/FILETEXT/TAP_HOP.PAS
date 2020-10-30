(*
  Tap Hop T Duoc Goi La tap Hop Tot Neu Nhu No Chua Cac So i,j Thoa Man I+j 
  Khong Thuoc T (i Co The Bang J) 
  Bai Toan Dat Ra : Tao Ra k Tap Hop Tot Chua Cac So Tu Nhien 1--> n Sao Cho
                    N Lon Nhat Co The 
  Thuat Toan :N= ((3^k)-1) Div 2  
         Lap Trinh Vien  RONALDO Khoi Chuyen Toan Tin PBC
         *) ;

uses crt;
const st:array[1..15 ]of string=('1.dat','2.dat','3.dat','4.dat','5.dat','6.dat','7.dat','8.dat','9.dat','10.dat','11.dat',
                                 '12.dat','13.dat','14.dat','15.dat');
var   f:text;
      tep:array[1..15] of text;
      k,k1:byte;
      n:longint;

function  mu(i,j:byte):longint;
var s,p:longint;
begin
  s:=1;
  for p:=1 to j do
   s:=s*i;
  mu:=s;
end;


procedure writeinput;
begin
 write('k=');readln(k);
 k1:=k;
end;

procedure deletefiles;
var i:byte;
    f:text;
begin
 for i:=1 to k1 do
  begin
    assign(f,st[i]);
    erase(f);
  end;
end;

procedure writeoutput;
var  i,j:longint;
begin
 write((mu(3,k1)-1) div 2);readln;
 for i:=1 to k1 do
  begin
    writeln('Tap So Thu : ',I);
    assign(f,st[i]);
    reset(f);
    while not eof(f) do
     begin
       read(f,j);
       if j>0 then write(j,'  ');
     end;
     readln;
     close(f);
  end;
end;

procedure  innit1;
var i:byte;
begin
 for i:=1 to k do
  begin
   assign(tep[i],st[i]);
   rewrite(tep[i]);
  end;
end;

procedure innit2;
var  i:longint;
begin
  for i:=1 to (mu(3,k)-1)  div 2 do
   if i mod 3=1 then  write(tep[1],i,'  ');
    close(tep[1]);
end;

procedure xuli;
var i,j:longint;
begin
 for i:=2 to k do
  begin
   j:=1;
   while  j<=mu(2,i-1) do
    begin
     inc(n);
     while n mod 3=1 do inc(n);
     write(tep[i],n,'  ');
     inc(j);
    end;
  end;
  close(tep[k]);
end;

procedure main;
begin
 n:=0;
 writeinput;
 innit1;
 innit2;
 while k>1 do
  begin
   xuli;
   dec(k);
  end;
  writeoutput;
  deletefiles;
end;

begin  clrscr;
 main;
end.