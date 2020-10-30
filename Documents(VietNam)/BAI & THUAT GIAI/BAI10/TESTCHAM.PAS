{$M 65384,0,655360}
Program ChuongTrinhTestBai_TQA2K30PBC;
Uses Crt;
Const
     out          : string  =       'Danden.ou';
     Inp          : String  =       'Danden.in';
     ketqua       : array ['0'..'9'] of byte = (107,5,7,15,17,18,37,47,58,70);
     Maxn         = 15000;
Type
    toado               =       record
                                x, y  : integer;
                                end;
    arr1                =       array [1..maxn] of integer;
    arr2                =       array [1..maxn] of toado;
Var
   mau, ind             :       arr1;
   a                    :       ^arr2;
   f                    :       text;
   c                    :       char;
   k, m, n, dem         :       Integer;
   kqcb                 :       integer;
   Pmark                :       pointer;

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
Gotoxy(26,4);Writeln('TEST CHAM BAI DAN DEN MAU');
Textcolor(15);
gotoxy(35,wherey+1);
Write('DANDEN.IN');
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
Readln(f, m, n, k);
new(a);
For i := 1 to k do
    readln(f, a^[i].x, a^[i].y);
Close(f);
End;

Procedure DocFileCanTest_FileKetQua;
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
dem := 0;
While not eof(f) do
      begin
      inc(dem);
      readln(f, mau[dem]);
      end;
if mau[dem] = 0 then dec(dem);
Close(f);
End;


procedure QuickSort(Lo, Hi: Integer);

procedure Sort(l, r: Integer);
var
  i, j, x, y: integer;
begin
  i := l; j := r; x := mau[(l+r) DIV 2];
  repeat
    while mau[i] < x do i := i + 1;
    while x < mau[j] do j := j - 1;
    if i <= j then
    begin
      y := mau[i]; mau[i] := mau[j]; mau[j] := y;
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

function cc(i: integer): boolean;
begin
cc := (a^[ind[i]].x = a^[ind[i-1]].x) or (a^[ind[i]].y = a^[ind[i-1]].y);
end;

Procedure Kiemtracachtomau(var ok: boolean);
var
   i, j         :       integer;
   max          :       integer;
Begin
{new(ind);}
for i := 1 to k do
    ind[i] := i;
Quicksort(1,k);
max := 0;
for i := 1 to k do
    if mau[i] = 0 then begin ok := false; exit; end
    else   if max < mau[i] then max := mau[i];
if max <> kqcb then begin ok := false; exit; end;

for i := 2 to k do
    if (mau[i] = mau[i-1]) and cc(i) then
           begin ok := false; exit; end;
ok := true;
End;


Procedure KiemTraVaCham;
var
   ok           :       Boolean;
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

If dem < k then
   begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(28, 12); Writeln('Xuat file sai quy cach');
   Gotoxy(35, 13); Writeln(' Diem: 0');
   Exit;
   end;

Kiemtracachtomau(ok);
if not ok then
   begin
   Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
   Gotoxy(28, 12); Writeln('Cach to mau khong dung');
   Gotoxy(35, 13); Writeln(' Diem: 0'); Exit;
   end
else
   begin
   if kqcb > ketqua[c] then
         begin
         Gotoxy(27, 11); Writeln('Not Corect -- Not Corect');
         Gotoxy(35, 13); Writeln(' Diem: 0');
         Gotoxy(23, 12); Writeln(' Cach to dung nhung so mau to lon');
         end
   else
       begin
       Gotoxy(26, 11); Writeln('    Corect  ----  Corect');
       If kqcb < ketqua[c] then
          begin Gotoxy(23, 12); Writeln(' Toi uu hon dap an') end
       Else
          begin Gotoxy(27, 12); Writeln(' Cach to mau cac dinh dung'); end;
       Gotoxy(35, 13); Writeln(' Diem: 1');
       end;
   end;
End;


Begin  {main}
{textbackground(6);}
Mark(PMark);
Clrscr;
NhapTenFileDuLieu;
inp := inp + c;
out := out + c;
DocFileCanTest_FileKetQua;
DocFileDuLieu;
KiemTraVaCham;
Release(pmark);
Assign(f, out);
Erase(f);
Gotoxy(27, 16);
Writeln('Chu y: Da xoa file ket qua');
Readln;
End.