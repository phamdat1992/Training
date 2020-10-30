{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V-,X+}
{$M $4000,$0,$A0000}
Uses Crt;
Const MN                = 18;
      MaxGroup          = 21;
      InpF              = 'RESALO.INP';
      OutF              = 'RESALO.OUT';
      Sec               = 58;
      BreakTime         = Sec*18.2;
      FastMode          = True;
      Range             = 100/100;
      Stop              = 100;
Type  Type1             = Array[1..MaxGroup,1..MN,1..MN] Of LongInt;
      Type2             = Array[1..MaxGroup,1..MN,1..MN] Of Boolean;
Var   A                 : ^Type1;
      Good              : ^Type2;
      ResD,MonD         : Array[1..MaxGroup,0..MN*MN] Of LongInt;
      PerD              : Array[1..MaxGroup,0..MN*MN] Of ShortInt;
      Money             : Array[1..MaxGroup,1..MN] Of LongInt;
      Per               : Array[1..MaxGroup,1..MN] Of ShortInt;
      Next              : Array[1..MaxGroup] Of LongInt;
      N,K,Num,Q,SQ      : Array[1..MaxGroup] Of ShortInt;

      F                 : Text;
      Stoped            : Boolean;
      d,p,z,i,j,SavePer : ShortInt;
      b,KQ,SaveMon,NS,L : LongInt;
      Updated,T,All     : LongInt;
      Time              : LongInt Absolute 0:$46C;
      MaxRange          : Real;
Procedure Inp;
Begin
  New(A);
  FillChar(A^,SizeOf(A^),0);
  New(Good);
  FillChar(Good^,SizeOf(Good^),0);
  Assign(F,InpF);
  Reset(F);
  Read(F,d,p,b);
  For z := 1 To d Do
  Begin
    Read(F,N[z]);
    For i := 1 To N[z] Do Read(F,Per[z,i]);
    Read(F,K[z]);
    For i := 1 To K[z] Do Read(F,Money[z,i]);
    For i := 1 To N[z] Do For j := 1 To K[z] Do Read(F,A^[z,i,j]);
    For i := 1 To N[z] Do For j := 1 To K[z] Do Good^[z,i,j] := True;
  End;
  Close(F);
End;
Procedure HVL(Var a,b : LongInt);
Var c : LongInt;
Begin
  c := a;
  a := b;
  b := c;
End;
Procedure HVB(Var a,b : ShortInt);
Var c : ShortInt;
Begin
  c := a;
  a := b;
  b := c;
End;
Procedure ChangeRow(Group,Row1,Row2 : Byte);
Var z : Byte;
Begin
  For z := 1 To K[Group] Do
  Begin
    HVL(A^[Group,Row1,z],A^[Group,Row2,z]);
    HVB(Per[Group,Row1],Per[Group,Row2]);
  End;
End;
Procedure ChangeCol(Group,Col1,Col2 : Byte);
Var z : Byte;
Begin
  For z := 1 To N[Group] Do
  Begin
    HVL(A^[Group,z,Col1],A^[Group,z,Col2]);
    HVL(Money[Group,Col1],Money[Group,Col2]);
  End;
End;
Function MaxValue(Group : ShortInt) : LongInt;
Var Save : LongInt;
Begin
  Save := 0;
  For i := 1 To Num[Group] Do
      If ResD[Group,i] > Save Then Save := ResD[Group,i];
  MaxValue := Save;
End;
Procedure Prepair;
Var x,y : Integer;
Begin
  For z := 1 To d Do
  Begin
    {Sort}
    For i := 1 To Pred(N[z]) Do For j := Succ(i) To N[z] Do
        If Per[z,i] > Per[z,j] Then ChangeRow(z,i,j);
    For i := 1 To Pred(K[z]) Do For j := Succ(i) To K[z] Do
        If Money[z,i] > Money[z,j] Then ChangeCol(z,i,j);
    {Refresh}
    For i := 1 To N[z] Do For j := 1 To K[z] Do
    Begin
      For x := i+1 To N[z] Do If (A^[z,x,j] <= A^[z,i,j]) Then
      Begin
        A^[z,x,j] := A^[z,i,j];
        Good^[z,x,j] := False;
      End;
      For y := j+1 To K[z] Do If (A^[z,i,y] <= A^[z,i,j]) Then
      Begin
        A^[z,i,y] := A^[z,i,j];
        Good^[z,i,y] := False;
      End;
    End;
  End;
  For z := 1 To d Do
  Begin
    For i := N[z] DownTo 1 Do For j := K[z] DownTo 1 Do If Good^[z,i,j] Then
    Begin
      Inc(Num[z]);
      ResD[z,Num[z]] := A^[z,i,j];
      MonD[z,Num[z]] := Money[z,j];
      PerD[z,Num[z]] := Per[z,i];
    End;
    {Sort}
    For i := 1 To Num[z]-1 Do For j := i+1 To Num[z] Do
    If ResD[z,i] < ResD[z,j] Then
    Begin
      HVL(ResD[z,i],ResD[z,j]);
      HVL(MonD[z,i],MonD[z,j]);
      HVB(PerD[z,i],PerD[z,j]);
    End;
    If FastMode Then
    Begin
      ResD[z,Round(Num[z]*Range)] := ResD[z,Num[z]];
      PerD[z,Round(Num[z]*Range)] := PerD[z,Num[z]];
      MonD[z,Round(Num[z]*Range)] := MonD[z,Num[z]];
      Num[z] := Round(Num[z]*Range);
    End;
  End;
  Next[d] := MaxValue(d);
  For z := d-1 DownTo 1 Do Next[z] := MaxValue(z) + Next[z+1];
  Dispose(A);
  Dispose(Good);
End;
Procedure Try(Group : ShortInt;MoneyRemain : LongInt;PersonRemain : Integer);
Var u : ShortInt;
Begin
  If Group > d Then
  Begin
    If ((NS>KQ) Or ((NS=KQ) And (MoneyRemain>SaveMon)) Or
       ((NS=KQ) And (MoneyRemain=SaveMon) And (PersonRemain < SavePer))) Then
    Begin
      SQ := Q;
      KQ := NS;
      SaveMon := MoneyRemain;
      SavePer := PersonRemain;
      Inc(Updated);
      Write((Updated/Stop)*100:0:0,'% => ',KQ,#13);
    End;
  End Else
  If KeyPressed Or (FastMode And (Updated >= Stop)) Or (Time-L > BreakTime) Then
  Begin
    Stoped := True;
    Exit;
  End;
  For u := 1 To Num[Group] Do
  If (PersonRemain >= PerD[Group,u]) And (MoneyRemain >= MonD[Group,u]) Then
  Begin
    Inc(NS,ResD[Group,u]);
    If NS + Next[Group+1] > KQ Then
    Begin
      Q[Group] := u;
      Try(Group+1,MoneyRemain-MonD[Group,u],PersonRemain-PerD[Group,u]);
    End;
    Dec(NS,ResD[Group,u]);
  End;
End;
Procedure Show(S : String);
Begin
  T := Time-L;
  Inc(All,T);
  WriteLn(T,' clock(s) = ',T/18.2:0:2,' second(s) for ',S);
  L := Time;
End;
Begin
  Write(#13'Start in ');
  If FastMode Then WriteLn('fast mode.') Else WriteLn('normal mode.');
  L := Time;
  Inp;
  Prepair;
  Show('prepairing');
  Try(1,b,p);
  Show('processing');
  {Output}
  Assign(F,OutF);
  ReWrite(F);
  WriteLn(F,b-SaveMon);
  WriteLn(F,p-SavePer);
  WriteLn(F,KQ);
  For z := 1 To d Do
  Begin
    WriteLn(F);
    WriteLn(F,MonD[z,SQ[z]]);
    WriteLn(F,PerD[z,SQ[z]]);
    WriteLn(F,ResD[z,SQ[z]]);
    If SQ[z]/Num[z] > MaxRange Then MaxRange := SQ[z]/Num[z];
  End;
  Close(F);
  Show('output');
  WriteLn;
  WriteLn(All,' clock(s) = ',All/18.2:0:2,' second(s) for all program');
  Write  (' * Best solution found ');If Stoped Then Write('*') Else Write(':');
  WriteLn('   ',MaxRange*100:0:0,'%'#7);
  WriteLn('   Money in use : ',b-SaveMon,'/',b);
  WriteLn('  Person in use : ',p-SavePer,'/',p);
  WriteLn('         Result : ',KQ);
  WriteLn('------------ 12/11/97 --------------');
End.