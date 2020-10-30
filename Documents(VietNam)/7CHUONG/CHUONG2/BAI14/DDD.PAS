program                 dartagnan ;
uses                    crt ;
const
     fi         =       'DART.INP' ;
     fo         =       'DART.OUT' ;
var
   function             doi ( x : char ) : integer ;
   begin
        if x = 'M' then doi := 1 else doi := 2 ;
   end ;

   procedure            add ( u , v , w , x , dem : word ) ;
   begin
        if x = 1 then
        begin
             a [ u , v + n ] . x := w ;
             a [ u , v + n ] . y := dem ;
        end
        else
        begin
             a [ u , v ] . x := w ;
             a [ u , v ] . y := dem ;
        end ;
   end ;

   procedure            readfile ;
   var
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , n ) ;
           fillchar ( a , sizeof ( a ) , 0 ) ;
           dem := 0 ;
           while not seekeof ( f ) do
            begin
                 readln ( f , u , v , w1 , w2 , x ) ;
                 inc ( dem ) ;
                 a [ u , v ] . x := w1 ;
                 a [ u , v ] . y := dem ;
                 a [ u , v ] . z := doi ( x ) ;
                 a [ v , u ] . x := w2 ;
                 a [ v , u ] . y := dem ;
                 a [ v , u ] . z := 3 - doi ( x ) ;
{                 add ( u , v , w1 , doi ( x ) , dem ) ;
                 add ( v , u , w2 , 3 - doi ( x ) , dem ) ;
 }           end ;
           close ( f ) ;
      end ;

      procedure                 bellman ;
      var
         begin
              for i := 1 to n do
               begin
                    d [ i ] := maxlongint ;
                    tr [ i ] := maxlongint ;
               end ;
              d [ n ] := 0 ;
              repeat
                    ok := true ;
                    for i := 1 to n do
                     if d [ i ] [ 1 ] <> maxlongint then
                      for j := 1 to n do



         end ;