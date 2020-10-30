{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_Activity_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Activity.ou';
     Inp          : String  =       'Activity.in';
     ketqua       : array ['0'..'9'] of integer = (1091,5,7,34,67,82,115,366,832,1017);
     Maxn         = 4000;
     cons         = 32;
Type
    Arr1          =       Array [1..Maxn] of integer;
    Arr2          =       Array [1..Maxn] of longint;
Var
   Luu, Tam             :       Arr2;
   dd, cc, ind          :       Arr1;
   f                    :       text;
   c                    :       char;
   n, m, dem            :       longint;
   kqcb                 :       integer;
   Quycachxuatfile      :       boolean;
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
Gotoxy(18,4);Writeln('TEST CHAM BAI BO TRI PHONG HOP - 30/4/2002');
Textcolor(15);
gotoxy(34,wherey+1);
Write('ACTIVITY.IN');
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

Procedure MoFileDuLieu;
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
Readln(f, n);
{Chua dong file - su dung o thu tuc kiemtracachbotriphonghop}
End;

Procedure DocFileCanTest;
Var
   i            :       Integer;
   j            :       longint;
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
For i := 1 to kqcb do
    read(f, luu[i]);
Close(f);
End;

Procedure KiemtraCachXuatFile(Var QuyCachXuatFile: boolean);
Var
   i, j         :       longint;
   u, v         :       longint;
Begin
For i := 1 to kqcb do {Kiem tra so am hoac lon hon n}
    if (Luu[i] < 0) or (luu[i] > n) then
       Begin QuyCachXuatFile := False; Exit; End;
{Kiem tra tinh khac nhau cua cac cuoc hop}
For i := 1 to kqcb - 1 do
    For j := i + 1 to kqcb do
        if luu[i] = luu[j] then Begin QuyCachXuatFile := False; Exit; End;
QuyCachXuatFile := True;
End;

procedure QuickSort(Lo, Hi: Integer);
{Sap xep mang luu - tam}

procedure Sort(l, r: Integer);
var
  i, j          : integer;
  x, y          : longint;
begin
  i := l; j := r; x := tam[(l+r) Div 2];
  repeat
    while (tam[i] < x) do i := i + 1;
    while (x < tam[j]) do j := j - 1;
    if i <= j then
    begin
      y := tam[i]; tam[i] := tam[j]; tam[j] := y;
      y := ind[i]; ind[i] := ind[j]; ind[j] := y;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
end;

begin {QuickSort};
  Sort(Lo,Hi);
end;

Procedure KiemtraCachBoTriPhongHop(Var MauThuan: boolean);
{Tra Gia Tri True Neu Trong Ket Qua Cua Ban Co Su Mau Thuan}
Var
   i, j, t      :       longint;
   d, c         :       integer;
   luuc         :       integer;
   tg           :       arr1;
Begin
luuc := 0;
Tam := luu; For i := 1 to kqcb do ind[i] := i;
Quicksort(1, kqcb);
j := 1;
for i := 1 to n do
    Begin
    readln(f, d, c);
    If i = tam[j] then
       begin
       dd[j] := d; cc[j] := c; inc(j);
       if j = kqcb + 1 then break;
       end;
    End;
tg := dd;
For i := 1 to kqcb do dd[ind[i]] := tg[i];
tg := cc;
For i := 1 to kqcb do cc[ind[i]] := tg[i];

For i := 1 to kqcb - 1 do
    if cc[i] > dd[i+1] then begin MauThuan := True; Exit; end;
MauThuan := False;
Close(f);
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
KiemtraCachXuatFile(QuyCachXuatFile);
If Not QuyCachXuatFile Then
   Begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(25, 12); Writeln('Xuat Sai: Co So Am Hoac Trung');
   Gotoxy(35, 13); Writeln(' Diem: 0');
   Exit;
   End;
   KiemtraCachBoTriPhongHop(mauthuan);
   If MauThuan then
      Begin
      Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
      Gotoxy(26, 12); Writeln('Bo Tri Phong Hop Khong Dung');
      Gotoxy(35, 13); Writeln(' Diem: 0');
      End
   Else
      Begin
      TestSoKetQua(ok);
      Case Ok of
           0: Begin {Toi uu hon}
              Gotoxy(27, 11); Writeln('    Corect  ----  Corect');
              Gotoxy(31, 12); Writeln('Toi Uu Hon Test Cham');
              Gotoxy(35, 13); Writeln(' Diem: 1');
              End;
           1: Begin {Dung}
              Gotoxy(26, 11); Writeln('    Corect  ----  Corect');
              Gotoxy(30, 12); Writeln('Cach Bo Tri Phu Hop');
              Gotoxy(35, 13); Writeln(' Diem: 1');
              End;
           2: Begin {Khong toi uu}
              Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
              Gotoxy(30, 12); Writeln('Cach Bo Tri Phu Hop');
              Gotoxy(26, 13); Writeln(' Khong Toi Uu --- Diem: 0');
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
DocFileCanTest;
MoFileDuLieu;
KiemTraVaCham;
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Textcolor(2);
Writeln('Chu y: Da xoa file ket qua');
Readln;
End.