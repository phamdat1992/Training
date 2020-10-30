{   de bai :
    cho mot bang co kich thuoc n*n(n<=8);hay tim cach sap xep n quan hau len bang
sao cho khong co hai quan nao nhin thay nhau duoc  .
    }
program  queen1;
const    n=20;
var      a:array[1..n]of boolean;
         x:array[1..n]of integer;
         c:array[1-n..(n-1)]of boolean;
         b:array[2..(2*n)]of boolean;
         s,i,count:integer;
(*************************************************)
procedure danhdau;
begin     count:=0;
          for i:=1 to s do
          a[i]:=true;
          for i:=(1-n) to (n-1) do
          c[i]:=true;
          for i:=2 to n+n do
          b[i]:=true;
end;
(*************************************************)
procedure xuat;
var   k:integer;
begin count:=count+1;
      write(count,': ');
      for k:=1 to s do
      begin
          write(x[k]:4);
      end;
      writeln;
end;
(*************************************************)
procedure try(i:integer);
var       j:integer;
begin     for j:=1 to s do
          if a[j] then
          if b[i+j] then
          if c[i-j] then
          begin
               x[i]:=j;
               a[j]:=false;
               b[i+j]:=false;
               c[i-j]:=false;
               if i=s then xuat else
               try(i+1);
               a[j]:=true;
               b[i+j]:=true;
               c[i-j]:=true;

          end;

end;
(*************************************************)
begin
         writeln('      MOi nhap n:  ');readln(s);
         danhdau;
         try(1);
         readln;
end.