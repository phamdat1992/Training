{$R+}
program         bai_cap_so_cong ;
uses            crt ;
const
     fi         =       'BL1.IN5' ;
     fo         =       'BL1.OUT' ;
     max        =       8000 ;
     maxd       =       100 ;
type
    link        =       ^node ;
    node        =       record
     x          :       integer ;
     next       :       link ;
    end ;
    arr         =       array[ -max..max ] of link;
    arr1        =       array [ 1..10000 ] of integer ;
    arr11       =       array [ 0..64000 ] of byte;
var
   hung         :       arr;
   a1           :       ^arr1;
   n , i , j    :       integer ;
   f            :       text ;
   best , dem   :       integer ;
   luui , luuj  :       integer ;
   jj , v , t   :       integer ;
   v1 , luuv    :       integer ;
   time         :       longint ;
   time_save    :       longint absolute 0:$46c ;
   dd           :       ^arr11 ;

   function             kt     :         boolean ;
   var
    i ,dem : integer ;
    begin
         dem :=0 ;
          for i := 1 to n - 1 do
           if a1^ [ i ] >= a1^ [ i + 1 ] then inc ( dem );
           if dem = n - 1 then
           kt := false else kt := true ;
    end ;

    procedure           add  (i  , j : integer ) ;
    var   l : link ;
    begin
         new ( l ) ;
         l^.x := j ;
         l^.next := hung [ i ] ;
         hung [ i ] := l ;
    end ;

   procedure            readfile ;
   begin
        time:=time_save ;
        clrscr ;
        assign ( f , fi ) ;
        reset ( f ) ;
        readln ( f , n ) ;
        for i:=-max to max do hung [ i ] := nil ;
        for i := 1 to n do
         begin
              readln ( f , a1^ [ i ] ) ;
              add ( a1^ [ i ] , i ) ;
         end ;
        close ( f ) ;
   end ;

   function             get_bit ( k :   longint ) : byte ;
   var
      i , j   : longint ;
      begin
           i := k div 8 ;
           j := k mod 8 ;
           get_bit := ( dd^ [ i ] shr j ) and 1 ;
      end;

   procedure         bat_bit ( k : longint ) ;
   var
      i , j : longint ;
      begin
         i := k div 8 ;
         j := k mod 8 ;
         dd^ [ i ] := dd^ [ i ] or ( 1 shl j ) ;
      end;

   function     words ( i , j : integer ):word  ;
   var l  : link ;
       luu:integer ;
       begin
            luu:=0;
            if a1^ [ i ] + j > max then
            begin
                 words := 0 ;
                 exit ;
            end ;
            l := hung [ a1^ [ i ] + j ] ;
            while l <> nil do
             begin
                  if l^. x > i then luu := l^.x ;
                  l := l^.next ;
             end ;
             words := luu ;
       end ;

   procedure            xuli ;
   begin
        best := 0 ;
        for j := 1 to maxd do
        begin
             fillchar ( dd^ , sizeof ( dd^ ) , 0 ) ;
             for i := 1 to n - 1 do
             if get_bit ( i ) = 0 then
              begin
                   dem := 0;
                   t := i ;
                   v := j ;
                   repeat
                         bat_bit ( t ) ;
                         t := words ( t , v ) ;
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
              t := words( t , v ) ;
              inc ( dem ) ;
        until ( dem = best ) or ( t = 0 ) ;
        close ( f ) ;
   end ;

BEGIN
     new(a1);
     new(dd);

     readfile ;
     if kt then
     begin
          xuli ;
          writeln ((time_save-time )/18.21 :0:4) ;
          writefile ;
     end
     else
     begin
          assign( f , fo ) ;
          rewrite( f ) ;
          writeln( f , -1 ) ;
          close ( f ) ;
     end ;

     dispose(dd);
     dispose (a1);
END.
