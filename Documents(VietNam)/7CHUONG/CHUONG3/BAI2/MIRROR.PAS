{Le Van Hung -K28 A2 Phan Boi Chau -Nghe An }
{ Bai Mirror - Nha Guong Cuoi -Thay Nghia -Doi Tuyen Nam 2000-2001}
Program Hoa_Tra_my ;
Uses Crt;
Const
     Fi='Mirror.in4';{Quyen3\Bai14.inp';}
     Fo='Mirror.out';
     Toa_Do_Y:Array[1..4]Of Shortint=(0,-1,0,1);
     Toa_Do_X:Array[1..4]Of Shortint=(-1,0,1,0);
Var
   A:Array[0..50,0..50]Of Integer;
   N,i,j:integer;
   Kt:array[0..50,0..50]Of integer;
   f:text;
   Tong:Longint;

Procedure Init;
 Begin
      For i:=0 to n+1 do
      For j:=0 to n+1 do
      Kt[i,j]:=0;
      For i:=0 To N+1 Do
       Begin
            Kt[i,0]:=1;
            Kt[i,n+1]:=1;
       End;
      For j:=0 To N+1 Do
       Begin
            Kt[0,j]:=1;
            Kt[n+1,j]:=1;
       End;
 End;

Procedure Readfile;
 Var X:Char;
 Begin
      Assign(f,Fi);
      Reset(f);
      Readln(f,n);
      For i:=0 to n+1 Do
       For j:= 0 To n+1 Do
        A[i,j]:=1;
      A[0,0]:=0;
      A[0,1]:=0;
      A[1,0]:=0;
      A[n,n+1]:=0;
      A[n+1,n]:=0;
      A[n+1,n+1]:=0;
      For i:=1 To n DO
       Begin
        For j:=1 To n DO
         Begin
              Read(f,x);
              If x='.'Then A[i,j]:=0
              Else A[i,j]:=1;
         End;
         Readln(f);
       End;
      For i:=0 To n+1 Do
       Begin
            For j:=0 To n+1 Do
             Write(a[i,j],' ');
            Writeln;
       End;
      Close(f);
 End;

Procedure Loang(i,j:Integer);
 Var t:Integer;
 Begin
      For t:=1 To 4 Do
      Begin
           If A[i+Toa_Do_X[t],j+Toa_Do_Y[t]]=1 Then Inc(Tong)
           Else
           If (Kt[Toa_Do_X[t]+i,Toa_Do_Y[t]+j]=0)and(A[i+Toa_Do_X[t],j+Toa_Do_Y[t]]=0) then
           Begin
                Kt[Toa_Do_X[t]+i,Toa_Do_Y[t]+j]:=1;
                Loang(i+Toa_Do_X[t],j+Toa_Do_Y[t]);
           End;
      End;
 End;

Procedure Xuli;
 Begin
      Tong:=0;
      Kt[1,1]:=1;
      Loang(1,1);
      If Kt[n,n]=0 Then
      Begin
           Kt[n,n]:=1;
           Loang(n,n);
      End;
 End;

Procedure Writefile;
 Begin
      Assign(f,Fo);
      Rewrite(f);
      Writeln(f,Tong*9);
      Close(f);
 End;

Begin
     Clrscr;
     Readfile;
     Init;
     Xuli;
     Writefile;
End.

5
.....
...##
..#..
..###
.....
