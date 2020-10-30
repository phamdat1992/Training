  {$m 65000,0,655336}
  uses crt;
  type mang1=array[1..5000] of char;
      mang2 =array[1..5000] of integer;
  var s:mang1;
      a,front:mang2;
      s1:array[1..20] of string[20];
     n, d,i:integer;
     F:TEXT;
  procedure  readfile;
  var i:integer;
  ch:char;
      name:string;
  begin
      write('FILENAME INPUT1:');READLN(name);
      assign(f,name);
      reset(f);
      readln(f,d);
      for i:=1 to d do readln(f,s1[i]);
      close(f);
      write('FILENAME INPUT2:');readln(name);
      assign(f,name);
      reset(f);
      n:=0;
      while not eof(f) do begin inc(n);readln(f,ch);s[n]:=ch; end;
      close(f);
      writeln('OUT PUT');
      writeln(n);
      for i:=1 to n do write(s[i],' ');
      WRITELN;
      WRITELN(D);
     FOR I:=1 TO D DO WRITELN(S1[I]);
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

  procedure xuat(i:integer);
   begin
        while i<a[1] do
         begin
              writeln(s1[front[i]]);
              i:=i+length(s1[front[i]]);
        end;
   end;

  procedure  longest;
    var i,j:integer;
    begin
        fillchar(a,sizeof(a),0);
       for i:=n downto 1 do
         for j:=1 to d do
            if (length(s1[j])+i<=n+1) and  ok(j,i) then
            if (a[i]<length(s1[j])+a[i+length(s1[j])])  then
           begin  a[i]:=length(s1[j]) +a[i+length(s1[j])]; front[i]:=j ;end;

   end;

  BEGIN CLRSCR;
  READFILE;
  longest;
  WRITELN('INPUT');
  writeln(a[1]);
  xuat(1);
  readln
  END.

8
A
AB
BBC
CA
BA
ABC
CBBC
BC


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
B
C
A
B
B
B
B
B
C
C
C