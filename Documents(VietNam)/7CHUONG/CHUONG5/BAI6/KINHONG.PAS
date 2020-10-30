program         conkinhongdoimau ;
uses            crt ;
const
     fi =       'kinhong.inp' ;
     fo =       'kinhong.out' ;
   function     kt ( a , b , c : longint ) : boolean ;
   begin
        kt := true ;
        if abs ( a - b ) mod 3 = 0 then exit ;
        if abs ( a - c ) mod 3 = 0 then exit ;
        if abs ( b - c ) mod 3 = 0 then exit ;
        kt := false ;
   end ;

   procedure    readfile ;
   var
      f1 , f            :       text ;
      i , n             :       integer ;
      a , b , c         :       longint ;
      begin
           assign ( f , fi ) ; reset ( f ) ;
           readln ( f , n ) ;
           assign ( f1 , fo ) ; rewrite ( f1 ) ;
           for i := 1 to n do
            begin
                 readln ( f , a , b , c ) ;
                 if kt ( a , b , c ) then writeln ( f1 ,'YES') else
                 writeln ( f1 ,'NO');
            end ;
           close ( f ) ;
           close ( f1 ) ;
      end ;
begin
     readfile ;
end .

1
15 23 22