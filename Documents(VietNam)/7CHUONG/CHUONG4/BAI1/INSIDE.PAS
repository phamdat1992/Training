{$N+}
program		Inside ;
uses    crt ;
const
     fi =       'inside.inp' ;
     fo =       'inside.out' ;
     Hoa_Tra_My : longint = 62831853 ;(* tinh = 2 * pi * 10000000 *)
type
    point       =       record
                x , y   :     integer ;
    end ;
var
   a    :       array [ 1..101 ] of point ;
   n    :       integer ;
   M    :       point ;
   Hung , HTM   :     point ;

procedure       readfile ;
var
   f    :       text ;
   i    :       integer ;
   begin
        assign ( f , fi ) ; reset ( f ) ;
        readln ( f , n ) ;
        for i := 1 to n do readln ( f,a[i].x,a[i].y);
        Readln ( f , M.x,M.y);
        close ( f ) ;
   end ;

procedure       chieu_dong_ho ;
var
   s    :       real ;
   i    :       integer ;
   b    :       array[1..101]of point ;
   begin
        a[n+1]:=a[1];
        s:=0 ;
        for i := 1 to n do
         s:=s+(a[i+1].x-a[i].x)*(a[i].y+a[i+1].y)/2 ;
        if s<0 then
        begin
             for i:=1 to n do
              b[i]:=a[n+1-i] ;
             for i:=1 to n do
             a[i]:=b[i];
        end ;
   end ;

Procedure 	Xac_DinhABC( P , Q : Point ; var A , B , C : Longint ) ;
Begin
		A := P.y-Q.y ;
		B := Q.x-P.x ;
		C := -(A*P.x+B*P.y ) ;
End ;

function        ptrinhdthang ( p ,q , t : point ) : longint ;
var
   a , b , c : longint ;
   begin
        xac_dinhABC ( p, q ,a,b,c);
        ptrinhdthang :=t.x*a+t.y*b+c ;
   end ;

Function	thuoc_doan ( P ,C,B: Point ) : Boolean ;
		Var
			a1 , b1 , c1 : longint ;
			t 	 : Longint  ;
			Begin
				xac_dinhABC ( C, B ,a1,b1,c1) ;
				thuoc_doan:=false ;
				t := a1 * P.x + b1*P.y + c1 ;
				if t<>0 then exit ;
				if ( (P.x-C.x)*(P.x-B.x)>0 ) or ((P.y-C.y)*(P.y-B.y)>0)then
				Exit ;
				thuoc_doan:=True ;
			End ;

Function        kiemtrabien : boolean ;
                var
                   j : byte ;
                   begin
	                kiemtrabien:=true;
	                for j:=1 to n do
	                 if thuoc_doan ( M , a[j] , A[j+1]) then exit ;
                        kiemtrabien:=false;
                   end;

Function        goc ( p , q : point ) : double ;
                var
                   k1 , k2 , k3 , t : real ;
                   begin
                        If ptrinhdthang ( p , q , m )  = 0 then
                        begin
                             If thuoc_doan ( M , P , Q ) then goc := 0
                             else
                             goc := pi ;
                             exit ;
                        end ;
		        k1 := sqr ( p.x - q.x ) + sqr ( p.y - q.y ) ;
		        k2 := sqr ( p.x - M.x ) + sqr ( p.y - M.y ) ;
		        k3 := sqr ( q.x - M.x ) + sqr ( q.y - M.y ) ;
                        if k1 = k2 + k3 then goc := pi/2 else
                        begin
		             t:=(K2+k3-k1)/(2*sqrt(k2)*sqrt(k3));
		             t:=sqrt(1/sqr(t)-1);
                             if k1>k2+k3 then
                             goc:=(pi-arctan(t)) else
		             goc:=arctan(t);
                        end ;
                   end;

Function       giatrigoc ( p , q : point ) : double ;
               var
                  t : point ;
                  begin
                       if  (Q.y=P.y) then
		       begin
                            if P.x<Q.x then
		            begin
                                 if M.y>=Q.y then giatrigoc:=-goc(p,q)
                                 else
                                 if M.y<Q.y then Giatrigoc:=goc(p,q)
                            end
                            else
                            if P.x>Q.x then
                            giatrigoc:=-giatrigoc(q,p);
                       end
                       else
		       if (Q.y<P.y ) then
		       begin
			    t.x:=p.x;
			    t.y:=q.y;
			    if P.x=Q.x then
			    begin
                                 if M.x>=P.x then giatrigoc:=-goc(p,q)
			         else
			         if M.x<Q.x then giatrigoc:=goc(p,q)
			         else  giatrigoc:=0
                            end
			    else
			    if P.x<Q.x then
			    begin
			         t.x:=P.x;
				 t.y:=Q.y;
				 if  ptrinhdthang(p,q,t)*ptrinhdthang(p,q,m)>0 then
				 giatrigoc:=goc(p,q)
				 else
				 if ptrinhdthang(p,q,t)*ptrinhdthang(p,q,m)<0 then
				 giatrigoc:=-goc(p,q)
				 else
				 giatrigoc:=0;
			    end
			    else
			    begin
			         if ptrinhdthang(p,q,t)*ptrinhdthang(p,q,m)>0 then
				 giatrigoc:=-goc(p,q)
				 else
				 if ptrinhdthang(p,q,t)*ptrinhdthang(p,q,m)<0 then
				 giatrigoc:=goc(p,q)
				 else giatrigoc:=0;
			    end;
		       end;
		       if P.y<Q.y then
		       giatrigoc:=-giatrigoc(q,p);
                  end;

procedure         xuli ;
                  var
                  k : double ;
                  t : double ;
                  i : integer ;
                  f : text ;
	          Begin
                       assign ( f , fo ) ; rewrite ( f ) ;
                       clrscr ;
                       a[n+1]:=a[1];
		       if kiemtrabien then writeln(f , ' diem do nam tren bien da giac')
		       else
		       begin
                            k:=0;
			    for i:=1 to n do
                                  k := k + giatrigoc(a[i],a[i+1]);
                            (* Tinh pi xap xi ma thoi *)
			    if  trunc(k*10000000)=Hoa_Tra_My then
                            writeln(f , ' diem nay nam trong da giac ')
			    else writeln(f ,' diem nay nam ngoai da giac');
		       end;
                       close ( f ) ;
                  end;

begin
     readfile ;
     chieu_dong_ho ;
     xuli ;
end.

4
0 0
2 0
2 2
0 2
1 1


