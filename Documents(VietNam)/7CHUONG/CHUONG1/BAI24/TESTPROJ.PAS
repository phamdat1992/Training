program PROJECT;
uses Crt;
const
   fn	= 'PROJECT.IN5';
   fg	= 'PROJECT.OUT';
   maxn	= 120;
   dapso: array['1'..'7'] of longint= (251, 540, 491, 670, 1424, 465,123240000);
var
   d1, d  : array[0..maxn] of longInt;
   n, p: Integer;
   diem: real;
   TT, TongCp         : longint;
   Thue, Luong, SaThai:	longInt;
   fn1: string;
   chon: char;

procedure View;
var
   i: Integer;
begin
     writeln(' Chi phi thue   : ', Thue);
     writeln(' Luong thang    : ', Luong);
     writeln(' Chi phi sa thai: ', SaThai );
     writeln(' So giai doan: ', n);
     writeln(' So luong nhan cong can trong cac giai doan: ');
     for i:= 1 to n do writeln('    + Giai doan ', i, ': ', d[i]: 6);
     readln;
end;
(*--------------------------------------------------------------------------*)
procedure Nhap;
var
   f: Text;
   i: Integer;
begin
     assign(f, fn1); reset( f );
     readln(f, n);
     readln(f, Thue, Luong, SaThai);
     for i := 1 to n do read(f, d[i]);
     close( f );
     View;
end;

(*--------------------------------------------------------------------------*)

var i, j, k, max, st, sum: longint;
(*--------------------------------------------------------------------------*)
procedure Intg(i: integer);
begin
     writeln('Giai doan ', i);
     writeln('Tong chi phi: ', Sum);
     writeln('Bien dong nhan cong: ', d1[i]);
end;

(*--------------------------------------------------------------------------*)
procedure Evaluation;
var
   f: Text;
   i, dd: longInt;
begin
     diem:=0;
     assign(f, fg); reset(f);
     readln(f, TongCp);
     for i := 1 to n do  readln(f, d1[i]);
     close(f);
     dd:=0; sum:=0;
     for i:=1 to n do
     begin
         dd:=dd+d1[i];
         sum:= sum + dd*Luong;
         if d1[i]<0 then sum:=sum-d1[i]*Sathai;
         if d1[i]>0 then sum:=sum+ d1[i]*Thue;
         Intg(i);
         if dd<d[i] then
         begin
             writeln('LOI:  So luong nhan cong trong thang ',i);
             writeln('      khong dap ung yeu cau! ');
             readln; exit;
         end;
     end;
     if sum<> TongCp then
     begin
         writeln('Tinh sai chi phi: Theo file: ',Tongcp,' < > ',Sum,'(Tinh theo ke hoach)');
         readln; exit;
     end;
     writeln('................................');
     writeln('      CORRECT SOLUTION');
     writeln('................................');
     if TongCp>Dapso[chon] then
     begin
         writeln('Ke hoach thue co chi phi ',Tongcp,' > ',Dapso[chon],'(dap so)');
         readln; exit;
     end;
     if chon<>'7' then diem:=1.5 else diem:=1.;
end;
(*--------------------------------------------------------------------------*)
BEGIN
     ClrScr;
     writeln('            ****************************************');
     writeln('                     CHAM BAI THUE NHAN CONG');
     writeln('            ****************************************');
     write  ('                 Cho ten file Test: PROJECT.IN');chon:=readkey;
     writeln(chon); fn1:='PROJECT.IN'+chon;
     Nhap;
     Evaluation;
     writeln;
     writeln('            ********************************');
     writeln('                       Diem: ', diem:4:1);
     writeln('            ********************************');
     readln;
END.

PROJECT.IN1
5
4 5 6
10 9 8 3 4
Chi phi:  251

PROJECT.IN2
10
4 5 46
10 9 8 7 6 5 4 3 2 1
Chi phi: 547

PROJECT.IN3
10
4  5  16
10 9 8 7 6 5 6 7 8 9


PROJECT.IN4
12
4  5  26
10 9 8 7 6 5 6 7 8 9 11 15


PROJECT.IN5
12
4  5  12
20 9 8 17 6 5 16 7 8 29 11 35

PROJECT.IN6
10
4 5 20
10 9 8 7 6 5 4 3 2 1

