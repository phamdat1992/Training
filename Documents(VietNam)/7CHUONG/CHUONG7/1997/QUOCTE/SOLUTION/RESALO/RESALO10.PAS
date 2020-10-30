{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 65520,0,655360}
Uses Crt;
Const MN                = 10;
      MaxGroup          = 20;
      InpF              = 'RESALO.INP';
      OutF              = 'RESALO.OUT';
      Sec               = 59;
      BreakTime         = Sec*18.2;
Var   A                 : Array[1..MaxGroup,1..MN,1..MN] Of LongInt;
      Good              : Array[1..MaxGroup,1..MN,1..MN] Of Boolean;
      Money             : Array[1..MaxGroup,1..MN] Of LongInt;
      Per               : Array[1..MaxGroup,1..MN] Of Integer;
      Next              : Array[1..MaxGroup] Of LongInt;
      N,K,Q,SQ,R,SR     : Array[1..MaxGroup] Of Integer;
      Stop              : Boolean;
      F                 : Text;
      d,p,z,i,j,SavePer : Integer;
      b,KQ,SaveMon,NS,L : LongInt;
      Updated,T,All     : LongInt;
      Time              : LongInt Absolute 0:$46C;
Procedure Inp;
Begin
  Assign(F,InpF);
  Reset(F);
  Read(F,d,p,b);
  For z := 1 To d Do
  Begin
    Read(F,N[z]);
    For i := 1 To N[z] Do Read(F,Per[z,i]);
    Read(F,K[z]);
    For i := 1 To K[z] Do Read(F,Money[z,i]);
    For i := 1 To N[z] Do For j := 1 To K[z] Do Read(F,A[z,i,j]);
    For i := 1 To N[z] Do For j := 1 To K[z] Do Good[z,i,j] := True;
  End;
  Close(F);
End;
Function MaxValue(Group : Byte) : LongInt;
Var Save : LongInt;
Begin
  Save := 0;
  For i := 1 To N[Group] Do For j := 1 To K[z] Do If A[Group,i,j] > Save Then
      Save := A[Group,i,j];
  MaxValue := Save;
End;
Procedure Prepair;
Var x,y : Integer;
Begin
  FillChar(Good,SizeOf(Good),True);
  For z := 1 To d Do
  Begin
    For i := 1 To N[z] Do For j := 1 To K[z] Do
    Begin
      For x := i+1 To N[z] Do If (A[z,x,j] <= A[z,i,j]) Then
      Begin
        A[z,x,j] := A[z,i,j];
        Good[z,x,j] := False;
      End;
      For y := j+1 To K[z] Do If (A[z,i,y] <= A[z,i,j]) Then
      Begin
        A[z,i,y] := A[z,i,j];
        Good[z,i,y] := False;
      End;
    End;
  End;
  Next[d] := MaxValue(d);
  For z := d-1 DownTo 1 Do Next[z] := MaxValue(z) + Next[z+1];
End;
Procedure Try(Group : Byte;MoneyRemain : LongInt;PersonRemain : Integer);
Var x,y   : Byte;
Begin
  If Group > d Then
  Begin
    If ((NS>KQ) Or ((NS=KQ) And (MoneyRemain>SaveMon)) Or
       ((NS=KQ) And (MoneyRemain=SaveMon) And (PersonRemain < SavePer))) Then
    Begin
      SQ := Q;
      SR := R;
      KQ := NS;
      SaveMon := MoneyRemain;
      SavePer := PersonRemain;
      Inc(Updated);
      Write(#13,Updated);
    End;
  End Else
  If KeyPressed Or (Time-L > BreakTime) Then
  Begin
    Stop := True;
    Exit;
  End Else
  For x := N[Group] DownTo 1 Do
  Begin
    If PersonRemain >= Per[Group,x] Then
    For y := K[Group] DownTo 1 Do
    If Good[Group,x,y] And (MoneyRemain >= Money[Group,y]) Then
    Begin
      Inc(NS,A[Group,x,y]);
      If NS + Next[Group+1] > KQ Then
      Begin
        Q[Group] := x;
        R[Group] := y;
        Try(Group+1,MoneyRemain-Money[Group,y],PersonRemain-Per[Group,x]);
      End;
      Dec(NS,A[Group,x,y]);
    End;
  End;
End;
Begin
  WriteLn(#13'Start . . .    ');
  L := Time;
  Inp;
  Prepair;
  T := Time-L;
  Inc(All,T);
  WriteLn(T,' clock(s) = ',T/18.2:0:2,' second(s) for prepairing');
  L := Time;
  Write('0    solution updated');
  Try(1,b,p);
  WriteLn;
  T := Time-L;
  Inc(All,T);
  WriteLn(T,' clock(s) = ',T/18.2:0:2,' second(s) for processing');
  L := Time;
  {Output}
  Assign(F,OutF);
  ReWrite(F);
  WriteLn(F,b-SaveMon);
  WriteLn(F,p-SavePer);
  WriteLn(F,KQ);
  For z := 1 To d Do
  Begin
    WriteLn(F);
    WriteLn(F,Money[z,SQ[z]],' = [',SQ[z],'] <Money>');
    WriteLn(F,Per[z,SR[z]],' = [',SR[z],'] <Person>');
    WriteLn(F,A[z,SQ[z],SR[z]],' = [',SQ[z],',',SR[z],'] <Value>');
  End;
  Close(F);
  T := Time-L;
  Inc(All,T);
  WriteLn(T,' clock(s) = ',T/18.2:0:2,' second(s) for output');
  If Stop Then WriteLn('          - - Break ! - -') Else
               WriteLn('          - - Finish ! - -');
  WriteLn('Total : ',All,' clock(s) = ',All/18.2:0:2,' second(s)');
  WriteLn(' * Best solution found : ');
  WriteLn('   Money in use : ',b-SaveMon,'/',b);
  WriteLn('  Person in use : ',p-SavePer,'/',p);
  WriteLn('         Result : ',KQ);
  WriteLn('------------ 12/11/97 --------------');
End.