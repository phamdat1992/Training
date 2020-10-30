Program Robot3;
Const Fi='Robot3.Inp';
      Fo='Robot3.Out';

Var  F1,F2:Text;
     A:Array[1..100,1..100] Of Byte;
     S:Array[1..100] Of String;
     Cot,L:Array[1..100] Of Byte;
     m,n,Dem,i,j:Byte;
     Tong:Integer;

Procedure MoFile;
Begin
 Assign(F1,Fi);
 Reset(F1);
 Assign(F2,Fo);
 Rewrite(F2);
End;

Procedure DongFile;
Begin
  Close(F1);
  Close(F2);
End;

Procedure ReadFile;
Var St:String[100];
    i,j:Integer;
Begin
 For i:=1 to 40 Do Writeln;
 FillChar(A,SizeOf(A),0);
 Tong:=0;
 FillChar(Cot,SizeOf(Cot),0);
 Fillchar(L,SizeOf(L),0);
 Readln(F1,m,n);
 For i:=1 to m Do
   Begin
     Readln(F1,St);
     For j:=1 To Length(St) Do
       Begin
         If St[j]='0' Then A[i,j]:=0;
         If St[j]='1' Then A[i,j]:=1;
         Cot[j]:=Cot[j]+A[i,j];
         Tong:=Tong+A[i,j];
         If A[i,j]=1 Then L[j]:=i;
       End;
   End;
End;

Procedure Init;
Begin
  Dem:=0;
  FillChar(S,SizeOf(S),' ');
End;

Function Min(j:Byte):Byte;
Var i,Tam:Byte;
Begin
  Tam:=0;
  For i:=1 to m Do
    If A[i,j]=1 Then Tam:=i;
  Min:=Tam;
End;

Procedure TimLaiMinCot;
Var j:Integer;
Begin
  For j:=1 to n Do
     L[j]:=Min(j);
End;

Procedure DatRoBot;
Var td:Byte;
Begin
 Dem:=Dem+1;
 i:=1;j:=1;
 Repeat
    If i>=L[j]  Then
       Begin
         If j<n Then
          Begin
            j:=j+1;
            Tong:=Tong-A[i,j];
            A[i,j]:=0;
            S[Dem]:=S[dem]+'R';
          End
         Else
           If j=n Then
                Repeat
                   i:=i+1;
                   Tong:=Tong-A[i,j];
                   A[i,j]:=0;
                   S[Dem]:=S[Dem]+'D';
                Until i=m;
       End
    Else
     Begin
       Repeat
        i:=i+1;
        Tong:=Tong-A[i,j];
        A[i,j]:=0;
        S[Dem]:=S[Dem]+'D';
       Until i=l[j];
       L[j]:=0;
     End;
 Until (i=m)And(j=n);
End;

Procedure WriteFile;
Begin
 For i:=1 to Dem Do
    Writeln(F2,S[i]);
End;

Begin
  MoFile;
  Readfile;
  Init;
  Repeat
      DatRobot;
      If Tong>0 Then
      TimLaiMinCot;
  Until Tong=0;
  WriteFile;
  DongFile;
End.
10 12
011100101000
010001000000
000100001000
100001000000
000100000000
010010000000
100001111000
111111000100
100000000100
100000000100
4 5
01111
00100
01010
11010