program         thap ;
uses            crt ;

const
     fi         =       'HNTOWER.INP' ;
     fo         =       'HNTOWER.OUT' ;
var
   f            :       text ;
   a            :       array [ 1..30 , 1..30 ] of longint ;

   procedure            process ;
   var
      i , j , min , l   :       longint ;
      begin
           for i := 1 to 30 do
            a [ i , 1 ] := 1 ;
           a [ 1 , i ] := 1 ;
           for i := 2 to 30 do
            begin
                 a [ 1 , i ] := - 1 ;
                 a [ 2 , i ] := - 1 ;
            end ;
           for i := 3 to 30 do
            for j := 2 to 30 do
             begin
                  min := maxlongint ;
                  for l := 1 to j -1 do
                   if ( a [ i , l ] <> - 1 ) and ( a [ i -1 , j - l ] <> -1 )
                      and ( min > 2 * a [ i , l ] + a [ i - 1 , j - l ] ) then
                      min := 2 * a [ i , l ] + a [ i - 1 , j - l ] ;
                  a [ i , j ] := min ;
             end ;
      end ;

   procedure            writefile ;
   var
      i , j     :       integer ;
      m , n     :       integer ;
      begin
           assign ( f , fi ) ; reset ( f ) ; readln ( f , m , n) ; close ( f ) ;
           assign ( f , fo ) ;
           rewrite ( f ) ;
           writeln ( f , a[m , n] ) ;
           close ( f ) ;
      end ;

BEGIN
     process ;
     writefile ;
END.

3 29

5 6
8 23
24 26
3 20
28 13
9 25
29 10
22 30
29 30
