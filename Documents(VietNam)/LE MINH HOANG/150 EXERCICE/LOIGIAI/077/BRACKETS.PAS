{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,ctest077;

const
    fi='brackets.in1';
    fo='brackets.out';

var f:text;
    n,vt:integer;
    a:array[1..10000]of integer;
    b:array[1..30000]of char;

procedure nhap;
var i:integer;
begin
   assign(f,fi);
   reset(f);

   readln(f,n);

   for i:=1 to n do read(f,a[i]);

   close(f);
end;

procedure vitri;
begin
   repeat
      inc(vt);
   until b[vt]=' ';
end;

procedure inkq;
var i:integer;
begin
   assign(f,fo);
   rewrite(f);

   fillchar(b,sizeof(b),' ');

   for i:=1 to n do
      begin
         vitri;
         b[vt]:='(';
         b[vt+a[i]+1]:=')';
      end;

   for i:=1 to 2*n do write(f,b[i]);

   close(f);
end;

Begin
   clrscr;

   nhap;

   inkq;
End.


7
4 2 0 2 0 0 0

10
8 2 0 0 0 4 0 0 0 0