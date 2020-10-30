{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_MA_HOA_BURROWS___WHEELER_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Mahoa.ou';
     Inp          : String  =       'Mahoa.in';
     kq           : string  =       'ketqua.out';
Var
   f                    :       text;
   c                    :       char;
   kqcb                 :       string;
   ketqua               :       string;

Procedure NhapTenFileDuLieu;
Var
   i, j, code           :       integer;
Begin
Textcolor(10{ + 15});
Writeln('        (***********************************************************)          ');
Writeln('        (**                                                       **)          ');
Writeln('        (**                                                       **)          ');
Writeln('        (**                                                       **)          ');
Writeln('        (***********************************************************)          ');
Textcolor(yellow{ + 15});
Gotoxy(29,2);Writeln('NGUYEN TRONG QUYEN');
Gotoxy(28,3);Writeln('A2 K30 PHAN BOI CHAU');
Textcolor(13{ + 15});
Gotoxy(19,4);Writeln('TEST CHAM BAI MA HOA BURROWS - WHEELER');
Textcolor(15);
gotoxy(35,wherey+1);
Write('MAHOA.IN');
c:=readkey;
Writeln(c);
If Not ((c <= '9') and (c >= '0')) then
   Begin
   gotoxy(26,11);
   Textcolor(6);
   Writeln('Nhap Ten File Du Lieu Sai');
   Readln;
   halt;
   End;
End;


Procedure DocFileCanTest;
Var
   i                    :       Integer;
Begin
Assign(f,out);
{$I-}
Reset(f);
{$I+}
If IOResult <> 0 then
   Begin
   gotoxy(30,11);
   Textcolor(6);
   Writeln('File Ket Qua Not Found');
   Readln;
   halt;
   End;
{Doc file}
readln(f, kqcb);
Close(f);
End;


Procedure KiemTraVaCham;
var
   i                    :       char;
Begin
Textcolor(4);
Gotoxy(21,10);
Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
Gotoxy(21,11);
Writeln('&                                    &');
Gotoxy(21,12);
Writeln('&                                    &');
Gotoxy(21,13);
Writeln('&                                    &');
Gotoxy(21,14);
Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
Textcolor(4);

{doc}
assign(f, kq);
reset(f);
for i := '0' to c do readln(f, ketqua);
close(f);
{Cham}
If kqcb <> ketqua Then
   Begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(29, 12); Writeln(' Giai ma khong dung');
   Gotoxy(35, 13); Writeln(' Diem: 0');
   End
Else
   Begin
   Gotoxy(27, 11); Writeln('    Corect  ----  Corect');
   Gotoxy(34, 12); Writeln(' Giai ma dung');
   Gotoxy(35, 13); Writeln(' Diem: 1');
   End;
End;


Begin  {main}
{textbackground(6);}
Clrscr;
NhapTenFileDuLieu;
inp := inp + c;
out := out + c;
DocFileCanTest;
KiemTraVaCham;
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Writeln('Chu y: Da xoa file ket qua');
Readln;
End.