  uses crt;
  type mang=array[1..100,1..100] of byte;
  var  a,a1:mang;
       va,max,max1:array[0..100] of byte;
       ok,ok1:array[1..100] of boolean;
       n,u,v,m,maxd:byte;
       f:text;

  procedure  readfile;
  var  i,j:byte;
  begin
     writeln('INPUT:');
     fillchar(a,sizeof(a),0);
     assign(f,'ve_vach.inp');
     reset(f);
     readln(f,n);
     writeln(n);
     for i:=1 to n do
      begin
        for j:=1 to n do
         begin
         read(f,a[i,j]);
         write(a[i,j]:4);
         end;
         writeln;
      end;
  end;

  procedure try;
  var i:byte;
  begin
   for i:=1 to n do
    if (a[va[va[0]],i]=1) and (ok[i]) then
     begin
       a[va[va[0]],i]:=0;
       a[i,va[va[0]]]:=0;
       ok[i]:=false;
       inc(va[0]);
       va[va[0]]:=i;
       try;
       dec(va[0]);
       a[va[va[0]],i]:=1;
       a[i,va[va[0]]]:=1;
       ok[i]:=true;
      end;
      if va[0]>max[0] then max:=va;
  end;

 begin  clrscr;
  maxd:=0;
  readfile;
  writeln('OUT PUT:');
  fillchar(ok,sizeof(ok),true);
  while maxd<n do
  begin
  fillchar(max1,sizeof(max1),0);
  for u:=1 to n do
  if ok[u] and (max1[0]<n)then
  begin
  a1:=a;
  fillchar(va,sizeof(va),0);
  va[0]:=1;va[1]:=u;ok[u]:=false;
  max:=va;
  try;
  if max[0]>max1[0] then  max1:=max;
  ok[u]:=true;
  end;
  maxd:=maxd+max1[0];
  end;
  for v:=1 to max[0] do write(max[v]:4);
  readln
 end.
  10
  7
  0 0 0 0 0 1 1
  0 0 1 0 0 0 0
  0 1 0 1 0 0 0
  0 0 1 0 1 0 0
  0 0 0 1 0 0 0
  1 0 0 0 0 0 1
  1 0 0 0 0 1 0
  16
  0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0
  0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0
  1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0
  0 1 1 0 1 0 1 0 0 0 1 1 1 0 0 0
  0 1 1 1 0 1 1 0 0 0 1 0 0 0 0 1
  0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 1
  0 0 0 1 1 1 0 1 1 0 1 0 0 0 0 1
  0 0 0 0 0 0 1 0 1 1 1 0 0 0 0 0
  0 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0
  0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0
  0 0 0 1 1 0 1 1 1 0 0 1 1 0 0 0
  0 0 0 1 0 0 0 0 0 0 1 0 1 1 0 0
  0 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0
  0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0
  0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1
  0 0 0 0 1 1 1 0 0 0 0 0 0 0 1 0










