Uses Crt;
Const Fi='Mach.Inp';
Var f:Text;
    R:Array[0..255]Of Integer;
    A:Array[0..1000]Of Char;
    Save:Array[1..1000]Of Real;
    Nt:Array[0..1000]Of Integer;
    m1,m2,m:Real;
    n,l,i,j,k,d1,d2:Integer;
    Ch:Char;
Procedure Error;
Begin
 Writeln('                         File Input : ',Fi);
 Writeln('           ?????????????????????????????????????????????????????');
 Writeln('                     Bieu Thuc Mach Sai !');
 Writeln('           ?????????????????????????????????????????????????????');
 Readln;
 Halt;
End;
Procedure ReadF;
Begin
 Assign(f,Fi);
 Reset(f);
 FillChar(R,SizeOf(R),0);
 L:=-1;d1:=0;d2:=0;
 While Not Eoln(f) Do
  Begin
   Inc(l);
   Read(f,A[l]);
   If A[0]<>'(' Then Error;
{   If (A[l]<>')')And(A[l]<>'(')And(A[l]<>'+')And(A[l]<>'*')And(l>1)And
     (A[l-1]<>')')And(A[l-1]<>'(')And(A[l-1]<>'+')And(A[l-1]<>'*') Then Error;}
   If (A[l]<>')')And(A[l]<>'(')And(A[l]<>'+')And(A[l]<>'*')Then
    If R[Ord(A[l])]=0 Then R[Ord(A[l])]:=1 Else Error;
   If (A[l]='*')Or(A[l]='+') Then
    If (A[l-1]='(')Or(l=1)Or(A[l-1]='*')Or(A[l-1]='+') Then Error;
   If (A[l]=')')And((A[l-1]='+')Or(A[l-1]='*')Or(l=1)Or(A[l-1]='(')) Then Error;
   If (l>1)And(A[l]='(')And(A[l-1]='*')And(A[l-1]='+') Then Error;
   If A[l]='(' Then
    Begin
     If (l>1)And(A[l-1]<>'+')And(A[l-1]<>'*') Then Error;
     Inc(d1);
     Nt[d1]:=l;
    End Else
   If A[l]=')' Then Inc(d2);
  End;
 If d1<>d2 Then Error;
 Readln(f);
 If A[l]<>')' Then Error;
 Dec(l);
 Readln(f,n);
 For i:=1 to n do Readln(f,ch,R[Ord(ch)]);
 Close(f);
End;
Procedure Solution;
Var BoQua:Boolean;
Begin
 Clrscr;
 ReadF;
 If l=1 Then m:=R[Ord(A[1])] Else Begin
 Nt[0]:=0;
 Repeat
  k:=Nt[d1]+1;
  A[k-1]:=#0;
  If A[k]=#0 Then
   Begin
    m1:=Save[k];
    While (A[k]<>'*')And(A[k]<>'+') Do Inc(k);
    Ch:=A[k];
    A[k]:=#0;
   End;
  If A[k]<>#0 Then Begin m1:=R[Ord(A[k])];A[k]:=#0;Inc(k);Ch:=A[k];A[k]:=#0;End;
  k:=k+1;
  If A[k]<>#0 Then Begin m2:=R[Ord(A[k])];A[k]:=#0;A[k+1]:=#0;End Else
   Begin
    If A[k]=#0 Then m2:=Save[k];
   End;
  If Ch='*' Then m:=m1+m2 Else
   Begin
    If m1*m2=0 Then m:=0 Else m:=1/(1/m1+1/m2);
   End;
  Save[Nt[d1]]:=m;
  Dec(d1);
 Until d1=0;End;
 Writeln('                         File Input : ',Fi);
 Writeln('           $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
 Writeln('                        ToTal :',m:10:5,' ê !');
 Writeln('           $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
 Readln;
End;
BEGIN
 Solution;
END.