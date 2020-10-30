{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

program test_contour;
{ test bai su dung file mau CONTOUR.AN? de test }
uses    crt;
const
        sotest                          = 5;     { So test cho bai }
        mark                            = 10.0 /sotest;  { Tong diem bai }
        {-----------------------------------------}
        tfi                             : string[13] = 'contour.inp';
        tfo                             : string[13] = 'contour.out';
        tfa                             : string[13] = 'contour.ans';
        max                             = 10000;
type
        mang1int                        = array [0..max] of integer;
                                          {0_thua; 1_thang}
        mang1byt                        = array [0..max] of byte;                                         {0_thua; 1_thang}
var
        fi, fa, fo                      : text;
        diem                            : real;
        test                            : char;
        sl                              : longint;
        x, y                            : mang1int;
        dau                             : mang1byt;
        tdx, tdy, chay                  : longint;

(*===================================================*)
procedure chuanbi;
begin
     clrscr;
     writeln;
     writeln('          Chuong trinh cham test bai CONTOUR');
     writeln('          **********************************');
       write('           Cham test CONTOUR.IN');
       test := readkey; writeln(test);
     tfi := 'contour.in' + test;
     tfa := 'contour.an' + test;
     assign(fi, tfi); reset(fi);
     assign(fa, tfa); reset(fa);
     assign(fo, tfo); reset(fo);
     diem := mark;
end;
(*===================================================*)
procedure nhapans;
begin
     sl := 0;
     while not seekeof(fa) do
     begin
          inc(sl);
          read(fa, x[sl], y[sl]);
     end;
     fillchar(dau, sizeof(dau), 0);
end;
(*=================================================*)
procedure docout;
var
   i    : integer;
begin
     if seekeof(fo) then
     begin
          diem := 0;
          writeln;
          writeln('   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          writeln('          Error : Khong in du so dinh');
          writeln('   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          exit;
     end;
     readln(fo, tdx, tdy);
     for i := 1 to sl do
         if (x[i] = tdx) and (y[i] = tdy) then
         begin
              if dau[i] = 0 then begin dau[i] := 1; exit; end;
              diem := 0;
              writeln;
              writeln('   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
              writeln('      Error : Dinh so ', chay);
              writeln('                   BI LAP LAI');
              writeln('   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
              exit;
         end;
     diem := 0;
     writeln;
     writeln('   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
     writeln('      Error : Dinh so ', chay);
     writeln('                   DINH KHONG TON TAI');
     writeln('   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
end;
(*===================================================*)
procedure main;
begin
     nhapans;
     for chay := 1 to sl do
     begin
          docout;
          if diem = 0 then exit;
     end;
end;
(*===================================================*)
procedure theend;
begin
     writeln;
     writeln('         *****************************');
     writeln('         *       Diem : ', diem :6:2, '       *');
     writeln('         *****************************');
     writeln;
     writeln('     ( Diem toi da cho moi test : ', mark:0:2, ' )');
     close(fi);
     close(fo);
     close(fa);
     readln;
end;
(*===================================================*)

begin
     chuanbi;
     main;
     theend;
end.
