{  Test PERIOD }
{$R+}
{$M 60384,0,655360}

Uses  Crt;
Const
      inp: string = 'PERIOD.IN1';
      out         = 'PERIOD.OUT';
   dapso1: array['0'..'9'] of integer = ( 96, 0,  8999,  4, 799, 4, 63, 71, 0, 156 );
   dapso2: array['0'..'9'] of string = (
   '871332', '1', '1', '9996', '1', '6', '13',
   '4585463908266590128842601028100640139030567288601014644837921387',
   '10000',
   '30517233228914154605281150918939894987435329094100893358053355043357948068678794791814712228407896674476632944920'+
   '228893019697105927'
   );

Var
      F          : Text;
      d1         : longint;
      d2         : string;
      diem       : real;
      chon       : char;

Procedure Cham;
Begin
    diem:=0;
    Assign(f,out); Reset(f);
    readln(f, d1, d2);
    close(f);
    while d2[1]= ' ' do d2:= copy(d2, 2, length(d2)-1);
    writeln;
    writeln('Ket qua tim duoc: ',d1,' ', d2);
    writeln('Dap so          : ', dapso1[chon],' ', dapso2[chon]);
    if d1<> dapso1[chon] then
    begin
           writeln('???????????????????????????????????????????????????');
           writeln('   ERROR: Sai dap so 1!');
           writeln('              Tim duoc: ', d1);
           writeln('              Dap so  : ',dapso1[chon]);
           writeln('???????????????????????????????????????????????????');
    end
    else diem:=diem+0.5;
    if d2<>dapso2[chon] then
    begin
        writeln('???????????????????????????????????????????????????');
        writeln('   ERROR: Sai dap so 2!');
        writeln('              Tim duoc: ', d2);
        writeln('              Dap so  : ',dapso2[chon]);
        writeln('???????????????????????????????????????????????????');
    end
    else diem:=diem+0.5;
End;

Begin
   Clrscr;
   writeln('            ===========================================');
   writeln('                  CHUONG TRINH CHAM BAI PERIOD');
   writeln('            ===========================================');
   write  ('                  Cho ten file test: PERIOD.IN');
   chon:=readkey; writeln(chon);
   inp:= 'PERIOD.IN'+chon;
   Cham;
   writeln; writeln;
   writeln('            ====================================');
   writeln('                         Diem: ', diem:4:1);
   writeln('            ====================================');
   readln;
End.
