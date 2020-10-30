(*  Le Van Hung K28 A2 Phan Boi Chau     *)
program         chuong_trinh_test_bai1 ;
uses            crt ;
const
     fi         =  'Tien.In' ;
     fo         =  'Tien.Out' ;
     ket_qua    :  array [ 0..9 ] of integer = ( 11 ,
                                                  7 ,
                                                  2 ,
                                                  12 ,
                                                  -1 ,
                                                  10 ,
                                                  6 ,
                                                  -1 ,
                                                  4 ,
                                                  10 );
var
   tra_loi      :       char ;
   f            :       text ;
   i , so_to    :       integer ;
   n ,x,c,m         :       integer ;
   b , a            :       array [1..100 ] of integer ;
   tinh ,to_tinh        :       longint ;

   procedure            readfile ;
   begin
        clrscr ;
        writeln ;
        Writeln ('                   ************** Test Doi Tien ************* ') ;
        Writeln ('                   ********* Le Van Hung K28 A2 PBC ********* ') ;
        write   ('                   ****************  Tien.In');
        tra_loi := readkey ;
        writeln (                                             tra_loi,'  **************' );
        assign ( f,fi+tra_loi );
        reset ( f ) ;
        readln ( f , n , m ) ;
        for i :=1 to n do read ( f , a [ i ] ) ;
        close ( f ) ;
        c:=ord(tra_loi)-48;
        assign ( f , fo ) ;
        reset ( f ) ;
        readln ( f , so_to ) ;
        if (c =4)or(c=7) then
        begin
             if so_to<>-1 then
             begin
                          Writeln ;               WRITELN;WRITELN;
        writeln (     '                        NOT CORRECT !    NOT CORRECT !');
        writeln ;
        writeln ;
        writeln ;
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             writeln ('                           $$$$$$   Diem : 0   $$$$$$');
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             readln ;
             halt;
        end
             else
             begin
                          Writeln ;writeln;writeln;
        writeln (     '                           CORRECT !    CORRECT !');
        writeln ;
        writeln ;
        writeln ;
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             writeln ('                           $$$$$$   Diem : 1   $$$$$$');
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');

        readln ;
        halt;

             end ;
        end ;
        for i :=1 to n do
         read ( f , b [i]);
        close ( f ) ;
   end;

   procedure            test ;
   begin
        tinh :=0 ;
        to_tinh:=0 ;
        for i :=1 to n do
         begin
              tinh := tinh+b[i]*a[i];
              to_tinh :=to_tinh+b[i];
         end ;

        writeln ;
        writeln ;
        writeln;

        if so_to>ket_qua[c] then
        begin

             writeln ('                            Ket qua chua toi uu     ' ) ;
             writeln ('                            Dap an  : ' , ket_qua [ c]) ;
             writeln ('                            Cua ban : ' , so_to );
             writeln ; writeln ; writeln ;
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             writeln ('                           $$$$$$   Diem : 0   $$$$$$');
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             readln;
             halt ;
        end ;
        if so_to<>to_tinh then
        begin
             writeln ('                            Khong dung cach ra ' ) ;
             writeln ('                            Dap An cua ban    : ',so_to ) ;
             writeln ('                            Thuc chat phai la : ',to_tinh );
             writeln ; writeln ; writeln ;
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             writeln ('                           $$$$$$   Diem : 0   $$$$$$');
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             readln;
             halt ;
        end ;
        if tinh<>m then
        begin
             writeln ('                            Tien chua du ' );
             writeln ('                            Ghi la       :',tinh ) ;
             writeln ('                            Tien can doi :',m);
             writeln ; writeln ; writeln ;
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             writeln ('                           $$$$$$   Diem : 0   $$$$$$');
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             readln;
             halt ;
        end ;
        Writeln ;
        writeln (     '                           CORRECT !    CORRECT !');
        writeln ;
        writeln ;
        writeln ;
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');
             writeln ('                           $$$$$$   Diem : 1   $$$$$$');
             writeln ('                           $$$$$$$$$$$$$$$$$$$$$$$$$$ ');

        readln ;
   end ;

begin
     readfile ;
     test ;
end.