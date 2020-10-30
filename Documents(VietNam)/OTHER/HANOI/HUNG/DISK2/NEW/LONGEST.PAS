 uses crt;
 var f1:text;
     s1:array[1..100] of string[30];
     s,ss,ch1:array[1..50] of char;
     f2:file of char;
     a,aa:array[1..50] of longint;
     dem:longint;
     d,n,max:byte;

 procedure  innitfile;
 var   ch:char;
 begin
   writeln('INPUT1:');
   dem:=0;
   assign(f1,'inp1.lg');
   reset(f1);
   assign(f2,'inp2.lg');
   rewrite(f2);
   while not(eof(f1)) do
    begin
      readln(f1,ch);
      write(ch,'  ');
      write(f2,ch );
      inc(dem);
    end;
   close(f2);
  close(f1);
  writeln;
 end;

 procedure readfile;
 var f3:text;
 begin
   writeln('INPUT2:');
   d:=0;
   max:=0;
   assign(f3,'inp3.lg');
   reset(f3);
   readln(f3,d);
   writeln(d);
   while not(eof(f3)) do
    begin
       inc(d);
       readln(f3,s1[d]);
       writeln(s1[d]);
       if length(s1[d])>max then max:=length(s1[d]);
    end;
   close(f3);
  writeln;
  end;

  function  ok(i,j:integer):boolean;
  var  k:integer;
       ok1:boolean;
  begin  ok1:=true;k:=1;
     while (ok1=true) and (k<=length(s1[i])) DO
       begin if s1[i][k]<>s[j+k-1] then  ok1:=false;
              inc(k);
       end;
       ok:=ok1;
  end;

 procedure  xuli;
 var i,j:byte;
     ch:char;
 begin
  for i:=1 to max do s[i]:=' ';
  assign(f2,'inp2.lg');
  reset(f2);
  repeat
  n:=0;
  while (dem>0) and(n<max) do
  begin
    seek(f2,dem-1);
    inc(n);
    read(f2,ch);
    ch1[n]:=ch;
    dec(dem);
  end;
  for i:=1 to n do ss[i]:=ch1[n-i+1];
  i:=1;
  fillchar(aa,sizeof(aa),0);
  while (s[i]<>' ') and(i<=max) do
   begin
        inc(n);
        ss[n]:=s[i];
        aa[n]:=a[i];
        inc(i);
    end;
    s:=ss;a:=aa;
      for i:=n downto 1 do
        for j:=1 to d do
           if (length(s1[j])+i<=n+1) and  ok(j,i) then
            if a[i]<a[i+length(s1[j])]+length(s1[j]) then
               a[i]:=length(s1[j]) +a[i+length(s1[j])];
   until dem<=0;
   close(f2);
   writeln('OUTPUT:');
   writeln(a[1]);
 end;

 begin  clrscr;
 innitfile;
 readfile;
 xuli;
 readln
 end.
A
B
A
B
A
C
A
B
A
A
B
C
B
A
C
B
C
B
C
C
C
C
A
B
C
A
C
C
C

A
B
A
B
A
C
A
B
A
A
B
C
B
5
A
AB
BBC
CA
BA


8
A
AB
BBC
CA
BA
ABC
CBBC
BC
ABABACABAABCBACBCBBCABBBBBCCC
ABABACABAABCBACBCBBCA