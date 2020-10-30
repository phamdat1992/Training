(*    Cham bai Xay dung nha may bia *)
uses crt;
const
    fin: string = 'BRO.IN';
    fou: string = 'BRO.OUT';
    dapso: array['0'..'9'] of extended=
    (178266221936.,
    783,
    4951050000.,
    1453643,
    2062300,
    6318812500.,
    30518011398.,
    199800000000.,
    412365129500.,
    25000000. );
var
   n: integer;
   c: longint;
   diem: integer;
   ds1: extended;
   f: text;
   chon: char;

procedure Cham;
var i: integer;
begin
    assign(f,fin); reset(f);
    readln(f,n);
    readln(f,c);
    close(f);
    assign(f,fou); reset(f);
    readln(f,ds1);
    close(f);
    if ds1<>dapso[chon]*c then
    begin
        writeln;
        writeln('???????????????????????????????????????????????');
        writeln('       E R R O R:   Khong dung dap so!');
        writeln('                    Tim duoc: ',ds1:16:0);
        writeln('                    Dap so  : ',dapso[chon]*c:16:0);
        writeln('???????????????????????????????????????????????');
        exit;
    end;
    writeln;
    writeln('**********************************');
    writeln('           C O R R E C T !');
    writeln('**********************************');
    diem:=1;
end;

BEGIN
   clrscr;
   writeln('            ============================================');
   writeln('                CHUONG TRINH CHAM BAI XAY DUNG NM BIA');
   writeln('            ============================================');
   write  ('                        Cho ten file test: BRO.IN'); chon:=readkey;
   writeln(chon); writeln;
   fin:='BRO'+chon+'.IN';
   Cham;
   writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   writeln('                              Diem: ' , diem);
   writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   readln;
END.
BRO10.OUT