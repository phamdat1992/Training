uses crt;
const
     fi='biendoi2.inp';
     fo='biendoi2.out';
var
   a:array[1..100,1..100]of integer;
   x,y,luu1,luu2:array[1..100]of integer;
   n,m,so_lan_lay,x1:longint;
   f:text;
procedure readfile;
var i,j,t:integer;
begin
     assign(f,fi);
     reset(f);
     readln(f,m,n,x1);
     for i:=1 to m do
     for j:=1 to n do
     read(f,a[i,j]);
     readln(f);
     for i:=1 to m do
     for j:=1 to  n do
     begin
          read(f,t);
          a[i,j]:=(t+x1-a[i,j]) mod x1;
     end;
     close(f);
end;
function kt:boolean;
var i,j:integer;
begin
     kt:=false;
     for i:=1 to m do
     for j:=1 to n do
     if ( a[i,j]+a[1,1])mod x1<>(a[i,1]+a[1,j]) mod x1 then exit;
     kt:=true;
end;
procedure tinh;
var i,j,so_lay:integer;
begin
     fillchar(x,sizeof(x),0);
     y:=x;
     so_lan_lay:=maxint;
     for x[1]:=0 to x1 do
     begin
          so_lay:=0;
          for j:=1 to n do
          begin
               y[j]:=(a[1,j]-x[1]+x1) mod x1;
               inc(so_lay,y[j]);
          end;
          for j:=2 to m do
          begin
               x[j]:=(a[j,1]-y[1]+x1) mod x1;
               inc(so_lay,x[j]);
          end;
          inc(so_lay,x[1]);
          if so_lay<so_lan_lay then
          begin
               so_lan_lay:=so_lay;
               luu1:=x;
               luu2:=y;
          end;
     end;
end;
procedure writefile;
var i,j:integer;
begin
     assign(f,fo);
     rewrite(f);
     if not kt then writeln(f, -1)
     else
     begin
          writeln(f,1);
          tinh;
          writeln(f,so_lan_lay);
          for i:=1 to m do
          write(f,luu1[i],' ');
          writeln(f);
          for i:=1 to n do
          write(f,luu2[i],' ');
     end;
     close(f);
end;
procedure sinhtest1;
var x1,i,j,n,t,m:integer;
begin
     assign(f,fi);
     rewrite(f);
     m:=100;
     n:=100;
     randomize;
     x1:=random(100)+1;
     writeln(f,m,' ',n,' ',x1);
     for i:=1 to m do
     begin
          for j:=1 to n do
          begin
               t:=random(1000)+1;
               write(f,t mod (x1+1),' ');
               a[i,j]:=t mod (x1+1);
          end;
          writeln(f);
     end;
     for i:=1 to m do
     begin
          t:=random(1000)+1;
          x[i]:=t mod (x1+1);
     end;
     for i:=1 to n do
     begin
          t:=random(1000)+1;
          y[i]:=t mod (x1+1);
     end;
     for i:=1 to m do
     for j:=1 to n do
     a[i,j]:=(a[i,j]+x[i])mod x1;
     for j:=1 to n do
     for i:=1 to m do
     a[i,j]:=(a[i,j]+y[j]) mod x1;
     for i :=1 to m do
     begin
          for j:=1 to n do
          write(f,a[i,j],' ');
          writeln(f);
     end;
     close(f);
end;
procedure sinhtest2;
var i,j,n,t,x1,m:integer;
begin
     assign(f,fi);
     rewrite(f);
     n:=100;
     m:=100;
     randomize;
     x1:=random(100)+1;
     writeln(f,m,' ',n,' ',x1);
     for i:=1 to m do
     begin
          for j:=1 to n do
          begin
               t:=random(1000)+1;
               write(f,t mod (x1+1),' ');
          end;
          writeln(f);
     end;
     for i:=1 to m do
     begin
          for j:=1 to n do
          begin
               t:=random(1000)+1;
               write(f,t mod (x1+1),' ');
          end;
          writeln(f);
     end;
     close(f);
end;
begin
{     sinhtest1;   }      { dung cho cac phep co the bien doi duoc }
{     sinhtest2;}         { thuong dung cho cac test khong the bien doi duoc}

     readfile;
     writefile;
end.