   (* Le Van Hung K28 A2 Phan Boi Chau *)
   (*  HTM Group *)

Program All_For_You;
Uses Crt;
Const
     N=100;
     fo    ='abc.out';
     Next:String[3]='ACB';
Var
   S,B:Array[1..1000]Of Char;
   Dem,Dem1,L,K:Integer;
   Kt:Boolean;
   Time:Longint;
   TimeSave:Longint Absolute 0:$46C;
   f:text;

Function Ok(I:Integer):Boolean;
 Var K:Integer;
 Begin
      Ok:=False;
      For K:=1 To I Div 2 Do
       Begin
            Kt:=False;
            For L:=1 To K Do
             If S[I-2*K+L]<>S[I-K+L] Then
             Begin
                  Kt:=True;
                  Break;
             End;
            If Not Kt Then Exit;
       End;
      Ok:=True;
 End;

Procedure Result;
 Begin
      B:=S;
      Dem:=Dem1;
 End;

Procedure Try(I:Integer);
 Var J:Byte;
 Begin
      For J:=1 To 3 Do
       Begin
            S[I]:=Next[J];
            If Ok(I) Then
            Begin
                 If J=3 Then Inc(Dem1);
                 If Dem1+(N-I) Div 4 < Dem Then
                 If I=N Then ReSult Else Try(I+1);
                 If J=3 Then Dec(Dem1);
            End;
       End;
 End;

Procedure Xuli;
 Begin
      Dem:=N;
      Dem1:=0;
      For K:=1 To N Do
       S[K]:=' ';
      Try(1);
      assign ( f , fo ) ; rewrite ( f ) ;
      Writeln('So Ky Tu B La :',Dem);
      For K:=1 To N Do begin Write(B[K]); write(f,b[k]); end ; close ( f ) ;
 End;

Begin
     Clrscr;
     Time:=TimeSave;
     Writeln(' Chuong Trinh Dang Chay ');
     Write(' Voi So N=',N,' Thi ');
     Xuli;
     Writeln;
     Writeln(' Chuong Trinh Chay Het ', (TimeSave-Time)/18.21:3:4,' Giay');     Readln;

End.

