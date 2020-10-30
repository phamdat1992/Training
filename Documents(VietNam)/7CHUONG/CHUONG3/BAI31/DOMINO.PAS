   { Le Van Hung K28 A2 Phan Boi Chau }
   { Problem : Domino - Bai 125 Trong Sach Bai Tap Lap Trinh PasCal Tac Gia
   Bui The Tam }
   { Finish :22-11-2001 }

Program All_For_You;
Uses Crt;
Const
     Fi='C:\Data\Hung\Lungtung\HocTap\Duyet\Domino.Inp';
     Fo='C:\Data\Hung\Lungtung\HocTap\Duyet\Domino.Out';
     M=7;
     N=8;
     Hang:Array[1..2]Of Shortint=(0,1);
     Cot:Array[1..2]Of Shortint=(1,0);
Var
   A,B:Array[1..M,1..N]Of Integer;
   Luu:Array[0..66]Of Byte;
   KiemTra:Array[0..66]Of Boolean;
   I,J,Dem:Integer;
   F:Text;

Procedure ReadFile;
 Begin
      Assign(F,Fi);
      Reset(F);
      For I:=1 To M Do
       For J:=1 To N Do
        Read(F,A[I,J]);
      Close(F);
 End;

Procedure Xuli;
 Var Dem:Integer;
 Begin
      Dem:=0;
      Fillchar(Luu,Sizeof(Luu),0);
      For I:=0 To 6 Do
       For J:=I To 6 Do
        Begin
             Inc(Dem);
             Luu[I*10+J]:=Dem;
             Luu[J*10+I]:=Dem;
        End;
      Fillchar(Kiemtra,Sizeof(Kiemtra),True);
      For I:=1 To M Do
       For J:=1 To N Do
        B[I,J]:=-1;
      Dem:=0;
 End;

Procedure WriteRa;
 Var I,J:Byte;
 Begin
      For I:=1 To M Do
       Begin
            For J:=1 To N Do
            Begin
                 If B[I,J] Div 10 =0 Then Write(F,'0',B[I,J],' ')
                 Else
                 Write(F,B[I,J],' ');
            End;
            Writeln(F);
       End;
      Writeln(F);
 End;

Procedure Try(I,J:Integer);
 Var K,U1,U2:Byte;
 Begin
      If B[I,J]=-1 Then
      Begin
           For K:=1 To 2 Do
            If(I+Hang[K]<=M)And(J+Cot[K]<N+1)And(B[I+Hang[K],Cot[K]+J]=-1)Then
            Begin
                 U1:=A[I,J]*10+A[I+Hang[K],J+Cot[K]];
                 U2:=10*A[I+Hang[K],J+Cot[K]]+A[I,J];
                 If KiemTra[U1] Or Kiemtra[U2] Then
                 Begin
                      Inc(Dem);
                      B[I,J]:=Luu[U1];
                      B[I+Hang[K],J+Cot[K]]:=Luu[U1];
                      Kiemtra[U1]:=False;
                      Kiemtra[U2]:=False;
                      If (J=8)And(I<7)Then Try(I+1,1)
                      Else
                      If ((I=7)And(J=8))Or(Dem=28) Then WriteRa
                      Else Try(I,J+1);
                      Dec(Dem);
                      B[I,J]:=-1;
                      B[I+Hang[K],J+Cot[K]]:=-1;
                      Kiemtra[U1]:=True;
                      Kiemtra[U2]:=True;
                 End;
           End;
       End
       Else
       Begin
            If (I=7)And(J=8) Then WriteRa Else
            If (J=8)And(I<7) Then Try(I+1,1) Else Try(I,J+1);
       End;
 End;

Procedure WriteFile;
 Begin
      Assign(F,Fo);
      ReWrite(F);
      Try(1,1);
      Close(F);
 End;

Begin
     ReadFile;
     Xuli;
     WriteFile;
End.
4 2 5 2 6 3 5 4
5 0 4 3 1 4 1 1
1 2 3 0 2 2 2 2
1 4 0 1 3 5 6 5
4 0 6 0 3 6 6 5
4 0 1 6 4 0 3 0
6 5 3 6 2 1 5 3



