{ Bai Firstrow Cua Thay Nghia }
{ Le Van Hung K28 A2 Phan Boi Chau -Nghe An}
Program All_For_You;
Uses Crt;
Const
     Fi='Firstrow.inp';
     Fo='Firstrow.out';
Var
   A:Array[1..255]of byte;
   F1,F2:text;
   i,j:Integer;
   S:String;

Begin
     Assign(f1,Fi);
     Reset(f1);
     Assign(f2,fo);
     Rewrite(f2);
     Fillchar(a,sizeof(a),0);
     While Not eof(f1) Do
     Begin
          Readln(f1,s);
          If s='#' Then Break;
          For i:=1 To Length(s) Do
           A[i]:=A[i] Xor ord(S[i]);
     End;
     For i:=1 To 255 Do
     If A[i]<>0 Then
     Write(f2,chr(A[i]));
     Close(f1);
     Close(f2);
End.

hung
hung
Levanhung
Levanhung
PhanBoiChau
Phan Boi Chau
PhanBoiChau
#




