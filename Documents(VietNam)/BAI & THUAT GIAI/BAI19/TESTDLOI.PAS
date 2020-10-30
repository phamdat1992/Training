{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_Day_con_loi_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Dayloi.ou';
     Inp          : String  =       'Dayloi.in';
     ketqua       : array ['0'..'9'] of integer = (0,9,17,35,55,87,121,4000,0,193);
     Maxn         = 5001;
Type
    Arr1          =       Array [0..Maxn] of Integer;
Var
   a, luu               :       arr1;
   f                    :       text;
   c                    :       char;
   n, dem               :       Integer;
   CachXuatF            :       boolean;
   Dung                 :       boolean;
   Ok, Diem             :       Integer;

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
Gotoxy(26,4);Writeln('TEST CHAM BAI DAY CON LOI');
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
readln(f, n);
fillchar(a, sizeof(a), 0);
for i := 1 to n do
    read(f, a[i]);
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
readln(f, dem);
fillchar(luu, sizeof(luu), 0);
for i := 1 to dem do
    read(f, luu[i]);
Close(f);
End;

Procedure KtCauHinh(Var Dung: boolean);
Var
   i, j         :       integer;
Begin
Dung := False;
i := 1;
while luu[i] > luu[i+1] do inc(i);
while luu[i] < luu[i+1] do inc(i);
if i < dem then exit;

i := 0;
j := 1;
if dem > 0 then
repeat
      inc(i);
      while (luu[i] <> a[j]) and (j <= n) do inc(j);
      if j > n then exit;
      until i = dem;
Dung := True;
End;

Procedure TestSoKetQua(Var ok: Integer);
{Ok = 0 tuc la toi uu hon Test
    = 1 tuc la dung
    = 2 tuc la khong toi uu}
Var
   i, j         :       integer;
Begin
if dem < ketqua[c] then ok := 2
else
   if dem = ketqua[c] then ok := 1
   else ok := 0;
End;

Procedure KiemTraVaCham;
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
KtCauHinh(Dung);
ok := 2;
If dung then testsoketqua(ok);
if dung and (ok <> 2) then
   begin
   diem := 1;
   Gotoxy(27, 11); Writeln('    Corect -----  Corect');
   if ok = 0 then
      begin   Gotoxy(30, 12); Writeln(' Toi uu hon test cham');   end
   else
      begin   Gotoxy(36, 12); Writeln(' Toi uu');   end
   end
else
   begin
   diem := 0;  Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');  end;
if not dung then
   begin Gotoxy(27, 12); Writeln('Cach xuat file khong dung'); end
else
   if ok = 2 then begin Gotoxy(34, 12); Writeln('Khong toi uu') end;
Gotoxy(35, 13); Writeln(' Diem:  ', diem);
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