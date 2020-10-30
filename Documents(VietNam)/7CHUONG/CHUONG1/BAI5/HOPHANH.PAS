uses CRT ;

CONST   INPUT  = 'activity.in5';
        OUTPUT = 'ACTIVITY.OUT';

TYPE MANG = ARRAY [ 1 .. 10000 ] OF INTEGER ;

VAR     FI      : TEXT ;
        N , SO  : INTEGER ;
        STT , S , F : ARRAY [ 1 .. 10000 ] OF INTEGER ;
        LUU     : ^ MANG ;
PROCEDURE CHUANBI ;

          BEGIN

               new ( luu ) ;

               fillchar ( luu ^ , sizeof ( luu ^ ) , 0 ) ;
               fillchar ( s ,sizeof ( s ) , 0 ) ;
               fillchar ( f ,sizeof ( f ) , 0 ) ;

               so := 0 ;

          END;

PROCEDURE NHAP ;

          VAR  i : integer ;

          BEGIN
               assign ( fi , input ) ;
               reset ( fi ) ;

               read ( fi , n ) ;
               for i :=1 to n do
                   begin
                        read ( fi , s [ i ] , f [ i ] ) ;
                        stt [ i ] := i ;
                   end ;

               close ( fi ) ;

          END;

PROCEDURE DOICHO ( VAR i , j : integer ) ;

          VAR t : integer ;

          BEGIN
               t := i ;
               i := j ;
               j := t ;
          END;

PROCEDURE QS ( b , e : integer  ) ;

          VAR i , j , x : integer ;

          BEGIN
               x := f [ ( b + e ) div 2 ] ;
               i := b ;
               j := e ;

               repeat
                     while f [ i ] < x do i := i + 1 ;
                     while f [ j ] > x do j := j - 1 ;

                     if i <= j then
                        begin
                             DOICHO ( f [ i ] , f [ j ] ) ;
                             DOICHO ( s [ i ] , s [ j ] ) ;
                             DOICHO ( stt [ i ] , stt [ j ] ) ;
                             i := i + 1 ;
                             j := j - 1 ;
                        end;

               until i > j ;

               if i < e then QS ( i , e ) ;
               if b < j then QS ( b , j ) ;

          END;


PROCEDURE XL ;
   VAR i , td : integer ;
   BEGIN
     QS ( 1 , n ) ;
     td := 0 ;
     i := 1 ;
     while i < n + 1  do
       begin
         while (i<n+1) and (s[i]<td) do i := i + 1 ;
         if i <> n + 1 then
           begin
             so := so + 1 ;
             luu^[so] := stt[i] ;
             td := f [ i ] ;
             i := i + 1 ;
           end;
       end;
   END;

PROCEDURE TRALOI ;

          VAR i : integer ;

          BEGIN
               assign ( fi , output ) ;
               rewrite ( fi ) ;
               writeln ( fi , so ) ;
               for i := 1 to so do writeln ( fi , luu ^ [ i ] ) ;
               close ( fi ) ;
          END;


BEGIN
     CHUANBI ;
     NHAP ;
     XL ;
     TRALOI ;
END.

Stt 3*32000
L   2*32000

6
1 6
1 2
2

