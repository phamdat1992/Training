uses crt ;

type
      point = record
         x, y : real ; end ;
      line = record
         p1, p2 : point ; end ;

const
    maxint = 20000 ;

var
    p : array[0..100] of point ;
    p1, p2 : point ;
    l1, l2 : line ;
    n : integer ;

function ccw(p0, p1, p2 : point) : integer ;
 var
     dx1, dx2, dy1, dy2 : real ;

 begin
     dx1 := p1.x - p0.x ;
     dx2 := p2.x - p0.x ;
     dy1 := p1.y - p0.y ;
     dy2 := p2.y - p0.y ;

     if dx1 * dy2 > dx2 * dy1 then ccw := 1 { re trai } ;
     if dx1 * dy2 < dx2 * dy1 then ccw := -1 { re phai } ;
     if dx1 * dy2 = dx2 * dy1 then
        begin
            if (dx1 * dx2 < 0) or (dy1 * dy2 < 0) then
                ccw := - 1 { p2 p0 p1 }
            else
               if (dx1 * dx1 + dy1 * dy1 >= dy2 * dy2 + dx2 * dx2) then
                  ccw := 0     { p0 p2 p1 }
                  else ccw := 1 ;  { p0 p1 p2 }
        end ;
 end ;

{ kiem tra xem 2 doan thang co giao nhau hay khong }

function intersect(l1, l2 : line) : boolean ;
 begin
    intersect := (ccw(l1.p1, l1.p2, l2.p1) * ccw(l1.p1, l1.p2, l2.p2) <= 0)
           and (ccw(l2.p1, l2.p2, l1.p1) * ccw(l2.p1, l2.p2, l1.p2) <= 0) ;
 end ;

{ tim giao diem cua 2 duong thang co dang ax + by = c }
function giao(a1, b1, c1, a2, b2, c2 : real ; var x, y : real) : boolean;
 var
      d, dx, dy : real ;
 begin
      d := a1 * b2 - a2 * b1 ;
      dx := c1 * b2 - c2 * b1 ;
      dy := a1 * c2 - a2 * c1 ;
      if d = 0 then giao := false
      else
          begin
               giao := true ;
               x := dx/d ;
               y := dy/d ;
          end ;
 end ;

{tim phuong trinh duong thang dang ax + by + c = 0
di qua 2 diem x, y cho truoc }

procedure phuongtrinh(p1, p2 : point ; var a, b, c : real) ;
 begin
      a := p2.y - p1.y ;
      b := p1.x - p2.x ;
      c := -(a * p1.x + b * p1.y) ;
 end ;

{goc cua tia p1p2 voi truc hoanh}
function theta(p1, p2 : point) : real ;
 var
     dx, dy, ax, ay, t : real ;

 begin
     dx := p2.x - p1.x ;
     ax := abs(dx) ;
     dy := p2.y - p1.y ;
     ay := abs(dy) ;

     if (dx = 0) and (dy = 0) then t := 0
         else t := dy/(ax + ay) ;

     if dx < 0 then t := 2 - t
      else if dy < 0 then t := 4 + t ;
 end ;

{kiem tra xem 1 diem co nam trong da giac hay khong }
{ viet chua duoc chuan lam ==> review it ! }

function inside(t : point) : boolean ;
 var
    count, i, j : integer ;
    lt, lp : line ;

 begin
    count := 0 ;
    p[0] := p[n] ;
    p[n + 1] := p[1] ;
    lt.p1 := t ;
    lt.p2 := t ;
    lt.p2.x := maxint ;

    j := 0 ;
    for i := 1 to n do
      begin
          lp.p1 := p[i] ;
          lp.p2 := p[i] ;
          if not intersect(lp, lt) then
             begin
                  lp.p2 := p[j] ;
                  j := i ;
                  if intersect(lp, lt) then inc(count) ;
             end ;
      end ;
    insidxe := (count mod 2 = 1) ;
 end ;

procedure sort ;
 begin
 end ;

function grahamscan : integer ;
          var
     i, j, min, M : integer ;
     l : line ; t : point ;

 begin
   min := 1 ;
   for i := 1 to n do if p[i].x < p[min].x  then min := i ;
   for i := 1 to n do if p[i].x = p[min].x then
       if p[i].y > p[min].y then min := i ;
   t := p[1] ; p[1] := p[min] ; p[min] := t ;

   sort ;    { sort theo theta }
   p[n + 1] := p[1] ;
   p[0] := p[n] ;
   m := 3 ;

   for i := 4 to n + 1 do
    begin
         while ccw(p[m - 1], p[m], p[i]) >= 0 do m := m - 1 ;
         m := m + 1 ;
         t := p[i] ; p[i] := p[m] ; p[m] := t ;
    end ;
   grahamscan := m ;
 end ;

begin
end.