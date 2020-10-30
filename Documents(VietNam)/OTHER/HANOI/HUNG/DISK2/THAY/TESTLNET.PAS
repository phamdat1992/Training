const
    fin: string = 'LIGHTNET.IN';
    fou: string = 'LIGHTNET.OUT';
    dapso: array['1'..'2', 1..10] of string[3] =
    (('YES','NO','YES','YES','NO','NO','NO','YES','YES','YES'),
    ('YES','NO','YES','NO','YES','YES','NO','NO','YES','NO' ));
var
   f           : text;
   ntest, diem : integer;
   chon        : char;
   odd, even   : integer;

procedure Evaluation;
var
   i: integer;
   ds: string[3];
begin
    diem:=0;
    odd:=0;
    even:=0;
    assign(f,fin); reset(f);
    readln(f,ntest);
    close(f);
    assign(f,fou); reset(f);
    for i:=1 to ntest do
    begin
         readln(f,ds);
         if ds<>dapso[chon,i] then
         begin
            writeln('??????????????????????????????????????');
            writeln('    Tra loi sai: Test ',chon,'.',i);
            writeln('ds: ',ds);
            writeln('dapso: ',dapso[chon,i]);
            writeln('??????????????????????????????????????');
            readln;
         end
         else
         begin
            diem:=diem+1;
            if dapso[chon,i]='YES' then odd:=odd+1
            else even:=even+1;
         end;
    end;
    close(f);
    if (odd=0) or (even=0) then diem:=0;
end;


BEGIN

   writeln('                 =========================================');
   writeln('                       CHUONG TRINH CHAM BAI LIGHTNET');
   writeln('                 =========================================');
   write  ('                    Cho ten file test: LIGHTNET.IN');
   chon:='2'; writeln(chon);
   fin:='LIGHTNET.IN'+chon;
   Evaluation;
   writeln; writeln;
   writeln('                  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   writeln('                                 Diem: ',diem);
   writeln('                  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   if (diem=0) and (odd=0) then
   writeln('                              Luon tra loi: NO');
   if (diem=0) and (even=0) then
   writeln('                              Luon tra loi: YES');
   readln;
END.


