const
     fi1='text2.dat';
     fi2='lex2.dat';
     fo='Nearest.sol';
type
    xau=string[20];
    daytu=array[1..2000] of xau;
    dtd=^daytu;
var
   f,g,h,tam:text;
   s1,s2,s3:xau;
   min,sl:word;
   i,j,t  : word;
   n1,n2  : word;
   m1,m2  : word;
   d1,d2:dtd;
   distance:array[0..20,0..20] of word;
function Checkdistance:word;
begin
FillChar(Distance,sizeof(Distance),0);
n1:=Length(s1);
n2:=Length(s2);
for i:=0 to n1 do Distance[i,0]:=i;
for i:=0 to n2 do Distance[0,i]:=i;
for i:=1 to n1 do
for j:=1 to n2 do
      begin
        if s1[i]=s2[j] then Distance[i,j]:=Distance[i-1,j-1]
        else Distance[i,j]:=Distance[i-1,j-1]+1;
        m1:=Distance[i-1,j]+1;m2:=Distance[i,j-1]+1;
        if (m1<Distance[i,j]) then Distance[i,j]:=m1;
        if (m2<Distance[i,j]) then Distance[i,j]:=m2;
        if (i>1) and (j>1) and (s1[i]<>s2[j]) then
          begin
            if (s1[i]=s2[j-1]) then
              begin
                t:=i-1;
                while (t>0) and (s2[j]<>s1[t]) do dec(t);
                if (t>0) and (Distance[i,j]>Distance[t-1,j-2]+(i-t)) then
                  Distance[i,j]:=Distance[t-1,j-2]+(i-t);
              end;
            if (s1[i-1]=s2[j]) then
              begin
                t:=j-1;
                while (t>0) and (s2[t]<>s1[i]) do dec(t);
                if (t>0) and (Distance[i,j]>Distance[i-2,t-1]+(j-t)) then
                  Distance[i,j]:=Distance[i-2,t-1]+(j-t);
              end;
          end;
      end;
  CheckDistance:=Distance[n1,n2];
end;
BEGIN
k:=0;
      assign(g,fi2);reset(g);
      while not(eof(g)) do
      begin
      readln(g,s2);
      if Checkdistance<min then min:=Checkdistance;
      end;
      close(g);
assign(f,fi1);reset(f);
assign(h,fo);rewrite(h);
while not(eof(f)) do
      begin
      readln(f,s1);
      min:=maxint;
      writeln(h,min);
      sl:=0;
      assign(g,'lex.dat');reset(g);assign(tam,'t.t');rewrite(tam);
      while not(eof(g)) do
      begin
      readln(g,s2);
      if Checkdistance=min then begin writeln(tam,s2);inc(sl);end;
      end;
      close(g);close(tam);
      writeln(h,sl);
      assign(tam,'t.t');reset(tam);
      while not(eof(tam)) do begin readln(tam,s3);writeln(h,s3);end;
      close(tam);
      end;
close(f);
close(h);
END.