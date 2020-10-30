program         test_bien_doi ;  {  giai phuong trinh gauss }
uses            crt ;
const
     fi :  string  = 'BIENDOI1.IN' ;
     fo :  string  = 'BIENDOI.OUT' ;
     ketqua       : array [ 0..9 ] of integer =
     (  25 ,
        1  ,
        4  ,
        30 ,
        27 ,
        70 ,
        10 ,
        45 ,
        37 ,
        67 ) ;
var
   chon         :       string ;
   ok           :       boolean ;
   A            :       array [ 1..100 , 1..100 ] of byte ;
   bx , by      :       array [ 1..100 ] of byte ;
   n , i , j    :       integer ;
   min_total    :       integer ;
   f , g        :       text ;
   code , x     :       integer ;

   procedure            cham ;
   var x : integer ;
      begin
           assign ( f , fi ) ;
           reset ( f )  ;
           readln ( f , n ) ;
           for i := 1 to n do
            for j := 1 to n do
             read ( f , a [ i , j ] ) ;
           assign ( g , fo ) ;
           reset ( g ) ;
           readln ( g , min_total ) ;
           for i := 1 to n do
            read ( g , bx [ i ] ) ;
           for i := 1 to n do
            read ( g , by [ i ] ) ;
           for i := 1 to n do
            for j := 1 to n do
             a [ i , j ] := ( a [ i , j ] + bx [ i ] ) mod 2 ;
           for j := 1 to n do
            for i := 1 to n do
             a [ i , j ] := ( a [ i , j ] + by [ j ] ) mod 2 ;
           close ( g ) ;
           for i := 1 to n do
            for j := 1 to n do
             begin
                  read ( f , x ) ;
                  if a [ i , j ] <> x then
                  begin
                       writeln ( '     Error    :       Du Lieu Bien Doi Chua Dung !!!' ) ;
                       close ( f ) ;
                       exit ;
                  end ;
             end ;
           close ( f ) ;
           ok := true ;
      end ;

begin
     clrscr ;
     writeln ;
     writeln ( '           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ' ) ;
     writeln ( '           %%              CHAM BAI BIEN DOI              %% ' ) ;
     writeln ( '           %%       Le Van Hung K28 A2 Phan Boi Chau      %% ' ) ;
     writeln ( '           %%                                             %% ' ) ;
     writeln ( '           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ' ) ;
     writeln ;
     textcolor ( 2 ) ;
     write ( '     InPut :                    BienDoi1.In' ) ;
     readln ( chon ) ;
     val ( chon , x , code ) ;
     fi := fi + chon ;
     ok := false ;
     writeln ;
     writeln ;
     cham ;
     textcolor ( 11 ) ;
     writeln ;
     writeln ;
     if ok and ( ketqua [ x ] >= min_total ) then
     begin
          writeln ;
          writeln ( '                     CORRECT !!      CORRECT !! ' ) ;
          writeln ;
          if ketqua [ x ] > min_total then
          writeln ( '                       Tot Hon dap an ' ) ;
          writeln ;
          writeln ( '                          Ban Duoc : 1 Diem  ' ) ;
     end
     else
     if ok and ( ketqua [ x ] < min_total ) then
     begin
          writeln ;
          writeln ;
          writeln ( '           So phep bien doi o dap an : ' , ketqua[x] : 4 ) ;
          writeln ( '           So phep bien doi o ban    : ' , min_total : 4 ) ;
          writeln ;
          writeln ;
          writeln ( '                     Ban Duoc : 0.5 Diem  ' ) ;
     end
     else
     begin
          writeln ;
          writeln ;
          writeln ( '                     NOT CORRECT !!      NOT CORRECT !! ' ) ;
          writeln ;
          writeln ;
          writeln ( '                            Ban Duoc :    0 Diem  ' ) ;
     end ;
     readln ;
end .