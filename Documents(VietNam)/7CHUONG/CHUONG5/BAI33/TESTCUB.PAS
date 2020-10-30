(**********************************************************)
(*                  Cham bai MAXIMAL CUB                  *)
(**********************************************************)
{$r+}
Uses Crt;
const
      tfi: string = 'MAXCUB.IN5';
      tfo         = 'MAXCUB.OUT';
      dapso: array['0'..'9'] of longint =
(115002,1000, 8000, 16700, 30000, 10000, 68590,-10,13358,8611709);

var
   f     : text;
   chon  : char;
   diem  : real;

procedure Cham;
var
   i : integer;
   ds: longint;
   s : string;
begin
   diem:=0;
   assign(f,tfo); reset(f);
   readln(f,s);
   close(f);
   val(s,ds,i);
   if i<>0 then
   begin
       writeln('????????????????????????????????????????');
       writeln('    ERROR:  Dap so ghi o file: ', s);
       writeln('????????????????????????????????????????');
       exit;
   end;
   if ds<>dapso[chon] then
   begin
       writeln('????????????????????????????????????????????');
       writeln('    ERROR:  Khong dung dap so !');
       writeln('    Tim duoc: ',ds);
       writeln('    Dap so  : ',dapso[chon]);
       writeln('????????????????????????????????????????????');
       exit;
   end;
   diem:=1;
   writeln;
   writeln('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   writeln('        C O R R E C T!');
   writeln('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
end;


BEGIN
     clrscr;
     writeln('                CHUONG TRINH CHAM BAI: MAXIMAL CUB');
     writeln('           ============================================');
     write  ('                  Cho ten file: MAXCUB.IN'); chon:=readkey;
     writeln(chon); tfi:='MAXCUB.IN'+chon;
     Cham;
     writeln;
     writeln('                  ***************************');
     writeln('                           Diem: ',diem:4:1);
     writeln('                  ***************************');
     readln;
END.
