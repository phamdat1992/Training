program         sinh ;
uses crt ;
const
     m =25 ;
     fi = 'biendoi1.in0' ;
     n = 100 ;
var
   a    :       array [1..100 ,1..100 ] of integer ;
   f    :       text ;
   bx :array[1..200]of byte ;
   x ,i , j ,dem : integer ;
begin
ASSIGN (f ,fi ) ;
rewrite ( f ) ;
writeln ( f , n ) ;
randomize ;
for i := 1 to n do
 for j := 1 to n do
       a [ i , j ] := ( random ( 100 ) + 1 ) mod 2 ;
for i := 1 to n do
begin
     for j := 1 to n do
      write ( f , a [ i , j ] : 2 ) ;
     writeln ( f ) ;
end ;
dem := 0 ;
fillchar ( bx ,sizeof ( bx ) , 0 ) ;
repeat
      x := random ( n * 2 ) + 1 ;
      if bx[ x ] = 0 then
      begin
           inc ( dem ) ;
           bx [x ]:=1;
      end;
until dem >= m ;
for i :=1 to n do
 for j :=1 to n do
  a [ i , j ] := (a [ i ,j ] + bx [ i ]+bx[j+n] ) mod 2 ;
 for i := 1 to n do
  begin
       for j := 1 to n do
        write ( f , a[ i , j ] : 2 ) ;
       writeln ( f ) ;
  end ;
close ( f ) ;
end .

