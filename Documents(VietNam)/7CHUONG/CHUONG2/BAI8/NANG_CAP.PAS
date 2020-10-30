{  ********************************************************* }
{           Le Van Hung K28 A2 Phan Boi Chau Nghe An         }
{               Nang Cap Duong : Nguyen Xuan My              }
{  ********************************************************* }

{$R+}
program         nang_cap_duong ;
uses            crt ;
const
     fi         =       'NC.I5' ;
     fo         =       'NC.OUT' ;
     max        =       2000 ;
type
    link        =       ^node ;
    node        =       record
     x          :       integer ;
     next       :       link ;
    end ;
    noi         =       record
     x , y      :       integer ;
    end ;
var
   kt           :       array [ 1..max ] of boolean ;
   ketnoi       :       array [ 1..max + 1 ] of noi ;
   q            :       array [ 1..max ] of integer ;
   a            :       array [ 1..max ] of link ;
   f            :       text ;
   n , luui     :       integer ;
   bac_dinh     :       integer ;

   procedure            add ( i , j  :  integer ) ;
   var
      l :       link ;
      begin
           new ( l ) ;
           l^.x := j ;
           l^.next := a [ i ] ;
           a [ i ] := l ;
      end ;

   procedure            readfile ;
   var
      i , x     :       integer ;
      dem       :       integer ;
      begin
           assign ( f , fi ) ;
           reset ( f ) ;
           for i := 1 to max do a [ i ] := nil ;
           n := 0 ;
           bac_dinh := 0;
           while not seekeof ( f ) do
            begin
                 inc ( n ) ;
                 dem := 0 ;
                 while not seekeoln ( f ) do
                  begin
                       read ( f , x ) ;
                       inc ( dem ) ;
                       add ( n , x ) ;
                  end ;
                 if dem > bac_dinh then
                  begin
                       bac_dinh := dem ;
                       luui := n ;
                  end ;
            end ;
           close ( f ) ;
      end ;

   function             bac ( i :  integer )  : integer ;
   var
      l         :       link ;
      dem       :       integer ;
      begin
           l := a [ i ] ;
           dem := 0 ;
           while l <> nil do
            begin
                 if kt [ l^.x ] then inc ( dem ) ;
                 l := l^.next ;
            end ;
           bac := dem ;
      end ;

   procedure            xuli ;
   var
      dem , i , u , luu_next    :       integer ;
      t , so_dd , luu_noi       :       integer ;
      l1                        :       link ;
      ok                        :       boolean ;
      begin
           fillchar ( kt , sizeof ( kt ) , true ) ;
           q [ 1 ] := luui ;
           kt [ luui ] := false ;
           dem := 1 ;
           repeat
                 so_dd := 0 ;
                 ok := true ;
                 for i := 1 to dem do
                  begin
                       t := bac ( q [ i ] ) ;
                       if t > so_dd then
                       begin
                            luu_noi := q [ i ] ;
                            so_dd := t ;
                       end ;
                  end ;
                 if so_dd > 0 then
                 begin
                      ok := false ;
                      l1 := a [ luu_noi ] ;
                      while l1 <> nil do
                       begin
                            if kt [ l1^.x ] then
                            begin
                                 inc ( dem ) ;
                                 kt [ l1^.x ] := false ;
                                 q [ dem ] := l1^.x ;
                                 ketnoi [ dem ].x := luu_noi ;
                                 ketnoi [ dem ].y := l1^.x ;
                            end ;
                            l1 := l1^.next ;
                       end ;
                 end ;
           until ok ;
      end ;

   procedure            writefile ;
   var
      i , dem :  integer ;
      bac_d   :  array [ 1..2000 ] of integer ;
      begin
           dem := 0 ;
           fillchar ( bac_d , sizeof ( bac_d ) , 0 ) ;
           for i := 2 to n do
            begin
                 inc ( bac_d [ ketnoi [ i ].x ] ) ;
                 inc ( bac_d [ ketnoi [ i ].y ] ) ;
            end ;
           for i := 1 to n do
            if bac_d [ i ] = 1 then inc ( dem ) ;
           assign ( f , fo ) ;
           rewrite ( f ) ;
           writeln ( f , dem ) ;
           for i := 2 to n do
            writeln ( f , ketnoi [ i ] .x , ' ' , ketnoi [ i ].y ) ;
           close ( f ) ;
      end ;


BEGIN
     readfile ;
     xuli ;
     writefile ;
END .




