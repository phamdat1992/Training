Uses crt;
const
  FileIn : string = 'DIV.IN';
  FileOut: string = 'DIV.OUT';
  Dapso: array['0'..'9',1..5] of integer=
(
(1, 0, 1, 0, 1),
(1, 1, 0, 0, 0),
(0, 1, 1, 0, 1),
(0, 0, 1, 1, 1),
(1, 0, 1, 1, 0),
(0, 1, 0, 1, 1),
(0, 0, 1, 1, 1),
(0, 1, 0, 0, 1),
(0, 0, 1, 1, 1),
(0, 1, 0, 1, 0)
);
  dds:array[0..1] of string =('NO','YES');

var
  f: text;
  d, i: integer;
  sol : string;
  diem: real;
  chon: char;

BEGIN
    clrscr;
    writeln('                     CHUONG TRINH CHAM BAI: DIV');
    writeln('                     ============================');
    write  ('                     Cho ten file test: DIV.IN');
	chon:=readkey; writeln(chon);
    FileIn := 'DIV'+chon+'.IN';
    FileOut := 'DIV'+chon+'.OUT';
    assign(f, FileIn); reset(f);
    readln(f,d);
    close(f);
    assign(f, FileOut); reset(f);
    diem:=0;
    for i:=1 to d do
    begin
        readln(f,sol);
        if sol<> dds[dapso[chon,i]] then
        begin
            writeln; writeln;
            writeln('??????????????????????????????????????????');
            writeln('      Subtest: ',i);
            writeln('      ERROR: Khong dung dap so!');
            writeln('      Tim duoc: ',sol);
            writeln('      Dap so  : ', dds[dapso[chon,i]]);
            writeln('??????????????????????????????????????????');
            readln;
        end
        else diem:= diem+0.6;
    end;
    close(f);
    writeln; writeln;
    writeln('                   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    writeln('                              Diem: ',diem:4:1);
    writeln('                   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    readln;
END.