{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

  uses crt;
  type mang=array[1..100] of real;
  var u,a:mang;
  s1,s2:string;
  f:text;
  dem:real;

  procedure  readfile;
  begin
    assign(f,'bl1.inp');
    reset(f);
    readln(f,s1);
    readln(f,s2);
    close(f);
    writeln('intput:');
    writeln(s1);
    writeln(s2);
  end;

  procedure  taomang;
  var i:byte;
  begin
      fillchar(u,sizeof(u),0);
      a:=u;
      u[1]:=1;u[2]:=2;
    for i:=3 to 40 do u[i]:=u[i-1]+u[i-2];
  {  for i:=1 to 20 do writeln(u[i]); readln;}
  end;

  procedure doc_xau;
  var  i:byte;
  begin
    dem:=0;
    for i:= length(s1) downto  1 do
    if s1[i]<>'0' then dem:=dem+u[length(s1)-i+1];
    for i:= length(s2)downto 1 do
    if s2[i]<>'0' then dem:=dem+u[length(s2)-i+1];
  end;

  procedure  bieu_dien;
  var  i,d,luu:byte;dk:boolean;
  begin
        d:=0;luu:=40;
    repeat
      inc(d);
      i:=luu;
      dk:=true;
      if dem>0 then
    begin
       while  (u[i]>dem) and (i>0)  do dec(i);
         if i>0 then
          begin dk:=false;a[i]:=1;dem:=dem-u[i];
          end;
    end;
  if d<=1 then luu:=i;
    until  dk;
  writeln('oupput');
  for i:= luu downto 1 do write(a[i]:1:0);
  end;

  begin  clrscr;
  readfile;
  taomang;
  doc_xau;
  bieu_dien;
  readln
  end.

10100000101000001010
1010010101000000000000000001

10100000
10010101

100000000001
1000000000010

1010100000000000000000000000000000000000
1001000000000000000000000000000000

100000000000000000000000000000000000001
10000000000000000000000000000000000010