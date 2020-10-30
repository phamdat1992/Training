uses crt;
const
     fi='nhan.inp';
     fo='nhan.out';
     fo1='test.inp';
var a,b,c:array[1..1000]of byte;
    n,m,i,j:integer;
procedure readfile;
var f:text;
begin
     clrscr;
     assign(f,fi);
     reset(f);
     readln(f,m,n);
     for i:=1 to m do
     read(f,a[i]);
     readln(f);
     for j:=1 to n do
     read(f,b[j]);
     close(f);
     for i:=1 to m do
     c[i]:=a[m+1-i];
     a:=c;
     for i:=1 to n do
     c[i]:=b[n+1-i];
     b:=c;
     for i:=1 to n do
     write(b[i]);
     writeln;
     for i:=1 to m do
     write(a[i]);
     writeln;
end;
procedure init ;
begin
     fillchar(c,sizeof(c),0);
     for j:=1 to n do
     begin
          for i:=1 to m do
          begin
               c[i+j-1]:=c[i+j-1]+a[i]*b[j];
               c[i+j]:=c[i+j-1] div 10;
               c[i+j-1]:=c[i+j-1]mod 10;

          end;
     end;
end;
procedure writefile;
var f:text;
begin
     assign(f,fo);
     rewrite(f);
     for i:=m downto 1 do
     write(f,a[i]);
     writeln(f);
     for j:=n downto 1 do write(f,b[j]);writeln(f);writeln(f);
     i:=m+n;
     while c[i]<>0 do
     dec(i);
     if c[m+n]=0 then i:=m+n-1;
     for j:=i downto 1 do write(f,c[j]);
     close(f);
end;
procedure taotest;
var f,f1:text;   x,y:integer;
begin
     assign(f,fo1);
     rewrite(f);
     assign(f1,fi);
     rewrite(f1);
     writeln(f1,2,' ',2);


     x:=random(100)+1;
     writeln(f,x);
     writeln(f1,x);
     y:=random(100)+1;
     writeln(f1,y);
     writeln(f,y);
     WRITELN(f);
     writeln(f,x*y);
     close(f);
     close(f1);
end;

begin
{     taotest;}
     readfile;
     init;
     writefile;
     writeln(134*234);

end.
1 1
3
2
