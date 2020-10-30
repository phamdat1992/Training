{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
{ Le Van Hung K28 A2 Phan Boi Chau-Nghe An}
{ Bai Zeropath -Thay Nghia - Doi Tuyen Nam 2000-2001}

Program All_For_You;
Uses Crt;
Const
     Fi='zeropath.inp';
     Fo='zeropath.out';
Var
   F:text;
   Kt:Array[0..10000]Of Boolean;
   n:longint;

Procedure Readfile;
 Begin
     { Assign(f,Fi);
      Reset(f);
      Readln(f,n);
      Close(f);}n:=2345;
 End;

Procedure Loang(i:longint);
 Var j:longint;
 Begin
      For j:=1 To Trunc(Sqrt(i)) Do
      If i Mod j=0 Then
      Begin
           If kt[(j-1)*(i Div j +1)] Then
           Begin
                Kt[(j-1)*(i Div j +1)]:=false;
                Loang((j-1)*(i Div j +1));
           End;
      End;
 End;

Procedure Xuli;
 Begin
      Fillchar(Kt,Sizeof(kt),True);
      Kt[0]:=false;
      Loang(n);
 End;

Procedure Writefile;
 Var i,j:Integer;
 Begin

      Assign(f,Fo);
      Rewrite(f);
      j:=0;
      For i:=0 To n Do
      If Not Kt[i] Then
      Inc(j);
      Writeln(f,j);
      For i:=0 TO N Do
      IF Not Kt[i] Then
      Writeln(f,i,' ');
      Close(f);
 End;

Begin
     Readfile;
     Xuli;
     Writefile;
End.

12




