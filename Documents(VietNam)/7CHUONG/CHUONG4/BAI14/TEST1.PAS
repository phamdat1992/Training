uses    crt , graph ;
const
     fi ='contour.in1';
     fo='contour.out' ;
     midx=300 ;
     midy=100 ;
     hung = 200 ;
type point = record x , y : integer ;end ;
var
   a : array [ 1..10001 ] of point ;
   d , gm , gd , i , n : integer ;
   f : text ;
        procedure       draw_lines ( a , b  : point  ) ;
        var
           x1 , x2 , y1 , y2    :       integer ;
           begin
                x1 := midy + a . x  ;
                x2 := midy + b . x ;
                y1 := midx - a . y ;
                y2 := midx - b . y ;
                line ( x1 , y1 , x2 , y2 ) ;
           end ;

begin
     initgraph ( gm , gd , 'c:\laptrinh\pascal\bgi');
{     line(0,240,getmaxx,240);
     line(300,0,300,getmaxy);
 }    assign ( f , fi ) ;
     reset ( f ) ;
     readln ( f , d ) ;
     n := 0 ;
     while not seekeof ( f ) do
      begin
           inc ( n) ;
           readln ( f , a [ n ] . x , a [ n ] . y ) ;
      end ;
     close ( f ) ;
     a [ n +1 ] := a [ 1 ] ;
     setcolor ( 4 ) ;
     for i := 1 to n do
      line ( a [ i ] . x + hung , a [ i ] . y + hung  , a [ i + 1 ] .x + hung  , a [i + 1 ] . y+ hung ) ;
      readln ;
     assign ( f , fo ) ;
     reset ( f ) ;
     n:=0 ;
     while not seekeof ( f ) do
      begin
           inc ( n ) ;
           readln ( f , a [ n ] . x ,a[n ].y ) ;
      end ;
     a [ n + 1 ] := a[1];
          setcolor ( 11 ) ;
     for i := 1 to n do
      line ( a [ i ].x + hung , a [ i ] . y+ hung  , a [ i + 1 ].x + hung , a [ i + 1 ] . y + hung ) ;

     close ( f ) ;
     readln ;
     closegraph ;
end.