 uses crt;
 var  i,k,j,m,n:longint;
 ok:array[1..50000] of boolean;
 f:text;

 function ok1(i,j:longint):longint;
 begin
   ok1:=i;
   if (n mod 2=1) and (j>i+(n-1) div 2)  then  ok1:=j
   else
    if (j>n div 2) and (j>i+1+(n-2) div 2) then ok1:=j;
 end;

 begin  clrscr;
  write('so doi bong n='); readln(n);
  assign(f,'lich_bd.out');
  rewrite(f);
  writeln(f,'/-*-/-*-/-*-/- SO DOI BONG LA ',N ,' /-*-/-*-/-*-/-*-/-');
  writeln(f);
  if n mod 2=0 then m:=n-1
  else m:=n;
  for i:=1 to m do
   begin
   writeln(f,' -*-*-*-*-*- LICH DAU VONG  ',i,' *-*-*-*-*-*-');
   fillchar(ok,sizeof(ok),true);
   for k:=1 to m do
     if ok[k] then
       begin
         ok[k]:=false;
         j:=1;
         while (j<=m) and (((j+k) mod m<>i mod m) or (ok[j]=false)) do inc(j);
         if j<=m then
       begin
            ok[j]:=false;writeln(f,k ,' gap ',j,' tren san ',ok1(k,j));
       end
   else
   begin
      if m<>n-1 then  writeln(f,k,' nghi:')
      else
        begin
           ok[n]:=false;writeln(f,k,' gap ',n,' tren san ',ok1(k,n));
        end;
   end;
   end;
   writeln(f);
   end;
   close(f);
 end.
/-*-/-*-/-*-/- SO DOI BONG LA 14 /-*-/-*-/-*-/-*-/-

 -*-*-*-*-*- LICH DAU VONG  1 *-*-*-*-*-*-
1 gap 13 tren san 13
2 gap 12 tren san 12
3 gap 11 tren san 11
4 gap 10 tren san 4
5 gap 9 tren san 5
6 gap 8 tren san 6
7 gap 14 tren san 7

 -*-*-*-*-*- LICH DAU VONG  2 *-*-*-*-*-*-
1 gap 14 tren san 14
2 gap 13 tren san 13
3 gap 12 tren san 12
4 gap 11 tren san 4
5 gap 10 tren san 5
6 gap 9 tren san 6
7 gap 8 tren san 7

 -*-*-*-*-*- LICH DAU VONG  3 *-*-*-*-*-*-
1 gap 2 tren san 1
3 gap 13 tren san 13
4 gap 12 tren san 12
5 gap 11 tren san 5
6 gap 10 tren san 6
7 gap 9 tren san 7
8 gap 14 tren san 8

 -*-*-*-*-*- LICH DAU VONG  4 *-*-*-*-*-*-
1 gap 3 tren san 1
2 gap 14 tren san 14
4 gap 13 tren san 13
5 gap 12 tren san 5
6 gap 11 tren san 6
7 gap 10 tren san 7
8 gap 9 tren san 8

 -*-*-*-*-*- LICH DAU VONG  5 *-*-*-*-*-*-
1 gap 4 tren san 1
2 gap 3 tren san 2
5 gap 13 tren san 13
6 gap 12 tren san 6
7 gap 11 tren san 7
8 gap 10 tren san 8
9 gap 14 tren san 9

 -*-*-*-*-*- LICH DAU VONG  6 *-*-*-*-*-*-
1 gap 5 tren san 1
2 gap 4 tren san 2
3 gap 14 tren san 14
6 gap 13 tren san 6
7 gap 12 tren san 7
8 gap 11 tren san 8
9 gap 10 tren san 9

 -*-*-*-*-*- LICH DAU VONG  7 *-*-*-*-*-*-
1 gap 6 tren san 1
2 gap 5 tren san 2
3 gap 4 tren san 3
7 gap 13 tren san 7
8 gap 12 tren san 8
9 gap 11 tren san 9
10 gap 14 tren san 10

 -*-*-*-*-*- LICH DAU VONG  8 *-*-*-*-*-*-
1 gap 7 tren san 1
2 gap 6 tren san 2
3 gap 5 tren san 3
4 gap 14 tren san 14
8 gap 13 tren san 8
9 gap 12 tren san 9
10 gap 11 tren san 10

 -*-*-*-*-*- LICH DAU VONG  9 *-*-*-*-*-*-
1 gap 8 tren san 1
2 gap 7 tren san 2
3 gap 6 tren san 3
4 gap 5 tren san 4
9 gap 13 tren san 9
10 gap 12 tren san 10
11 gap 14 tren san 11

 -*-*-*-*-*- LICH DAU VONG  10 *-*-*-*-*-*-
1 gap 9 tren san 9
2 gap 8 tren san 2
3 gap 7 tren san 3
4 gap 6 tren san 4
5 gap 14 tren san 14
10 gap 13 tren san 10
11 gap 12 tren san 11

 -*-*-*-*-*- LICH DAU VONG  11 *-*-*-*-*-*-
1 gap 10 tren san 10
2 gap 9 tren san 2
3 gap 8 tren san 3
4 gap 7 tren san 4
5 gap 6 tren san 5
11 gap 13 tren san 11
12 gap 14 tren san 12

 -*-*-*-*-*- LICH DAU VONG  12 *-*-*-*-*-*-
1 gap 11 tren san 11
2 gap 10 tren san 10
3 gap 9 tren san 3
4 gap 8 tren san 4
5 gap 7 tren san 5
6 gap 14 tren san 14
12 gap 13 tren san 12

 -*-*-*-*-*- LICH DAU VONG  13 *-*-*-*-*-*-
1 gap 12 tren san 12
2 gap 11 tren san 11
3 gap 10 tren san 3
4 gap 9 tren san 4
5 gap 8 tren san 5
6 gap 7 tren san 6
13 gap 14 tren san 13

