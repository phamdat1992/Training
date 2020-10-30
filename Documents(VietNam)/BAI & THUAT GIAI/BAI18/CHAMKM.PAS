{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_KhuyenMai_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Km.ou';
     Inp          : String  =       'Km.in';
     ketqua       : array ['0'..'9'] of longint = (2209573,4112087,5827005,7212738,
                          8972481,10006790,11718050,13661359,15088125,16634669);
     maxn               =       101;
     maxk               =       5001;
type
    rec                 =       record
                                x      :        integer;
                                y      :        word;
                                z      :        longint;
                                end;
    arr1_1              =       array[0..maxn, 0..maxn] of longint;
    arr1_2              =       array[0..maxn, 0..maxn] of integer;
    arr2                =       array[0..maxk] of rec;
    arr3                =       array[0..maxk] of integer;
{    arr4                =       array[0..maxk] of longint;}
var
   a                    :       arr2;
   cp                   :       ^arr1_1;
   tg                   :       ^arr1_2;
   Luu                  :       arr3;
   f                    :       text;
   m, n, k, dem         :       longint;
   pmark                :       pointer;
   c                    :       char;
   kqcb                 :       longint;
   Quycachxuatfile      :       boolean;
   Mauthuan             :       boolean;
   Ok                   :       longint;

Procedure NhapTenFileDuLieu;
Var i,j,code:longint;
Begin
Textcolor(10);
Writeln('        (***********************************************************)          ');
Writeln('        (**                                                       **)          ');
Writeln('        (**                                                       **)          ');
Writeln('        (**                                                       **)          ');
Writeln('        (***********************************************************)          ');
Textcolor(yellow);
Gotoxy(29,2);Writeln('NGUYEN TRONG QUYEN');
Gotoxy(28,3);Writeln('A2 K30 PHAN BOI CHAU');
Textcolor(13);
Gotoxy(26,4);Writeln('TEST CHAM BAI KHUYEN MAI');
Textcolor(15);
gotoxy(37,wherey+1);
Write('KM.IN');
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
   i, j         :       longint;
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
readln(f, n, m, k);
fillchar(a, sizeof(a), 0);
for i := 1 to k do
    readln(f, a[i].x, a[i].y, a[i].z); {cua hang x tai thoi diem y tang qua z}
new(tg);
fillchar(tg^, sizeof(tg^), 0);
for i := 1 to n + 1 do
    begin
    for j := 1 to n + 1 do
        read(f, tg^[i,j]);
    readln(f);
    end;

new(cp);
fillchar(cp^, sizeof(cp^), 0);
for i := 1 to n + 1 do
    begin
    for j := 1 to n + 1 do
        read(f, cp^[i,j]);
    readln(f);
    end;
for i := 1 to n do
    begin
    cp^[i,0] := cp^[i,n+1];  cp^[0,i] := cp^[n+1,i];
    tg^[i,0] := tg^[i,n+1];  tg^[0,i] := tg^[n+1,i];
    end;
Close(f);
End;

Procedure DocFileCanTest;
Var
   i            :       longint;
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
while not seekeof(f) do
      begin
      inc(dem);
      readln(f, luu[dem]);
      end;
Close(f);
End;

procedure QuickSort(var luu: arr3; Lo, Hi: longint);
procedure Sort(l, r: longint);
var
  i, j, x, y: longint;
begin
  i := l; j := r; x := luu[(l + r) DIV 2];
  repeat
    while luu[i] < x do i := i + 1;
    while x < luu[j] do j := j - 1;
    if i <= j then
    begin
      y := luu[i]; luu[i] := luu[j]; luu[j] := y;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
end;

begin {QuickSort};
  Sort(Lo,Hi);
end;




Procedure KtXuatFile(Var QuyCachXuatFile: boolean);
Type
    arr0                =       array[0..maxk] of boolean;
Var
   i, j                 :       longint;
   chuaxet              :       arr0;
Begin
QuyCachXuatFile := false;
for i := 1 to dem do if luu[i] = 0 then exit;
fillchar(chuaxet, sizeof(chuaxet), 1);
for i := 1 to dem do
    if chuaxet[luu[i]] then chuaxet[luu[i]] := false
    else               exit;
QuyCachXuatFile := true;
End;

Procedure KtDayCauHinh(Var MauThuan, ddidung: boolean);
Var
   i, j         :       longint;
   tong         :       longint;
Begin
mauthuan := true;
ddidung := false;
fillchar(a[0], sizeof(a[0]), 0);
a[k+1] := a[0]; a[k+1].y := m;

luu[dem+1] := k + 1;
luu[0] := 0;
tong := 0;
for i := 1 to dem + 1 do
    begin
    if a[luu[i]].y < a[luu[i-1]].y + tg^[a[luu[i-1]].x,a[luu[i]].x] then
       exit
    else
        tong := tong + a[luu[i]].z - cp^[a[luu[i-1]].x,a[luu[i]].x];
    end;

ddidung := true;
if tong = kqcb then mauthuan := false;
End;

Procedure TestSoKetQua(Var ok: longint);
{Ok = 0 tuc la toi uu hon Test
    = 1 tuc la dung
    = 2 tuc la khong toi uu}
Var
   i, j         :       longint;
Begin
if kqcb < ketqua[c] then ok := 2
else
   if kqcb = ketqua[c] then ok := 1
   else ok := 0;
End;

Procedure KiemTraVaCham;
var
   trung        :       Boolean;
   ddidung      :       boolean;
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
KtXuatFile(QuyCachXuatFile);
If Not QuyCachXuatFile Then
   Begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(27, 12); Writeln('Xuat sai - co 0 or Lap');
   Gotoxy(35, 13); Writeln(' Diem:  0');
   End
Else
   Begin
   KtDayCauHinh(mauthuan, ddidung);
   if not ddidung then
      begin
      Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
      Gotoxy(27, 12); Writeln('Xuat sai - duong di sai');
      Gotoxy(35, 13); Writeln(' Diem:  0'); exit;
      end;
   If MauThuan then
      Begin
      Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
      Gotoxy(26, 12); Writeln('Tong Va Duong Di Mau Thuan');
      Gotoxy(35, 13); Writeln(' Diem:  0');
      End
   Else
      Begin
      TestSoKetQua(ok);
      Case Ok of
           0: Begin
              Gotoxy(27, 11); Writeln('    Corect  ----  Corect');
              Gotoxy(31, 12); Writeln('Toi Uu Hon Test Cham');
              Gotoxy(35, 13); Writeln(' Diem:  1');
              End;
           1: Begin
              Gotoxy(27, 11); Writeln('    Corect  ----  Corect');
              Gotoxy(34, 12); Writeln('   Toi Uu   ');
              Gotoxy(35, 13); Writeln(' Diem:  1');
              End;
           2: Begin
              Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
              Gotoxy(29, 12); Writeln('Ket Qua Khong Toi Uu');
              Gotoxy(35, 13); Writeln(' Diem:  0');
              End;
           end;
      End;
   End
End;


Begin  {main}
{textbackground(0);}
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