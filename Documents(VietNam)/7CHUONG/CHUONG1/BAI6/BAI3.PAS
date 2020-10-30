{  Le Van Hung K28 A2 Phan Boi Chau }
{  Problem : HSGQG Bang A 2000-2001 - Bai 3 ( Vong Quanh The Gioi) }
{ $N+}

Program Hoa_Tra_My ;
Uses Crt;
Const
     Fi='bl3.in3';
     Fo='BL3.OUT';
     NSinh=5000;
     PSinh=500;
     SoSinh=10000;
Type
    Mang1=Array[0..10000]Of real;
    Mang2=Array[0..10000]Of longint;
Var
   A,W,Luu:^Mang2;
   Mind:^Mang1;
   F1,F2:Text;
   N,I,P:Longint;
   Time:Longint;
   TimeSave:Longint Absolute 0:$46C;


Procedure Init;
 Begin
      Clrscr;
      Time:=TimeSave;
      Writeln(' Chuong Trinh Dang Chay ');
      New(Mind);
      New(Luu);
      New(A);
      New(W);
      Assign(F1,Fi);
      Assign(F2,Fo);
      Reset(F1);
      ReWrite(F2);
 End;

Procedure Fini;
 Begin
      Close(F1);
      Close(F2);
      Dispose(Mind);
      Dispose(Luu);
      Dispose(A);
      Dispose(W);
      Writeln(' Chuong Trinh Chay Het ',(TimeSave-Time)/18.21:0:1);
      Writeln(' Press Enter To Exit !');
      Readln;
 End;

Procedure InPut;
 Begin
      Readln(F1,N);
      Readln(F1,P);
      For I:=1 To N Do
       Read(F1,A^[I]);
      A^[0]:=0;
 End;

function bp(a:real):real;
begin bp:=a*a; end;

Procedure OutPut;
 Var I,J,h:Integer;
     tong:extended;
     ok:boolean;
 Begin
      I:=N;
      J:=0;
      h:=0;
      Repeat
            Inc(J);
            W^[J]:=I;
            I:=Luu^[I];
      Until I=0;

      tong:=bp(a^[W^[j]]-p);
      ok:=true;
      For i:=j-1 downto 1 do
       begin
            Tong:=Tong+bp((a^[w^[i]]-a^[w^[i+1]])-p);
       end;
       writeln(f2,tong:0:0);
      Writeln(F2,J);
      For I:=J Downto 1 Do
       Write(F2,W^[I],' ');

 End;

Procedure Quy_Hoach_Dong;
 Var I,J:Integer;
 Begin
      Fillchar(Mind^,Sizeof(Mind^),0);
      Mind^[0]:=0;
      For I:=1 To N Do
       Begin
            Mind^[I]:=Mind^[I-1]+bp(abs(A^[I]-A^[I-1])-P);
            Luu^[I]:=I-1;
            For J:=I-1 Downto 0 Do
             Begin
                  If Mind^[I]>Mind^[J]+bp(abs(A^[I]-A^[J])-P) Then
                  Begin
                       Mind^[I]:=Mind^[J]+bp(abs(A^[I]-A^[J])-P);
                       Luu^[I]:=J;
                  End;

             End;
       End;
   end;    begin
   init;
       InPut;
     Quy_Hoach_Dong;
     output;
     Fini;
End.




     OutPut;


1.7e38


