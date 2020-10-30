{$r+} {$q+}
PROGRAM He_thong_duong_cao_toc ;
Const   Max                    = 751 ;
        Fi                     = 'highway.in0' ;
        Fo                     = 'highway.out' ;

Type    link                   = ^node ;
        node                   = Record
                                   v : integer ;
                                   next : link ;
                                 End ;

Var     Ke                     : Array [0..max] of Link ;
        Px ,Py ,D              : Array [0..max] of real ;
        tr                     : Array [0..max] of integer ;
        Xet                    : Array [0..max] of boolean ;
        N ,M ,op               : integer ;

Procedure Nhap ;
  Var F : Text ;
      i ,x ,y : Integer ;
      t : link ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Readln(F ,N) ;
    For i := 1 to N do Readln(F ,px[i] ,py[i]) ;
    For i := 1 to N do ke[i] := nil ;
    Readln(F ,M) ;
    For i := 1 to M do
      Begin
        Readln(F ,x ,y) ;
        new(t) ;t^.v := x ;t^.next := ke[y] ;ke[y] := t ;
        new(t) ;t^.v := y ;t^.next := ke[x] ;ke[x] := t ;
      End ;
    Close(F) ;
  End ;

Function Kcach(u ,v : Integer) : real ;
  Begin
    Kcach := sqr(px[u]-px[v]) + sqr(py[u]-py[v]) ;
  End ;

var kq : Array [1..max] of Record
                             x ,y : integer ;
                           End ;

Procedure Xuly ;
  Var k ,i ,min : Integer ;
      w      : real ;
      t      : link ;
  Begin
    op := 0 ;
    Fillchar(Xet ,sizeof(Xet) ,false) ;
    Xet[1] := true ;
    Fillchar(tr ,sizeof(tr) ,0) ;
    For i := 2 to N do Begin d[i] := kcach(1,i) ;tr[i] := 1 ;End ;
    t := ke[1] ;
    While t <> nil do
      Begin
        d[t^.v] := 0 ;
        t := t^.next ;
      End ;
    d[1] := 0 ;
    For k := 1 to N-1 do
      Begin
        min := 0 ;
        w := 1e10 ;
        For i := 2 to N do If not xet[i] and (d[i] < w) then
          Begin
            w := d[i] ;min := i ;
          End ;
        xet[min] := true ;
        If d[min] > 0
          then Begin Inc(op) ;kq[op].x := tr[min] ;kq[op].y := min End ;
        For i := 2 to N do If not xet[i] then
          Begin
            w := kcach(min,i) ;
            If w < d[i] then Begin tr[i] := min ;d[i] := w End ;
          End ;
        t := Ke[min] ;
        While t <> nil do
          Begin
            If not xet[t^.v] then Begin tr[t^.v] := min ;d[t^.v] := 0 End ;
            t := t^.next ;
          End ;
      End ;
  End ;

Procedure Inkq ;
  Var F : text ;
      i : Integer ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ;
    Writeln(F ,op) ;
    For i := 1 to op do
      Writeln(F ,kq[i].x,' ',kq[i].y) ;
    Close(F) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  Inkq ;
END .
9
1 5
0 0
3 2
4 5
5 1
0 4
5 2
1 2
5 3
4
1 3
9 7
1 2
2 3