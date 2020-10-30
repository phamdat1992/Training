const  fi='wires.in7';
       fo='wires.out';
var    a:array[1..10000] of integer;
       maxd:array[0..10000] of integer;
       f:text;
       n:integer;

procedure  init;
var  i:integer;
begin
      fillchar(a,sizeof(a),0);
      fillchar(maxd,sizeof(maxd),0);
      for i:=1 to 10000 do maxd[i]:=1;
end;

procedure  readfile;
var  i:integer;
begin
     assign(f,fi);
     reset(f);
        readln(f,n);
        for i:=1 to n do read(f,a[i]);
     close(f);
end;

procedure   xuli;
var  i,j:integer;
begin
      for i:=2 to n do
        for j:=1 to i-1 do
          if a[j]<a[i] then
            if maxd[i]<maxd[j]+1 then  maxd[i]:=maxd[j]+1;
end;

procedure  try(i:integer);
var  j:integer;
begin
      if maxd[i]>1 then
      begin
           j:=i;
           while (a[j]>a[i]) or ( maxd[j]+1<>maxd[i]) do dec(j);
           try(j);
           write(f,a[i],'  ');
      end
    else  write(f,a[i],'  ');
end;

procedure  xuat;
var i,max,luu:integer;
begin
      max:=0;
      for i:=1 to n do
       if maxd[i]>max then
         begin
              max:=maxd[i];
              luu:=i;
         end;
      assign(f,fo);
      rewrite(f);
          writeln(f,maxd[luu]);
          try(luu);
      close(f);
end;

begin
   init;
   readfile;
   xuli;
   xuat;
end.

9
2 5 3 8 7 4 6 9 1