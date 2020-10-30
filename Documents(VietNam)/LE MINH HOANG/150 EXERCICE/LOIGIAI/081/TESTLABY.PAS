(**********************************************************)
(*                  Cham bai LABYRINTH                    *)
(**********************************************************)
{$r+}
Uses Crt;
const
      tfi: string = 'LABYR.IN0';
      tfo         = 'LABYR.OUT';
      dapso: array['0'..'9'] of longint =
(3804, 0, 84, 494, 1020, 1750, 79001, 2326, 3376, 4160);

var
   f     : text;
   chon  : char;
   diem  : integer;

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
     writeln('                  CHUONG TRINH CHAM BAI: ME CUNG');
     writeln('           ============================================');
     write  ('                  Cho ten file: LABYR.IN'); chon:=readkey;
     writeln(chon); tfi:='LABYR.IN'+chon;
     Cham;
     writeln;
     writeln('                  ***************************');
     writeln('                           Diem: ',diem);
     writeln('                  ***************************');
     readln;
END.
 0.
 79001.
 0.
 84.
 494.
 1020.
 1750.
 2730.
 2326.
 3376.
 4160.
 3804.
 7346.
 1390.
 1812.
 898.
 576.
 2094.
 1898.
 1772.
 222.
 426.
 1620.
 1010.
 2022.
 1758.
 1110.
 824.
 344.
 2304.
 1590.

