PROGRAM Cu_Ty_cau_ca ;
Const   Fi             = 'b2.inp' ;
        Fo             = 'ca.out' ;

Var     t ,f ,d        : Array [0..27] of longint ;
        max ,tr        : Array [0..27,0..192] of integer ;
        ca             : Array [0..27,0..192] of integer ;
        N ,h ,x        : Longint ;

Procedure Nhap ;
  Var F1 : Text ;
      i : Integer ;
  Begin
    Assign(F1 ,Fi) ;
    Reset(F1) ;
    Readln(F1 ,N ,h) ;h := h*12 ;
    For i := 1 to N-1 do Begin read(F1 ,t[i]) ;t[i] := t[i] div 5 ;End ;
    For i := 1 to N do read(F1 ,f[i]) ;
    For i := 1 to N do read(F1 ,d[i]) ;
    Close(F1) ;
  End ;

Procedure Tinhsoca ;
  Var u ,i ,j ,s : longint ;
  Begin
    For u := 2 to N do
     Begin
      j := h ;
      i := f[u] ;s := 0 ;
      While j > 0 do
        Begin
          Inc(s ,i) ;ca[u,h-j+1] := s ;
          i := i-d[u] ;
          If i < 0 then i := 0 ;
          Dec(j) ;
        End ;
    End ;
  End ;

Function Soca(ho ,tgian : longint) :Longint ;
  Var i ,j ,s : Integer ;
  Begin
    j := tgian ;
    i := f[ho] ;s := 0 ;
    While j > 0 do
      Begin
        Inc(s ,i) ;
        i := i-d[ho] ;
        If i < 0 then i := 0 ;
        Dec(j) ;
      End ;
    soca := s;
  End ;

Function Kc(u : integer) : Integer ;
  Var i ,s : integer ;
  Begin
    s := 0 ;
    For i := 2 to u do Inc(s,t[i-1]) ;
    kc := s ;
  End ;

Procedure Xuly ;
  Var i ,j ,k ,m ,k0 ,t0 ,way : Longint ;
  Begin
    way := 0 ;
    Fillchar(max ,sizeof(max) ,0) ;
    Fillchar(tr ,sizeof(tr) ,0) ;
    For j := 0 to h do Begin max[1,j] := soca(1,j) ;tr[1,j] := j End ;
    Tinhsoca ;
    For i := 2 to N do
     Begin
      inc(way ,t[i-1]) ;
      For j := 0 to h do
        Begin
          m := 0 ;
          For k := j-way downto 0 do
            Begin
              t0 := ca[i,k] ;
              If max[i-1,j-k-t[i-1]] + t0 > m then
                Begin
                  m := max[i-1,j-k-t[i-1]] + t0;
                  max[i,j] := m ;tr[i,j] := k ;
                End ;
            End ;
{          max[i,j] := m ;tr[i,j] := k0 ;}
        End ;
     End ;
    x := 0 ;
    For i := 1 to N do If max[i,h] > max[x,h] then x := i ;
  End ;

Var kq : Array [1..27] of longint ;

Procedure inkq ;
  Var f1 : Text ;
      k ,v ,y ,x0: Longint ;
  Begin
    assign(F1 ,Fo) ;
    rewrite(F1) ;
    v := 0 ;y := h ;x0 := x ;
    While (x > 0) and (y > 0) do
      Begin
       inc(v) ;kq[v] := tr[x,y] ;
       y := y - tr[x,y] - t[x-1] ;
       dec(x) ;
      End ;
    Writeln(F1 ,max[x0,h]) ;
    For k := 1 to x do Write(F1 ,'0 ') ;
    For k := v downto 1 do Write(F1 ,kq[k]*5,' ') ;
    For k := v+1 to N-1 do Write(F1 ,'0 ') ;
    Close(F1) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  inkq ;
END .

4 1
5 10 5
1 3 2 0
1 1 0 0
3 8*2

