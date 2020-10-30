Uses Crt;
Const Fi='Static.Inp';
      Fo='Static.Out';
      MaxC=20;
Type Xau=String[50];
Var f,ft:Text;
    S:Array[1..20]Of Xau;
    St:Xau;

Function ChuTrinh(Top:Integer):Boolean;
Var i:Integer;
Begin
 ChuTrinh:=False;
 For i:=1 to top-1 do
  If S[i]=S[top+1] Then
   Begin
    Writeln(ft,St,' THUOC CHU TRINH ',Top-i+1,' SAU ',Top,' LAN SINH' );
    ChuTrinh:=True;
   End;
End;

Function TuSinh(Top:Integer):Boolean;
Begin
 TuSinh:=False;
 If S[Top+1]=S[top] Then
  Begin
   Writeln(ft,St,' TU SINH SAU ',top-1,' BUOC');
   TuSinh:=True;
  End;
End;

Procedure Find(St:Xau);
Var Top,k,m,i:Integer;
    X,Y,c,ch:Xau;
Begin
 Top:=1;
 S[1]:=St;
 For Top:=1 to MaxC do
  Begin
   X:=S[Top];
   Y:='';
   For i:=0 to 9 do
    Begin
     Str(i,c);k:=0;
     m:=Pos(c,X);
     While m>0 Do Begin Inc(k);Delete(X,m,1);m:=Pos(c,X);End;
     If k>0 Then
      Begin Str(k,ch);Y:=Y+ch+c;End;
    End;
   S[Top+1]:=Y;
   If TuSinh(Top) Then Exit;
   If ChuTrinh(Top) Then Exit;
  End;
  Writeln(ft,St,'KHONG');
End;

Procedure ReadF;
Begin
 Assign(f,Fi);
 Reset(f);
 Assign(ft,Fo);
 ReWrite(ft);
 While Not Eof(f) Do
  Begin
   Readln(f,St);
   Find(St);
  End;
 Close(f);
 Close(ft);
End;
Procedure Solution;
Begin
 ReadF;
End;
BEGIN
 Clrscr;
 Solution;
END.

