(* Le Van Hung 		*)
(* K28 A2 PBC 		*)
(* Hoa_Tra_My Group 	*) 

program         rotation ;
uses            crt ;
const
     fi         =       'ROTATION.INP' ;
     fo         =       'ROTATION.OUT' ;
     n_g        :       array [ 1..5 ] of byte = ( 0 , 1 , 6 , 8 , 9 ) ;
     nguoc      :       array [ 1..5 ] of byte = ( 0 , 1 , 9 , 8 , 6 ) ;
     that       :       array [ 1..3 ] of byte = ( 0 , 1 , 8 ) ;
var
   a            :       array [ 1..20 ] of integer ;
   count , n    :       longint ;
   kt           :       array [ 0..9 , 1..20 ] of boolean ;
   f            :       text ;
   time         :       longint ;
   time_save    :       longint absolute 0:$46c ;

   procedure            readfile ;
   begin
        time := time_save ;
        assign ( f , fi ) ;
        reset ( f ) ;
        readln ( f , n ) ;
        close ( f ) ;
        count := 0 ;
        fillchar ( kt , sizeof ( kt ) , true ) ;
        kt [ 0 , 1 ] := false ;
   end ;

   procedure            xuat ;
   var
      i , j     :       integer ;
      begin
           if odd ( n ) then
           begin
                for i := 1 to 3 do
                 begin
                      inc ( count ) ;
                      a [ n div 2 + 1 ] := that [ i ] ;
                      for j := 1 to n do
                       write ( f , a [ j ] ) ;
                      writeln ( f ) ;
                 end ;
           end
           else
           begin
                inc ( count ) ;
                for j := 1 to n do
                 write ( f , a [ j ] ) ;
                writeln ( f ) ;
           end ;
      end ;

   procedure            try ( i : integer ) ;
   var
      j         :       integer ;
      begin
           for j := 1 to 5 do
            if kt [ n_g [ j ] , i ] then
            begin
                 a [ i ] := n_g [ j ] ;
                 a [ n + 1 - i ] := nguoc [ j ] ;
                 if i = n div 2 then xuat else try ( i + 1 ) ;
            end ;
      end ;

   procedure            process ;
   begin
        assign ( f , fo ) ;
        rewrite ( f ) ;
        try ( 1 ) ;
        close ( f ) ;
   end ;

BEGIN
     readfile ;
     process ;
     clrscr ;
     writeln ( ' Time Run =   ' , ( time_save - time ) / 18.21 : 0 : 4 ) ;
END.

4
