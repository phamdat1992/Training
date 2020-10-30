 uses crt;
 var
     s1:array[1..100] of string[20];
     s,ss,ch1:array[1..50] of char;
     f2:file of char;
     a,aa:array[1..50] of longint;
     time1:longint  absolute 0:$46c;
     dem,time2:longint;
     d,n,max:byte;
 (***************************************)
 procedure readfile_and_change_namefile;
 var f,f1:text;
     ch:char;
 begin
   assign(f1,'longest.inp');
   rewrite(f1);
   assign(f,'longest1.inp');
   reset(f);
   while not(eof(f)) do
    begin
     readln(f,ch);
     write(f1,ch);
    end;
   close(f);
  close(f1);
  end;
 (**************************************)
 procedure readfile;
 var f3:text;
 begin
   d:=0;
   max:=0;
   assign(f3,'longest2.inp');
   reset(f3);
   readln(f3,d);
   while not(eof(f3)) do
    begin
       inc(d);
       readln(f3,s1[d]);
       if length(s1[d])>max then max:=length(s1[d]);
    end;
   close(f3);
  end;
  (**************************************)
  function  ok(i,j:integer):boolean;
  var  k:byte;
       ok1:boolean;
  begin  ok1:=true;k:=1;
       while (ok1=true) and (k<=length(s1[i])) do
       begin
            if s1[i][k]<>s[j+k-1] then  ok1:=false;
            inc(k);
       end;
       ok:=ok1;
  end;
 (***************************************)
 procedure  xuli;
 var i,j:byte;
     ch:char;
 begin
  for i:=1 to max do s[i]:=' ';
  assign(f2,'longest.inp');
  reset(f2);
  dem:=filesize(f2);
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
      For i:=n downto 1 do
        for j:=1 to d do
           if (length(s1[j])+i<=n+1) and  ok(j,i) then
            if a[i]<a[i+length(s1[j])]+length(s1[j]) then
               a[i]:=length(s1[j]) +a[i+length(s1[j])];
   until dem<=0;
   close(f2);
   writeln('OUTPUT:');
   writeln(a[1]);
   writeln('TIME RUN:',((time1-time2)/18.21):6:6);
 end;
 (******************************************)
 begin  clrscr;
 time2:=time1;
 if ((time2-time1)/18.21)>10 then writeln(' *****PLESEA WAIT*******');
 readfile;
 readfile_and_change_namefile;
 xuli;
 readln
 end.
A
C
B
B
A
C
B
C
A
C
B
A
C
A
B
X
A
C
4
AB
ACB
BCB
BBC

