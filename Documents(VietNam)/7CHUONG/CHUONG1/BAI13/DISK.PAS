program         Hoa_tra_my ;
uses            crt ;
const
     fi         =       'disk.inp' ;
     fo         =       'disk.out' ;
     max        =       2 * maxint ;
type
    arr1        =       array [ 0..20000 ] of word ;
    arr2        =       array [ 0..20000 ] of integer ;
    point       =       record
                x       :     integer ;
                c       :     byte ;
    end ;
var
   mind         :       ^ arr1 ;
   luu          :       ^ arr2 ;
   n , p , q    :       longint ;
   u , v        :       longint ;
   duongdi      :       array [ 1..20000 ] of point ;

   procedure    readfile ;
   var
      f :       text ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , n , p , q , u , v ) ;
           close ( f ) ;
      end ;

   procedure    quy_hoach_dong ;
   var
      i         :       integer ;
      ok        :       boolean ;
      begin
           for i := 0 to n do
           begin
                mind ^ [ i ] := max ;
                luu ^ [ i ] := maxint ;
           end ;
           mind ^ [ u ] := 0 ;
           repeat
                 ok := true ;
                 for i := 0 to n do
                  if mind ^ [ i ] <> max then
                   begin
                        if ( i - q >= 0 ) and ( mind ^ [ i ] + 1 < mind ^ [ i - q ] ) then
                        begin
                             ok := false ;
                             mind ^ [ i - q ] := mind ^ [ i ] + 1 ;
                             luu ^ [ i - q ] := - q ;
                        end ;
                        if ( i + p <= n ) and ( mind ^ [ i ] + 1 < mind ^ [ i + p ] ) then
                        begin
                             ok := false ;
                             mind ^ [ i + p ] := mind ^ [ i ] + 1 ;
                             luu ^ [ i + p ] := p ;
                        end ;
                   end ;
           until ok ;
      end ;

   procedure    writefile ;
   var
      f                 :       text ;
      i , count , dem   :    integer ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           if mind ^ [ v ] = max then
           writeln ( f , -1 )
           else
           begin
                writeln ( f , mind ^ [ v ] ) ;
                i := v ;
                dem := 1 ;
                if luu ^ [ v ] > 0 then
                duongdi [ dem ] . c := 0 else duongdi [ 1 ] . c := 1 ;
                count := 1 ;
                repeat
                      if luu ^ [ i ] <> luu ^ [ i- luu ^ [ i ] ] then
                      begin
                           duongdi [ dem ] . x := count ;
                           inc ( dem ) ;
                           count := 1 ;
                           duongdi [ dem ] . c := ( duongdi [ dem - 1 ] . c + 1 ) mod 2 ;
                      end
                      else inc ( count ) ;
                      i := i - luu ^ [ i ] ;
                until luu ^ [ i ] = maxint ;
                for i := dem-1 downto 1 do
                 begin
                      if duongdi [ i ] . c = 0 then write ( f , ' T') else
                      write (f,' L');
                      write ( f , duongdi [ i ] . x ) ;
                 end ;
           end ;

           close ( f ) ;
      end ;

BEGIN
     new ( mind ) ;
     new ( luu ) ;

         readfile ;
         quy_hoach_dong ;
         writefile ;

     dispose ( mind ) ;
     dispose ( luu ) ;
END.
10 5 3 7 6