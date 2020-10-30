program         Hoa_Tra_my ;
uses            crt ;
const
     fi =       'Tien.In0' ;
     fo =       'Tien.Out' ;
Var
   mind , luu   :       array [ 0..10000 ] of word ;
   n , m        :       integer ;
   a , sl       :       array [ 1..100 ] of integer ;

     procedure          readfile ;
     var
        f       :       text ;
        i       :       integer ;
        begin
             assign ( f , fi ) ;
             reset ( f ) ;
             readln ( f , n , m ) ;
             for i := 1 to n do
              read ( f , a [ i ] ) ;
             close ( f );
        end ;

     procedure          quy_hoach_dong ;
     var
        i , j , min     :       word ;
        begin
             Mind [ 0 ] := 0 ;
             luu [ 0 ] := 0 ;
             For i:=1 to m do
              begin
                   luu [ i ] := 2 * maxint ;
                   min := 2 * maxint ;
                   for j :=1 to n do
                    if a [ j ] <= i then
                     if min > mind [ i - a [ j ] ] + 1 then
                      begin
                           luu [ i ] := j ;
                           min := mind [ i - a [ j ] ] + 1 ;
                      end ;
                   mind [ i ] := min ;
              end ;
        end ;

     procedure          writefile ;
     var
        f       :       text ;
        i , j   :       integer ;
        begin
             assign ( f , fo );
             rewrite ( f ) ;
             if mind [ m ] = 2 * maxint then
             begin
                  writeln ( f , -1 );
                  close ( f ) ;
                  halt ;
             end ;
             writeln ( f , mind [ m ] ) ;
             j := luu [ m ] ;
             i := m ;
             fillchar ( sl , sizeof ( sl ) ,0 ) ;
             while j<>0 do
              begin
                   inc ( sl [ j ] ) ;
                   i := i - a [ j ] ;
                   j := luu [ i ] ;
              end ;
             for i := 1 to  n do
              write ( f , sl [ i ] ,' ' ) ;
             close ( f ) ;
        end ;

Begin
     readfile ;
     quy_hoach_dong ;
     writefile ;
End.

5 97
1 5 10 50 100








