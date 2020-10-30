{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 65384,0,655360}
{ Thay giao Nguyen Duc Nghia }

uses crt;
const fi='bro9.in';
	  fo='bro.out';

var a,b:array[1..10000] of word;
 	s:real;
	i,j,k,l,cuoc,n:integer;

    f:text;
    tg,tong,maxtien:extended;


procedure nhap;
begin
assign(f,fi);reset(f);
readln(f,n);
readln(f,cuoc);
for i:=1 to n do  readln(f,a[i],b[i]);
close(f);
end;
{ nhu cau tieu thu trong a, chieu dai trong b }

procedure try(i:integer);
var j:integer;
    tong1:longint;
begin
tong:=0;
tg:=0;
for j:=1 to n do tong:=tong+b[i];
tong1:=0;

for j:=i to n do
      begin
        tong1:=tong1+b[i];
        if tong1<tong div 2 then tg:=tg+tong1*a[i]
               else tg:=(tg+tong-tong1)*a[i];
      end;

tong:=0;
for j:= i-1 downto 1 do
     begin
	     tong1:=tong1+b[i];
         if tong1<tong div 2 then tg:=tg+tong1*a[i]
               else tg:=(tg+tong-tong1)*a[i];
      end;


if tg<maxtien then  BEGIN
						maxtien:=tg;
                        L:=I;
                      END;
end;

procedure main;
begin
 maxtien:=1.0e100;

 for i:=1 to n do try(i);

 assign(f,fo);rewrite(f);
 tg:=maxtien*cuoc;
 write(f,tg);
 close(f);

end;
begin
nhap;
main
end.

6
2
1 2
2 3
1 2
5 2
1 10
2 3