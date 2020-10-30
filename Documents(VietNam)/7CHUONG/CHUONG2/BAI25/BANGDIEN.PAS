        (* *************************** *)
        (*      Bai toan Bang Dien     *)
        (*    Le van Hung K28 A2 PBC   *)
        (* *************************** *)

program         Hoa_Tra_my ;
uses            crt ;
const
     fi         =       'ELE.INP' ;
     fo         =       'ELE.OUT' ;
     M          =       15 * 15 + 2 ; (* cong them 2 dinh gia *)
type
    arr         =       array [ 1..M , 1..M ] of byte ;
var
   a            :       arr ;
   b            :       ^ arr ;
   n            :       integer ;
   find         :       boolean ;
   e , p        :       array [ 1..M ] of integer ;
   c            :       array [ 1..15 , 1..15 ] of byte ;

   procedure    readfile ;
   var
      f         :       Text ;
      i , j     :       integer ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f , n ) ;
           for i := 1 to n do
              for j := 1 to n do
               read ( f , c [ i , j ] ) ;
           close ( f ) ;
      end ;

   procedure    khoi_tao ;
   var
      i , j         :       integer ;
      f             :       text ;
      i1 , j1       :       integer ;
      begin
           fillchar ( a , sizeof ( a ) , 0 ) ;
           for i1 := 2 to n - 1 do
            for j1 :=  2 to n - 1 do
            begin
                 i := (i1-1)*n+j1 ;
                 a [ i , i - 1] :=1 ;
                 a [ i , i +1 ]:=1 ;
                 a [ i ,i-n]:=1 ;
                 a [ i , i + n ] := 1 ;
            end ;
           (* loai tru bien bang cach *)
(*           for i := 1 to n do
            begin
                 if c [ i , 1 ] = 1 then
                 begin
                      if i > 1 then a [ ( i - 1 ) * n + 1 , ( i - 2 )* n +1 ]:= 0;
                      if i < n then a [ ( i - 1 ) * n + 1 , i * n + 1 ] := 0 ;
                      a [ ( i - 1 ) * n + 1 , ( i - 1 ) * n ] := 0 ;
                 end ;
                 if c [ 1 , i ] = 1 then
                 begin
                      if i > 1 then a [ i , i - 1 ] := 0 ;
                      if i < n then a [ i , i + 1 ] := 0 ;
                      a [ i ,i + n ] := 0 ;
                 end ;
                 if ( c [ n , i ] = 1 ) then
                 begin
                      if i > 1 then a [ ( n - 1 ) * n + i , ( n -1 )* n + i - 1 ] := 0 ;
                      if i < n then a [ ( n - 1 ) * n + i , ( n -1 ) * n + i + 1 ] := 0 ;
                      a [ ( n -1 ) * n + i ,( n -2 ) * n + i] := 0 ;
                 end ;
                 if c [ i , n ] = 1 then
                 begin
                      if i > 1 then a [ i * n , ( i - 1 ) * n ] := 0;
                      if i < n then a [ i * n , ( i + 1 ) * n ] := 0 ;
                      a [ i * n , i * n - 1 ] := 0 ;
                 end ;
            end ;
            *)
           for i := 2 to n - 1 do
               for j := 2 to n - 1 do
                if c [ i , j ] = 1 then
                 a [ n*n+1,(i-1)*n+j]:= 1 ;
           for i := 1 to n do
            begin
                 if c [ 1 , i ] = 0 then a [ i , n*n+2 ] := 1 ;
                 if c [ i , 1 ] = 0 then a [ ( i - 1 ) * n + 1 , n*n+2]:=1 ;
                 if c [ n , i ] = 0 then a [ ( n - 1 ) + i , n*n+2]:=1 ;
                 if c [ i , n ] = 0 then a [ i * n , n*n+2]:=1 ;
            end ;
      end ;

   function     min ( a , b : integer ) : integer ;
   begin
        if a < b then min := a else min := b ;
   end ;

   procedure    find_path ;
   var
      dau , cuoi , i , j   :       integer ;
      q                    :       array [ 1..M ]of integer ;
      begin
           find := true ;
           for i := 1 to n*n+2 do
           begin
                e [ i ] := maxint ;
                p [ i ] := 0 ;
           end ;
           p [ n*n+1]:=n*n+1 ;
           dau := 1 ;
           cuoi := 1 ;
           q [ 1 ] := n * n + 1 ;
           while dau <= cuoi do
            begin
                 i := q [ dau ] ;
                 inc ( dau ) ;
                 for j := 1 to n*n+2 do
                  if p [ j ] = 0 then
                   begin
                        if ( a [ i , j ] > b ^ [ i , j ] ) and (a [ i , j ] >0 ) then
                        begin
                             inc ( cuoi ) ;
                             q [ cuoi ] := j ;
                             e [ j ] := min ( e [ i ] , a [ i , j ] - b ^ [ i ,j ] ) ;
                             p [ j ] := i ;
                             if j = n*n+2 then exit ;
                        end ;
                        if ( a [ j , i ] > 0 ) and ( b ^ [ j , i ] > 0 ) then
                        begin
                             inc ( cuoi ) ;
                             q [ cuoi ] := j ;
                             e [ j ] := min ( e [ i ]  , b ^ [ j , i ] ) ;
                             p [ j ] := - i ;
                             if j = n*n+2 then exit ;
                        end ;
                   end ;
            end ;
           find := false ;
      end ;

   procedure    inc_flow ;
   var
      i , j , t         :       integer ;
      begin
           i := n*n+2 ;
           j := p [ i ] ;
           t := e [ i ] ;
           while i <> n*n+1 do
            begin
                 if j > 0 then inc ( b ^ [ j , i ] , t )
                 else
                 begin
                      j := - j ;
                      dec ( b^ [ i , j ] , t ) ;
                 end ;
                 i := j ;
                 j := p [ i ] ;
            end ;
      end ;

   procedure            main ;(*  thuat toan luong cuc dai *)
   var
      stop      :       boolean ;
      begin
           fillchar ( b^ , sizeof ( b^ ) , 0 ) ;
           stop := false;
           repeat
                 find_path ;
                 if find then inc_flow else stop := true ;
           until stop ;
      end ;

   procedure            writefile ;
   var
      f                 :       text ;
      i , j , count     :       integer ;
      x , y             :       integer ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           count := 0 ;
           for i := 1 to n*n+2 do
            if b^ [ n*n+1 ,i ] > 0 then inc ( count ) ;
            writeln ( f , count ) ;
            for i := 1 to n*n do
            if b^ [ n*n+1,i ] > 0 then
            begin
                 write ( f , i ,' ') ;
                 x := i ;
                 while x < n*n + 2 do
                  begin
                       if ( x div n = 0 ) or ( x mod n = 1 ) or ( x mod n = 0 ) or ( x div n = n - 1 ) then break ;
                       if ( x + n < n*n + 2 ) and ( b^ [ x ,x+n]>0) then
                       begin
                            write ( f ,'S');
                            x:=x+n ;
                       end
                       else
                       if ( x + 1 <n*n+2 ) and(b^[x,x+1]>0) then
                       begin
                            write( f ,'E') ;
                            x:=x+1 ;
                       end
                       else
                       if ( x -1 > 0 ) and ( b ^ [ x,x-1]>0 ) then
                       begin
                            write ( f ,'W') ;
                            x:=x-1 ;
                       end
                       else
                       if ( x-n > 0 )and ( b^[x,x-n]>0)then
                       begin
                            write ( f ,'N');
                            x:=x-n ;
                       end ;
                       if x =n*n+2 then break ;
                  end ;
                  writeln ( f ) ;
            end ;

           close ( f ) ;
      end ;

BEGIN
     new ( b ) ;

     readfile ;
     khoi_tao ;
     main ;
     writefile ;

     dispose ( b ) ;
END.

6
0 0 0 1 1 1
0 0 0 0 0 0
0 0 0 1 1 1
0 0 0 0 0 0
0 0 1 1 1 1
0 0 0 1 0 1




