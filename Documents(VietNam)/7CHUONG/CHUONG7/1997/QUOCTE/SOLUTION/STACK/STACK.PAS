Uses Crt,StackLib;
Var X,Y,Z,A,B,C:Integer;
    KX,KY,XX,YY,ZZ,MX,MY,MZ:Integer;
    MaxT:Integer;
    Telpa:Array[1..32,1..32,1..32]Of Byte;
    Aug:Array[1..32,1..32]Of Byte;
    Time:Array[1..250]Of Integer;
    Ir:Array[1..250]Of Boolean;
Begin
 XX:=GetX;
 YY:=GetY;
 ZZ:=GetZ;
 For X:=1 To 250 DO Ir[X]:=False;
 C:=GetNextContainer;
 While C<>0 Do
  Begin
   A:=GetNextAction;
   B:=0;
   For X:=1 To XX Do
    For Y:=1 To YY Do B:=B+(ZZ-Aug[X,Y]);
   If(B<ZZ-1)And(A=1)Then RefuseContainer Else
   If A=1 Then
    Begin
     B:=GetNextStorageTime;
     Time[C]:=B;
     Ir[C]:=True;
     MaxT:=-1000;MX:=0;MY:=0;
     For X:=1 To XX Do
      For Y:=1 To YY Do
       If(Aug[X,Y]=0)Or((Time[Telpa[X,Y,Aug[X,Y]]]>MaxT)And(Aug[X,Y]<ZZ))Then
        Begin
         If Aug[X,Y]=0 Then MaxT:=1000 Else
          MaxT:=Time[Telpa[X,Y,Aug[X,Y]]];
         MX:=X;MY:=Y;
        End;
     If MX=0 Then
      Begin
       RefuseContainer;
      End Else
      Begin
       Aug[MX,MY]:=Aug[MX,MY]+1;
       Telpa[MX,MY,Aug[MX,MY]]:=C;
       StoreArrivingContainer(MX,MY);
      End;
    End Else
    BEGIN
     For X:=1 To XX Do
      For Y:=1 To YY Do
       For Z:=1 To ZZ do If Telpa[X,Y,Z]=C Then
        Begin
         MX:=X;MY:=Y;MZ:=Z;
        End;
     While Telpa[MX,MY,Aug[MX,MY]]<>C Do
      Begin
       MaxT:=-1000;KX:=0;KY:=0;
       For X:=1 To XX Do
        For Y:=1 To YY Do
         If(Aug[X,Y]=0)Or(Time[Telpa[X,Y,Aug[X,Y]]]>MaxT)And(Aug[X,Y]<ZZ)Then
          Begin
           If Aug[X,Y]=0 Then MaxT:=1000 Else
            MaxT:=Time[Telpa[X,Y,Aug[X,Y]]];
           KX:=X;KY:=Y;
          End;
       If KX=0 Then
        Begin
         Halt;
        End Else
        Begin
         Aug[KX,Ky]:=Aug[KX,KY]+1;
         Telpa[Kx,KY,Aug[KX,KY]]:=Telpa[Mx,MY,Aug[MX,MY]];
         Telpa[Mx,MY,Aug[MX,MY]]:=0;
         Aug[MX,MY]:=Aug[MX,MY]-1;
         If MoveContainer(MX,MY,KX,KY)=0 Then
          Begin
           Halt;
          End;
        End;
      End;
     RemoveContainer(MX,MY);
     Telpa[MX,MY,Aug[MX,MY]]:=0;
     Aug[MX,MY]:=Aug[Mx,MY]-1;
     Ir[C]:=False;Time[C]:=0;
    END;
   For X:=1 To 250 Do If Ir[X] then Time[X]:=Time[X]-1;
   C:=GetNextContainer;
  End;
End.
