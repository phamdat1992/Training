{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

program         Dem_sodiemnamtrongdagiac ;
uses            crt ;
const
     fi =       'dempoint.inp' ;
     fo =       'dempoint.out' ;
type
    point       =       record
                x , y   :     integer ;
    end ;
    lines       =       record
                a , b , c :  longint ;
    end ;
var
   s            : real ;
   a            :       array [ 1..101 ] of point ;
   so_diem , s1 : longint ;
   n            : integer ;

Procedure       Readfile ;
var
   f : text ;
   i : integer ;
   begin
        assign ( f , fi ) ; reset ( f ) ;
        readln ( f , n ) ;
        for i := 1 to n do
         readln ( f , a [ i ] . x , a [ i ] . y ) ;
        a[ n + 1 ] := a [ 1 ] ;
        close ( f ) ;
   end ;

procedure       init ;
var
   i , j        :       integer ;

   begin
        s := 0 ;
        for i := 1 to n do
         s := s + ( a [ i + 1 ] . x - a [ i ] . x ) * ( a[ i ].y + a [ i + 1 ].y ) / 2 ;
        s := abs ( s ) ;
        s1:=trunc(s*2);
   end ;

Procedure 	Xac_DinhABC( P , Q : Point ; var A , B , C : Longint ) ;
Begin
		A := P.y-Q.y ;
		B := Q.x-P.x ;
		C := -(A*P.x+B*P.y ) ;
End ;

Function    dem_hang ( p , q  : point ) : longint ;
       begin
            dem_hang := abs(q.y-p.y)+1;
       end ;

Function  dem_cot ( p , q : point ) : integer ;
    begin
         dem_cot := abs ( q.x-p.x) +1;
    end ;

Function	Count_point ( P, Q: Point) : Integer ;
	Var
		L : Lines ;
		Count , i : Integer ;
		Begin
                        if p.y=q.y then count_point := dem_cot(p,q)
                        else
                        if p.x=q.x then count_point:=dem_hang (p,q)
                        else
                        begin
			     With L do
			     Xac_DinhABC( P,Q,a , b, c ) ;
			     Count := 0 ;
			     If P.x>Q.x then
                             Begin
                                  Count_Point :=Count_Point ( Q , P ) ;
                                  Exit ;
			     End ;
			     For i :=P.x to Q.x do
			     If (L.a*i+L.c) Mod L.b = 0 then Inc ( Count ) ;
			     Count_Point:=Count ;
                        end ;
		End ;

Procedure 	Main_Count ;
Var
		So_Diem , i : Integer ;
                inpoint     : longint ;
                f           : text ;
Begin
	So_Diem:=0 ;
	For i := 1 to n do  Inc ( So_Diem, Count_Point ( A[i],A[i+1]) ) ;
	So_Diem := So_Diem - N ;(* nam tren bien *)
        inpoint := (s1+2-so_diem ) div 2;
        clrscr ;
        textcolor ( 11 ) ;
        writeln ('   So diem nguyen nam trong da giac da cho la '  ) ;
        textcolor ( 15 ) ;
        writeln ( '           ',inpoint ) ;
        assign ( f , fo ) ; rewrite ( f ) ; writeln ( f , inpoint ) ; close ( f ) ;
        readln ;

End ;

begin
     readfile ;
     init ;
     main_count ;
end.

