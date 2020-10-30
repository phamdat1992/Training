uses crt;
var a:array[1..100] of word;
    fb:array[1..2,0..30000] of byte;
    ok:array[1..100] of 0..1;
    f:text;
    max:longint;
    n:byte;

procedure readfile;
var i:byte;
begin
  writeln('INPUT:');
  assign(f,'chiakeo.inp');
  reset(f);
  readln(f,n);
  writeln(n);
  for i:=1 to n do
   begin
    read(f,a[i]);
    write(a[i],'  ');
   end;
  close(f);
end;

procedure innit;
begin
 fillchar(fb,sizeof(fb),0);
end;

procedure xu_li;
var i,j:longint;
begin
 fb[1,0]:=1;max:=0;
 for i:=1 to n do
 begin
  for j:=max downto 0 do
   if fb[1,j]=1 then
     if fb[1,j+a[i]]=0 then
       begin
         fb[1,j+a[i]]:=1;
         fb[2,j+a[i]]:=i;
        end;
   max:=max+a[i];
  end;
end;

procedure  xuat;
var j:longint;
begin
 writeln;
 writeln('OUTPUT:');
 j:=max div 2;
 while fb[1,j]=0 do dec(j);
 fillchar(ok,sizeof(ok),0);
 writeln(abs(2*j-max));
 while j>0 do
  begin
    ok[a[fb[2,j]]]:=1;
    write(fb[2,j],'  ');
    j:=j-a[fb[2,j]];
  end;
  writeln;
  for j:=1 to n do
   if ok[j]=0 then write(j,'  ');
 readln;
 end;

 procedure test;
 begin
   readfile;
   innit;
   xu_li;
   xuat;
 end;

 BEGIN clrscr;
  test;
 END.
10
197 74 67 23 58 127 75 93 163 61
30
177 183 187 163 139 157 128 136 191 148 171 113 192 146 169 120 130 181 125 156 140 121 194 158 173 197 129 141 117 189