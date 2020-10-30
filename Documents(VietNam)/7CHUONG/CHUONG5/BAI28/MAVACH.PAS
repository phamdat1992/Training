program bai_toan_ma_vach;
uses crt;
const
        fi      =       'MAVACH.INP';
        fo      =       'MAVACH.OUT';
var
        ma_vach :       array[0..30,0..30]of longint;
        vach    :       string ;
        sh,tren :       longint ;
        v       :       array[1..30]of integer ;
        f,g     :       text ;
        n,k,m   :       integer ;

procedure       quy_hoach_dong ;
var
   s            :       longint ;
   i , j  , t   :       integer ;
begin
     fillchar ( ma_vach , sizeof ( ma_vach ) , 0 ) ;
     ma_vach [ 0 , 0 ] := 1 ;
     if n - k + 1 < m then tren := n - k + 1 else tren := m ;
     for i := 1 to k do
      for j := 1 to n do
       begin
            s := 0 ;
            for t := 1 to tren do
             if j - t >= 0 then
              s := s + ma_vach [ j - t , i - 1 ] ;
             ma_vach [ j , i ] := s ;
       end ;
     writeln ( g , ma_vach [ n , k ] ) ;
end;

procedure       tim_so_hieu ;
var
   t , i , j        :       integer ;
   s                :       longint ;
begin
     fillchar ( v , sizeof ( v ) , 0 ) ;
     sh := 0 ;
     t := 1 ;
     vach := vach + '2' ;
     for i := 1 to n do
      begin
           inc ( v [ t ] ) ;
           if vach [ i ] <> vach [ i + 1 ] then inc ( t ) ;
      end ;
     s := 0 ;
     for i := 1 to k do
     begin
          if odd ( i ) then
          begin
               for j := 1 to v [ i ] - 1 do
                if n - j - s >= 0 then sh := sh + ma_vach [ n - j - s , k - i ] ;
          end
          else
          begin
               for j := v [ i ] + 1 to tren do
                if n - s - j >= 0 then sh := sh + ma_vach [ n - s - j , k - i ] ;
          end ;
          s := s + v [ i ] ;
     end ;
     writeln ( g , sh + 1 ) ;
end ;

procedure       readfile;
var
   x    :       integer;
   socap:       integer ;
   i    :       integer ;
begin
     assign( f , fi ) ; reset ( f ) ;
     assign( g , fo ) ; rewrite(g);
     readln(f,n,k,m);
     quy_hoach_dong ;
     readln ( f , socap ) ;
     for i := 1 to socap do
     begin
          readln(f,vach);
          tim_so_hieu;
     end ;
     close(f);
     close(g);
end;

begin
     readfile;
end.