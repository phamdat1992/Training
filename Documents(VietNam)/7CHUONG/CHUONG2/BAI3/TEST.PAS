(* Le VAn HUng *)
program         Hoa_Tra_My ;
uses            crt ;
Const
     fi =       'Deg.In' ;
     fo =       'Deg.Out' ;
var
   a : array [1..100,1..100 ]of integer ;
    n ,i , j : integer ;
   f : text ;
   dem , x,  y : integer ;
   dd : array [1..100]of integer ;

   function bac ( i : integer ) : integer ;
   var
      j , t : integer ;
      begin
           t := 0 ;
           for j := 1 to n do
            if a [ i , j ] >0 then inc (t ) ;
           bac := t ;
      end ;
var c : char ;
   begin
        clrscr ;
        writeln ;
        writeln ('   Chuong trinh cham bai tao do thi ');
        writeln (' ************************************');
        write ('       Du lieu vao:  Deg.In');
        c:=readkey ;
        writeln ( c ) ;
        assign ( f, fi+c) ;
        reset ( f ) ; readln ( f , n ) ;
        for i := 1 to n do read ( f ,dd[i] ) ;
        close ( f ) ;
        assign ( f , fo) ;
        reset ( f ) ;
        for i := 1 to n do
         for j :=1 to n do read ( f ,a[i,j]);
        close ( f ) ;
        for i := 1 to n do
         if bac ( i)<> dd[i] then
         begin
              writeln ;
              writeln ;
              writeln ( '             Not Correct ! Not Correct ! ') ;
              writeln ;
              writeln ;
              writeln ('              ******************** ' );
              writeln ( '                    Diem : 0'     );
              writeln ('              ******************** ' );
              readln ;
              halt ;
         end ;
        writeln ;
        writeln ;
        writeln ( '             Correct ! Correct ! ') ;
        writeln ;
        writeln ;
        writeln ('              ******************** ' );
        writeln ( '                    Diem : 1'     );
        writeln ('              ******************** ' );
        readln ;


   end .