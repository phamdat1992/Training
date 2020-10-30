{$B-}
Uses Crt;
Const Fi='bai2.inp';
      Fo='bai2.out';
      MaxMN=100;
Var A:Array[1..MaxMN,1..MaxMn]of Byte;
    Dy,My,Mx,Ldx,LDy:Array[1..MaxMN]of Byte;
    Cx:Array[1..MaxMN]of Boolean;
    Correct:Boolean;
    M,K,i,j:Byte;
    f:Text;

procedure Readfile;
Var St:Array[1..MaxMN+1]of String[100];
    l:Byte;
Begin
  Assign(f,Fi);
  Reset(f);
  Readln(f,M,K);
  For i:=1 to M+1 do Readln(f,St[i]);
  Close(f);

  Fillchar(A,Sizeof(A),0);
  For i:=1 to Length(St[M+1])Do
    For j:=1 to M do
      For l:=1 to Length(St[j]) Do
        If St[M+1,i]=St[j,l] Then
          Begin
            A[i,j]:=1;
            {Break;}
          End;
{  For i:=1 to K do
    Begin
      For j:=1 to M Do
        Write(A[i,j],' ');
      Writeln;
    End;}
End;

Procedure Inc_Flow(i:Byte);
Begin
  j:=LDx[i];
  My:=Dy;
  While j<>0 Do
    Begin
      Dy[j]:=LDy[j];
      j:=LDx[My[j]];
    End;
End;

Procedure Find(i:Byte);
Var j:Byte;
Begin
  For j:=1 to M do
    If Cx[j] And (Dy[j]<>i)And(A[i,j]=1) Then
      Begin
        If Correct Then Exit;
        Cx[j]:=False;
        My[j]:=i;
        Mx[i]:=j;
        If Dy[j]<>0 Then Find(Dy[j])
          Else
            Begin
              LDx:=Mx;
              LDy:=My;
              Correct:=True;
            End;
         Cx[j]:=True;
      End;
End;

Procedure Process;
Begin
  Fillchar(Dy,Sizeof(Dy),0);
  For i:=1 to K do
    Begin
      Fillchar(Mx,Sizeof(Mx),0);
      Fillchar(My,Sizeof(My),0);
      Fillchar(Cx,Sizeof(Cx),True);
      Correct:=False;
      Find(i);
      If Correct Then Inc_Flow(i);
    End;
End;

Procedure Result;
Var Dem:Byte;
Begin
  dem:=0;
  For j:=1 to M do
    If Dy[j]<>0 Then Inc(Dem);
  Writeln(Dem);
  For j:=1 to M do
    If Dy[j]<>0 Then Writeln(Dy[j],' ',j);
  Assign(f,Fo);
  Rewrite(f);
  Writeln(f,Dem);
  For j:=1 to M do
    If Dy[j]<>0 Then Writeln(f,Dy[j],' ',j);
  Close(f);
  Readln;
End;

BEGIN
  Clrscr;
  Readfile;
  Process;
  Result;
END.