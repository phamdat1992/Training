program         bien_doi ;
uses            crt ;
const
     fi         =      'bd.in6';{ 'BIENDOI.IN6' ;}
     fo         =       'BIENDOI.OUT' ;
var
   a , biendoi , c , b  :       array [ 0..101 , 0..101 ] of byte ;
   n , best             :       integer ;
   f                    :       text ;
   time                 :       longint ;
   time_save            :       longint absolute 0:$46c ;
   tong1 , tong , total :       integer ;

   procedure            readfile ;
   var
      i , j     :       integer ;
      x         :       integer ;
      begin
           time := time_save ;
           assign ( f , fi ) ;
           reset ( f ) ;
           fillchar ( a , sizeof ( a ) , 0 ) ;
           c := a ;
           readln ( f , n ) ;
           for i := 1 to n do
            for j := 1 to n do
             read ( f , a [ i , j ] ) ;
           tong := 0 ;
           for i := 1 to n do
            for j := 1 to n do
             begin
                  read ( f , x ) ;
                  if x <> a [ i , j ] then c [ i , j ] := 1 ;
                  inc ( tong , c [ i , j ] ) ;
             end ;
           close ( f ) ;
      end ;

   function             tinh ( i , j :  integer ) : byte ;
   begin
        tinh := b [ i , j ] + b [ i , j + 1 ] + b [ i , j - 1 ] + b [ i - 1 , j ] ;
   end ;

   function             thoa_man ( i , j  :  integer ) : boolean ;
   var
      t :       integer ;
      begin
           t := b [ i , j ] + b [ i - 1 , j ] + b [ i , j - 1 ] + b [ i , j + 1 ] + b [ i + 1 , j ] ;
           thoa_man := ( t mod 2 = c [ i , j ] ) ;
      end ;

   procedure            writefile ;
   var
      i , j     :       integer ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           if best = 10000 then
           begin
                writeln ( f , -1 ) ;
                close ( f ) ;
                exit ;
           end ;
           writeln ( f , best ) ;
           for i := 1 to n do
            for j := 1 to n do
             if biendoi [ i , j ] <> 0 then writeln ( f , i , ' ' , j ) ;
           close ( f ) ;
      end ;

   procedure            xuli ;
   var
      i , j     :       integer ;
      i1 , j1   :       integer ;
      t1        :       integer ;
      begin
           for i := 2 to n do
            for j := n + 2 - i to n do
             begin
                  t1 := tinh ( i - 1 , j ) mod 2 ;
                  if c [ i - 1 , j ] = t1 then b [ i , j ] := 0 else b [ i , j ] := 1 ;
                  inc ( total , b [ i , j ] ) ;
{                  dec ( tong , c [ i , j ] ) ;}
             end ;
           for i := 1 to n do
            for j := 1 to n do
             if not thoa_man ( i , j ) then
             begin
                  for i1 := 2 to n do
                   for j1 := n + 2 - i1 to n do
                    begin
                         dec ( total , b [ i1 , j1 ] ) ;
                         b [ i1 , j1 ] := 0 ;
{                         inc ( tong , c [ i , j ] ) ;}
                    end ;
                  exit ;
             end ;
           if total < best then
            begin
                 biendoi := b ;
                 best := total ;
            end ;
           for i := 2 to n do
            for j := n + 2 - i to n do
             begin
                  dec ( total , b [ i , j ] ) ;
                  b [ i , j ] := 0 ;
{                  inc ( tong , c [ i , j ] ) ;}
             end ;
      end ;

   procedure            update ( i :  integer ) ;
   var
      i1 , j1    :       integer ;
      t1         :       integer ;
      begin
           j1 := i - 1;
           i1 := 2 ;
           while j1 > 0 do
            begin
                 t1 := tinh ( i1 - 1 , j1 ) mod 2 ;
                 if c [ i1 - 1 , j1 ] = t1 then b [ i1 , j1 ] := 0 else b [ i1 , j1 ] := 1 ;
                 inc ( total , b [ i1 , j1 ] ) ;
{                 dec ( tong , c [ i1 , j1 ] ) ;}
                 dec ( j1 ) ;
                 inc ( i1 ) ;
            end ;
      end ;

   procedure            unnistalls ( i :  integer ) ;
   var
      j1 , i1         :       integer ;
      begin
           i1 := 2 ;
           j1 := i - 1 ;
           while ( j1 > 0 ) do
            begin
                 dec ( total , b [ i1 , j1 ] ) ;
                 b [ i1 , j1 ] := 0 ;
{                 inc ( tong , c [ i1 , j1 ] ) ;}
                 dec ( j1 ) ;
                 inc ( i1 ) ;
            end ;
      end ;

   procedure            try ( i :  byte ) ;
   var
      j                 :       byte ;
      begin
           for j := 0 to 1 do
            begin
                 b [ 1 , i ] := j ;
                 inc ( total , b [ 1 , i ] ) ;
{                 dec ( tong , c [ 1 , i ] ) ;}
                 update ( i ) ;
                 if i = n then xuli
                 else
                 if total {+ tong div 4} < best then try ( i + 1 ) ;
                 unnistalls ( i ) ;
                 dec ( total , b [ 1 , i ] ) ;
{                 inc ( tong , c [ 1 , i ] ) ;}
                 b [ 1 , i ] := 0 ;
            end ;
      end ;

   procedure            process ;
   begin
        best := 10000 ;
        total := 0 ;
        try ( 1 ) ;
   end ;

BEGIN
     readfile ;
     process ;
     writefile ;
     clrscr ;
     textcolor ( 12 ) ;
     write ( '   Voi N = ' ) ;writeln ( N : 5 ) ;
     writeln ( '  Time Run = ' , ( time_save - time ) / 18.21 : 0 : 4 ) ;
END.


4
1 0 0 1
1 1 1 0
0 1 0 1
1 0 0 1
1 1 0 1
0 0 1 0
0 1 1 0
1 0 1 1
