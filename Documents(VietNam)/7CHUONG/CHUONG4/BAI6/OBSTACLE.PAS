{$r+}
program         chuong_ngai_vat ;
uses            crt ;
const
     fi         =       'OBSTACLE.IN1' ;
     fo         =       'OBSTACLE.OUT' ;
     max        =       1000000000 ;
     max1       =       32766 ;
type
    point       =       record
     x , y      :       real ;
    end ;
    kieu        =       record
     x , y      :       integer ;
    end ;
var
   m            :       integer ;
   a            :       array [ 0..31 , 1..4 ] of point ;
   f            :       text ;
   dd           :       array [ 0..31 , 1..4 , 0..31 , 1..4 ] of boolean ;
   d            :       array [ 0..31 , 1..4 ] of real ;
   tr           :       array [ 0..31 , 1..4 ] of kieu ;
   di           :       array [ 1..200 ] of kieu ;

   procedure            readfile ;
   var
      i         :       integer ;
      x , y , z :       real ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , m ) ;
           a [ 0 , 1 ] . x := 0 ;           a [ 0 , 1 ] . y := 0 ;
           a [ 0 , 2 ] . x := 0 ;           a [ 0 , 2 ] . y := 0 ;
           a [ 0 , 3 ] . x := 0 ;           a [ 0 , 3 ] . y := 0 ;
           a [ 0 , 4 ] . x := 0 ;           a [ 0 , 4 ] . y := 0 ;
           a [ m + 1 , 1 ] . x := 0 ;       a [ m + 1 , 1 ] . y := 0 ;
           a [ m + 1 , 2 ] . x := 0 ;       a [ m + 1 , 2 ] . y := 100 ;
           a [ m + 1 , 3 ] . x := 100 ;       a [ m + 1 , 3 ] . y := 100 ;
           a [ m + 1 , 4 ] . x := 100 ;       a [ m + 1 , 4 ] . y := 0 ;
           for i := 1 to m do
            begin
                 readln ( f , x , y , z ) ;
                 a [ i , 1 ] . x := x ;        a [ i , 1 ] . y := y ;
                 a [ i , 2 ] . x := x ;        a [ i , 2 ] . y := y + z ;
                 a [ i , 3 ] . x := x + z ;    a [ i , 3 ] . y := y + z ;
                 a [ i , 4 ] . x := x + z ;    a [ i , 4 ] . y := y ;
            end ;
           close ( f ) ;
      end ;

   procedure            abc ( p1 , p2 : point ; var a , b , c : real ) ;
   begin
        a := p1 . y - p2 . y ;
        b := p2 . x - p1 . x ;
        c := p1 . x * p2 . y  - p1 . y * p2 . x ;
   end ;

   function             pt ( a , b , c : real ; p : point ) : real ;
   begin
        pt := p . x * a + p . y * b + c ;
   end ;

   function             cut ( p1 , p2 , p3 , p4 : point ) : boolean ;
   var
      a1 , a2 , b1 , b2 , c1 , c2   :   real ;
      begin
           abc ( p1 , p2 , a1 , b1 , c1 ) ;
           abc ( p3 , p4 , a2 , b2 , c2 ) ;
           cut := false ;
           if pt ( a1 , b1 , c1 , p3 ) * pt ( a1 , b1 , c1 , p4 ) >= 0 then exit ;
           if pt ( a2 , b2 , c2 , p1 ) * pt ( a2 , b2 , c2 , p2 ) >= 0 then exit ;
           cut := true ;
      end ;

   function             cat ( p1 , p2 : point ; i : integer ) : boolean;
      begin
           cat := true ;
           if cut ( p1 , p2 , a [ i , 1 ] , a [ i , 3 ] ) then exit ;
           if cut ( p1 , p2 , a [ i , 2 ] , a [ i , 4 ] ) then exit ;
           cat := false ;
      end ;

   function             thoa_man ( p1 , p2 : point ) : boolean ;
   var
      i         :       integer ;
      begin
           thoa_man := false ;
           if ( p1 . x = p2 . x ) and ( p1 . y = p2 . y ) then exit ;
           for i := 1 to m do
            if cat ( p1 , p2 , i ) then exit ;
           thoa_man := true ;
      end ;

   function             kc ( p1 , p2 : point ) : real ;
   begin
        kc := sqrt ( sqr ( p1 . x - p2 . x ) + sqr ( p1 . y - p2 . y ) ) ;
   end ;

   procedure            init ;
   var
      i1 , j1 , i , j   :       integer ;
      begin
           for i := 0 to m + 1 do
            for j := 1 to 4 do
             for i1 := 0 to m + 1 do
               for j1 := 1 to 4 do
                dd [ i , j , i1 , j1 ] := thoa_man ( a [ i , j ] , a [ i1 , j1 ] ) ;
      end ;

   procedure            process ;
   var
      ok        :       boolean ;
      i , j     :       integer ;
      i1 , j1   :       integer ;
      k_c       :       real ;
      begin
           for i := 0 to m + 1 do
            for j := 1 to 4 do
             begin
                  d [ i , j ] := max ;
                  tr [ i , j ] . x := max1 ;
                  tr [ i , j ] . y := max1 ;
             end ;
           d [ 0 , 1 ] := 0 ;           d [ 0 , 2 ] := 0 ;
           d [ 0 , 3 ] := 0 ;           d [ 0 , 4 ] := 0 ;
           repeat
                 ok := true ;
                 for i := 0 to m + 1 do
                  for j := 1 to 4 do
                   if d [ i , j ] <> max then
                   for i1 := 0 to m + 1 do
                    for j1 := 1 to 4 do
                     if ( i1 <> i ) and ( j1 <> j ) then
                     if dd [ i , j , i1 , j1 ] then
                      if d [ i , j ] + kc ( a [ i , j ] , a [ i1 , j1 ] ) < d [ i1 , j1 ] then
                      begin
                           ok := false ;
                           d [ i1 , j1 ] := d [ i , j ] + kc ( a [ i , j ] , a [ i1 , j1 ] ) ;
                           tr [ i1 , j1 ] . x := i ;
                           tr [ i1 , j1 ] . y := j ;
                      end ;
           until ok ;
      end ;

   procedure            writefile ;
   var
      i1 , i , j , li , count     :       integer ;
      tinh                   :       real ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           tinh := 0 ;
           for i := 1 to 4 do
            if d [ m + 1 , i ] <> max then
            if tinh < d [ m + 1 , i ] then
             begin
                  tinh := d [ m + 1 , i ] ;
                  li := i ;
             end ;
           if tinh <> 0 then
           begin
                writeln ( f , d [ m + 1 , li ] : 0 : 3 ) ;
                i := m + 1 ;
                j := li ;
                count := 0 ;
                while ( i <> 0 ) do
                begin
                      if a [ i , j ] . x <> 100 then
                      begin
                           inc ( count ) ;
                           di [ count ] . x := i ;
                           di [ count ] . y := j ;
                      end ;
                      i1 := i ;
                      i := tr [ i , j ] . x ;
                      j := tr [ i1 , j ] . y ;
                end ;
                writeln ( f , count ) ;
                for i := count downto 1 do
                 writeln ( f , a [ di [ i ] . x , di [ i ] . y ] .x : 0 : 3 , ' ' ,
                               a [ di [ i ] . x , di [ i ] . y ] .y : 0 : 3 , ' ' ) ;
           end
           else writeln ( f , 0 ) ;
           close ( f ) ;
      end ;

BEGIN
     clrscr ;
     readfile ;
     init ;
     process ;
     writefile ;
END.
5
5 5 5
5 15 5
15 10 5
15 20 5
90 90 5



