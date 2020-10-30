program         cungcapvatlieu ;
uses            crt ;
const
     fi =       'cungcap.inp' ;
     fo =       'cungcap.out' ;
     max=       1000000 ;
     max1=100 ;
var
   n , r : integer ;
   a , b , d : array [ 1..max1]of word ;
   s,l : array [ 1..max1,0..max1]of word ;
   i,j,x : longint ;
   procedure            readfile ;
   var
      f : text ;
      i : integer ;
      begin
           clrscr ;
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , n , r ) ;
           for i := 1 to n do
                 read ( f , d [ i ] ) ;
           readln ( f ) ;
           for i := 1 to n do
                 read ( f , a [ i ] ) ;
           readln ( f ) ;
           for i := 1 to n do
                 read ( f , b [ i ] ) ;
           close ( f ) ;
      end ;

   function     min ( a , b : longint ) : longint ;
   begin
        if a> b then min := b else min := a ;
   end ;

   procedure    xuli ;
   var
      m         :       longint ;
      luu       :       integer ;
      begin
           fillchar ( s , sizeof ( s ) , 0 ) ;
           l := s ;
           for j := 0 to r do
               begin
                    m := max ;
                    for x := 0 to min ( j , d [ 1] ) do
                     if a [ 1 ] * x + b [ 1 ] *( d [ 1 ] - x ) < m then
                        begin
                             luu := x ;
                             m := a [ 1 ] * x + b [ 1 ] *(d [ 1 ] - x ) ;
                        end ;
                    s [ 1 , j ] := m ;
                    l [ 1 , j ] := luu ;
               end ;
           for i := 2 to n do
            for j := 0 to r do
                begin
                     m := max ;
                     for x:= 0 to min ( j , d [ i ] ) do
                      if m > a[i]*x+b[i]*(d[i]-x)+S[i-1,j-x] then
                      begin
                           m := a[i]*x+b[i]*(d[i]-x)+S[i-1,j-x] ;
                           luu := x ;
                      end ;
                     s [ i , j ] := m ;
                     l [ i , j ] :=luu ;
                end ;
      end ;

   procedure    xuat ;
   var
      f :       text ;
      hang : array [ 1..max1 ] of word ;
      begin
           assign( f , fo ) ;
           rewrite ( f ) ;
           writeln ( f , s[n,r]);
           for i := n downto 1 do
            begin
                 hang [i ]:=l[i,r];
                 dec(r,l[i,r]);
            end ;
           for i:=1 to n do
            write(f,hang[i],' ');
            writeln(f);
            for i:=1 to n do
            write ( f,d[i]-hang[i],' ');
           close ( f ) ;
      end ;

begin
     readfile ;
     xuli ;
     xuat ;
end.

5 10
30 80 80 50 40
3 5 10 4 23
4 6 2 7 4

