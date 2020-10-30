{ chuong trinh sinh test cua bai biendoi1
  co cac test tu biendoi1.in0->biendoi1.in9}
uses crt;
const
     fi='c:\data\tam\biendoi1.in';
     n=100;
var
   f:text;
   t,i,j:integer;
   a:array[1..100,1..100]of integer;
   x,y:array[1..100]of integer;
   s:string[1];
begin
     randomize;

     for t:=0 to 9 do
     begin
          s:='';
          str(t,s);
          writeln(s);
          assign(f,fi+s);
          rewrite(f);
          writeln(f,n);
          for i:=1 to n do
          begin
               for j:=1 to n do
               begin
                    a[i,j]:=(random(100)+1) mod 2;
                    write(f,a[i,j],' ');
               end;
               writeln(f);
          end;
          for i:=1 to n do
          Begin
               X[i]:=(random(100)+1)mod 2;
               Y[i]:=(random(100)+1)mod 2;
          End;
          for i:=1 to n do
          If X[i]=1 then
          Begin
               for j:=1 to n do
               a[i,j]:=(a[i,j]+1) mod 2;
          End;
          for i:=1 to n do
          If y[i]=1 then
          Begin
               for j:=1 to n do
               a[j,i]:=(a[j,i]+1) mod 2;
          End;
          for i:=1 to n do
          Begin
               for j:=1 to n do
               write(f,a[i,j],' ');
               writeln(f);
          End;
          close(f);
     end;
end.
