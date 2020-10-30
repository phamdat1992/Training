program         sinh_test ;
uses            crt ;
const
        fi   :string   =       'BD.IN' ;
        fo  : string     =       'BIENDOI.OUT' ;
        hh      :       array [ 1..5 ] of shortint = ( -1 , 0 , 1 , 0 , 0 ) ;
        cc      :       array [ 1..5 ] of shortint = ( 0 , -1 , 0 , 1 , 0 ) ;
type
    point       =       record
     x , y      :       integer ;
    end ;
var
   luu            :  array [ 1..1000]of point ;
   total          :  integer ;
   c , a          :  array  [ 0..101 , 0..101 ] of byte ;
   n , i , j , m  :  integer ;
   f              :  text ;
   so             :  string ;

   procedure              readfile ;
   begin
        assign ( f, fi ) ;
        reset ( f ) ;
        readln ( f , n ) ;
        for i := 1 to n do
         for j := 1 to n do
          read ( f , a [ i , j ] ) ;
        for i := 1 to n do
         for j := 1 to n do
          read ( f , c [ i , j ] ) ;
        read ( f , m ) ;
        close ( f ) ;
        assign ( f, fo ) ;
        reset ( f ) ;
        readln ( f , total ) ;
        for i := 1 to total do
         readln ( f , luu [ i  ].x ,luu [ i ] . y ) ;
        close ( f ) ;
   end ;

   procedure             biendoi ( i , j  : integer ) ;
   var
      t :  integer ;
      begin
           for t := 1 to 5 do
            a [ i + hh [t ] , j + cc [ t ] ] := ( a [ i + hh [ t ] , j + cc [ t ] ] + 1  ) mod 2 ;
      end ;

   procedure            cham ;
   begin
        for i := 1 to total do
         biendoi ( luu [ i ] . x , luu [ i ] . y ) ;
   end ;

begin
     clrscr ;
     textcolor ( 10 ) ;
     writeln ;
     writeln ( '           Chuong trinh cham bai Bat Bit ' ) ;
     writeln ( ' ************************************************* ') ;
     write ( '                Input :  BIENDOI.IN' ) ;
     so:=readkey;
     writeln ( so ) ;
     writeln ; writeln ;
     fi := fi + so ;
     readfile ;
     cham ;
     textcolor ( 12 ) ;
     for i := 1 to n do
      for j := 1 to n do
       if a [ i , j ] <> c [ i , j ] then
       begin
            writeln ( '             Cac Phep Bien Doi Khong Dung ' ) ;
            writeln ( '           NOT CORRECT !!!     NOT CORRECT !!! ' ) ;
            readln ;
            halt ;
       end ;
     writeln ( '            CORRECT !!!!    CORRECT  !!!! ' ) ;
     writeln ;
     write ( '      So phep o Dap An  : ' ) ;
     writeln (  m   :   5 ) ;
     write ( '      so phep o ket qua : ' ) ;
     writeln (  total : 5 ) ;
     if m = total then
      writeln ( '      Ket Qua Dung Voi Dap An  !!!!! ' )
     else
      if m < total then
      writeln ( '      Ket Qua Chua Toi Uu    !!!!!! ' )
      else if m > total then
      writeln ( '      Ket Qua Tot Hon Dap An  !!!!! ' ) ;
     readln ;
end .