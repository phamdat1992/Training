{$R +}
          {   ***************************************    }

          {       Le Van Hung K28 A2 Phan Boi Chau       }

          {   ***************************************    }

program         san_hinh_chu_nhat ;
uses            crt , graph ;
const
        fi      =       'SAN.INP' ;
        fo      =       'SAN.OUT' ;
        midx         =     240 ;
        midy         =     300  ;
        hung         =     10  ;
type
        point   =       record
         x , y  :       integer ;
        end ;
        point1  =       record
         x , y  :       real ;
        end ;
var
        f                       :       text ;
        n , dem , vi_tri        :       integer ;
        a                       :       array [ 1 ..401 ] of point ;
        dien_tich               :       real ;
        luu                     :       array [ 1 ..401 ] of integer ;
        p                       :       array [ 1 ..400 ] of boolean ;
        a1 , b1 , c1            :       integer ;
        a2 , b2 , c2            :       integer ;
        tra_my , tra            :       array [ 1 ..4 ] of integer ;
        gd       , gm           :       integer ;
        ket_qua                 :       array [ 1..4 ] of point ;
        ket_qua_tam             :       array [ 1..5 ] of point1 ;
        ok                      :       boolean ;

        procedure       readfile ;
        var
           i    :       integer ;
           begin
                assign ( f , fi ) ;
                reset ( f ) ;
                readln ( f , n ) ;
                for i := 1 to n do
                 readln ( f , a [ i ] .x , a [ i ] .y ) ;
                close ( f ) ;
           end ;

        function        p_t  ( i  ,  j  ,  k :   integer  ) : integer ;
        begin
             if  ( a [ i ] .x = a [ j ] .x ) then
             begin
                  if a [ i ] .x < a [ k ] .x then p_t := -1
                  else if a [ i ] .x > a [ k ] .x then p_t := 1 else
                  if a [ i ] .x = a [ k ] .x then p_t := 0 ;
             end
             else
             if  ( a [ i ] .y = a [ j ] .y ) then
             begin
                  if a [ i ] .y < a [ k ] .y then p_t := -1 else if
                  a [ i ] .y> a [ k ] .y then p_t := 1 else
                  if a [ i ] .y = a [ k ] .y then p_t := 0 ;
             end
             else
             p_t := ( a [ i ] .y - a [ j ] .y ) * a [ k ] .x + ( a [ j ] .x - a [ i ] .x )* a [ k ] .y +
             a [ i ] .x *  a [ j ] .y - a [ i ] .y* a [ j ] .x ;
        end ;

        function           k_t  ( i  ,  j   :    integer  )  :     boolean ;
        var
           i1   ,  j1        :       integer ;
           t    ,  p1        :       longint ;
           begin
                k_t := false ;
                for i1 := 1 to n - 1 do
                 if  ( i1 <> i ) and ( i1 <> j ) then
                 for j1 := i1 + 1 to n do
                  if  ( j1 <> j ) and ( j1 <> i ) then
                  begin
                       t := p_t ( i , j , i1 ) ;
                       p1 := p_t ( i , j , j1 ) ;
                       if t * p1 < 0 then exit ;
                  end ;
                k_t := true ;
           end ;

        Procedure         Bao_Loi ;
        var      ok              :       boolean ;
                 min             :       integer ;
                 dem1 , l_i      :       integer ;
                 i , j           :       integer ;
                 Begin
                      i := 1 ;
                      dem := 1 ;
                      luu [ dem ] := 1 ;
                      fillchar ( p , sizeof ( p ) , true ) ;
                      p [ i ] := false ;
                      repeat
                            ok := true ;
                            for j := n downto 1 do
                             if p [ j ] and k_t ( i , j ) then
                             begin
                                  inc ( dem ) ;
                                  luu [ dem ] := j ;
                                  p [ j ] := false ;
                                  ok := false ;
                                  break ;
                             end ;
                             i := j ;
                      until ok ;
                 end ;

        procedure       sort ;
        var
           i  ,  j        :       integer ;
           t              :       point ;
           begin
                for i := 1 to n - 1 do
                 for j :=i + 1 to n do
                  begin
                       if a [ i ] .y > a [ j ] .y then
                       begin
                            t := a [ i ] ; a [ i ] := a [ j ] ; a [ j ] := t ;
                       end ;
                       if a [ i ] .x > a [ j ] .x then
                       begin
                            t := a [ i ] ;  a [ i ] := a [ j ] ;  a [ j ] := t ;
                       end ;
                  end ;
           end ;

        function        khoang_cach ( a1  ,  b1  ,  c1 : integer ; p  :   point  ): real ;
        begin
             khoang_cach := abs ( a1 * p .x + b1 * p .y + c1 ) / sqrt (sqr ( a1 ) + sqr ( b1 ) ) ;
        end ;

        procedure       xuli  (  i  :  integer  ; var s : real  )  ;
        var
           min  ,  min_tam        :       real ;
           a2 , b2 , c2           :       integer ;
           j , l , t , luu_tam1   :       integer ;
           dem1 , i1 , j1         :       integer ;
           begin
                min := 0.0 ;
                for j := 1 to dem do
                 if khoang_cach ( a1 , b1 , c1 , a [ luu [ j ] ] ) > min then
                 begin
                      min := khoang_cach ( a1 , b1 , c1 , a [ luu [ j ] ] ) ;
                      tra [ 2 ] := j ;
                 end ;
                s := min ;
                min_tam := 0.0 ;
                for i1 := 1 to dem do
                 begin
                      a2 := -b1 ;
                      b2 := a1 ;
                      c2 := - ( a2 * a [ luu [ i1 ] ] .x + b2 * a [ luu [ i1 ] ] .y ) ;
                      for j1 := 1 to dem do
                       if min_tam < khoang_cach ( a2 , b2 , c2 , a [ luu [ j1 ] ] ) then
                       begin
                            min_tam := khoang_cach ( a2 , b2 , c2 , a [ luu [ j1 ] ] ) ;
                            tra [ 3 ] := i1 ;
                            tra [ 4 ] := j1 ;
                       end ;
                 end ;
                s := s * min_tam ;
           end ;

        procedure       process ;
        var
           i , j          :       integer ;
           s              :       real ;
           begin
                for i := 1 to dem do
                 writeln ( a [ luu [ i ] ] .x , ' ' ,  a [ luu [ i ] ] .y , ' '  , luu [ i ] ) ;
                luu [ dem + 1 ] := luu [ 1 ] ;
                dien_tich := 100000000 ;
                for i := 1 to dem do
                 begin
                      a1 := a [ luu [ i ] ] .y - a [ luu [ i + 1 ] ] .y ;
                      b1 := a [ luu [ i + 1 ] ] .x - a [ luu [ i ] ] .x ;
                      c1 := a [ luu [ i ] ] .x * a [ luu [ i + 1 ] ] .y - a [ luu [ i ] ] .y* a [luu [ i +1 ] ] .x ;
                      xuli ( i , s ) ;
                      tra [ 1 ] := i ;
                      if s < dien_tich then
                      begin
                           dien_tich := s ;
                           tra_my := tra ;

                      end ;
                 end ;
           end ;

        { *************************************** }
        {     giai nghiem ra toa do cac dinh      }
        { *************************************** }

        function        nx ( a1  ,  b1  ,  c1  ,  a2  ,  b2  ,  c2  :   integer )   :  real ;
        begin
             nx := ( b1 * c2 - b2 * c1 ) / ( a1 * b2 - a2 * b1 ) ;
        end ;

        function        ny (  a1  ,  b1  ,  c1  ,  a2  ,  b2  ,  c2  :   integer )   :  real ;
        begin
             ny := ( a1 * c2 - c1 * a2 ) / ( a2 * b1 - a1 * b2 ) ;
        end ;

        procedure       draw_point ( a : point )  ;
        begin
             with a do
             begin
                  setcolor ( 11 ) ;
                  circle ( midy + x * hung , midx - y * hung , 3 ) ;
             end ;
        end ;

        procedure       draw_lines ( a , b  : point ; e : integer ) ;
        var
           x1 , x2 , y1 , y2    :       integer ;
           begin
                setcolor ( 13 + e ) ;
                x1 := midy + a . x * hung ;
                x2 := midy + b . x * hung ;
                y1 := midx - a . y * hung ;
                y2 := midx - b . y * hung ;
                line ( x1 , y1 , x2 , y2 ) ;
           end ;

        procedure       draw_lines1 ( a , b  : point ; e : integer ) ;
        var
           x1 , x2 , y1 , y2    :       integer ;
           begin
                setcolor ( 10 + e ) ;
                x1 := midy + a . x  ;
                x2 := midy + b . x  ;
                y1 := midx - a . y  ;
                y2 := midx - b . y  ;
                line ( x1 , y1 , x2 , y2 ) ;
           end ;

        procedure       init_graph ;
        var
           i :  integer ;
           begin
                initgraph ( gd , gm , 'c:\laptrinh\pascal\bgi ' ) ;
                setbkcolor ( 4 )  ;
                line ( 0 , 240 , getmaxx , 240 ) ;
                line ( 300 , 0 , 300 , getmaxy ) ;
                for i := 1 to  n do
                 draw_point ( a [ i ] ) ;
        end ;

        procedure       viet ;
        var
           i  :  integer ;
           begin
                for i := 1 to 21 do
                 writeln ;
                textcolor ( 3 ) ;
                writeln ( '                              Press Enter To Contineu ');
                textcolor ( 14 ) ;
           end ;

        procedure       display ;
        var
           i         :       integer ;
           begin
                textbackground ( 4 ) ;
                textcolor ( 14 ) ;
                clrscr ;
                writeln ;
                writeln ;
                writeln ( '                        Bieu Dien Bao Loi Cua N Diem Do :  ' ) ;
                delay ( 1000 ) ;
                init_graph ;
                for i := 1 to dem - 1 do
                 draw_lines ( a [ luu [ i ] ] , a [ luu [ i + 1 ] ] , 0 ) ;
                draw_lines ( a [ luu [ dem ] ] , a [ luu [ 1 ] ] , 0 ) ;
                viet ;
                readln ;
                closegraph ;
                textbackground ( 4 ) ;
                textcolor ( 14 ) ;
                clrscr ;
                writeln ;
                writeln ;
                writeln ( '                        Bieu Dien Hinh Chu Nhat Do La ' ) ;
                delay ( 1000 ) ;
                init_graph ;
                draw_lines1 ( ket_qua [ 1 ] , ket_qua [ 2 ] , 0 ) ;
                draw_lines1 ( ket_qua [ 2 ] , ket_qua [ 3 ] , 0 ) ;
                draw_lines1 ( ket_qua [ 3 ] , ket_qua [ 4 ] , 0 ) ;
                draw_lines1 ( ket_qua [ 4 ] , ket_qua [ 1 ] , 0 ) ;
                readln ;
                closegraph ;
           end ;

       procedure       writefile ;
        begin
             assign ( f , fo ) ;
             rewrite ( f ) ;
             textbackground ( 4 ) ;
             textcolor ( 14 ) ;
             clrscr ;
             writeln ;
             writeln ( '             Dien tich cua chuong trinh tinh la ' , dien_tich :0 : 2 ) ;
             write   ( '             Toa Do Dinh 1 :   ');
             writeln ( f , dien_tich : 0 : 5 ) ;
             a1 := a [ luu [ tra_my [ 1 ] ] ] .y - a [ luu [ tra_my [ 1 ] + 1 ] ] .y ;
             b1 := a [ luu [ tra_my [ 1 ] + 1 ] ] .x - a [ luu [ tra_my [ 1 ] ] ] .x ;
             c1 := a [ luu [ tra_my [ 1 ] ] ] .x * a [ luu [ tra_my [ 1 ] + 1 ] ] .y
             - a [ luu [ tra_my [ 1 ] ] ] .y * a [ luu [ tra_my [ 1 ] + 1 ] ] .x ;
             a2 := -b1 ;
             b2 := a1 ;
             c2 := - ( a2 * a [ luu [ tra_my [ 3 ] ] ] .x + b2 * a [ luu [ tra_my [ 3 ] ] ] .y ) ;
             ket_qua_tam [ 1 ] .x := nx ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua_tam [ 1 ] .y := ny ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua [ 1 ] .x := trunc ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung )  ;
             ket_qua [ 1 ] .y := trunc ( ny ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung ) ;
             writeln ( f ,  nx ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             writeln ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ): 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             write   ( '             Toa Do Dinh 2 :   ');
             c2 := - ( a2 * a [ luu [ tra_my [ 4 ] ] ] .x + b2 * a [ luu [ tra_my [ 4 ] ] ] .y ) ;
             ket_qua_tam [ 2 ] .x := nx ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua_tam [ 2 ] .y := ny ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua [ 2 ] .x := trunc ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung )  ;
             ket_qua [ 2 ] .y := trunc ( ny ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung ) ;
             writeln ( f , nx ( a1 , b1 , c1 ,  a2 , b2 , c2 ) : 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             writeln ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             write   ( '             Toa Do Dinh 3 :   ');
             c1 := - ( a1 * a [ luu [ tra_my [ 2 ] ] ] .x + b1 * a [ luu [ tra_my [ 2 ] ] ] .y ) ;
             ket_qua_tam [ 3 ] .x := nx ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua_tam [ 3 ] .y := ny ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua [ 3 ] .x := trunc ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung )  ;
             ket_qua [ 3 ] .y := trunc ( ny ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung ) ;
             writeln ( f , nx ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             writeln ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ): 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             write   ( '             Toa Do Dinh 4 :   ');
             c2 := - ( a2 * a [ luu [ tra_my [ 3 ] ] ] .x + b2* a [ luu [ tra_my [ 3 ] ] ] .y ) ;
             ket_qua_tam [ 4 ] .x := nx ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua_tam [ 4 ] .y := ny ( a1 , b1 , c1 , a2 , b2 , c2 ) ;
             ket_qua [ 4 ] .x := trunc ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung )  ;
             ket_qua [ 4 ] .y := trunc ( ny ( a1 , b1 , c1 , a2 , b2 , c2 ) * hung ) ;
             writeln (f , nx ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 ,c2 ):0:5 ) ;
             writeln ( nx ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 , '  ' , ny ( a1 , b1 , c1 , a2 , b2 , c2 ) : 0 : 5 ) ;
             close ( f ) ;
             readln ;
        end ;

{    ******************    }
{        main program      }
{    ******************    }

begin
     clrscr ;
     readfile ;
     sort ;
     bao_loi ;
     process ;
     writefile ;
     display ;
end .


6
0 0
3 2
4 4
5 2
8 0
4  -4


