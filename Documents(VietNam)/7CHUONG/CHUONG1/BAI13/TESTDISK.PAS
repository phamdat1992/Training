program cham ;
uses    crt ;
const
     fi =       'disk.in' ;
     fo =       'disk.out' ;
     ketqua : array [ 0..9 ] of integer = ( 26, 3 , 36 , 82 , 356 ,
                                            6666 , 583 , 50 , 57 ,
                                            -1  ) ;
type
    luu =       record
        x       :     longint ;
        c       :     char ;
    end ;
var
   a    :       array [ 1..10000 ] of luu ;
   code , so , s , n , p ,  q , u , v , count , dem , i : integer ;
   t , x : char ;
   k:char ;
   vitri :integer ;

   procedure    readfile ;
   var
      f :       text ;
      begin
           assign ( f , fi + k ) ; reset ( f ) ;
           readln ( f , n , p ,q , u , v ) ; close ( f ) ;
           assign ( f , fo ) ;
           reset ( f ) ;
           readln ( f , count ) ;
           if count <> ketqua [ vitri ] then
           begin
                textcolor ( 13 ) ;
                writeln ( ' ket qua cua ban    : ' , count ) ;
                writeln ( ' ket qua cua dap an : ' , ketqua [ vitri ] ) ;
                writeln ;
                textcolor ( 4 ) ;
                writeln ( '   No correct !!! ');
                textcolor ( 3 ) ;
                writeln ;
                writeln ( '           ************************** ' ) ;
                writeln ( '                     Diem :  0 ');
                writeln ( '           ************************** ' ) ;
                readln ;

                halt ;
           end ;


           dem := 0 ;
           if count = - 1 then
           begin
                if vitri = 9 then
                begin
                     textcolor ( 13 ) ;
                     writeln ;
                     writeln ( '      correct !!! ');
                     writeln ;
                     textcolor ( 3 ) ;
                     writeln ( '          *****************************');
                     writeln ( '                     diem : 1 ' ) ;
                     writeln ( '          *****************************');
                     readln ;
                     halt ;
                end ;
                exit ;
           end ;
           while not seekeof ( f ) do
            begin
                 read ( f , t ) ;
                 read ( f , x ) ;
                 val ( x , so , code ) ;
                 while ( x <> #32) and ( not eof(f) ) do
                 begin
                       read ( f , x ) ;

                       if x = #32 then break
                       else
                       if x in ['0'..'9'] then
                       begin
                            val ( x , s , code ) ;
                            so := so * 10 + s ;
                       end ;
                 end ;
                 inc ( dem ) ;
                 a [ dem ] . x := so ;
                 a [ dem ] . c := t ;
            end ;
           close ( f ) ;
      end ;

   begin
        clrscr ;
        writeln ;
        textcolor ( 3 ) ;
        writeln ( ' chuong trinh kiem tra bai Disk ');
        writeln ( '******************************** ' ) ;
        write ( '   du lieu tu file : Disk.in');
        k := readkey ;
        writeln ( k ) ;
        vitri := ord ( k ) - 48 ;
        readfile ;
        for i := 1 to dem do
         begin
              if a [ i ] . c ='T' then u := u + p * a [ i ] . x
              else u := u - q * a [ i ] . x ;
         end ;
        
        writeln ;
        textcolor ( 13 ) ;
        writeln ( ' Ket qua di ( theo chuong trinh ban ) se den : ',u ) ;
        writeln ( ' Ket qua can toi                             : ',v );
        writeln ;
        textcolor ( 10 ) ;
        if u <> v then
        begin

             writeln ( '  Ket qua sai lac ' );
             writeln ;
             textcolor ( 13 ) ;
             writeln ( '   *****************');
             writeln ( '      diem :  0 ' ) ;
             writeln ( '   *****************');
        end
        else
            begin
                 writeln ( ' Correct !!! ' ) ;
                 writeln ; textcolor ( 13 ) ;
                 writeln ( '   ********************* ');
                 writeln ( '         diem  : 1 ');
                 writeln ( '   ********************* ');
            end ;
        readln ;

   end.

