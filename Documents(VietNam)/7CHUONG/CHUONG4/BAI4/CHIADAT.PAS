{$R+}
         {   *****************************************    }
         {        Le Van Hung K28 A2 Phan Boi Chau        }

         {   Chuong trinh bai chia dat trong khu dan cu   }
         {   *****************************************    }

program           chia_vung_dat ;
uses              crt , graph ;
const
     fi           =     'WALL.INP' ;
     fo           =     'WALL.OUT' ;
     midx         =     240 ;
     midy         =     300  ;
     hung         =     2  ;
type
     point        =     record
      x , y       :     integer ;
      e           :     byte ;
     end ;
     lines         =     record
      p1 , p2     :     point ;
     end ;
     mang         =     array [ 1..201 ] of integer ;
var
     luu1 , luu2  :     mang ;
     dem1 , dem2  :     integer ;
     n            :     integer ;
     f            :     text ;
     a            :     array [ 1..201 ] of point ;
     p            :     array [ 1..201 ] of boolean ;
     ok           :     boolean ;
     l1 , l2      :     lines ;
     a2 , b2 , c2 :     integer ;
     gd , gm      :     integer ;

     procedure       readfile ;
     var
        i            :  integer ;
        begin
             assign ( f , fi ) ;
             reset ( f ) ;
             readln ( f , n ) ;
             for i := 1 to n do
              readln ( f , a [ i ] .x , a [ i ] .y , a [ i ] .e ) ;
             close ( f ) ;
        end ;

        function        p_t ( i , j , k :   integer ) : real ;
        begin
             if ( a [ i ] .x = a [ j ] .x ) then
             begin
                  if a [ i ] .x < a [ k ] .x then p_t := -1
                  else if a [ i ] .x > a [ k ] .x then p_t := 1 else
                  if a [ i ] .x = a [ k ] .x then p_t := 0 ;
             end
             else
             if ( a [ i ] .y = a [ j ] .y ) then
             begin
                  if a [ i ] .y < a [ k ] .y then p_t := -1 else if
                  a [ i ] .y > a [ k ] .y then p_t := 1 else
                  if a [ i ] .y = a [ k ] .y then p_t := 0 ;
             end
             else
             p_t := ( a [ i ] .y - a [ j ] .y ) * a [ k ] .x + ( a [ j ].x - a [ i ] .x )
             * a [ k ] .y + a [ i ] .x * a [ j ] .y - a [ i ] .y * a [ j ] .x ;
        end ;

        function           k_t ( e , i , j   :    integer )  :     boolean ;
        var
           i1  , j1        :       integer ;
           t   , p1        :       real ;
           begin
                k_t := false ;
                for i1 := 1 to n - 1 do
                 if ( i1 <> i )and( i1 <> j ) then
                 if a [ i1 ] .e = e then
                 for j1 := i1 + 1 to n do
                  if ( j1 <> j )and( j1 <> i ) then
                  if a [ j1 ] .e = e then
                  begin
                       t := p_t ( i , j , i1 ) ;
                       p1 := p_t ( i , j , j1 ) ;
                       if t * p1 < 0 then exit ;
                  end ;
                k_t := true ;
           end ;

           {  Thu tuc bao loi tung loai diem  }

        Procedure         Bao_Loi ( e : byte ; var luu : mang ; var dem : integer ) ;
        var      ok              :       boolean ;
                 min             :       integer ;
                 dem1 ,l_i       :       integer ;
                 i , j           :       integer ;
                 Begin
                      for i := 1 to n do
                       if a [ i ] .e = e then break ;
                      dem := 1 ;
                      luu [ dem ] := i ;
                      fillchar ( p , sizeof ( p ) , true ) ;
                      p [ i ] := false ;
                      repeat
                            ok := true ;
                            for j := n downto 1 do
                             if a [ j ] .e = e then
                             if p [ j ] and k_t ( e , i , j ) then
                             begin
                                  inc ( dem ) ;
                                  luu [ dem ] := j ;
                                  p [ j ] := false ;
                                  ok := false ;
                                  break ;
                             end ;
                             i := j ;
                      until ok ;
                      luu [ dem + 1 ] := luu [ 1 ] ;
                 end ;

           {  Sap xep tang dan toa do  }

        procedure       sort ;
        var
           i , j        :       integer ;
           t            :       point ;
           begin
                for i := 1 to n - 1 do
                 for j := i + 1 to n do
                  begin
                       if a [ i ] .y > a [ j ] .y then
                       begin
                            t := a [ i ] ; a [ i ] := a [ j ] ; a [ j ] := t ;
                       end ;
                       if a [ i ] .x > a [ j ] .x then
                       begin
                            t := a [ i ] ; a [ i ] := a [ j ] ; a [ j ] := t ;
                       end ;
                  end ;
           end ;

        function             ccw (    p0 , p1 , p2 :   point )  :  shortint ;
        var
              dx1 , dy1 , dx2 , dy2   :    integer ;
              begin
                   dx1 := p1 .x - p0 .x ;              dy1 := p1 .y - p0 .y ;
                   dx2 := p2 .x - p0 .x ;              dy2 := p2 .y - p0 .y ;

                   if dx1 * dy2 > dx2 * dy1 then ccw := 1 ;
                   if dx1 * dy2 < dx2 * dy1 then ccw := -1 ;
                     if dx1 * dy2 = dx2 * dy1 then
                      if ( dx1 * dx2 < 0 ) or ( dy1 * dy2 < 0 )then ccw := -1
                       else
                        if dx1 * dx1 + dy1 * dy1 >= dx2 * dx2 + dy2 * dy2
                         then ccw := 0 else ccw := 1 ;
              end ;

        function          intesect ( l1 , l2 :   lines ) :    boolean ;
        begin
             intesect := ( ccw (l1 .p1 , l1 .p2 , l2 .p1 ) *
             ccw ( l1 .p1 , l1 .p2 , l2 .p2 ) <= 0 ) and ( ccw ( l2 .p1 , l2 .p2 , l1 .p1 ) *
             ccw ( l2 .p1 , l2 .p2 , l1 .p2 ) <= 0 )
        end ;

        {   Kiem tra loi cat nhau   }

        procedure       xuli ;
        var
           i , j         :       integer ;
           begin
                sort ;
                bao_loi ( 0 , luu1 , dem1 ) ;
                bao_loi ( 1 , luu2 , dem2 ) ;
                ok := true ;
                for i := 1 to dem1 do
                 begin
                      l1 .p1 := a [ luu1 [ i ] ] ;
                      l1 .p2 := a [ luu1 [ i + 1 ] ] ;
                      for j := 1 to dem2 do
                       begin
                            l2 .p1 := a [ luu2 [ j ] ] ;
                            l2 .p2 := a [ luu2 [ j + 1 ] ] ;
                            if intesect ( l1 , l2 ) then
                            begin
                                 ok := false ;
                                 exit ;
                            end ;
                       end ;
                 end ;
           end ;

        procedure       draw_point ( a : point )  ;
        begin
             with a do
             begin
                  setcolor ( 10 + e ) ;
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

        procedure       display ;
        var
           i         :       integer ;
           begin
                initgraph ( gd , gm , 'c:\tp\bgi ' ) ;
                setbkcolor ( 4 )  ;
                line ( 0 , 240 , getmaxx , 240 ) ;
                line ( 300 , 0 , 300 , getmaxy ) ;
                for i := 1 to  n do
                 draw_point ( a [ i ] ) ;
                for i := 1 to dem1 - 1 do
                 draw_lines ( a [ luu1 [ i ] ] , a [ luu1 [ i + 1 ] ] , a [ luu1 [ i ] ] . e ) ;
                draw_lines ( a [ luu1 [ dem1 ] ] , a [ luu1 [ 1 ] ] , a [ luu1 [ 1 ] ] . e ) ;
                for i := 1 to dem2 - 1 do
                 draw_lines ( a [ luu2 [ i ] ] , a [ luu2 [ i + 1 ] ] , a [ luu2 [ i ] ] .e ) ;
                draw_lines ( a [ luu2 [ dem2 ] ] , a [ luu2 [ 1 ] ] , a [ luu2 [ 1 ] ] . e ) ;
                readln ;
                closegraph ;
           end ;

        function        pt (  a , b , c  : integer  ; p : point ) :  integer ;
        begin
             pt := a * p .x + b * p .y + c ;
        end ;

        function        thoa_man ( a1 , b1 , c1 : integer ) : boolean ;
        var
           i1   :    integer ;
           begin
                thoa_man := false ;
                for i1 := 1 to n do
                 if pt ( a1 , b1 , c1 , a [ i1 ] ) = 0 then exit ;
                thoa_man := true ;
           end ;

        function        kiemtra ( a1 , b1 , c1 : integer   ) : boolean ;
        var
           t , k          :       longint ;
           i1 , j1        :       integer ;
           begin
                kiemtra := false ;
                for i1 := 1 to dem1 - 1 do
                 for j1 := i1 + 1 to dem1 do
                  begin
                       t := pt ( a1 , b1 , c1 , a [ luu1 [ i1 ] ] ) ;
                       k := pt ( a1 , b1 , c1 , a [ luu1 [ j1 ] ] ) ;
                       if t * k < 0 then exit ;
                  end ;
                for i1 := 1 to dem2 - 1 do
                 for j1 := i1 + 1 to dem2 do
                  begin
                       t := pt ( a1 , b1 , c1 , a [ luu2 [ i1 ] ] ) ;
                       k := pt ( a1 , b1 , c1 , a [ luu2 [ j1 ] ] ) ;
                       if t * k < 0 then exit ;
                  end ;
                for i1 := 1 to dem1 do
                 for j1 := 1 to dem2 do
                  begin
                       t := pt ( a1 , b1 , c1 , a [ luu1 [ i1 ] ] ) ;
                       k := pt ( a1 , b1 , c1 , a [ luu2 [ j1 ] ] ) ;
                       if t * k > 0 then exit ;
                  end ;
                kiemtra := true ;
           end ;

        {  Lay Nghiem phuong trinh duong thang  }

        procedure       process ;
        var
           a1, b1 , c1    :       integer ;
           i , j          :       integer ;
           min1 , min2    :       real ;
           begin
                for i := 1 to dem1 do
                  begin
                       for j := 1 to dem2 do
                        begin
                             a1 := a [ luu2 [ j ] ] .y - a [ luu2 [ j + 1 ] ] .y ;
                             b1 := a [ luu2 [ j + 1 ] ] .x - a [ luu2 [ j ] ] .x ;
                             c1 := - ( a1 * a [ luu1 [ i ] ] .x + b1 * a [ luu1 [ i ] ] .y ) ;
                             if kiemtra ( a1 , b1 , c1 ) then
                             begin
                                  a2 := a1 ;
                                  b2 := b1 ;
                                  c2 := c1 ;
                                  exit ;
                             end ;
                        end ;
                  end ;
                for i := 1 to dem2 do
                  begin
                       for j := 1 to dem1 do
                        begin
                             a1 := a [ luu1 [ j ] ] .y - a [ luu1 [ j + 1 ] ] .y ;
                             b1 := a [ luu1 [ j + 1 ] ] .x - a [ luu1 [ j ] ] .x ;
                             c1 := - ( a1 * a [ luu2 [ i ] ] .x + b1 * a [ luu2 [ i ] ] .y ) ;
                             if kiemtra ( a1 , b1 , c1 ) then
                             begin
                                  a2 := a1 ;
                                  b2 := b1 ;
                                  c2 := c1 ;
                                  exit ;
                             end ;
                        end ;
                  end ;
           end ;

        procedure       writefile ;
        begin
             assign ( f , fo ) ;
             rewrite ( f ) ;
             if ok then
             begin
                  process ;
                  writeln ( f , 1 ) ;
                  writeln ( f , a2 , ' ', b2 ,' ', c2 ) ;
             end
             else
             writeln ( f , 0 ) ;
             close ( f ) ;
        end ;

{  main program }

begin
     clrscr ;
     readfile ;
     xuli ;
     display ;
     writefile ;
end.



6
0 0 0
0 1 0
1 1 0
1 2 1
2 3 1
3 2 1


9
10 10 0
10 15 0
30 12 0
23 13 0
34 14 1
18 28 1
29 20 1
37 22 1
38 26 1
