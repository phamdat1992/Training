{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
uses crt;
const
    fin: string = 'FIRSTROW.IN5';
    fou: string = 'FIRSTROW.OUT';
    dapso: array['1'..'8'] of string =
    (
'us2',
'0',
'Good luck, Goodbye, This is a game, Game over',
'b',
'aaalllaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'+
'baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbb'+
'bbbbbbbbbbbbbbbbbbbbbb?',
'____________________________________________________________________________________________________________________'
+'___________________________________________________________________________________________________________________'
+'________________________',
'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+
'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+
'!!!!!!!!!!!!!!!!!!!!!!!',
'000'
    );

var
   s: string;
   f: text;
   chon: char;
   diem: integer;

BEGIN
   clrscr;
   writeln('            ============================================');
   writeln('                      CHUONG TRINH CHAM BAI FIRSTROW');
   writeln('            ============================================');
   write  ('                        Cho ten file test: FIRSTROW.IN'); chon:=readkey;
   writeln(chon); writeln;
   fin:='FIRSTROW.IN'+chon;
   assign(f, fou); reset(f); readln(f,s);
   if s=dapso[chon] then
   begin
      writeln;
      writeln('**********************************');
      writeln('           C O R R E C T !');
      writeln('**********************************');
      diem:=1;
   end
   else
   begin
        writeln;
        writeln('???????????????????????????????????????????????');
        writeln('       E R R O R:   Khong dung dap so!');
        writeln('                    Tim duoc: ',s);
        writeln('                    Dap so  : ',dapso[chon]);
        writeln('???????????????????????????????????????????????');
        diem:=0;
   end;
   writeln;    writeln;   writeln;
   writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   writeln('                              Diem: ' , diem);
   writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   readln;
END.
