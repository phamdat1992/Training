{ Chuong Trinh Cham Bai Bien Doi 1 }
{ Le Van Hung K28 A2 Phan Boi Chau }

Program All_For_You;
Uses Crt;
Const
     Fi='C:\Data\Hung\Tam\BienDoi1.In';
     Fo='C:\Data\Hung\Tam\BienDoi1.Out';
     luu:array[0..9]Of Integer=(43,39,41,43,98,0,87,96,100,94);
Var
   F1,F2:Text;
   A:Array[1..100,1..100]Of Byte;
   Min,Diem,Tong,X,Code,Y,Bi,N,I,J:Integer;
   Chon:Char;
   S:String;

Begin
     Clrscr;
     Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
     Writeln('                            CHUONG TRINH CHAM BAI BIEN DOI ');
     wRITELN('                            LE VAN HUNG K28 A2 PHAN BOI CHAU ');
     Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
     Write('                               FILE INPUT : BIENDOI1.IN');
     Readln(chon);
     S:=Fi+Chon;
     Assign(F1,S);
     Reset(F1);
     Readln(F1,N);
     For I:=1 To N Do
      For J:=1 To N Do
       Read(F1,A[I,J]);
     Readln(F1);
     Assign(F2,Fo);
     Reset(F2);
     Readln(F2,Min);
     Val(Chon,X,Code);
     Tong:=0;
     Diem:=1;
     Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');     If X=5 Then
          writeln;
          textcolor(15);
          writeln;
          writeln;
     If X=5 then
     If MIn<>0 Then
     Begin
          Writeln('                              BAN SAI ROI ');
          Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          WRITELN('                               BAN DUOC : 1 DIEM ');
               Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');

          WRITELN('   BAN DUOC : 0   DIEM ');
          rEADLN;
          hALT;
     End
     eLSE
     bEGIN
          wRITELN('                             BAN DUNG ROI - CORRECT !  ');
          writeln;
          writeln;
               Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          WRITELN('                               BAN DUOC : 1 DIEM ');
               Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          READLN;
          HALT;
     eND;

     For I:=1 To N Do
      Begin
           Read(F2,BI);
           Tong:=Tong+Bi;
           For J:=1 To N Do
           A[I,J]:=(A[I,J]+Bi) Mod 2;
      End;
     For I:=1 To N Do
      Begin
           Read(F2,Bi);
           Tong:=Tong+Bi;
           For J:=1 To N Do
           A[J,I]:=(A[J,I]+Bi) Mod 2;
      End;
     For I:=1 To N Do
      For J:=1 To N Do
       Begin
            Read(F1,Y);
            If A[I,J]<>Y Then
            Begin
                 Diem:=0;
                 Writeln( '                   KET QUA KHONG DUNG VOI DU LIEU HAI BANG ');
                 Writeln;
                 Writeln;
                 Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
                 Writeln('                         BAN DUOC : ',DIEM, '  DIEM ');
                 Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
                 Readln;
                 Halt;
            End;
       End;
     If Min<> Tong Then
     Begin
          Diem:=0;
          Writeln('                         KET QUA KHONG TOI UU ');
          Writeln;
          writeln;
     End;
     If Tong<> Luu[X] Then
     Begin
          Diem:=0;
          Writeln('                          KET QUA KHONG TOI UU ');
          Writeln;
          Writeln;
          Diem:=0;
     End;
     Writeln('                               KET QUA DUNG - CORRECT !');
               writeln;
               Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
     Writeln('                                  BAN DUOC: ' ,DIEM,' DIEM ');
               Writeln('                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
     close(F1);
     Close(F2);
     Readln;
End.
