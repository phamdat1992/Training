{$M 65000,0,655360}{$R+}
             (* ********************************** *)

             (*  Le Van Hung K28 A2 Phan Boi Chau  *)

             (* ********************************** *)

program                 ban_bi;
uses crt ;
const
     fi         =       'bi.inp' ;
     fo         =       'bi.out' ;
type
    ds          =       array [ 0..18000 ] of word ;
    ds1         =       array [ 18001..36000 ] of word ;
    mc          =       array [ 1..15 ] of byte ;
var
   bang                 :       array [ 1..30 , 1..30 ] of byte ;
   trong                :       array [ 1..30 ] of byte ;
   tt , can             :       mc ;
   d , c , s , scuoi    :       word ;
   svc , dich , n       :       byte ;
   i , j                :       byte ;
   dem                  :       longint ;
   dong , cot , so      :       byte ;
   db                   :       array [ 1..1000 ] of byte ;
   truoc1 , q           :       ^ds ;
   q1 , truoc2          :       ^ds1 ;
   found                :       boolean ;
   truoc                :       array [ 0..34000 ] of byte  ;
   f                    :       text ;
   time                 :       longint ;
   time_save            :       longint absolute 0:$46c ;

   procedure            nhap ;
   var
      k :       byte ;
      begin
           fillchar ( bang , sizeof ( bang ) , 0 ) ;
           fillchar ( trong , sizeof ( trong ) , 0 ) ;
           time := time_save ;
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f, n ) ;
           svc := 0 ;
           for i := 1 to n do
            begin
                 for j := 1 to n do
                  begin
                       read ( f , k ) ;
                       if k > 0 then
                       begin
                            inc ( svc ) ;
                            trong [ i ] := 1 ;
                            bang [ i , j ] := svc ;
                            tt [ svc ] := k-1 ;
                       end ;
                  end ;
                 readln ( f ) ;
            end ;
           readln ( f , dich ) ;
           close ( f ) ;
      end ;

   function             sh ( can    :  mc ) : word ;
   var
      tam       :       word ;
      t         :       byte ;
      begin
           tam := can [ 1 ] ;
           for t := 2 to svc do
            tam := tam * 2 + can [ t ] ;
           sh := tam ;
      end ;

   procedure            bd ( s : word ; var can : mc ) ;
   var
      y         :       byte ;
      begin
           fillchar ( can , sizeof (can ) , 0 ) ;
           y := svc ;
           while s > 0 do
            begin
                 can [ y ] := s mod 2 ;
                 s := s div 2 ;
                 dec ( y ) ;
            end ;
      end ;

   procedure               trai ;        forward ;

   procedure               phai ;        forward ;

   procedure               len ;
   begin
        dec ( dong ) ;
        if dong = 0 then
         begin
              if truoc [ sh ( can ) ] = 0 then
              begin
                   truoc [ sh ( can ) ] := i ;
                   if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                   else truoc2^ [ sh ( can ) ] := s ;
                   inc ( c ) ;
                   if c <= 18000 then q^ [ c ] := sh ( can )
                   else q1^ [ c ] := sh( can ) ;
              end ;
              exit ;
         end
         else
         begin
              while ( dong >= 1 ) and ( bang [ dong , cot ] = 0 ) do dec ( dong ) ;
              if dong = 0 then
              begin
                   if truoc [ sh ( can ) ] = 0 then
                   begin
                        truoc [ sh ( can ) ] := i ;
                        if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                        else truoc2^ [ sh ( can ) ] := s ;
                        inc ( c ) ;
                        if  c <= 18000 then q^ [ c ] := sh ( can )
                        else q1^ [ c ] := sh ( can ) ;
                   end ;
                   exit ;
              end ;
              so := bang [ dong , cot ] ;
              if can [ so ] = 0 then
              begin
                   can [ so ] := 1 ;
                   trai ;
              end
              else
              begin
                   can [ so ] := 0 ;
                   phai ;
              end ;
         end ;
   end ;

   procedure            xuong ;
   begin
        inc ( dong ) ;
        if dong>n then
        begin
             if truoc [ sh ( can ) ] = 0  then
             begin
                  truoc [ sh ( can ) ] := i ;
                  if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                  else truoc2^ [ sh ( can ) ] := s ;
                  inc ( c ) ;
                  if c <= 18000 then q^ [ c ] := sh ( can )
                  else q1^ [ c ] := sh ( can ) ;
             end ;
             exit ;
        end
        else
        begin
             while ( dong <= n ) and ( bang [ dong , cot ] = 0 ) do inc ( dong ) ;
             if dong > n then
             begin
                  if truoc [ sh ( can ) ] = 0 then
                  begin
                       truoc [ sh ( can ) ] := i ;
                       if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                       else truoc2^ [ sh ( can ) ] := s ;
                       inc ( c ) ;
                       if c <= 18000 then q^ [ c ] := sh ( can )
                       else q1^ [ c ] := sh ( can ) ;
                  end ;
                  exit ;
             end ;
             so := bang [ dong , cot ] ;
             if can [ so ] = 0 then
             begin
                  can [ so ] := 1 ;
                  phai ;
             end
             else
             begin
                  can [ so ] := 0 ;
                  trai ;
             end ;
        end ;
   end ;

   procedure            trai ;
   begin
        dec ( cot ) ;
        if cot = 0 then
        begin
             if truoc [ sh ( can ) ] = 0 then
             begin
                  truoc [ sh ( can ) ] := i ;
                  if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                  else truoc2^ [ sh ( can ) ] := s ;
                  inc ( c ) ;
                  if c <= 18000 then q^ [ c ] := sh ( can )
                  else q1^ [ c ] := sh ( can ) ;
             end ;
             exit ;
        end
        else
        begin
             while ( cot >= 1 ) and ( bang [ dong , cot ] = 0 ) do dec ( cot ) ;
             if cot = 0 then
             begin
                  if truoc [ sh ( can ) ] = 0 then
                  begin
                       truoc [ sh ( can ) ] := i ;
                       if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                       else truoc2^ [ sh ( can ) ] := s ;
                       inc ( c ) ;
                       if c <= 18000 then q^ [ c ] := sh ( can )
                       else q1^ [ c ] := sh ( can ) ;
                  end ;
                  exit ;
             end ;
             so := bang [ dong , cot ] ;
             if can [ so ] = 0 then
             begin
                  can [ so ] := 1 ;
                  xuong ;
             end
             else
             begin
                  can [ so ] := 0 ;
                  len ;
             end ;
        end ;
   end ;

   procedure            phai ;
   begin
        inc ( cot ) ;
        if cot > n then
        begin
             if truoc [ sh ( can ) ] = 0 then
             begin
                  truoc [ sh ( can ) ] := i ;
                  if sh( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                  else truoc2^ [ sh ( can ) ] := s ;
                  if dong = dich then
                  begin
                       scuoi := sh ( can ) ;
                       found := true ;
                       exit ;
                  end ;
                  inc ( c ) ;
                  if c <= 18000 then q^ [ c ] := sh ( can )
                  else q1^ [ c ] := sh ( can ) ;
             end ;
             exit ;
        end
        else
        begin
             while ( cot <= n ) and ( bang [ dong , cot ] = 0 ) do inc ( cot ) ;
             if cot > n then
             begin
                  if truoc [ sh ( can ) ] = 0 then
                  begin
                       truoc [ sh ( can ) ] := i ;
                       if sh ( can ) <= 18000 then truoc1^ [ sh ( can ) ] := s
                       else truoc2^ [ sh ( can ) ] := s ;
                       if dong = dich then
                       begin
                            scuoi := sh ( can ) ;
                            found := true ;
                            exit ;
                       end ;
                       inc ( c ) ;
                       if c <= 18000 then q^ [ c ] := sh ( can )
                       else q1^ [ c ] := sh ( can ) ;
                  end ;
                  exit ;
             end ;
             so := bang [ dong , cot ] ;
             if can [ so ] = 0 then
             begin
                  can [ so ] := 1 ;
                  len ;
             end
             else
             begin
                  can [ so ] := 0 ;
                  xuong ;
             end ;
        end ;
   end ;

   procedure            ban ;
   begin
        cot := 1 ;
        dong := i ;
        while ( cot <= n ) and ( bang [ dong , cot ] = 0 ) do inc ( cot ) ;
        so := bang [ dong , cot ] ;
        if can [ so ] = 1 then
        begin
             can [ so ] := 0 ;
             xuong ;
        end
        else
        begin
             can [ so ] := 1 ;
             len ;
        end ;
   end ;

   procedure            bfs ;
   begin
        fillchar ( truoc , sizeof ( truoc ) , 0 ) ;
        fillchar ( truoc1^ , sizeof ( truoc1^ ) , 0 ) ;
        fillchar ( truoc2^ , sizeof ( truoc2^ ) , 0 ) ;
        d := 1 ;
        c := 1 ;
        q^ [ d ] := sh ( tt ) ;
        truoc [ sh ( tt ) ] := 1 ;
        truoc1^ [ sh ( tt ) ] := q^ [ d ] ;
        found := false ;
        while ( d <= c ) and not ( found ) do
         begin
              if d <= 18000 then s := q^ [ d ] else s := q1^ [ d ] ;
              inc ( d ) ;
              for i := 1 to n do
               if trong [ i ] = 1 then
               begin
                    bd ( s , can ) ;
                    ban ;
                    if found then exit ;
               end ;
         end ;
   end ;

   procedure            viet ;
   var
      sb , vc   :       word ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           if found then
           begin
                writeln ( f , 1 ) ;
                sb := 0 ;
                vc := scuoi ;
                while vc <> sh ( tt ) do
                 begin
                      inc ( sb ) ;
                      db [ sb ] := truoc [ vc ] ;
                      if vc <= 18000 then vc := truoc1^ [ vc ]
                      else vc := truoc2^ [ vc ] ;
                 end ;
                writeln ( f , sb ) ;
                for i := sb downto 1 do writeln ( f , db [ i ] ) ;
           end
           else writeln ( f , 0 ) ;
           close ( f ) ;
      end ;

   procedure            dem_gio ;
   begin
       textcolor ( 3 ) ;
       writeln ( '     **********************************' ) ;
       textcolor ( 12 ) ;
       writeln ( '             Time load = ' , ( time_save - time ) /18.21 : 0 :4 ) ;
       textcolor ( 3 ) ;
       writeln ( '     **********************************' ) ;
       textcolor ( 12 ) ;
       writeln ;
       writeln ( '            Writeln by Le Van Hung ');
       writeln ; textcolor ( 3 ) ;
       writeln ( '            Press enter to quit ! ');
       readln ;
   end;

BEGIN
     clrscr ;
     new ( truoc1 ) ;
     new( q ) ;
     new( truoc2 ) ;
     new( q1 ) ;

     nhap ;
     if trong [ dich ] = 0 then
     begin
          assign ( f , fo ) ;
          rewrite ( f ) ;
          writeln ( f , 1 ) ;
          writeln ( f , 1 ) ;
          writeln ( f , dich ) ;
          close ( f ) ;
          dispose ( truoc1 ) ;
          dispose ( q ) ;
          dispose ( truoc2 ) ;
          dispose ( q1 ) ;
          dem_gio ;
          halt ;
     end ;
     bfs ;
     viet ;
     dispose ( truoc1 ) ;
     dispose ( q ) ;
     dispose ( truoc2 ) ;
     dispose ( q1 ) ;
     dem_gio ;
END.
