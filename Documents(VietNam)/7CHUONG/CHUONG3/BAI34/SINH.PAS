program         sinh_test ;
uses            crt ;
const
        fi      =       'BIENDOI.INP' ;
        n       =       80 ;
        m       =       11 ;
        hh      :       array [ 1..5 ] of shortint = ( -1 , 0 , 1 , 0 , 0 ) ;
        cc      :       array [ 1..5 ] of shortint = ( 0 , -1 , 0 , 1 , 0 ) ;
type
    point       =       record
     x , y      :       integer ;
    end ;
var
   i , j      :   integer ;
   a          :   array [ 0..101 , 0..101 ] of byte ;
   luu        :   array [ 1..1000 ] of point ;
   f          :   text ;
   dem , x , y:   integer ;

   procedure             biendoi ( i , j  : integer ) ;
   var
      t :  integer ;
      begin
           for t := 1 to 5 do
            a [ i + hh [t ] , j + cc [ t ] ] := ( a [ i + hh [ t ] , j + cc [ t ] ] + 1  ) mod 2 ;
      end ;

   function              thoa_man ( x , y : integer ) : boolean ;
   var
       i   :  integer ;
       begin
            thoa_man := false ;
            for i := 1 to dem do
             if ( luu [ i ] . x = x ) and ( luu [ i ] . y = y ) then exit ;
            thoa_man := true ;
       end ;

   procedure            sinh ;
      begin
           assign ( f , fi ) ;
           rewrite ( f ) ;
           writeln ( f , n ) ;
           fillchar ( a , sizeof ( a ) , 0 ) ;
           randomize ;
           for i := 1 to n do
            begin
                 for j := 1 to n do
                  begin
                       a [ i , j ] := ( random ( 100 ) + 1 ) mod 2 ;
                       write ( f , a [ i , j ] : 3 ) ;
                  end ;
                 writeln ( f ) ;
             end ;
             dem := 0 ;
             repeat
                   x := random ( n ) + 1 ;
                   y := random ( n ) + 1 ;
                   if thoa_man ( x , y ) then
                   begin
                        inc ( dem ) ;
                        luu [ dem ] . x := x ;
                        luu [ dem ] . y := y ;
                   end ;
             until dem >= m ;
            for i := 1 to m do
             biendoi ( luu [ i ] . x , luu [ i ] . y ) ;
            for i := 1 to n do
             begin
                  for j := 1 to n do
                   write ( f , a [ i , j ] : 3 ) ;
                  writeln ( f ) ;
             end ;
            writeln ( f , m ) ;
            for i := 1 to m do
             writeln ( f , luu [ i ] . x , ' ' ,luu [i ] . y ) ;
            close ( f ) ;
      end ;
begin
     sinh ;
end .