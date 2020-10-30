{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q-,R+,S-,T-,V-,X+,Y+}
{$M 16384,0,655360}
Uses Crt;
Const OutF              = 'TOXIC.OUT';
      Have              = 0;
      None              = 2;
      Pass              = 1;
      HX                : Array[0..5] Of ShortInt = (+1, 0, 0, 0, 0,-1);
      HY                : Array[0..5] Of ShortInt = ( 0,-1, 0, 0,+1, 0);
      HZ                : Array[0..5] Of ShortInt = ( 0, 0,-1,+1, 0, 0);
      Start             = 0;
      MN                = 32;
      Second            = 14;
      BreakTime         : LongInt = LongInt(Round(Second*18.2));
Type Board              = Array[1..MN,1..MN,1..MN] Of Byte;
     Line               = Array[0..17500] Of Byte;
Var L,W,H,X,Y,Z,Run     : Byte;
    XX,YY,ZZ            : ShortInt;
    A                   : Board;
    Val                 : Line;
    Save                : ^Line;
    Max,Long,All,i,MaxS : Word;
    CT                  : LongInt Absolute 0:$46C;
    ST,BT               : LongInt;
    F                   : Text;
Function Good(X,Y,Z,Value : Byte) : Boolean;
Begin
  Good := (X>0)And(Y>0)And(Z>0)And(X<=L)And(Y<=W)And(Z<=H)And(A[X,Y,Z]=Value);
End;
Function EatAble(HH : Byte) : Boolean;
Begin
  EatAble := False;
  XX := X+HX[HH];
  YY := Y+HY[HH];
  ZZ := Z+HZ[HH];
  If (XX>=1) And (YY>=1) And (ZZ>=1) And
     (XX<=L) And (YY<=W) And (ZZ<=H) And (A[XX,YY,ZZ] = Have) Then
  Begin
    For Run := 0 To 5 Do If (Run+HH <> 5) And
        Good(XX+HX[Run],YY+HY[Run],ZZ+HZ[Run],Pass) Then Exit;
    EatAble := True;
  End;
End;
Function Num : Byte;
Var HH,C : Byte;
Begin
  C := 0;
  For HH := 0 To 5 Do
  Begin
    XX := X+HX[HH];YY := Y+HY[HH];ZZ := Z+HZ[HH];
    If (XX>=1) And (YY>=1) And (ZZ>=1) And (XX<=L) And (YY<=W) And (ZZ<=H) Then
      If (A[XX,YY,ZZ] = Pass) Then Inc(C) Else
      If (A[XX,YY,ZZ] = None) Then Inc(C,6) Else
  End;
  Num := C;
End;
Procedure DFS;
Label Nguyen,Dinh,Nam;
Const HX  : Array[0..5] Of ShortInt = (+1, 0, 0, 0, 0,-1);
      HY  : Array[0..5] Of ShortInt = ( 0,-1, 0, 0,+1, 0);
      HZ  : Array[0..5] Of ShortInt = ( 0, 0,-1,+1, 0, 0);
 Function Min(a,b : Byte) : Byte;
 Begin
   If a < b Then Min := a Else Min := b;
 End;
Begin
  Run := Min(Min(L,W),H);
  If Run > 20 Then Max := Round(All*0.35) Else
  If Run > 15 Then Max := Round(All*0.30) Else
  If Run > 9 Then Max := Round(All*0.20) Else
  If Run > 5 Then Max := Round(All*0.15) Else
  Nguyen:
  If (CT > BT) Or KeyPressed Then Goto Nam;
  Inc(X,HX[Val[Long]]);
  Inc(Y,HY[Val[Long]]);
  Inc(Z,HZ[Val[Long]]);
  Inc(Long);
  A[X,Y,Z] := Pass;
  Val[Long] := 0;
  While Val[Long] <= 5 Do
  Begin
    If EatAble(Val[Long]) Then Goto Nguyen
    Else If Long > Max Then
         Begin
           Max := Long;
           Save^ := Val;
           Write(#13,Max,' = ',Max/All*100:0:0,'%')
         End;
    Dinh:
    Inc(Val[Long]);
  End;
  Dec(Long);
  A[X,Y,Z] := Have;
  Inc(X,HX[5-Val[Long]]);
  Inc(Y,HY[5-Val[Long]]);
  Inc(Z,HZ[5-Val[Long]]);
  If Long > 0 Then Goto Dinh;
  Nam:WriteLn;
  Write('Writing...'#13);
  MaxS := Max;
  Val := Save^;
  FillChar(A,SizeOf(A),0);
  X := 0;Y := 1;Z := 1;
  For i := 0 To Pred(Max) Do
  Begin
    Inc(X,HX[Val[i]]);
    Inc(Y,HY[Val[i]]);
    Inc(Z,HZ[Val[i]]);
    A[X,Y,Z] := Pass;
  End;
  For X := 1 To L Do For Y := 1 To W Do For Z := 1 To H Do
  If (A[X,Y,Z] = Have) And (Num = 1) Then
  Begin
    A[X,Y,Z] := None;
    Inc(Max);
  End;
  X := 0;Y := 1;Z := 1;
  For i := 0 To Pred(MaxS) Do
  Begin
    Inc(X,HX[Val[i]]);
    Inc(Y,HY[Val[i]]);
    Inc(Z,HZ[Val[i]]);
    WriteLn(F,'E ',X:3,Y:3,Z:3);
    WriteLn(F,'M ',X:3,Y:3,Z:3);
    For Run := 0 To 5 Do If Good(X+HX[Run],Y+HY[Run],Z+HZ[Run],None) Then
    WriteLn(F,'E ',X+HX[Run]:3,Y+HY[Run]:3,Z+HZ[Run]:3);
  End;
  WriteLn(F,'--------- Nam''s Board ---------');
  For X := 1 To L Do
  Begin
    For Y := 1 To W Do
    Begin
      For Z := 1 To H Do Write(F,A[X,Y,Z]:2);
      WriteLn(F);
    End;
    WriteLn(F);
  End;
End;
Procedure Init;
Begin
  New(Save);
  X := 0;Y := 1;Z := 1;
  If EatAble(Start) Then A[X+HX[Start],Y+HY[Start],Z+HZ[Start]] := None;
  Long := 0;
  Val[0] := Start;

  L := 35;Write('L = ');ReadLn(L);
  W := 35;Write('W = ');ReadLn(W);
  H := 35;Write('H = ');ReadLn(H);
  All := L*W;All := All*H;
  If All < 5000 Then Inc(BreakTime,72);
  If All < 16000 Then Inc(BreakTime,35);
  Assign(F,OutF);
  ReWrite(F);
End;
Procedure Tham;
Const HX  : Array[0..5] Of ShortInt = (+1, 0, 0, 0, 0,-1);
      HY  : Array[0..5] Of ShortInt = ( 0,-1, 0, 0,+1, 0);
      HZ  : Array[0..5] Of ShortInt = ( 0, 0,-1,+1, 0, 0);
Begin

End;
 {****************************** MAIN PROGRAM ******************************}
Begin
  WriteLn;
  Init;
  ST := CT;BT := ST+BreakTime;

  DFS;

  ST := CT-ST;
  Close(F);
  WriteLn(  'Max = ',Max,'/',All,' = ',Max/All*100:0:2,'%');
  WriteLn(ST,' clocks = ',ST/18.2:0:2,' second(s).');
End.