{$R+}
program                 tu_lam_chuong_trinh_cham ;
uses                    crt ;
const
     fi   : string      =  'B' ;
     fo   : string      =  'DC.OUT' ;
var
   a            :       array [ 0..9 , 0..9 ] of byte ;
   b , c        :       array [ 1..1000 ] of shortint ;
   max , max1   :       longint ;
   n , m , i , j:       integer ;
   g , f            :       text ;

   procedure            readfile ;
   var
      i         :       integer ;
      tg , x , y     :       integer ;
      x1        :       char ;
      x11       :       string ;
      begin
           write (          '  Ban Cham Test  : ' ) ;
           readln ( x11 ) ;
           assign ( f , fi + x11 + '.' ) ;
           reset ( f ) ;
           readln ( f , n ) ;
           fillchar ( a , sizeof ( a ) , 0 ) ;
           for i := 0 to 9 do a [ i , i ] := 1 ;
           for i := 1 to n do
            begin
                 readln ( f , x , y ) ;
                 a [ x , y ] := 1 ;
                 a [ y , x ] := 1 ;
            end ;
           m := 0 ;
           while not seekeoln ( f ) do
            begin
                 inc ( m ) ;
                 read ( f , x1 ) ;
                 b [ m ] := ord ( x1 ) - 48 ;
            end ;
           close ( f ) ;
           assign ( f , fo ) ;
           reset ( f ) ;
           readln ( f , max ) ;
           while not seekeof ( f ) do
           begin
                 read ( f , x ) ;
                 if a [ b [ x ] , b [ x + 1 ] ] = 0 then
                  begin
                       writeln ( '   ' , b [ x ] , '  ' , b [ x + 1 ] , '  khong the doi cho cho nhau !!!!' ) ;
                       writeln ( '              Ban Sai Roi  !!!!!! ' ) ;
                       writeln ( '     loi o vi tri doi o thu ' , x : 4 ) ;
                       readln ;
                       close ( f ) ;
                       halt ;
                  end ;
                 tg := b [ x ] ;
                 b [ x ] := b [ x + 1 ] ;
                 b [ x + 1 ] := tg ;
            end ;
           close ( f ) ;
           assign ( f , fi + x11 + '.dap' ) ;
           reset ( f ) ;
           readln ( f , max1 ) ;
           readln ( f ) ;
           m := 0 ;
           while not seekeoln ( f ) do
            begin
                 inc ( m ) ;
                 read ( f , x1 ) ;
                 c [ m ] := ord ( x1 ) - 48 ;
            end ;
           close ( f ) ;
           for i := 1 to m do
            if b [ i ] < c [ i ] then
            begin
                 writeln ( '        So Ban Tao Thanh Nho Hon Dap An  !!!!! ' ) ;
                 writeln ( '            Ket Qua Chua Toi Uu  !!! ' ) ;
                 readln ;
                 halt ;
            end ;
           writeln ( '   Cac Phep Doi Cho Hop Ly  ' ) ;
           writeln ( '   So Lon Nhat Giong DA  ' ) ;
           writeln ( '     Ok ' ) ;
           writeln ( '   So Phep Bien Doi O DA  : ' , max1 :  10 ) ;
           writeln ( '   So Phep Bien Doi O HS  : ' , max :  10 ) ;
           if max = max1 then writeln ( '     Dung Roi  !!!!! ' ) ;
      end ;

begin
     clrscr ;
     readfile ;
     readln ;
end.
