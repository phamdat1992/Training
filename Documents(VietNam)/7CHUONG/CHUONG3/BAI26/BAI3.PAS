   { Le Van Hung K28 A2 Phan Boi Chau }
   { Problem : HSGQG 1999-2000}
   { Bai3 }

Program All_For_You;
Uses Crt;
Const
     Fi='disk.Inp';
     Fo='disk.Out';
Var
   N:Integer;
   F:Text;
(********************************************************)
Procedure InPut;
 Begin
      Assign(F,Fi);
      Reset(F);
      Readln(F,N);
      Close(F);
 End;
(********************************************************)
Procedure Ghi(A,B:Byte);
 Begin
      Writeln(F,A,'->',B);
 End;
(********************************************************)
Procedure Try(N:Integer;A,B,C:Integer);
 Begin
      If N>0 Then
      Begin
           If B= A Mod 3+1 Then
           Begin
                Try(N-1,A,C,B);
                Ghi(A,B);
                Try(N-1,C,B,A);
           End
           Else
           Begin
                Try(N-1,A,B,C);
                Ghi(A,C);
                Try(N-1,B,A,C);
                Ghi(C,B);
                Try(N-1,A,B,C);
           End;
      End;
 End;
(******************************************************)
Procedure OutPut;
 Begin
      Assign(F,Fo);
      ReWrite(F);
      Try(N,1,2,3);
      Close(F);
 End;
(*******************************************************)
Begin
     Clrscr;
     Writeln(' Chuong Trinh Dang Chay ');
     InPut;
     OutPut;
End.
(********************************************************)
3




