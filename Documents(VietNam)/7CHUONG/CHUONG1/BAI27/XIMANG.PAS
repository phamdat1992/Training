(*   ************************ *)
(*     Le Van Hung PBC-NA     *)
(*   ************************ *)

const
     fi =       'ximang.inp' ;
     fo =       'ximang.out' ;
type
    box =       record
        f : word ;
        x : byte ;
    end ;
var
   m , c :      array [1 ..10 ] of byte ;
   a     :      array [ 1..10 , 0..300 ] of box ;
   n , q :      byte ;
   f     :      text ;

   procedure    khoitao ;
   var
      i :       byte ;
      begin
           assign ( f , fi ) ; reset ( f ) ;
           readln ( f , n , q ) ;
           for i := 1 to n do
               read ( f , m [ i ] ) ;
           readln ( f ) ;
           for i := 1 to n do
               read ( f , c [ i ] ) ;
           close ( f ) ;
      end ;

   procedure    lapbang ;
   var
      j , k , x1        :       byte ;
      t , v             :       word ;
      begin
           for k:= n downto 1 do
               begin
                    v := 0 ;
                    for j := k to n do v := v + m [ j ] ;
                    for t := 0 to v do
                    with a [ k , t ] do
                         begin
                              if k = n then
                              begin
                                   x := m [ n ] - t ;
                                   f := c [ n ] * x ;
                              end
                              else
                              begin
                                   x :=  m [ k ] - t ;
                                   f := x * c [ k] + a[ k +1 , 0 ] . f ;
                              end ;
                              x1:=x ;
                              while t+x1 <v do
                              begin
                                   x1:=x1+1 ;
                                   if f > x1*c[k]+ sqr(t+x1-m[k])*q+a[k+1,t+x1-m[k]].f then
                                   begin
                                        f:=x1*c[k]+sqr(t+x1-m[k])*q+a[k+1,t+x1-m[k]].f ;
                                        x := x1 ;
                                   end ;
                              end ;
                         end ;
               end ;
      end ;

      procedure inkq ;
      var
         t : word ;
         k : byte ;
         begin
              assign ( f , fo ) ; rewrite ( f ) ;
              writeln ( f , a [1,0].f);
              t:=0;
              for k := 1 to n do
              begin
                   write ( f , a [k,t].x,' ' );
                   t:=t+a[k,t].x-m[k];
              end ;
              close ( f ) ;
         end ;

BEGIN
     khoitao ;lapbang ; inkq ;
END.
4 2
5 3 10 6
14 20 10 30
