{$R+}
   { *************************************** }
   {     Le Van Hung K28 A2 Phan Boi Chau    }
   {       Giai Bai Contour - Thay Tung      }
   { *************************************** }

program         countour ;
uses            crt ;
const           fi  =   'CONTOUR.INP' ;
                fo  =   'CONTOUR.OUT' ;
type            point   =        record
                                       x , y   : integer ;
                                 end ;
        arr             =        array[0..10001 ] of point ;
var
   a , b        :       ^ arr ;
   f            :       text ;
   d , n        :       integer ;

   procedure            readfile ;
   var
      i         :       integer ;
      begin
           clrscr ;
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , d ) ;
           n := 0 ;
           while not seekeof ( f ) do
            begin
                 inc ( n ) ;
                 readln ( f , a ^ [ n ] . x , a ^ [ n ] . y ) ;
            end ;
           a ^ [ n + 1 ] := a ^ [ 1 ] ;
           a ^ [ 0 ] := a ^ [ n ] ;
           close ( f ) ;
      end ;

   procedure            abc ( p1 , p2 : point; var a , b , c : longint ) ;
   begin
        a := p1 . y - p2 . y ;
        b := p2 . x - p1 . x ;
        c := - ( a * p1 . x + b * p1 . y ) ;
   end ;

   function             khac_phia ( p1 , p2 : point ; p3 , p4 : point ) : boolean ;
   var
      a , b , c     :    longint ;
      t1 , t2, t : real ;
      begin
           abc ( p3 , p4 , a , b , c ) ;
           t1 := p1 . x * a + p1 . y * b + c ;
           t2 := p2 . x * a + p2 . y * b + c ;
           t := t1 * t2 ;
           khac_phia := ( t < 0 ) ;
      end ;

   procedure            xuli ( i : integer  ; p : point ; var p1 : point ) ;
   var
      t         :       integer ;
      t1 , t2   :       boolean ;
      begin
           t1 := khac_phia ( p , a ^ [ i - 1 ] , a ^ [ i ] , a ^ [ i + 1 ] ) ;
           t2 := khac_phia ( p , a ^ [ i + 2 ] , a ^ [ i ] , a ^ [ i + 1 ] ) ;
           if t1 and t2 then t := 2 * d
           else
           if not t1 and not t2 then t := - 2 * d
           else t := 0 ;
           if a ^ [ i ] . x = a ^ [ i + 1 ] . x then
            begin
                 p1 . x := p . x ;
                 if a ^ [ i ] . y > a ^ [ i + 1 ] . y then
                  p1 . y := p . y - abs ( a ^ [ i ] . y - a ^ [ i + 1 ] . y + t )
                 else
                  p1 . y := p . y + abs ( a ^ [ i + 1 ] . y - a ^ [ i ] . y + t ) ;
            end
           else
           if a ^ [ i ] . x < a ^ [ i + 1 ] . x then
            begin
                 p1 . y := p . y ;
                 p1 . x := p . x + abs ( a ^ [ i + 1 ] . x - a ^ [ i ] . x + t ) ;
            end
           else
           begin
                p1 . y := p . y ;
                p1 . x := p . x - abs ( a ^ [ i ] . x - a ^[ i + 1 ] . x + t ) ;
           end ;
      end ;

   procedure            process ;
   var
      min , i , li , dem      :       integer ;
      p , p1                  :       point ;
      g                       :       text ;
      begin
           li := 1 ;
           for i := 2 to n do
            begin
                 if a  ^ [ li ] . x > a ^ [ i ] . x then
                  li := i
                 else
                 if a ^ [ li ] . x = a ^ [ i ] . x then
                  if a ^ [ li ] . y < a ^ [ i ] . y then
                   li := i ;
             end ;
           dem := 0 ;
           for i := li to n do
            begin
                 inc ( dem ) ;
                 b ^ [ dem ] . x := a ^ [ i ] . x ;
                 b ^ [ dem ] . y := a ^ [ i ] . y ;
            end ;
           for i := 1 to li - 1 do
            begin
                 inc ( dem ) ;
                 b ^ [ dem ] . x := a ^ [ i ] . x ;
                 b ^ [ dem ] . y := a ^ [ i ] . y ;
            end ;
           a ^ := b^ ;
           a ^ [ n + 1 ] := a ^ [ 1 ] ;
           a ^ [ 0 ] := a ^ [ n ] ;
           p . x := a ^ [ 1 ] . x - d ;
           p . y := a ^ [ 1 ] . y + d ;
           writeln ( f , p . x : 7 , p . y : 7 ) ;
           for i := 1 to n - 1 do
            begin
                 xuli ( i , p , p1 ) ;
                 p := p1 ;
                 writeln ( f , p . x : 7 , p . y : 7 ) ;
            end ;
      end ;

   procedure            writefile ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           process ;
           close ( f ) ;
      end ;

BEGIN
     new ( a ) ;
     new ( b ) ;
     readfile ;
     writefile ;
     dispose ( a ) ;
     dispose ( b ) ;
END.

1
2 4
2 -3
-4 -3
-4 1
-2 1
-2 4
