{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S-,T-,V+,X+}
{$M 60000,0,655360}

program test_aut;
uses    crt;
const
        limit                           = 10.0;  { so diem toi da cua bai}
        sotest                          = 10;
        mark                            = limit / sotest;
        tfi                             : string[13] = 'rotation.inp';
        tfo                             = 'rotation.out';
        thang                           : array [2..15] of longint
        = (4, 12, 20, 60, 100, 300, 500, 1500, 2500, 7500,
          12500, 37500, 62500, 187500);
var
        fo                              : text;
        test                            : char;
        diem                            : real;
        tong                            : longint;
        n                               : integer;

(*================================================*)
procedure chuanbi;
begin
     clrscr;
     writeln;
     writeln('          Chuong trinh cham bai ROTATION');
     writeln('          ******************************');
       write('            Cham test ROTATION.IN');
       test := readkey; writeln(test);
     tfi := 'rotation.in' + test;
     assign(fo, tfi); reset(fo); readln(fo, n); close(fo);
     writeln;
     assign(fo, tfo); reset(fo);
     diem := mark;
end;
(*================================================*)
procedure nhaptong;
var
   c    : char;
begin
     if seekeof(fo) then
     begin
          diem := 0;
          writeln;
          writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          writeln('        Error : Khong in kq ra file');
          writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          exit;
     end;
     tong := 0;
end;
(*================================================*)
procedure nhapout;
var
   tr, doc      : string[20];
   i, j         : longint;
   sai          : boolean;
begin
     writeln;
     writeln('   Dang chech phan in cac xau');
     writeln('   ...');
     tr := '';
     for i := 1 to n do tr := tr + '0';
     while not seekeof(fo) do
     begin
          inc(tong);
          readln(fo, doc);
          if length(doc) <> n then
          begin
               diem := 0;
               writeln;
               writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
               writeln('        Error : Xau thu ', i);
               writeln('                Do dai xau khong dung');
               writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
               exit;
          end;
          for j := 1 to n do
              if not (doc[j] in ['0'..'9']) then
              if length(doc) <> n then
              begin
                   diem := 0;
                   writeln;
                   writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
                   writeln('        Error : Xau thu ', i);
                   writeln('                Co chua ky tu khong phai la chu so');
                   writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
                   exit;
              end;
          sai := false;
          for j := 1 to n + 1 do
          begin
               if j = n + 1 then begin sai := true; break; end;
               if ord(doc[j]) < ord(tr[j]) then
                  begin sai := true; break; end;
               if ord(doc[j]) > ord(tr[j]) then break;
          end;
          if sai then
              begin
                   diem := 0;
                   writeln;
                   writeln('     $$$$$$$$$$$$$$$$$$$$$');
                   writeln('           KHONG DUNG !');
                   writeln('     $$$$$$$$$$$$$$$$$$$$$');
                   exit;
              end;
              tr := doc;
     end;
     writeln('          So luong tim duoc : ', tong);
     writeln('                    Dap an  : ', thang[n]);
     if tong <> thang[n] then
     begin
          diem := 0;
          writeln;
          writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          writeln('        Error : Tong so luong tim duoc sai');
          writeln('     $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
          exit;
     end;
     writeln;
     writeln('          CORRECT !');
end;
(*================================================*)
procedure main;
begin
     nhaptong;
     if diem = 0 then exit;
     nhapout;
end;
(*================================================*)
procedure theend;
begin
     close(fo);
     writeln;
     writeln('          **************************');
     writeln('          *     Diem : ', diem :6:2, '      *');
     writeln('          **************************');
     writeln;
     writeln('        ( Diem toi da cho moi test : ', mark:0:2, ' )');
     readln;
end;
(*================================================*)

begin
     chuanbi;
     main;
     theend;
end.