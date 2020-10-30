  { Le Van Hung K28 A2 Phan Boi Chau }
  { Problem : Bai BusWay - Thay Hai (14-11-2001)}

Program All_For_You;
Uses Crt;
Const
     Fi='bus8.';
     Fo='busway.out';
Var
   D:Array[1..255]Of Longint;
   Tr:Array[1..255]Of Integer;
   Luu:Array[1..255]Of Integer;
   N,I,J,K:Integer;
   F:Text;
   S:Array[1..50]Of String[100];
   Dau,Cuoi:Array[1..10000]Of Integer;
   SLuu:Array[1..10000]Of Char;


Procedure InPut;
 Var X,Y:Char;
 Begin
      Assign(F,Fi);
      Reset(F);
      Readln(F,N);
      For I:=1 To N Do
       Readln(F,S[I]);
      Readln(F,K);
      For I:=1 To K Do
       Begin
            Readln(F,X,Y);
            Dau[I]:=Ord(X);
            Cuoi[I]:=Ord(Y);
       End;
      Close(F);
 End;

Procedure Xuli(S1,T:Integer);
 Var K,I,J,Dem,L,H,ChiSo1,ChiSo2:Integer;
     ChiSo:Byte;
     H_o_a:Integer;
     Ok,Kt:Boolean;
 Begin
      For I:=1 To 255 Do
       D[I]:=MaxLongint;
      D[S1]:=0;
      For I:=1 To N Do
       Begin
            Ok:=False;
            For J:=1 To Length(S[I]) Do
             If Ord(S[I][J])=S1 Then
             Begin
                  Ok:=True;
                  H_o_a:=J;
                  Break;
             End;
            If Ok Then
            For J:=1 To Length(S[I]) Do
             Begin
                  D[Ord(S[I][J])]:=10*Abs(J-H_o_a);
                  Tr[Ord(S[I][J])]:=I;
                  Luu[Ord(S[I][J])]:=S1;
             End;
       End;
      Luu[S1]:=0;
      Repeat
            Ok:=True;
            For I:=1 To 255 Do
             If D[I]<>MaxLongInt Then
             Begin
                  For J:=1 To N Do
                  Begin
                       Kt:=False;
                       For K:=1 To Length(S[J]) Do
                        If Ord(S[J][K])=I Then
                        Begin
                             Kt:=True;
                             H_o_a:=K;
                             Break;
                        End;
                       If Kt Then
                       For K:=1 To Length(S[J]) Do
                        If D[Ord(S[J][K])]>D[I]+1001+10*Abs(K-H_o_a) Then
                        Begin
                             D[Ord(S[J][K])]:=D[I]+1001+10*Abs(K-H_o_a);
                             Tr[Ord(S[J][K])]:=J;
                             Luu[Ord(S[J][K])]:=I;
                             Ok:=False;
                        End;
                  End;
             End;
      Until Ok;
      If D[T]=MAxLongint Then
      Writeln(F,0)
      Else
      Begin
           I:=0;
           J:=T;
           Dem:=0;
           Repeat
                 For H:=1 To Length(S[Tr[J]]) Do
                  If Ord(S[Tr[J]][H])=Luu[J] Then
                  ChiSo1:=H
                  Else
                  If Ord(S[Tr[J]][H])=J Then
                  Chiso2:=H;
                 If ChiSo1<ChiSo2 Then
                 Begin
                  For L:=ChiSo2 DownTo ChiSo1 Do
                   Begin
                        Inc(Dem);
                        SLuu[Dem]:=S[Tr[J]][L];
                   End
                  End
                  Else
                  Begin
                       For L:=ChiSo2 To ChiSo1 Do
                       Begin
                            Inc(Dem);
                            SLuu[Dem]:=S[Tr[J]][L];
                       End;
                  End;
                  Inc(Dem);
                  SLuu[Dem]:=#32;
                  J:=Luu[J];
           Until Luu[J]=0;
           For I:=Dem-1 DownTo 1 Do Write(F,SLuu[I]);
           Writeln(F);
      End;
 End;

Procedure OutPut;
 Var I:Integer;
 Begin
      Assign(F,Fo);
      ReWrite(F);
      For I:=1 To K Do
       Xuli(Dau[I],Cuoi[I]);
      Close(F);
 End;

Begin
     Clrscr;
     InPut;
     OutPut;
End.
4
ABCDEF
EKHG
HTKLP
FG
1
AP
