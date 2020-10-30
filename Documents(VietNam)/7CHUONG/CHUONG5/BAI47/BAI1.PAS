program         bai_cap_so_cong ;
uses            crt ;
const
     fi         =       'BL1.INP' ;
     fo         =       'BL1.OUT' ;
type
    arr1        =       array [ 1..10000 ] of integer ;
    arr11       =       array [ 0..64000 ] of byte;
var
   a1           :       ^arr1 ;
   n , i , j    :       integer ;
   f            :       text ;
   best , dem   :       integer ;
   luui , luuj  :       integer ;
   jj , v , t   :       integer ;
   v1 , luuv    :       integer ;
   time         :       longint ;
   time_save    :       longint absolute 0:$46c ;
   dd           :       arr11 ;

   procedure            init ;
   begin
        new ( a1 ) ;
   end ;

   procedure            fini ;
   begin
        dispose ( a1 ) ;
   end ;

   procedure            readfile ;
   begin
        time:=time_save ;
        clrscr ;
        assign ( f , fi ) ;
        reset ( f ) ;
        readln ( f , n ) ;
        for i := 1 to n do
         readln ( f , a1^ [ i ] ) ;
        close ( f ) ;
   end ;

   function             word ( i , j  :  integer ) : integer ;
   var
      i1        :       integer ;
      begin
           word := 0 ;
           for i1 := i + 1 to n do
           if a1^ [ i1 ] - a1^ [ i ] = j then
            begin
                 word := i1 ;
                 exit ;
            end ;
      end ;

   function                     get_bit ( k :   longint) : byte ;
   var
      i , j   : longint ;
      begin
           i := k div 8 ;
           j := k mod 8 ;
           Get_bit := ( dd [ i ] shr j ) and 1;
      end;

      procedure                 bat_bit ( k : longint ) ;
      var i , j : longint ;
      begin
         i := k div 8 ;
         j := k mod 8 ;
         dd [ i ] := dd [ i ] or ( 1 shl j ) ;
      end;

   procedure            xuli ;
   begin
        best := 0 ;
        for j := 1 to 100 do
        begin
             fillchar ( dd , sizeof ( dd ) , 0 ) ;
             for i := 1 to n - 1 do
             if get_bit ( i ) = 0 then
              begin
                   dem := 0;
                   t := i ;
                   v := j ;
                   repeat
                         bat_bit ( t ) ;
                         t := word ( t , v ) ;
                         inc ( dem ) ;
                   until t = 0 ;
                   if dem > best then
                   begin
                       luui := i ;
                       luuj := j ;
                       best := dem ;
                   end ;
               end ;
          end ;
   end ;

   procedure            writefile ;
   begin
        assign ( f , fo ) ;
        rewrite ( f ) ;
        if best = 0 then
        begin
             writeln ( f, -1 ) ;
             close ( f ) ;
             halt ;
        end ;
        writeln ( f , best , ' ' , luuj );
        dem := 0 ;
        t   := luui ;
        v := luuj;
        repeat
              writeln ( f , t ) ;
              t := word ( t , v ) ;
              inc ( dem ) ;
        until ( dem = best ) or ( t = 0 ) ;
        close ( f ) ;
   end ;

BEGIN
     init ;
     readfile ;
     xuli ;
     writeln ((time_save-time )/18.21 :0:4);
     writefile ;
     fini ;
END.
