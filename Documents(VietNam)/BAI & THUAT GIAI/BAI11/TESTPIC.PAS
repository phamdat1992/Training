{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_TreoTranh_Picture_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Picture.ou';
     Inp          : String  =       'Picture.in';
     ketqua       : array ['0'..'9'] of integer = (2493,224,766,1375,2126,2399,2458,2483,2485,2491);
     Maxn         = 50;
     Maxm         = 1500;
Type
    Arr1          =       Array [0..Maxm] of Byte;
    Mt1           =       Array [0..Maxn] of ^Arr1;
    Arr3          =       Array [0..Maxn] of integer;
Var
   c1                   :       arr1;
   v                    :       Mt1;  {kieu byte}
   luu                  :       arr3;
   f                    :       text;
   c                    :       char;
   n, m, dem            :       Integer;
   kqcb                 :       integer;
   QuyCachXuatFile      :       boolean;
   Mauthuan             :       boolean;
   Ok                   :       Integer;
   pmark                :       pointer;

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
Gotoxy(17,4);Writeln('TEST CHAM BAI BAY TRANH TRIEN LAM - 30/4/2002');
Textcolor(15);
gotoxy(35,wherey+1);
Write('PICTURE.IN');
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
   i, j         :       integer;
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
readln(f, n, m);
for i := 1 to n do    read(f, c1[i]); readln(f);
for i := 1 to n do
    begin
    new(v[i]);
    for j := 1 to m do
        read(f, v[i]^[j]);
    readln(f);
    end;
Close(f);
End;

Procedure DocFileCanTest;
Var
   i            :       Byte;
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
Readln(f, kqcb);
readln(f, luu[0]);
dem := 0;
while not seekeof(f) do
      begin inc(dem); read(f, luu[dem]); end;
if luu[dem] = 0 then dec(dem);
Close(f);
End;

Procedure KiemtraCachXuatFile(Var QuyCachXuatFile: boolean);
Var
   i, j         :       integer;
Begin
QuyCachXuatFile := dem = n - 1;
End;

Procedure KiemtraDuongDiUngVoiKetQuaCuaBan(Var mauthuan: boolean);
Var
   i, j, tong   :       integer;
Begin
tong := c1[luu[0]];
for i := 1 to luu[0] - 1 do
    tong := tong + v[i]^[luu[i]];
for i := luu[0] to n - 1 do
    tong := tong + v[i+1]^[luu[i]];
mauthuan := tong <> kqcb;
End;

Procedure TestSoKetQua(Var ok: Integer);
{Ok = 0 tuc la toi uu hon Test
    = 1 tuc la dung
    = 2 tuc la khong toi uu}
Var
   i, j         :       integer;
Begin
if kqcb < ketqua[c] then ok := 2
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

KiemtraCachXuatFile(QuyCachXuatFile);
If Not QuyCachXuatFile Then
   Begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(27, 12); Writeln('Cach xuat file khong dung');
   Gotoxy(35, 13); Writeln(' Diem: 1');
   End
Else
   Begin
   KiemtraDuongDiUngVoiKetQuaCuaBan(mauthuan);
   If MauThuan then
      Begin
      Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
      Gotoxy(26, 12); Writeln('Tong Va Duong Di Mau Thuan');
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
              Gotoxy(31, 12); Writeln('Cach Treo Tranh Dung');
              Gotoxy(35, 13); Writeln(' Diem: 1');
              End;
           2: Begin
              Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
              Gotoxy(29, 12); Writeln('Ket Qua Khong Toi Uu');
              Gotoxy(35, 13); Writeln(' Diem: 1');
              End;
           end;
      End;
   End
End;


Begin  {main}
{textbackground(6);}
Clrscr;
Mark(PMark);
NhapTenFileDuLieu;
inp := inp + c;
out := out + c;
DocFileCanTest;
DocFileDuLieu;
KiemTraVaCham;
Release(PMark);
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Writeln('Chu y: Da xoa file ket qua');
Readln;
End.