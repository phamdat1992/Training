program hoa_tra_my ;
uses    crt ;
const
     fi =       'canduong.inp' ;
     fo =       'canduong.out' ;
var
   a            :       array [ 1..20 ] of integer ;
   n , m        :       longint ;
   i , dem      :       longint ;
   ok           :       boolean ;
   dem1 , dem2  :       longint ;
   a1 , a2      :       array [ 1..20 ] of integer ;

   procedure    readfile ;
   var
      f         :       text ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           read ( f , n , m ) ;
           close ( f ) ;
      end ;

   procedure    xuli ;
   var
      t :       longint ;
      begin
           t := 1 ;
           for i := 1 to n + 1 do t := t * 3 ;
           if ( t - 1 ) / 2 < m then ok := true else ok := false ;
           if not ok then
           begin
                dem := 0 ;
                dem1 := 0 ; dem2 := 0 ;
                while m<>0 do
                begin
                     inc ( dem ) ;
                     a [ dem ] := m mod 3 ;
                     m := m div 3 ;
                end ;
                a [ dem + 1 ] := 0 ;
                for i := 1 to dem+1 do
                      case a [ i ] of
                      1 :
                        begin
                             inc ( dem1 ) ;
                             a1 [ dem1 ] := i ;
                        end ;
                      2 :
                        begin
                             inc ( a[i+1]);
                             inc ( dem2 ) ;
                             a2 [ dem2 ] := i ;
                        end ;
                      3 :
                             inc ( a [ i + 1 ] ) ;
                      end ;
           end ;
      end ;

   procedure    writefile ;
   var
      f :       text ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           if ok then writeln (f,'NO')
           else
           begin
                writeln ( f ,'YES');
                for i := 1 to dem2  do
                 write ( f , a2 [ i ] : 5 ) ;
                writeln ( f ) ;
                for i := 1 to dem1  do
                 write ( f , a1 [ i ] : 5 ) ;
           end ;
           close ( f ) ;
      end ;

begin
     readfile ;
     xuli;
     writefile ;
end.
