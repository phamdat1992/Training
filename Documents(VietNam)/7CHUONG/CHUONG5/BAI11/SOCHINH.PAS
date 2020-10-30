program hoa_tra_my ;
uses    crt ;
const
     fi =       'sochinh.inp' ;
     fo =       'sochinh.out' ;
var
   i , n , dem , x , y : longint ;

   procedure    readfile ;
   var
      f , f1 : text ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           n := 1 ;
           readln ( f , x ) ;
           dem := 1 ;
           while not eof ( f ) do
            begin
                 readln ( f , y ) ;
                 inc ( n ) ;
                 if y <> x then
                 begin
                      dec ( dem ) ;
                      if dem = 0 then
                      begin
                           x := y ;
                           dem := 1 ;
                      end ;
                 end
                 else inc ( dem ) ;
            end ;
           close ( f ) ;
           assign ( f1 ,fo ) ;
           rewrite ( f1 ) ;
           if dem > 0 then
           begin
                assign ( f , fi ) ;
                dem := 0 ;
                reset ( f ) ;
                for i := 1 to n do
                 begin
                      readln ( f , y ) ;
                      if y = x then inc ( dem ) ;
                 end ;
                close ( f ) ;
                if dem > n/2 then
                begin
                     writeln ( f1 ,'YES') ;
                     writeln ( f1 , x ) ;
                end
                else writeln ( f1 ,'NO');
           end
           else writeln ( f1 ,'NO');
           close ( f1 ) ;
      end ;

begin
     readfile ;
end.

3
2
3
4
2
3
4
3
3
