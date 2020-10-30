program         Test_hanoi_tower ;
uses            crt ;
const
     da : array [ 0..9 ] of longint = ( 536870911 , 15 , 77 , 57 , 1048575 ,
                                        25 , 83 , 19 , 39 , 63 ) ;
     fi  =  'hntower.inp' ;
     fo  =  'hntower.out' ;
var
   dapan , vitri        :       longint ;

   procedure    readfile ;
   var
      f :       text ;
      c :       char ;
      begin
           Clrscr ;
           writeln('          Chuong trinh cham test bai HNTOWER');
           writeln('          **********************************');
           write  ('                    HNTOWER.IN');
           c:=readkey ;
           writeln ( c ) ;
           vitri := ord(c)-48 ;
      end ;

   procedure    test ;
   var
      f :       text ;
      begin
           assign ( f , fo ) ;
           reset ( f ) ;
           readln ( f , dapan ) ;
           close ( f ) ;
      end ;

   procedure    writefile ;
      begin
           writeln ; writeln ; writeln ; writeln;
           if dapan <> da [ vitri ] then
           begin
                writeln ( '             No CORRECT ! No CORRECT ! ');
                writeln ;
                writeln('         *****************************');
                writeln('         *          Diem : ', 0 ,   '         *');
                writeln('         *****************************');
           end
           else
           begin
                writeln ( '             CORRECT ! CORRECT ! ');
                writeln ;

                writeln('         *****************************');
                writeln('         *          Diem : ', 1 ,   '         *');
                writeln('         *****************************');
           end ;
      end ;

Begin
     readfile ;
     Test ;
     Writefile ;
     readln ;

End .
