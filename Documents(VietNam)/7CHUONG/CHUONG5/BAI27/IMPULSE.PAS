{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
PROGRAM Space_Communication;
 Const
  InpName       = 'IMPULSE.INP';
  OutName       = 'IMPULSE.OUT';
  MaxLength     =          1000;
  MaxBits       =             3;
 Var
  F, G          : Text;
  R, j, L,
  N, i, k, k1   : LongInt;
  Mess          : Array [1..MaxLength] Of Byte;
  C, Px         : Array [0..MaxLength, 0..MaxBits] Of LongInt;

 Procedure PreCalc;
  Begin
   Fillchar(C, SizeOf(C), 0);
   For i := 1 to MaxLength do
    C[i][1] := i;
   For i := 1 to MaxLength do
    Begin
     For k := 2 to MaxBits do
      C[i][k] := C[i-1][k] + C[i-1][k-1];
    End;
   For i := 1 to MaxLength do
    C[i][0] := 1;

   For k := 1 to MaxBits do Px[1][k] := 2;
   For i := 2 to MaxLength do
    For k := 1 to MaxBits do
     For j := 0 to k-1 do Inc(Px[i][k], C[i-1][j]);
  End;

 Procedure BuildMessage;
  Begin
   Fillchar(Mess, SizeOf(Mess), 0);
   L := 1;
   k := MaxBits;
   Repeat
    If N = 2 Then
     Begin
      Mess[1] := 1;
      Break;
     End Else
    If N = 1 Then Break;
    i := 1;
    While N > Px[i][k] do
     Begin
      Dec(N, Px[i][k]);
      Inc(i);
     End;
    Mess[i] := 1;
    Dec(k);
    If L < i Then L := i;
   Until FALSE;
  End;

 Procedure SendMessage;
  Begin
   For i := L downto 1 do Write(G, Mess[i]);
   Writeln(G);
  End;

BEGIN
 PreCalc;
 Assign(F, InpName); Reset(F);
 Assign(G, OutName); ReWrite(G);
 Readln(F, R);
 For j := 1 to R do
  Begin
   Readln(F, N);
   BuildMessage;
   SendMessage;
  End;
 Close(F); Close(G);
END.