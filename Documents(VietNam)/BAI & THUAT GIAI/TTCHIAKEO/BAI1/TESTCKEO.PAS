{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_Day_con_loi_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Chiakeo.ou';
     Inp          : String  =       'Chiakeo.in';
     ketqua       : array ['0'..'9'] of integer = (0,0,1,0,1,1,0,1,1,1);
     Maxn         = 101;
Type
    Arr1          =       Array [0..Maxn] of Integer;
    arr2          =       array [0..maxn] of byte;
Var
   a                    :       arr1;
   luu                  :       arr2;
   f                    :       text;
   c                    :       char;
   n, m, sum            :       Integer;
   kqcb                 :       integer;
   CachXuatF            :       boolean;
   Mauthuan             :       boolean;
   Ok                   :       Integer;

Procedure NhapTenFileDuLieu;
Var i,j,code:integer;
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
Gotoxy(18,4);Writeln('TEST CHAM BAI DAY CON LOI');
Textcolor(15);
gotoxy(35,wherey+1);
Write('DAYLOI.IN');
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

Procedure DocFileDuLieu;
Var
   i, j         :       Integer;
Begin
Assign(f, inp);
{$I-}
Reset(f);
{$I+}
If IOResult <> 0 then
   Begin
   gotoxy(30,11);
   Textcolor(6);
   Writeln('File Du Lieu Not Found');
   Readln;
   halt;
   End;
{Doc file}
fillchar(a, sizeof(a), 0);
sum := 0;
readln(f, n);
for i := 1 to n do
    begin read(f, a[i]); sum := sum + a[i]; end;
Close(f);
End;

Procedure DocFileCanTest;
Var
   i            :       Integer;
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
readln(f, kqcb); {do chenh lech}
fillchar(luu, sizeof(luu), 0);
while not seekeof(f) do
    begin inc(m); read(f, luu[m]); end;
Close(f);
End;

Procedure KtXuatFile(Var CachXuatF: boolean);
Var
   i, j         :       integer;
Begin
cachxuatf := false;
if m <> n then exit; {so so hang xuat ra sai}
for i := 1 to n do
    if (luu[i] > 2) or (luu[i] = 0) then exit;
Cachxuatf := true;
End;

Procedure KtCauHinh(Var MauThuan: boolean);
Var
   i, j, tong   :       integer;
Begin
tong := 0; mauthuan := true;
for i := 1 to n do
    if luu[i] = 1 then tong := tong + a[i];
{do chenh lech khac voi cach chia nhom}
if kqcb <> abs(sum - 2 * tong) then exit;
mauthuan := false;
End;

Procedure TestSoKetQua(Var ok: Integer);
{Ok = 0 tuc la toi uu hon Test
    = 1 tuc la dung
    = 2 tuc la khong toi uu}
Var
   i, j         :       integer;
Begin
if kqcb > ketqua[c] then ok := 2
else
   if kqcb = ketqua[c] then ok := 1
   else ok := 0;
End;

Procedure KiemTraVaCham;
var
   trung        :       Boolean;
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

{Cham}
KtXuatFile(CachXuatF);
If Not CachXuatF Then
   Begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(27, 12); Writeln('Cach xuat file khong dung');
   Gotoxy(35, 13); Writeln(' Diem: 0');
   End
Else
   Begin
   KtCauHinh(mauthuan);
   If MauThuan then
      Begin
      Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
      Gotoxy(29, 12); Writeln('Xuat File Mau Thuan');
      Gotoxy(35, 13); Writeln(' Diem: 0');
      End
   Else
      Begin
      TestSoKetQua(ok);
      Case Ok of
           0: Begin
              Gotoxy(27, 11); Writeln('    Corect  ----  Corect');
              Gotoxy(31, 12); Writeln('Toi Uu Hon Test Cham');
              Gotoxy(35, 13); Writeln(' Diem: 1');
              End;
           1: Begin
              Gotoxy(27, 11); Writeln('    Corect  ----  Corect');
              Gotoxy(31, 12); Writeln('Cach Phan Nhom Dung');
              Gotoxy(35, 13); Writeln(' Diem: 1');
              End;
           2: Begin
              Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
              Gotoxy(29, 12); Writeln('Ket Qua Khong Toi Uu');
              Gotoxy(35, 13); Writeln(' Diem: 0');
              End;
           end;
      End;
   End
End;


Begin  {main}
{textbackground(6);}
Clrscr;
NhapTenFileDuLieu;
inp := inp + c;
out := out + c;
DocFileCanTest;
DocFileDuLieu;
KiemTraVaCham;
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Writeln('Chu y: Da xoa file ket qua');
Readln;
End.