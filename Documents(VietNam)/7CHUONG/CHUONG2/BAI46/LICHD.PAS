PROGRAM Lich_uu_tien_dung_han ;
Const   Max                   = 600 ;
        Fi                    = 'lichd.in3' ;
        Fo                    = 'lichd.out' ;

Var     p ,d ,cs              : Array [0..max] of Integer ;
        DD                    : Array [0..max] of Boolean ;
        N                     : Integer ;

Procedure nhap ;
  Var F : text ;
      i : Integer ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Readln(F ,N) ;
    For i := 1 to N do read(F ,p[i]) ;
    For i := 1 to N do read(F ,d[i]) ;
    Close(F) ;
  end ;

Procedure sapxep ;
  Var i ,j ,min ,t : Integer ;
  Begin
    For i := 1 to n-1 do
      Begin
        min := i ;
        For j := i+1 to n do If d[min] > d[j] then min := j ;
        t := d[min] ;d[min] := d[i] ;d[i] := t ;
        t := p[min] ;p[min] := p[i] ;p[i] := t ;
        t := cs[min] ;cs[min] := cs[i] ;cs[i] := t ;
      End;
  End ;

Function tim_max(u : Integer) : Integer ;
  Var i ,m : Integer;
  Begin
    m := 0 ;p[0] := 0 ;
    For i := 1 to u-1 do If DD[i] and (p[i] > p[m]) then m := i;
    tim_max := m ;
  End ;

Procedure Xuly ;
  Var t ,i ,k : Integer ;
  Begin
    For i := 1 to N do cs[i] := i ;
    sapxep ;
    Fillchar(DD ,sizeof(DD) ,False) ;
    t := 0 ;
    For i := 1 to N do If t+p[i] <= d[i] then
      Begin
        DD[i] := true ;
        inc(t ,p[i]) ;
      End else
      Begin
        k := tim_max(i) ;
        If (k <> 0) and (t-p[k]+p[i] <= d[i]) then
          Begin
            DD[k] := false ;
            DD[i] := true ;
            t := t - p[k] + p[i] ;
          end ;
      End ;
  End ;

Procedure Inkq ;
  Var F : text  ;
      i ,s : integer ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ; s := 0 ;
    For i := 1 to N do If DD[i] then Inc(s) ;
    writeln(F ,s) ;
    For i := 1 to N do If DD[i] then Write(F ,cs[i] ,' ') ;
    For i := 1 to N do If not DD[i] then Write(F ,cs[i] ,' ') ;
    Close(F) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  Inkq ;
END .
3
2 2 3
1 3 6
