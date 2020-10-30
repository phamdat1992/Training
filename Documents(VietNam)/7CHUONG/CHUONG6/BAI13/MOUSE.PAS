Uses Crt;
Var X,Y:Array[1..4]Of Integer;
    n,m,i,j:Integer;
    A:Array[1..100,1..100]Of 0..2;
Procedure Out;
Var i,j:Integer;
Begin
 Clrscr;
 For i:=1 to n do
  Begin
   For j:=1 to m do
    If A[i,j]=0 Then Begin TextColor(15);Write('.');End Else
     If A[i,j]=1 Then Begin TextColor(Yellow);Write('C');End
      Else Begin TextColor(Red);Write('M');End;
   Writeln;
  End;
End;
Procedure Init;
Begin
 TextBackGround(1);
 Clrscr;
 TextColor(15);
 Write('Nhap N:');Readln(n);
 Write('Nhap M:');Readln(m);
 FillChar(A,SizeOf(A),0);
 For i:=1 to 3 do
  Begin
   Repeat
    Write('Meo ',i,' : (');
    Readln(X[i]);
    Gotoxy(13,WhereY-1);
    Write(',');Readln(Y[i]);
    Gotoxy(16,WhereY-1);Writeln(')');
   Until (A[X[i],Y[i]]=0)And(X[i]>=1)And(X[i]<=n)And(Y[i]>=1)And(Y[i]<=m);
   A[X[i],Y[i]]:=1;
  End;
  Repeat
   Write('Chuot : (');
   Readln(X[4]);
   Gotoxy(13,WhereY-1);
   Write(',');Readln(Y[4]);
   Gotoxy(16,WhereY-1);Writeln(')');
  Until (A[X[4],Y[4]]=0)And(X[4]>=1)And(X[4]<=n)And(Y[4]>=1)And(Y[4]<=m);;
  A[X[4],Y[4]]:=2;
  Out;
End;
Procedure Go1;
Begin
 For i:=1 to 3 do

End;
Procedure Solution;
var meodi:Boolean;
Begin
 Clrscr;
 Init;
 MeoDi:=True;
 Repeat
  If MeoDi Then Go1 Else Go2;
 Until False;
End;
BEGIN
 Solution;
ENd.