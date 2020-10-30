{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
{$r+,q-}
program         danh_ca ;

uses            crt ;
const           max             = 100 ;
                fi              = 'dg.10' ;
                fo              = 'dagiac.out' ;

type            point           = record
                                        x , y   : real ;
                                  end ;

                polygont        = record
                                        sd : integer ;
                                        dinh : array [ 1..30 ] of point ;
                                  end ;

                line            = record
                                        p1 , p2 : point ;
                                  end ;

var
   a            :       array [ 1..2000 ] of ^ polygont ;
   n , count    :       integer ;
   f            :       text ;
   x1 , x2      :       real ;
   y1 , y2      :       real ;
   s            :       array [ 1..100 ] of line ;

   procedure  readfile ;
     var  i :   integer ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , n , x1 , y1 , x2 , y2 ) ;
           for i := 1 to n do
               with s [ i ] do readln ( f , p1 . x , p1 . y , p2 . x , p2 . y ) ;
           close ( f ) ;
      end ;

   procedure  abc (p1 , p2 : point ; var a , b , c : real ) ;
      begin
           a :=   ( p1 . y - p2 . y ) ;
           b := - ( p1 . x - p2 . x ) ;
           c :=   ( a * p1 . x + b * p1 . y ) ;
      end;

   function  trung ( p1 , p2 : point ) : boolean ;
   begin
        trung := ( p1 . x = p2 . x ) and ( p1 . y = p2 . y ) ;
   end ;

   function  beetwen ( p : point ; p1 , p2 : point ) : boolean ;
      begin
           beetwen := false ;
           if trung ( p , p1 ) then exit ;
           if ( ( p1 . x - p . x ) * ( p2 . x - p . x ) <= 0 ) and
              ( ( p1 . y - p . y ) * ( p2 . y - p . y ) <= 0) then
              beetwen := true;
      end ;

   function  cat ( p1 , p2 , p3 , p4 : point ; var p : point ) : boolean ;
    var
       a1 , a2 , b1 , b2 , c1 , c2 : real ;
       dt , dtx , dty              : real ;
       begin
          abc ( p1 , p2 , a1 , b1 , c1 ) ;
          abc ( p3 , p4 , a2 , b2 , c2 ) ;
          dt  := ( a1 * b2 - a2 * b1 ) ;
          dtx := ( c1 * b2 - c2 * b1 ) ;
          dty := ( a1 * c2 - a2 * c1 ) ;
          cat := false ;
          if dt = 0 then exit ;
          p . x := dtx / dt ;
          p . y := dty / dt ;
          if beetwen ( p , p1 , p2 ) then cat := true ;
       end ;

   procedure  cut ( p1 , p2 , p3 , p4 : point ; var p : point ) ;
    var
       a1 , a2 , b1 , b2 , c1 , c2 : real ;
       dt , dtx , dty              : real ;
       begin
          abc ( p1 , p2 , a1 , b1 , c1 ) ;
          abc ( p3 , p4 , a2 , b2 , c2 ) ;
          dt  := ( a1 * b2 - a2 * b1 ) ;
          dtx := ( c1 * b2 - c2 * b1 ) ;
          dty := ( a1 * c2 - a2 * c1 ) ;
          if dt = 0 then exit ;
          p . x := dtx / dt ;
          p . y := dty / dt ;
       end ;

   procedure  add ( p : point ; poli : polygont ) ;
   begin
        with poli do
         begin
              if ( sd > 0 ) and trung ( p , dinh [ sd ] ) then exit ;
              inc ( sd ) ;
              dinh [ sd ] := p ;
         end ;
   end ;

   function  new_poly ( j , i : longint ; var poli1 , poli2 : polygont ) : boolean ;
      var
         t , l1 , l2 : longint ;
         p1 , p2     : point ;
         begin
              new_poly := false ;
              with a [ j ] ^ do
               begin
                    dinh [ sd + 1 ] := dinh [ 1 ] ;
                    l1 := 0 ;
                    l2 := 0 ;
                    for t := 1 to sd do
                     if cat ( dinh [ t ] , dinh [ t + 1 ] , s [ i ] . p1 , s [ i ] . p2 , p1 ) then
                     if l1 = 0 then l1 := t else l2 := t ;
                     if l1 * l2 = 0 then exit ;
                     new_poly := true ;
                     cut ( dinh [ l1 ] , dinh [ l1 + 1 ] , s [ i ] . p1 , s [ i ] . p2 , p1 ) ;
                     cut ( dinh [ l2 ] , dinh [ l2 + 1 ] , s [ i ] . p1 , s [ i ] . p2 , p2 ) ;
                     poli1 . sd := 0 ;
                     add ( p1 , poli1 ) ;
                     for t := l1 + 1 to l2 do add ( dinh [ t ] , poli1 ) ;
                     poli2 . sd := 0 ;
                     for t := 1 to l1 do add ( dinh [ t ] , poli2 ) ;
                     add ( p1 , poli2 ) ;
                     add ( p2 , poli2 ) ;
                     for t := 1 + l2 to sd do add ( dinh [ t ] , poli2 ) ;
               end ;
         end ;

   function  area_polygont ( i : integer ) : real ;
      var
         area  : real ;
         j     : integer ;
         begin
              area := 0 ;
              with a [ i ] ^ do
               begin
                    a [ sd + 1 ] ^ := a [ 1 ] ^ ;
                    for j := 1 to sd do
                     area := area + ( dinh [ j ] . x - dinh [ j + 1 ] . x )
                     * ( dinh [ j ] . y + dinh [ j + 1 ] . y ) / 2;
               end ;
              area_polygont := abs ( area ) ;
         end ;

   procedure  process ;
      var
         i , j   :  longint ;
         p1 , p2 :  polygont ;
         begin
              new ( a [ 1 ] ) ;
              with a [ 1 ] ^ do
               begin
                    sd := 4 ;
                    dinh [ 1 ] . x := x1 ; dinh [ 1 ] . y := y1 ;
                    dinh [ 2 ] . x := x1 ; dinh [ 2 ] . y := y2 ;
                    dinh [ 3 ] . x := x2 ; dinh [ 3 ] . y := y1 ;
                    dinh [ 4 ] . x := x2 ; dinh [ 4 ] . y := y2 ;
               end ;
              count := 1 ;
              for i := 1 to n do
               for j := 1 to count do
                if new_poly ( j , i , p1 , p2 )  then
                 begin
                      a [ count ] ^ := p1 ;
                      inc ( count ) ;
                      new ( a [ count ] ) ;
                      a [ count ] ^ := p2 ;
                 end ;
         end ;

   procedure  writefile ;
    var
       i , li : integer ;
       max    : real ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           max := 0 ;
           li := 1 ;
           writeln ( count ) ;
           for i := 1 to count do
            if area_polygont ( i ) > max then
             begin
                  max := area_polygont ( i ) ;
                  li := i ;
             end ;
           writeln ( f , max : 0 : 4 ) ;
           with a [ li ] ^ do
           for i := 1 to sd do
            writeln ( f , dinh [ i ] . x : 0 : 4 , '  ', dinh [ i ] . y : 0 : 4 ) ;
           close ( f ) ;
      end ;

BEGIN
     readfile ;
     process ;
     writefile ;
END .


