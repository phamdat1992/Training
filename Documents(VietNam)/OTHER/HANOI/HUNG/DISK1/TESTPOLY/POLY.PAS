Program Polygon;
Const Fi='Poly.Inp';
      Fo='Poly.Out';
      Maxn=100;

Type Point=Record
             x,y:Integer;
           End;
     Line=Record
             P1,P2:Point;
          End;
     Pol=Array[0..Maxn] Of Point;

Var Po,Po1,Po2:Pol;
    D1,D2:Point;
    Chenhlech:Real;
    Min:Real;
    L1,l2,N:Integer;
    F1,F2:Text;

Procedure MoFile;
Begin
  Assign(F1,Fi);
  Reset(F1);
  Assign(F2,Fo);
  Rewrite(F2);
End;

Procedure Dongfile;
Begin
  Close(F1);
  Close(F2);
End;

Procedure ReadFile;
Var i:Byte;
Begin
  Readln(F1,N);
  For i:=1 to n Do
      Readln(F1,Po[i].x,Po[i].y);
End;

Procedure Init;
Begin
  Min:=9999999;
End;

Function Dientich(po:Pol;n:Byte):Real;
Var i,j:integer;S:Real;
Begin
    S:=0;
  Po[n+1]:=Po[1]; Po[0]:=Po[n];
  For i:=1 to n Do
     S:=S+((Po[i+1].x-Po[i].x)*(Po[i].y+Po[i+1].y)/2);
  Dientich:=Abs(S);
End;


Procedure Process;
Var i,j,k,tam1,tam2,sd1,sd2:Byte;
Begin

  For i:=1 to n Do
      For j:=i+1 to n Do
         Begin
            D1:=Po[i];
            D2:=Po[j];
            Sd1:=i+1;
            Sd2:=i+1;
            Po1[1]:=D1;Po1[Sd1]:=D2;
            Po2[1]:=Po1[1];Po2[Sd2]:=Po1[Sd1];
            Tam1:=1;Tam2:=1;
            For k:=i-1 Downto 1 Do
               Begin
                  Tam1:=Tam1+1;
                  Po1[Tam1]:=Po[k];
               End;
            For k:=i+1 to n-1 Do
               Begin
                 Tam2:=Tam2+1;
                 Po2[Tam2]:=Po[k];
               End;
            ChenhLech:=Abs(Dientich(Po1,Sd1)-Dientich(Po2,Sd2));
            If Chenhlech<Min Then
                 Begin
                   Min:=Chenhlech;
                   l1:=i;
                   l2:=j
                 End;
         End;
End;

Procedure WriteFile;
Begin
  Writeln(F2,L1,' ',L2);
End;

Begin
  Mofile;
  Readfile;
  Init;
  Process;
  Writefile;
  DongFile;
  End.