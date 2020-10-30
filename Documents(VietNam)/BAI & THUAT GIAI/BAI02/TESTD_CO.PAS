{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_Phan_Cong_Danh_Co_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Doico.ou';
     Inp          : String  =       'Doico.in';
     ketqua       : array ['0'..'9'] of integer = (19661,12,0,20,20,1933,9835,
                                     19737,20000,19657);
     Maxn         = 10001;
Type
    Arr1          =       Array [1..Maxn] of Integer;
Var
   a, b                 :       arr1;  {hai doi a - b: file du lieu}
   x                    :       arr1;  {ghep cap i cua doi a voi x[i] cua b}
   f                    :       text;  {x la mang doc du lieu file ket qua}
   c                    :       char;
   n, m, dem            :       Integer;
   kqcb, spt            :       integer;
   Cachxuatf            :       boolean;
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
Gotoxy(20,4);Writeln('TEST CHAM BAI PHAN CAP THI DAU - DOI CO');
Textcolor(15);
gotoxy(35,wherey+1);
Write('DOICO.IN');
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
readln(f, n);
fillchar(a, sizeof(a), 0);
b := a;
for i := 1 to n do
    readln(f, a[i], b[i]);
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
readln(f, kqcb);
spt := 0;
fillchar(x, sizeof(x), 0);
while not seekeoln(f) do
      begin    inc(spt);    read(f, x[spt]);     end;
Close(f);
End;


Procedure KtXuatFile(Var CachXuatF: boolean);
Type
    arr2                =       array [1..maxn] of boolean;
Var
   i, j                 :       integer;
   cx                   :       arr2;
Begin
cachxuatf := false;
if spt <> n then
   exit;
for i := 1 to n do
    if (x[i] = 0) or (x[i] > n) then exit;
fillchar(cx, sizeof(cx), 1);
for i := 1 to n do
    if cx[x[i]] then cx[x[i]] := false
    else             exit;         {trung}
cachxuatf := true;
End;

Procedure KtCauHinh(Var MauThuan: boolean);
Var
   i, j, tongd  :       integer;
Begin
Mauthuan := true;
tongd := 0;    {tong diem}
for i := 1 to n do
    if b[x[i]] > a[i] then inc(tongd, 2)
    else if b[x[i]] = a[i] then inc(tongd, 1);
if tongd <> kqcb then exit;
mauthuan := false;
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
      Gotoxy(26, 12); Writeln('Tong Mau Thuan Cach Bo Tri');
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
              Gotoxy(36, 12); Writeln('Toi Uu');
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