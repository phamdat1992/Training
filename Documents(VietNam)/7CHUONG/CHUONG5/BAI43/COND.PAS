{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const
     fi='cond.inp';
     fo='cond.out';
var
   s:string;
   x:integer;
function nhan(a,b:string):string;
var x1,x2,c:array[1..255]of byte;
    s:string;
    max,n,m,i,j,code:integer;
    x:string;
begin
     for i:=1 to length(a) do
     val(a[i],x1[i],code);
     m:=length(a);

     for j:=1 to length(b) do
     vaL(b[j],x2[j],code);
     n:=length(b);
     for i:=1 to m do
     c[i]:=x1[m+1-i];
     x1:=c;
     for i:=1 to n do
     c[i]:=x2[n+1-i];
     x2:=c;
     fillchar(c,sizeof(c),0);
     for j:=1 to n do
     begin
          for i:=1 to m do
          begin
               c[i+j-1]:=c[i+j-1]+x1[i]*x2[j];
               c[i+j]:=C[i+j]+c[i+j-1] div 10;
               c[i+j-1]:=c[i+j-1]mod 10;
          end;
     end;
     max:=n+m;
     s:='';
     for i:=max downto 1 do
     begin
          str(c[i],x);
          s:=s+x;
     end;
     nhan:=s;
end;
function giathua(n:integer):string;
var a,b:string;
    i:integer;
begin
     a:='1';
     for i:=2 to n do
     begin
          str(i,b);
          a:=nhan(a,b);
     end;
     while a[1]='0' do
     delete(a,1,1);
     giathua:=a;
end;
function cong(a,b:string):string;
var
   max,m,n,i,j,code:integer;
   s,s1:string;
   x1,x2,c:array[1..255]of byte;
begin
     m:=length(a);
     n:=length(b);
     for i:=1 to m do
     val(a[i],x1[m+1-i],code);
     for i:=1 to n do
     val(b[i],x2[n+1-i],code);
     fillchar(c,sizeof(c),0);
     if m>n then
     begin
          for i:=1 to n do
          begin
               c[i]:=c[i]+x1[i]+x2[i];
               c[i+1]:=c[i] div 10;
               c[i]:=c[i] mod 10;
          end;
          for i:=n+1 to m do
          begin
               c[i]:=c[i]+x1[i];
               c[i+1]:=c[i] div 10;
               c[i]:=c[i] mod 10;
          end;
     end
     else
     begin
          for i:=1 to m do
          begin
               c[i]:=x1[i]+x2[i]+c[i];
               c[i+1]:=c[i] div 10;
               c[i]:=c[i] mod 10;
          end;
          for i:=m+1 to n do
          begin
               c[i]:=c[i]+x2[i];
               c[i+1]:=c[i] div 10;
               c[i]:=c[i] mod 10;
          end;
     end;
     if m>n then max:=m+1 else max:=n+1;
     s:='';
     for i:=max downto 1 do
     begin
          str(c[i],s1);
          s:=s+s1;
     end;
     while s[1]='1' do
     delete(s,1,1);
     cong:=s;
end;

procedure readfile;
var f,f1:text;
    i:integer;
    b:string;
begin
     clrscr;
     assign(f,fi);
     reset(f);
     assign(f1,fo);
     rewrite(f1);
     while not eof(f) do
     begin
          readln(f,x);
          s:=giathua(x);
          for i:=1 to x-2 do
          begin
               b:='2';
               s:=nhan(s,b);
          end;
          while s[1]='0'do
          delete(s,1,1);
          s:=cong(s,'1');
          while s[1]='0' do
          delete(s,1,1);
          writeln(f1,s);
     end;
     close(f);
     close(f1);
end;

begin
     readfile;
end.

3