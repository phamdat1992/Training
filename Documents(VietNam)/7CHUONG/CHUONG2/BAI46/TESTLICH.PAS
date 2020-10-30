(*  Cham bai: Lich uu tien dung han   *)
uses crt;
const
   finp='LICHD.IN';
   fout='LICHD.OUT';
   dapso: array['0'..'9'] of integer = (36,13, 15, 51, 68, 97, 9, 18, 13, 34);
var
  p, d, tt: array[1..500] of integer;
  cx: array[1..500] of boolean;
  n, diem: integer;
  kmax: longint;
  f:text;
  chon: char;
  fn: string;

procedure Nhapdl;
var i:integer;
begin
   write('Cho ten file du lieu: LICHD.IN');chon:=readkey;writeln(chon);
   assign(f,finp+chon);reset(f);
   readln(f,n);
   for i:=1 to n do read(f,p[i]);
   for i:=1 to n do read(f,d[i]);
   close(f);
end;

procedure Evaluation;
var i, k, k1 : integer;
    pk: longint;
begin
   diem:=0;
   assign(f,fout); reset(f);
   readln(f,k1);
   for i:=1 to n do read(f,tt[i]);
   close(f);
   if k1< dapso[chon] then
   begin
       writeln('*** ERROR:  Trinh tu tim duoc khong phai toi uu');
       writeln('         k1= ',k1,' kmax = ',dapso[chon]);
       exit;
   end;
   for i:=1 to n do cx[i]:=true;
   writeln('***   Kiem tra trinh tu: ');
   for i:=1 to n do
   begin
       if (tt[i]<=0) or (tt[i]>n) then
       begin
           writeln('*** ERROR: Khong co cong viec voi chi so ',tt[i]);
           exit;
       end;
       if not cx[tt[i]] then
       begin
           writeln('*** ERROR: Cong viec ',tt[i],' xuat hien > 1 lan trong day');
           exit;
       end
       else cx[tt[i]]:=false;
   end;
   writeln('***   Kiem tra so viec dung han theo lich tim duoc: ');
   k:=0;pk:=0;
   for i:=1 to n do
   begin
       pk:=pk+p[tt[i]];
       if pk<=d[tt[i]] then k:=k+1;
   end;
   if k<>k1 then
   begin
       writeln('*** ERROR: So cong viec dung han trong lich khong khop');
       writeln('    Cong bo: k= ',k1,'. Tinh theo lich: ',k);
       exit;
   end;
   diem:=1;
end;

BEGIN
    clrscr;
    writeln('      CHAM BAI: XEP LICH UU TIEN DUNG HAN');
    writeln('      ===================================');
    writeln;
    Nhapdl;
    Evaluation;
    writeln;
    writeln('***********************************');
    writeln('*****         Diem: ',diem,'          ****');
    writeln('***********************************');
    readln;
END.

