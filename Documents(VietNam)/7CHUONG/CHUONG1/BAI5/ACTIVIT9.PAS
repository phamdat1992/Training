{$q+}{$r+}
PROGRAM Bo_tri_phong_hop ;
Const   Max              = 32001 ;
        Fi               = 'activity.in5' ;
        Fo               = 'activity.out' ;

Type    ArrI             = Array [0..max] of Integer ;
        ArrB             = Array [0..max] of byte ;

Var     csa              : ^ArrB ;
        csb ,update      : ^ArrI ;
        L                : ArrI ;
        N ,op            : Longint ;

Procedure Khoi_tao ;
  Begin
    New(csa) ;New(csb) ;New(update) ;
    Fillchar(csa^ ,sizeof(csa^) ,0) ;
    Fillchar(csb^ ,sizeof(csb^) ,0) ;
    Fillchar(update^ ,sizeof(update^) ,0) ;
    Fillchar(L ,sizeof(L) ,0) ;
  End ;

Procedure Nhap ;
  Var F : text ;
      i ,x ,y : Longint ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Readln(F ,N) ;
    For i := 1 to N do
      Begin
        Readln(F ,x ,y) ;
        If x > L[y] then
          Begin L[y] := x ;csa^[y] := i div max ;csb^[y] := i mod max End
      End ;
    Close(F) ;
  End ;

Procedure Xuly ;
  Var i ,t : Longint ;
  Begin
    t := 1 ;op := 0 ;
    For i := 1 to max do If L[i] >= t then
      Begin
        Inc(op) ;update^[op] := i ;
        t := i ;
      End ;
  End ;

Procedure Inkq ;
  Var F : Text ;
      j, i ,u ,x ,y : Longint ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ;
    Writeln(F ,op) ;
    For i := 1 to op do
      Begin
        u := 0 ;
        {For j := 1 to csa^[update^[i]] do u := u + max ;
        u := u + csb^[update^[i]] ;}
        x := csa^[update^[i]] ;y := csb^[update^[i]] ;
        u := x*max+y ;
        writeln(F ,u) ;
      End ;
    Close(F) ;
  End ;

BEGIN
  Khoi_tao ;
  Nhap ;
  Xuly ;
  Inkq ;
END .

5
1 4
2 4
4 6
3 5
7 9