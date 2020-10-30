{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Program ChuongTrinhTestBai_TreoTranh_Picture_TQA2K30PBC;
Uses Crt, Graph;
Const
     out          : string  =       'Tao.ou';
     Inp          : String  =       'Tao.in';
     ketqua       : array ['0'..'9'] of longint = (21359, 286740, 275094, 159120, 106820, 49256, 29872, 41902, 30672, 19740);
     Maxn         = 605;
Type
    point         =       record
                          x, y  :       integer;
                          end;
    Arr1          =       Array [0..Maxn] of point;
Var
   P                    :       arr1;
   f                    :       text;
   c                    :       char;
   n                    :       Integer;
   kqcb                 :       longint;
   trentrai, duoiphai   :       point;
   Quycachxuatfile      :       boolean;
   Mauthuan             :       boolean;
   Ok                   :       Integer;

procedure ktgraph;
var
   gd, gm               :       integer;
begin
{Khoi tao graph}
gd := detect;
initgraph(gd, gm,'');
if graphresult <> 0 then
   begin
   writeln(' Co loi do hoa');
   Halt(1);
   end;
end;


procedure Vedagiac;
type
    Arr3                =       Array [1..4] of pointtype;
var
   i, gd, gm            :       integer;
   dentax, dentay       :       integer;
   M1                   :       point;
   s, st                :       string;
   tren, duoi           :       point;
   dophongdai, tmp      :       real;
begin
Dophongdai := 0.4;
{ve}
SetTextJustify(centertext, centertext);
dentax := 320- 200;
dentay := {240} 275 - 200;

setfillstyle(1, cyan);
Bar(dentax, dentay, 400 + dentax, 400 + dentay);

tren.x := trunc(trentrai.x * dophongdai) + dentax;
tren.y := trunc(trentrai.y * dophongdai) + dentay;
duoi.x := trunc(duoiphai.x * dophongdai) + dentax;
duoi.y := trunc(duoiphai.y * dophongdai) + dentay;
setfillstyle(1, lightblue);
Bar(tren.x, tren.y, duoi.x, duoi.y);

{ve dinh}
for i := 1 to n do
    begin
    P[i].x := trunc(P[i].x * dophongdai) + dentax;
    P[i].y := trunc(P[i].y * dophongdai) + dentay;
    end;
{Setcolor(red);
For i := 1 to n do
    begin
    Line(P[i].x, dentay, P[i].x, 400 + dentay);
    Line(dentax, P[i].y, 400 + dentax, P[i].y);
    end;}
setfillstyle(1, red);
Setcolor(white);
for i := 1 to n do
    begin
    Str(i, s);
    fillellipse(P[i].x, P[i].y, 7, 7); {ve hinh elip co to dac}
    Outtextxy(P[i].x, P[i].y, s);
    end;

Str(ketqua[c], S);
S := 'Ket qua dap an la     : ' + S;
Outtextxy(320, 15, s);

Str(kqcb, S);
S := 'Dien tich ban tim duoc: ' + S;
Outtextxy(320, 25, s);
end;


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
Gotoxy(15,4);Writeln('TEST CHAM BAI VUON TAO - HCN C0 DIEN TICH LON NHAT');
Textcolor(15);
gotoxy(37,wherey+1);
Write('TAO.IN');
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
fillchar(P, sizeof(P), 0);
for i := 1 to n do
    readln(f, P[i].x, P[i].y);
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
readln(f, kqcb);
readln(f, trentrai.x, trentrai.y);
readln(f, duoiphai.x, duoiphai.y);
{Doc file}
Close(f);
End;

Procedure KiemtraDienTichHCN(Var MauThuan: boolean);
Var
   Tg           :       longint;
Begin
tg := (duoiphai.x - trentrai.x);
tg := tg * (duoiphai.y - trentrai.y);
if kqcb <> tg then mauthuan := true
else               mauthuan := false;
End;

procedure Kiemtradiemthuochinhchunhat(var found: boolean);
var
   i            :       integer;
begin
found := true;
for i := 1 to n do
    if (p[i].x < duoiphai.x) and (p[i].x > trentrai.x) then
       if (p[i].y < duoiphai.y) and (p[i].y > trentrai.y) then
          exit;
found := false;
end;

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
   found, mauthuan, dung:       Boolean;
   ok                   :       integer;
   S                    :       string;
Begin
KiemtraDienTichHCN(MauThuan);
Kiemtradiemthuochinhchunhat(found);
TestSoKetQua(ok);

Ktgraph;
Vedagiac;
Setcolor(red);
S := 'Chuong Trinh Test Bai Vuon Tao: ' + inp;
Outtextxy(320, 5, S);
Setcolor(white);
if mauthuan then
   outtextxy(320, 53, 'Dien tich va toa do hcn mau thuan');
if found then
   outtextxy(320, 63, ' Co diem thuoc mien trong hcn');
if (not mauthuan) and (not found) and (ok <> 2) then
   begin
   if ok = 0 then outtextxy(320, 35, 'Toi uu hon test')
   else if ok = 1 then outtextxy(320, 35, 'Corect -- Corect');
   dung := true;
   end;
if mauthuan or found or (ok = 2) then
   begin
   dung := false;
   outtextxy(320, 35, 'Not Corect - Not Corect');
   end;
setcolor(red);
if dung then          outtextxy(320, 45, 'Diem : 1')
else                  outtextxy(320, 45, 'Diem : 0');
readln;
closegraph;
End;


Begin  {main}
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