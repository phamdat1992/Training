(* Le Van Hung *) 
(* Hoa_Tra_My Group *)
program                 bai_phieu_duc_lo;
uses                    crt;
const
     fi                 =       'BL4.In5';
     fo                 =       'BL4.OUT';
var
   a                    :               array [ 1..20 , 1..10 , 1..10 ] of byte ;
   f                    :               text ;
   n , k                :               integer ;
   kt                   :               array [ 1..20 , 1..20 ] of integer ;
   so_lan , best        :               integer ;
   so_o                 :               integer ;
   bd , luu             :               array [ 1..20 ] of byte ;
   tong                 :               array [ 1..21 ] of integer ;
   ok                   :               boolean ;
   time                 :               longint ;
   tong1                :               array [ 0..20 ] of integer ;
   time_save            :               longint absolute 0:$46c ;

   procedure            readfile ;
   var
      i , i1 , j1       :       integer ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           readln ( f, n , k ) ;
           for i := 1 to n do
            for i1 := 1 to k do
             for  j1 := 1 to k do
              read ( f , a [ i , i1 , j1 ] );
           close ( f ) ;
      end ;

   procedure            init ;
   var
      i , j1 ,i1        :       integer ;
      begin
           fillchar ( kt , sizeof ( kt ) , 0 ) ;
           time := time_save ;
           for i := 1 to n do
            for i1 := 1 to k do
             for j1 := 1 to k do
              if a [ i , i1 , j1 ] = 1 then kt [ i1 , j1 ] := 1 ;
           ok := true ;
           for i1 := 1 to k do
            for j1 := 1 to k do
             if kt [ i1 , j1 ] = 0 then
             begin
                  ok := false ;
                  break ;
             end ;
           fillchar ( kt , sizeof ( kt ) , 0 ) ;
           fillchar ( bd , sizeof ( bd ) , 0 ) ;
           fillchar ( tong , sizeof ( tong ) , 0 ) ;
           tong [ n + 1 ] := 0 ;
           for i := n downto 1 do
            begin
                 for i1 := 1 to k do
                  for j1 := 1 to k do
                   if a [ i , i1 , j1 ] = 1 then  inc ( tong [ i ] ) ;
                   tong [ i ] := tong [ i + 1 ] + tong [ i ] ;
            end ;
           best := 20 ;
           so_lan := 0 ;
           so_o := 0 ;
      end ;

   procedure            writefile ;
   var
      i         :       integer ;
      begin
           assign ( f , fo ) ;
           rewrite ( f ) ;
           if ok then
           begin
                writeln ( f , best ) ;
                for i := 1 to n do
                 write ( f , luu [ i ] , ' ' ) ;
           end
           else writeln ( f , -1 ) ;
           close ( f ) ;
           writeln ((time_save-time )/18.21 :0 :4 );
      end ;

   procedure            xuat ;
   begin
        if so_o = k * k then
        if so_lan < best then
         begin
              best := so_lan ;
              luu := bd ;
              ok := true ;
              if time_save-time > 8*18.21 then
              begin
                   writefile ;
                   halt ;
              end ;
         end ;
   end ;

   procedure            xoay ( i  :  integer  ) ;
   var
      i1 , j1          :    integer ;
      begin
           case bd [ i ] of
           1 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                   begin
                        if kt [ j1 , k + 1 - i1 ] = 0 then inc ( so_o ) ;
                        inc ( kt [ j1 , k + 1 - i1 ] ) ;
                   end;
           end ;
           2 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                  begin
                       if kt [ k + 1 - i1 , k + 1 - j1 ] = 0 then inc ( so_o ) ;
                       inc ( kt [ k + 1 - i1 , k + 1 - j1 ] ) ;
                  end ;
           end ;
           3 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                  begin
                       if kt [ k + 1 - j1 , i1 ] = 0 then inc ( so_o ) ;
                       inc ( kt [ k + 1 - j1 , i1 ] ) ;
                  end ;
           end ;
           0 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                  begin
                       if kt [ i1 , j1 ] = 0 then inc ( so_o ) ;
                       inc ( kt [ i1 , j1 ] ) ;
                  end ;
           end ;
           end ; (* end case *)
      end ;

   procedure            thao_ra ( i  :  integer  ) ;
   var
      i1 , j1   :       integer ;
      begin
           case bd [ i ] of
           1 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                   begin
                        dec ( kt [ j1 , k + 1 - i1 ] ) ;
                        if kt [ j1 , k + 1 - i1 ] = 0 then dec ( so_o ) ;
                   end;
           end ;
           2 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                  begin
                       dec ( kt [ k + 1 - i1 , k + 1 - j1 ] ) ;
                       if kt [ k + 1 - i1 , k + 1 - j1 ] = 0 then dec ( so_o ) ;
                  end ;
           end ;
           3 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                  begin
                       dec ( kt [ k + 1 - j1 , i1 ] ) ;
                       if kt [ k + 1 - j1 , i1 ] = 0 then dec ( so_o ) ;
                  end ;
           end ;
           0 :
           begin
                for i1 := 1 to k do
                 for j1 := 1 to k do
                  if a [ i , i1 , j1 ] = 1 then
                  begin
                       dec ( kt [ i1 , j1 ] ) ;
                       if kt [ i1 , j1 ] = 0 then dec ( so_o ) ;
                  end ;
           end ;
           end ; (* end case *)
      end ;

   procedure            try ( i :  integer ) ;
   var
      j :   byte ;
      begin
           if so_lan >= best then exit ;
           if so_o + tong [ i ] < k * k then exit ;
           if i > n then
           begin
                xuat ;
                exit ;
           end ;
           for j := 0 to 3 do
            begin
                 bd [ i ] := j ;
                 if bd [ i ] > 0 then inc ( so_lan ) ;
                 xoay ( i ) ;
                 try ( i + 1 ) ;
                 thao_ra ( i ) ;
                 if bd [ i ] > 0 then dec ( so_lan ) ;
            end;
      end;


BEGIN
     readfile ;
     init ;
     if not ok then
     try ( 1 ) ;
     writefile ;
END .
5 3
1 0 0 0 1 0 0 0 0
0 1 0 1 0 0 0 0 0
1 0 0 0 1 0 0 0 1
0 1 0 0 0 0 1 0 0
1 0 0 1 0 0 0 0 0
