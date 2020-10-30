(*
   Cho xau ki tu ,hay viet dang thu gon cua xau sao cho so luong cac ki tu
   con lai la it nhat.
       Vi du:
          Input : aaababcabbcabxaaababcabbcabxyz
          Output: 10
                  (a3ba(bcab)2x)2yz
   Tu tuong thuat toan:
          Dung quy hoach dong:
             -  lap ham  mind(i,i+j) la ham the hien so ki tu it nhat neu rut
                gon j+1 ki tu tu ki tu i.
             -  ham soluong(i,j,p) la so lan lap lai cua xau co p ki tu ke tu
                ki tu i+j trong xau(i,i+j);
             _  thu moi kha nang cua p ,lay gia tri be nhat.
*)

uses crt;
const  fi='same.inp';
       fo='same.out';
       maxkt=230;
       soxau=3;
type   xau=string[maxkt];
       mang=array[1..maxkt,1..maxkt] of byte;
var    st,s:xau;
       mind:array[1..maxkt,1..maxkt] of byte;
       fro1,fro2:^mang;
       n:byte;
       f:text;
       t1:longint absolute 0:$46c;
       t2:longint;

procedure  readfile;
var  i:byte;
begin
       t2:=t1;
       assign(f,fi);
       reset(f);
       for i:=1 to soxau do readln(f,st);
       n:=length(st);
       close(f);
       writeln('DaTa Of Program: ');
       writeln('****************');
       writeln(st);
       writeln('****************');
       writeln('Solution:');
end;

procedure  init;
var  i:byte;
begin
       fillchar(mind,sizeof(mind),0);
       fillchar(fro1^,sizeof(fro1^),0);
       fro2^:=fro1^;
       for i:=1 to n do
       begin
            mind[i,i]:=1;
            fro2^[i,i]:=1;
            fro1^[i,i]:=1;
       end;
end;

function  soluong(i,j,lm:byte):byte;
var    j1,dem,k1:byte;
       dk:boolean;
       s1:xau;
begin
      s:=copy(st,i+j-lm+1,lm);
      s1:=copy(st,i,j+1);
      dem:=0;j1:=i+j;
      while (s=copy(st,j1-lm+1,lm)) and (j1>=i) do
       begin
             inc(dem);
             j1:=j1-lm;
       end;
       soluong:=dem;
end;

procedure  xuat(i,j:integer);
begin
      if (i>0) and (j>0) and (i<=j)and (fro1^[i,j]>=1) then
       begin
            if (fro1^[i,j]=1)  then
               begin
                    xuat(i,j-1);
                    write(st[j]);
                    if (fro1^[i,j]>1) or (fro2^[i,j]>1) then write(fro1^[i,j]);
               end
            else
               begin
                     xuat(i,j-fro1^[i,j]*fro2^[i,j]);
                     if (fro2^[i,j]>1) then write('(');
                     xuat(j+1-fro2^[i,j],j);
                     if fro2^[i,j]>1 then write(')');
                     write(fro1^[i,j]);
               end;
       end;
end;

procedure  xuli;
var  i,j,k,p,ln:byte;
begin
      for j:=1 to n-1 do
        for i:=1 to n-j do
         begin
             mind[i,i+j]:=mind[i,i+j-1]+1;
             fro1^[i,i+j]:=1;fro2^[i,i+j]:=1;
               for p:=1 to j div 2+1 do
                begin
                  ln:=soluong(i,j,p)-1;
                     for k:=ln downto 1 do
                  begin
                   if mind[i,i+j]>mind[i,(i+j)-p*(k+1)]+mind[i+j-p+1,i+j] then
                     begin
                           mind[i,i+j]:=mind[i,(i+j)-p*(k+1)]+mind[i+j-p+1,i+j];
                           fro1^[i,i+j]:=k+1;
                           fro2^[i,i+j]:=p;
                     end;
                  end;
               end;
         end;
         writeln(mind[1,n]);
         writeln('****************');
         xuat(1,n);
         writeln;
         writeln('****************');
         writeln('TIME RUN: ',((t1-t2)/18.21):6:6);
end;

begin
       clrscr;
       new(fro1);
       new(fro2);
       readfile;
       init;
       xuli;
       release(fro1);
       release(fro2);
       readln
end.


