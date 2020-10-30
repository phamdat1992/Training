program         test_vat_can ;
uses            crt , graph ;
const
     fi  :string       =       'obstacle.in' ;
     fo         =       'obstacle.out' ;
     rate  = 5 ;
type
    point= record x ,y : real ;end;

var
   n , m                   :       integer ;
   f                    :       text ;
   grDriver, grMode     :       integer;
   a         :          array [ 0..200 ] of point ;
   min,min1:real;
   x:char ;
   procedure            init ;
   begin
        grDriver := Detect;
        initgraph(grDriver, grMode,'c:\laptrinh\pascal\bgi');
        if GraphResult <> GrOk then
        begin
             writeln('error');
             halt;
        end;
   end ;

   procedure            ve ( x , y , z : real ; color : longint ;style : integer  ) ;
   var ver : array [ 1..5]of point ;
       i , j : integer ;
       p : point ;
   begin
        p . x := 0 ;
        p . y := 0 ;
        ver [ 1 ] . x := x ;ver [1 ] . y := y ;
        ver [ 2 ]. x := x ; ver [ 2 ]. y := y + z ;
        ver [ 3 ] . x := x + z ; ver [ 3 ] . y := y + z ;
        ver [ 4 ] . x := x + z ; ver [ 4] . y := y ;
        ver [ 5 ]:=ver [1 ];

             for i := 1 to 4 do p.x := p.x + ver[i].x;
             for i := 1 to 4 do p.y := p.y + ver[i].y;
             p.x := p.x/4;
             p.y := p.y/4;
             setcolor(15);
             for i := 1 to 4 do
                 line ( round (ver[i].x),   round(ver[i].y),
                        round (ver[i+1].x), round(ver[i+1].y));
             setfillstyle( style, color);
             floodfill (round(p.x), round(p.y), 15);
   end ;
   function     kc ( p1 , p2 : point ) : real ;
   begin
        kc := sqrt ( sqr ( p1 .x-p2.x ) + sqr ( p1.y-p2.y));
   end ;


   procedure            readfile ;
   var
      x , y , z : integer ;
      i : integer ;

      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , n ) ;
           ve ( 0 , 0 , 400 , 14 , 0 ) ;
           for i := 1 to n do
            begin
                 readln ( f , x , y , z ) ;
                 ve ( x * 4, y* 4 , z* 4 , 13 , 1 ) ;
            end ;
           readln ;
           close ( f ) ;
           assign ( f ,fo ) ;
           reset ( f ) ;
           readln ( f , min ) ;
           readln ( f , m ) ;
           for i := 1 to m do
            begin
                 readln ( f , a [ i ] . x , a[ i ] . y ) ;
                 a [ i ] .x:= a[i].x*4;
                 a[i].y := a [ i ] . y *4;
            end ;
           close ( f );
      a [ 0 ] .  x := 0 ;a[ 0 ] . y := 0 ;
     a [ m + 1 ] . x := 400 ; a[m+1].y:=400;
     setcolor(11);
     min1:=0;
     for i := 0 to m do
      begin
           line ( round(a[ i ].x), round(a [i].y),round(a[i+1].x),round(a[i+1].y));
           min1:=min1+kc(a[i],a[i+1]);
      end;
      readln;
      closegraph ;
   end ;


begin
     clrscr ;
     writeln ( '              CHUONG TRINH CHAM BAI : VUOT CHUONG NGAI VAT     ');
     writeln ( '       *******************************************************    ');
     WRITE ('                  INPUT    :       OBSTACLE.IN' );
     x := readkey ;
     writeln ( x ) ;
     delay(400);
     fi:=fi+x ;

     init ;
     readfile ;
     clrscr ;
     writeln ( '          Ket Qua Cua Chuong Trinh Nhu Sau : ' ) ;
     writeln ;
     writeln ( '          Tong Quang Duong Di   :    '  , min : 0 : 3 ) ;
     writeln ( '          Tong Quang Duong Tinh :    '  ,min1 /4: 0 : 3 ) ;
     min1 := (min1 / 4 ) * 1000 ;
     min := min * 1000 ;
     WRITELN;
     WRITELN ;
     WRITELN ;
     if round ( min1 )=round(min) then
     begin
          WRITELN ('             ************************* ' ) ;
          writeln ('             CORRECT !!!   CORRECT !!!' );
          WRITELN ('             ************************* ' ) ;
          WRITELN ; WRITELN ; WRITELN ; writeln ; writeln ; writeln ;
          writeln ('                      ******************************* ' ) ;
          writeln ('                             Ban Duoc : 1 Diem ' ) ;
          writeln ('                      ******************************* ' ) ;
     end
     else
     begin
          writeln ('            NO SOLUTION ??  NO SOLUTION ?? ');
          writeln ('     **************************************** ' ) ;
          writeln ('                 Ban Duoc : 0 Diem ' ) ;
          writeln ('     **************************************** ' ) ;

     end ;
     readln ;
end.
