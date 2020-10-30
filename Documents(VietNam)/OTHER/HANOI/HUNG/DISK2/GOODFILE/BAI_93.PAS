 uses crt;
 type mang=array[1..40,1..40] of  shortint;
 var  a:mang;


 procedure  sinh_hoan_vi;
 var  i,j,x,y:short;
 begin
  for i:=1 to n do
   for j:=1 to n do
    a[i,j]:=(i-1)*n+j;
   randomize;
   for i:=1 to n do
    for j:=1 to n do
      begin
        x:=random(n)+1;
        y:=random(n)+1;
        tg:=a[i,j];
        a[i,j]:=a[x,y];
        a[x,y]:=tg;
       end;
  end;

  procedure  tim_cho(i,j);
  var
  begin







































































































































































































