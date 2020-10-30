{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const fi = 'house.in0';
      fo = 'house.out';
      max = 101;
      limit = max*max;
      pos : array[1..2,1..4] of integer = ((0,-1,0,1),(-1,0,1,0));
type inte = integer;
     lo = longint;

     qtype = record
      x, y : inte;
     end;

    arr = array[0..limit] of qtype;

    arr1 = array[0..max,0..max] of inte;
    arr2 = array[0..limit] of inte;
var e : arr1;
    savee : ^arr1;

    free : array[0..max,0..max] of boolean;

    queue : ^arr;

    select, se : ^arr2;

    counte : array[0..limit] of inte;

    n, count : inte;
{----------------------------------------------------------------------------}
procedure init;
 var inp : text;
     i, j : inte;
  begin
   assign(inp, fi);reset(inp);
   readln(inp, n);

   for i := 1 to n do
    for j := 1 to n do
     begin
      read(inp, e[i,j]);
      e[i,j] := -e[i,j];
     end;

   close(inp);
  end;
{----------------------------------------------------------------------------}
procedure BFS(sx, sy : inte);
 var w, u, v, i, j : inte;
     f, l : inte;
  begin
   new(queue);

   f := 1;l := 1;

   queue^[f].x := sx;queue^[f].y := sy;

   while f <= l do
    begin

     u := queue^[f].x;v := queue^[f].y;

     for w := 1 to 4 do
      begin

       i := u + pos[1,w];j := v + pos[2,w];

       if e[i,j] = -1 then
        begin
         inc(counte[count]);
         e[i,j] := count;
         inc(l);
         queue^[l].x := i;queue^[l].y := j;
        end;

      end;

     inc(f);

    end;{while}

   dispose(queue);
  end;
{----------------------------------------------------------------------------}
procedure create;
 var i ,j : inte;
  begin
   count := 0;
   fillchar(counte,sizeof(counte),0);

   for i := 1 to n do
    for j := 1 to n do
     if e[i,j] = -1 then
      begin
       inc(count);
       e[i,j] := count;
       counte[count] := 1;
       BFS(i,j);
      end;

  end;
{----------------------------------------------------------------------------}

function tinhtien(i , j : inte)  : boolean;{i thuoc e, j thuoc savee}
 var xi, yi,xj , yj : inte;
     indexx, indexy : inte;
     u, v : inte;
  begin

   if counte[i] <> counte[j] then
    begin
     tinhtien := false;
     exit;
    end;

   xi := 0;xj := 0;
   for u := 1 to n do
    for v := 1 to n do
     begin
      if (e[u,v] = i)and( xi = 0) then
       begin
        xi := u;yi := v;
       end;

      if (savee^[u,v] = j)and( xj = 0) then
       begin
        xj := u;yj := v;
       end;

     end;

   indexx := xi - xj;
   indexy := yi - yj;

   for u := 1 to n do
    for v := 1 to n do
     if e[u,v] = i then
      if savee^[u - indexx, v - indexy] <> j then
       begin
        tinhtien := false;
        exit;
       end;

   tinhtien := true;
  end;
{----------------------------------------------------------------------------}
procedure update;
 var i, j : inte;
  begin
   for i := 1 to count do
    for j := 1 to count do
     if (select^[i] <> select^[j]) then
      if tinhtien(i,j) then
       begin
        if select^[i] < select^[j] then select^[j] := select^[i]
         else
        select^[i] := select^[j];
       end;
  end;
{----------------------------------------------------------------------------}
procedure xoaydiem(var x, y : inte);
 var i, j : inte;
  begin
   j := x;
   i := n - y + 1;
   x := i;y := j;
  end;
{----------------------------------------------------------------------------}
procedure quay;
 var i, j, u, v : inte;
     ss : ^arr1;
  begin
   new(ss);
   ss^ := savee^;
   fillchar(savee^,sizeof(savee^),0);
   for i := 1 to n do
    for j := 1 to n do
     if ss^[i,j] <> 0 then
      begin
       u := i;v := j;
       xoaydiem(u,v);
       savee^[u,v] := ss^[i,j];
      end;
   dispose(ss);
  end;
{----------------------------------------------------------------------------}
procedure viet;
 var i, j : inte;
  begin
   writeln;
   for i := 1 to n do
    begin
     for j := 1 to n do
      write(savee^[i,j],' ');
     writeln;
    end;
  end;
{----------------------------------------------------------------------------}
procedure solve;
 var i, j : inte;
  begin

   create;

   fillchar(free,sizeof(free),false);
   new(savee);
   savee^ := e;

   new(select);
   select^[0] := 0;
   for i := 1 to count do
    select^[i] := i;

   for i := 1 to 3 do
    begin
     update;
     quay;
{    viet;}
    end;
   dispose(savee);
  end;

{----------------------------------------------------------------------------}

procedure print;
 var out : text;
     i, j,c1, c  : inte;
     free : array[0..limit] of boolean;
  begin
   fillchar(free,sizeof(free),false);
   c := 0;
   for i := 1 to count do
    begin
     if c < select^[i] then c := select^[i];
     free[select^[i]] := true;
    end;

   for i := 1 to c - 1 do
    if not free[i] then
     begin
      free[i] := true;
      for c1 := i + 1to c do
       if free[c1] then break;

      for j := i + 1 to count do
       if select^[j] = c1 then
         select^[j] := i;

      free[c1] := false;
     end;

   c := 0;
   for i := 1 to count do
    if c < select^[i] then c := select^[i];

   select^[0] := 0;
   assign(out, fo);rewrite(out);
   writeln(out, c);
   for i := 1 to n do
    begin
     for j := 1 to n do
      write(out,select^[e[i,j]],' ');
     writeln(out);
    end;
   close(out);
  end;
{----------------------------------------------------------------------------}

begin

 init;

 solve;

 print;

end.
9
1 1 1 0 1 0 0 0 1
1 0 0 0 1 1 0 1 1
1 1 0 0 0 0 0 0 0
1 0 0 1 0 0 0 0 0
1 0 0 1 0 0 0 0 0
0 0 1 1 0 1 0 0 0
1 0 0 0 0 1 0 0 1
1 0 1 0 0 1 1 0 1
1 1 1 1 1 0 0 1 1
house.inp
house.out