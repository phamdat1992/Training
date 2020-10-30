{   **********************************************    }
{      Le Van Hung K28 A2 Phan Boi Chau Nghe An       }
{          Bai Xep Hinh - Nguyen To Thanh             }
{   **********************************************    }

{ $R+}
program                 tro_choi_xep_hinh ;
uses                    crt ;
const
     fi         =       'XEPHINH.INP' ;
     fo         =       'XEPHINH.OUT' ;
type
    arr         =       array [ 1..10000 ] of boolean ;
    arr1        =       array [ 1..10000 ] of integer ;
    arr2        =       array [ 1..100 , 1..100 ] of integer ;
var
   ngoai        :       arr1 ;
   trong        :       array [ 1..100 , 1..100 ] of integer ;
   luu          :       ^ arr2 ;
   dd           :       ^ arr ;
   f            :       text ;
   n , m        :       integer ;

   procedure            readfile ;
   var
      i , j     :       integer ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , m , n ) ;
           for i := 1 to n * m do read ( f , ngoai [ i ] ) ;
           for i := 1 to m do
            for j := 1 to n do
             read ( f , trong [ i , j ] ) ;
           close ( f ) ;
      end ;

   function             doi ( i1 , j1 : byte ) : string ;
   var
      s : string ;
      x : integer ;
      begin
           s := '' ;
           x := ( i1 shr ( ( j1 - 1 ) * 2 ) ) and 3 ;
           str ( x  , s ) ;
           doi := s ;
      end ;

   function             so_buoc ( i , j    :  byte ) :  byte ;
   var
      s1 , s2 , s3         :       string ;
      tinh , dem           :       integer ;
      i1                   :       integer ;
      begin
           tinh := 5 ;
           s1 := '' ;
           s2 := '' ;
           for i1 := 1 to 4 do s1 := s1 + doi ( i , i1 );
           for i1 := 1 to 4 do s2 := s2 + doi ( j , i1 );
           dem := 0 ;
           repeat
                 if s1 = s2 then
                 begin
                      so_buoc := dem ;
                      exit ;
                 end ;
                 s3 := s1 ;
                 delete ( s1 , 4 , 1 ) ;
                 s1 := s3 [ 4 ] + s1 ;
                 inc ( dem ) ;
           until dem >= 4 ;
           so_buoc := tinh ;
      end ;

   procedure            viet ;
   begin
        assign ( f , fo ) ; rewrite ( f ) ;
        writeln ( f , -1 ) ;
        close ( f ) ;
   end ;

   procedure            xuli ;
   var
      i , j , i1 , j1 , nho , min  :  integer ;
      begin
           fillchar ( dd ^ , sizeof ( dd ^ ) , true ) ;
           assign ( f , fo ) ;
           rewrite ( f ) ;
           for i := 1 to m do
            begin
                 for j := 1 to n do
                  begin
                       min := 5 ;
                       for i1 := 1 to n * m do
                        if dd ^ [ i1 ] then
                         begin
                              j1 := so_buoc ( trong [ i ,j ] , ngoai [ i1 ] ) ;
                              if j1 <> 5 then
                               if j1 < min then
                                begin
                                     min := j1 ;
                                     nho := i1 ;
                                end ;
                         end ;
                       if min = 5 then
                       begin
                            writeln ( trong [ i , j ] );
                            close ( f ) ;
                            viet ;
                            halt ;
                       end ;
                       write ( f , nho ,' ' ) ;
                       luu ^ [ i , j ] := min ;
                       dd ^ [ nho ] := false ;
                  end ;
                 writeln ( f ) ;
            end ;
           for i := 1 to m do
            begin
                 for j := 1 to n do
                  write ( f , luu ^ [ i , j ] , ' ' ) ;
                 writeln ( f ) ;
            end ;
           close ( f ) ;
      end ;

BEGIN
     clrscr ;
     new ( dd ) ;
     new ( luu ) ;
     readfile ;
     xuli ;
     dispose ( luu ) ;
     dispose ( dd ) ;
END .

2 3
183 237 183 108 27 198
198 123 108
237 222 177
