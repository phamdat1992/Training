{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBaiPhanPhoiKenh_Chanel_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Chanel.ou';
     Inp          : String  =       'Chanel.in';
     ketqua       : array ['0'..'9'] of integer = (2546,8,16,53,103,259,215,510,1017,2538);
     Maxn         = 5001;
Type
     rec                =       record
                                s, t  : longint;
                                end;
   Arr1                 =       Array [0..Maxn] of integer;
   Arr2                 =       Array [1..Maxn] of rec;
   Arr3                 =       Array [1..Maxn] of boolean;
Var
   f                    :       text;
   c                    :       char;
   a                    :       Arr2;
   b                    :       arr1;
   n                    :       Integer;
   Dem                  :       integer;



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
Gotoxy(16,4);Writeln('TEST CHAM BAI PHAN PHOI KENH: CHANEL - 30/4/2002');
Textcolor(15);
gotoxy(36,wherey+1);
Write('CHANEL.IN');
c:=readkey;
Writeln(c);
{If Not ((c <= '9') and (c >= '0')) then
   Begin
   gotoxy(26,11);
   Textcolor(6);
   Writeln('Nhap Ten File Du Lieu Sai');
   Readln;
   halt;
   End;}
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
Readln(f, n);
fillchar(a, sizeof(a), 0);
For i := 1 to n do
    readln(f, a[i].s, a[i].t);
Close(f);
End;


{************************************************************}
{************************************************************}

Var
   ketquacb     :       integer;


{Doc File Ket Qua - Doc Ket Qua Cua Loi Giai Cua Ban}
Procedure DocFileKetQua;
Var
   i            :       integer;
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

Readln(f, ketquacb);
{Close(f);}
End;

Function KiemTraGiaTriDau: Boolean;
Begin
KiemTraGiaTriDau := (ketquacb <= ketqua[c]);
End;


Function Kiemtracachphancong(ketquacb: integer): boolean;
Var
   i, j, k, dem :       integer;
   chuaxet      :       arr3;
Begin
fillchar(chuaxet, sizeof(chuaxet), 1);
dem := 0;
for i := 1 to ketquacb do
    begin             {doc thanh phan thu i}
    Fillchar(b, sizeof(b), 0);
    While not seekeoln(f) do
          begin
          inc(b[0]);
          read(f, b[b[0]]);
          if chuaxet[b[b[0]]] then chuaxet[b[b[0]]] := false
          else   begin  Kiemtracachphancong := false;  exit; end;
          end;
    readln(f);
    dem := dem + b[0];
    {xu li thanh phan thu i}
    for j := 1 to b[0] - 1 do
        for k := j + 1 to b[0] do
        if not ((a[b[j]].t <= a[b[k]].s) or (a[b[k]].t <= a[b[j]].s)) then
           begin   Kiemtracachphancong := false;   exit;  end;
    end;
Kiemtracachphancong := dem = n;
End;

Procedure KiemTraVaCham;
Var
   Dung         :       Boolean;
   kt1, kt2     :       Boolean;
Begin
Textcolor(3);
Gotoxy(18,10);
Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
Gotoxy(18,11);
Writeln('&                                           &');
Gotoxy(18,12);
Writeln('&                                           &');
Gotoxy(18,13);
Writeln('&                                           &');
Gotoxy(18,14);
Writeln('&                                           &');
Gotoxy(18,15);
Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
Textcolor(4);
kt1 := kiemtragiatridau;
kt2 := Kiemtracachphancong(ketquacb); close(f);

If kt2 then
   begin
   gotoxy(22, 12);
   Writeln('Cach Phan Cong Chap Nhan Duoc');
   end
Else
   begin
   gotoxy(22, 12);
   Writeln('Cach Phan Cong Mau Thuan');
   end;

If ketquacb = ketqua[c] then
   Begin
   gotoxy(22, 11);
   Writeln('So Luong Kenh Su Dung Toi Uu');
   End
Else
   Begin
   gotoxy(22, 11);
   If ketquacb > ketqua[c] then
      Begin
      Writeln('So Luong Kenh Khong Toi Uu');
      gotoxy(22, 12);
      End
   Else
      if (ketquacb < ketqua[c]) then
            Writeln('So Luong Kenh Toi Uu Hon Dap An)')
   End;

Dung := kt1 and kt2;
If Dung Then
   Begin
   Gotoxy(22,13);
   Writeln('Corect ---- Corect');
   Gotoxy(22,14);
   Writeln('Diem: 1 Diem')
   End
Else
   Begin
   Gotoxy(22,13);
   Writeln('Not Corect ---- Not Corect');
   Gotoxy(22,14);
   Writeln('Diem: 0 Diem')
   End
End;



Begin  {main}
{textbackground(0);}
Clrscr;
NhapTenFileDuLieu;
inp := inp + c;
out := out + c;
DocFileDuLieu;
DocFileKetQua;
KiemTraVaCham;
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Writeln('Chu y: Da xoa file ket qua');
Readln;
textbackground(black);
clrscr;
End.