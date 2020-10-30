Program Hoa_Tra_My ;
Uses Crt;
Const Fi   = 'CODE.INP' ;
      Fo   = 'CODE.OUT' ;
Type  Xau  = String [100] ;
      Mang = Array [1..1000] Of Char ;
Var
      f,ft  : Text ;
    i,j,l,k : Integer ;
        St  : Mang ;

Procedure Wheeler(A:Mang;k:Integer);
 Procedure QSort(l,r:Integer);
 Var i,j:Integer;
    Mid,Tg:Char;
 Begin
      i:=l;
      j:=r;
      Mid:=A[(i+j) div 2];
      RePeat
            While A[i]<Mid Do Inc(i);
            While A[j]>Mid Do Dec(j);
            If i<=j Then
            Begin
                 Tg:=A[i];
                 A[i]:=A[j];
                 A[j]:=Tg;
                 Inc(i);
                 Dec(j);
            End;
      Until i>j;
      If i<r Then QSort(i,r);
      If l<j Then QSort(l,j);
 End;

Begin
     A:=St;
     QSort(1,l);
     For i:=1 to l do
      Begin
           Write(ft,A[k]);
           St[k]:=#0;
           For j:=2 to l+1 do
           If (St[((j-1) Mod l)+1]=A[k]) Then
           Begin
                k:=((j-1) Mod l)+1;
                Break;
           End;
      End;
     writeln(ft);
end;
Procedure ReadF;
Begin
     Assign(f,Fi);
     Reset(f);
     Assign(ft,Fo);
     ReWrite(ft);
     While Not Eof(f) Do
      Begin
           l:=0;
           While Not Eoln(f) Do
            Begin
                 Inc(l);
                 Read(f,St[l]);
            End;
           Readln(f,k);
           Wheeler(St,k);
      End;
      Close(f);
      Close(ft);
End;

BEGIN
     Readf ;
END.