{
  Exercise   :
  Name       : Nguyen Van Hanh
  class      : 12 A2
  Day        :
  Total Time :
  Command    :
}
  Program Pascal;
   Uses Crt;
   Const Fi='network.Inp';
    Var F:Text;
        Time:Longint Absolute 0:$46C;
        TimeConVert:Longint;
        L,R,N:Integer;
        A:Array[1..200,1..200] Of byte;
        B:Array[1..200] Of byte;

   Procedure Prepare;
    Var i,j:Integer;
     Begin
      Assign(F,Fi);
      {$I-}
      Reset(F);
      {$I+}
      If IoResult<>0 Then Begin Writeln('File : ',Fi,' Error'); Halt; End;
     End;
    Procedure R_File;
     Var i,j:Integer;
      Begin
       Readln(F,N);
       For I:=1 to n do
       For J:=1 to n do
        A[i,j]:=0;
       For I:=1 to n do
        Begin
         While Not SeekEoln(F) do
         Begin
         Read(F,J);
         If J>0 Then A[I,J]:=1;
         End;
         Readln(F);
        End;
        Close(F);
      End;
    Procedure Go(Ts:Integer);
     Var ii:integer;
     Begin
      For ii:=1 to n do
      If (B[ii]=0)And(A[ts,ii]=1) Then Begin B[ii]:=1; Go(II); End;
     End;
    Procedure Test;
     Var i,j:Integer;
      Begin
         For I:=1 to n do
         B[i]:=0;
         For I:=1 to n do
         If B[i]=0 Then
          Begin
           Go(I);
           B[i]:=0;
          End;
          J:=0;
          For I:=1 to n do
          If B[i]=0 Then Inc(J);
          Writeln(J);
      End;
  Procedure Make;
   Var i,j,tg:Integer;
   Begin
    Test;
    For I:=1 to n do
    For J:=1 to i do
     Begin
      Tg:=A[i,j]; A[i,j]:=A[j,i]; A[j,i]:=Tg;
     End;
     Test;
   End;
  Begin
   Clrscr;
    TimeConVert:=Time;
    Prepare;
    R_File;
    {Make_Screen;}
    Make;
    Writeln('Total Time : ',(Time-TimeConVert)/18.2:10:5,' Sec');
    Readln;
{   Clear_Screen;}
  End.