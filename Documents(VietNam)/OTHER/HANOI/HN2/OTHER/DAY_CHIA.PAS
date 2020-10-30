uses crt;
type  mang=array[1..1000] of word;
var  a,front,maxd:mang;
     n:integer;
     f:text;

procedure  readfile;
var  i:byte;
begin
  assign(f,'day_chia.inp');
  reset(f);
  readln(f,n);
  for i:=1 to n do
   begin
    read(f,a[i]);
    write(a[i]:8);
    end;
   close(f);
 end;

 function chia_het(i,j:word):boolean;
 begin
   chia_het:=false;
   if i mod j=0 then chia_het:=true;
  end;

 procedure  sort;
 var i,j,tg:word;
 begin
   for i:=1 to n-1 do
    for j:=i+1 to n do
     if a[i]<a[j] then
       begin
          tg:=a[i];
          a[i]:=a[j];
          a[j]:=tg;
        end;
 end;

 procedure try;
 var i,j,max,luu:word;
 begin
   fillchar(maxd,sizeof(maxd),0);
   maxd[n]:=1;
   front:=maxd;
   for i:=n-1 downto 1 do
   begin
    max:=0;luu:=0;
    for j:=i+1 to n do
     if chia_het(a[i],a[j]) then
      if max<maxd[j]+1 then
       begin
          max:=maxd[j]+1;
          luu:=j;
        end;
      maxd[i]:=max;
      front[i]:=luu;
    end;
    max:=0;
    for i:=1 to n do
     if maxd[i]>max then begin max:=maxd[i];luu:=i;end;
    writeln;
    writeln('OUTPUT:');
    writeln(max);
    while max>0 do
     begin
       dec(max);
       write(a[luu]:6);
       luu:=front[luu];
     end;
  end;

  begin  clrscr;
  readfile;
  sort;
  try;
  readln
  end.
  15
  1 3 5 4 6 12 15 24 30 36 18 27 39 72 78
