uses crt;
const
   dapso: array['1'..'7'] of integer = (198,72,12402,12384,10368,6192,10368);
   fou = 'mirror.out';
var
   chon: char;
   f: text;
   diem: real;

procedure Cham;
var cost: longint;
begin
   diem:=0;
   assign(f,fou); reset(f);
   readln(f, cost);
   close(f);
   if cost<>dapso[chon] then
   begin
       writeln;
       writeln('??????????????????????????????????????');
       writeln('      ERROR: Sai dap so:   Tim duoc: ',cost);
       writeln('                           Dap so  : ',dapso[chon]);
       writeln('??????????????????????????????????????');
       exit;
   end;
   writeln; writeln;
   writeln('*******************************************');
   writeln('      C o r r e c t! C o r r e c t!');
   writeln('*******************************************');
   diem:=1.5;
   if chon='1' then diem:=1;
end;

BEGIN
    clrscr;
    writeln('                    *****************************************');
    writeln('                           CHUONG TRINH CHAM BAI: MIRROR');
    writeln('                    *****************************************');
    write  ('                          Cho ten file du lieu: MIRROR.IN');
    chon:=readkey; writeln(chon); writeln;
    cham;
    writeln;    writeln;    writeln;
    writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    writeln('                                   Diem: ',diem:4:1);
    writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    readln;
END.
