{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_Truyen_Tin_Tren_Mang_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'TTin.ou';
     Inp          : String  =       'TTin.in';
     ketqua       : array ['0'..'9'] of longint = (44312,1444,2470,157,1349,
                                     6520,4695,11835,13455,14653);
     Maxn         = 101;
Type
    Mt1           =       array [1..maxn, 1..maxn] of longint;
    Arr1          =       Array [0..Maxn] of Integer;
Var
   a                    :       mt1;
   luu                  :       arr1;
   f                    :       text;
   c                    :       char;
   n, m, dem, k, s, t   :       Integer;
   kqcb, tongkt         :       longint;
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
Gotoxy(22,4);Writeln('TEST CHAM BAI TRUYEN TIN TREN MANG');
Textcolor(15);
gotoxy(35,wherey+1);
Write('TTIN.IN');
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
   i, u, v, cp  :       Integer;
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
Readln(f, n, m, s, t, k);
fillchar(a, sizeof(a), 0);
for i := 1 to m do
    begin
    readln(f, u, v, cp);
    a[u,v] := cp;
    a[v,u] := cp;
    end;
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
Readln(f, kqcb);
End;

Procedure KtXuatFile(Var CachXuatF: boolean; dem, dt: integer);
{dtruyen thu dt}
Var
   i, j         :       integer;
Begin
cachxuatf := false;
   {--} textcolor(2);
   Gotoxy(18,20);
   Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
   Gotoxy(18,21);
   Writeln('&                                           &');
   Gotoxy(18,22);
   Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
   textcolor(4);
   {--}
for i := 1 to dem do
    if (luu[i] <= 0) or (luu[i] > n) then
       begin
       Gotoxy(21,21);   Writeln('co dinh khong ton tai o duong truyen: ', dt);
       exit;{gioi han sai}
       end;
if (luu[1] <> s) or (luu[dem] <> t) then
   begin
   Gotoxy(25,21); Writeln('Duong di thu ', dt, ' khong tu ',s, ' den ',t);
   exit; {duong di khong phai tu s->t}
   end;
for i := 1 to dem - 1 do
    if a [luu[i], luu[i+1]] = 0 then
       begin
       Gotoxy(23,21); Writeln('Dtruyen khong ton tai hoac trung lap');
       exit;
       end;
   cachxuatf := true;
   {--} textcolor(0);
   Gotoxy(18,20);
   Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
   Gotoxy(18,21);
   Writeln('&                                           &');
   Gotoxy(18,22);
   Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
   {--} textcolor(4);
End;

Procedure TinhTheoCauHinh(Var tongkc: longint; dem: integer);
Var
   i            :       integer;
Begin
for i := 1 to dem - 1 do
    begin
    tongkc := tongkc + a[luu[i], luu[i+1]];
    a[luu[i], luu[i+1]] := 0;
    end;
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
   i            :       integer;
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
tongkt := 0;
for i := 1 to k do
    begin
    dem := 0; fillchar(luu, sizeof(luu), 0);
    while not seekeoln(f) do
          begin inc(dem); read(f, luu[dem]); end;      readln(f);
    if dem < 2 then
           begin
           close(f);
           gotoxy(22, 11); writeln('so duong truyen thieu');
           gotoxy(22, 12); writeln('Diem: 0');     readln; halt;
           end;
    KtXuatFile(CachXuatF, dem, i);
    If Not CachXuatF Then
       Begin
       Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
       Gotoxy(27, 12); Writeln('Cach xuat file khong dung');
       Gotoxy(35, 13); Writeln(' Diem: 0'); close(f); readln ; halt;
       End;
    TinhTheoCauHinh(tongkt, dem)
    end;
close(f);



   mauthuan := kqcb <> tongkt;
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
End;


Begin  {main}
{textbackground(6);}
Clrscr;
NhapTenFileDuLieu;
inp := inp + c;
out := out + c;
DocFileDuLieu;
DocFileCanTest;
KiemTraVaCham;
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Writeln('Chu y: Da xoa file ket qua');
Readln;
End.