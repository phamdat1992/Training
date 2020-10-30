{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;
const  fi='robot.inp';
       fo='robot.out';
var    a:array[0..52] of extended;
       b:array[0..52] of byte;
       n,k,dem:byte;
       f,f1:text;

procedure  mofile;
begin
      assign(f,fi);
      reset(f);
      assign(f1,fo);
      rewrite(f1);
end;

procedure  dongfile;
begin
      close(f);
      close(f1);
end;

procedure  docfile;
begin
       readln(f,n,k);
end;

procedure  khoitao;
begin
      fillchar(a,sizeof(a),0);
      fillchar(b,sizeof(b),0);
      a[1]:=n;b[1]:=1;
end;

function  sl_robot(i:extended):extended;
var sl,j,l:extended;
begin
      sl:=0;
      j:=int(i/5);
      l:=i-j*5;
      sl:=9*(j-1);
      if l=0 then  sl:=sl+9;
      if l=1 then  sl:=sl+10;
      if l=2 then  sl:=sl+12;
      if l=3 then  sl:=sl+14;
      if l=4 then  sl:=sl+15;
      sl_robot:=sl;
end;

procedure  tao_robot(i:byte);
var  j:byte;
begin
       b[i]:=i;
       if i>15 then b[i]:=15;
       for j:=i-1 downto 1 do
       if b[j]>0 then
       begin
	          a[i]:=a[i]+sl_robot(a[j]);
              dec(b[j]);
       end;
end;

procedure  xuli;
var  i:byte;
begin
     for i:=2 to k+1 do tao_robot(i);
end;

procedure  xuat;
var  tong:extended;i:byte;
begin
    tong:=0;
     for i:=1 to k+1 do
       if b[i]>0 then tong:=tong+a[i];
    writeln(f1,tong:0:0);
end;

begin  clrscr ;
     mofile;
     docfile;
     khoitao;
     xuli;
     xuat;
     dongfile;
end.

