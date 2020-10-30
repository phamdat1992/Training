Uses crt;
Const max=50;
Type mang1=array[1..max,1..max]of integer;
     mang2=array[1..max]of integer;
     mang3=array[1..max]of boolean;
Var a:mang2;
    n,k:integer;
(**)
Procedure Init;
Begin
     fillchar(a,sizeof(a),0);
End;
(**)
Procedure Readfile;
Var i,j:integer;
    f:text;
Begin
    writeln('INPUT');
    assign(f,'Dong_soi.inp');
    reset(f);
    readln(f,n,k);
    for i:=1 to n do
    begin
         read(f,a[i]);
         write(a[i],'  ');
    end;
    writeln;
    close(f);
    writeln('OUTPUT');
End;
(**)
Function mu(x:integer):integer;
Var i,m:integer;
Begin
     m:=1;
     if x>0 then
     begin
         for i:=1 to x do m:=m*2;
     end;
     mu:=m;
End;
(**)
Procedure xuat;
var i:integer;
Begin
     for i:=1 to n do
     write(a[i],'  ');
End;
(**)
Procedure Don(var i,j:integer;x,y:integer);
Var L:integer;
Begin
     if i=j then
     begin
          writeln('Don hai dong:',x,' va ',y,' Thanh mot');
          a[x]:=i+j;
          for L:=y+1 to n do
          a[L-1]:=a[L];
          n:=n-1;
     end
     else
     begin
          writeln('Don hai dong:',x,' va ',y);
          if i>j then
          begin
             i:=i-j;
             j:=j*2;
          end
          else
          if i<j then
          begin
               j:=j-i;
               i:=i*2;
          end;
     end;
     xuat;
     readln;
End;
(**)
Procedure Process;
Var p,m1,m2,d,i:integer;
    b:mang2;
    c:mang3;
Begin
     p:=0;
     repeat
           m1:=mu(p);
           m2:=m1*2;
           d:=0;
           fillchar(b,sizeof(b),0);
           fillchar(c,sizeof(c),true);
           for i:=1 to n do
           if (a[i] mod m1=0)and(a[i] mod m2<>0)then
           begin
                inc(d);
                b[d]:=i;
           end;
           if d>0 then
           begin
                for i:=1 to d do
                if c[i] then
                begin
                    don(a[b[i]],a[b[i+1]],b[i],b[i+1]);
                    c[i]:=false;
                    c[i+1]:=false;
                end;
           end;
           inc(p);
     until  n=1;
     writeln('Ket thuc');
End;
(**)
BEGIN
     Clrscr;
     Init;
     Readfile;
     Process;
     Readln;
END.
4 5
5 15 4 8
