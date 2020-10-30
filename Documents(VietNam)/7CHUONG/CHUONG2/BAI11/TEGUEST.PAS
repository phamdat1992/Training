{$R+,B-}
Uses Crt;
Const
   fi           =  'guest.inp';
   fo           =  'guest.out';
   max          =  1000;
   dapso        : array['1'..'6'] of longint
                  =(2188, 120, 30086, 725380, 2261097, 8289147);
type
   arr          =  array[1..20] of integer;
Var
   t,v,d        :  array[0..max] of integer;
   moi          :  array[1..max] of integer;
   f            :  text;
   goc,n,snm,d1 :  integer;
   opt, maxi    : longint;
   chon         : char;
   fn: string;

Procedure Nhap;
var i : integer;
Begin
   assign(f,fn); reset(f); readln(f,n);
   for i:=1 to n do readln(f,t[i],v[i]);
   close(f);
   for i:=1 to n do
       if t[i]=0 then
       begin
           goc:=i;
           break;
       end;
End;

procedure Kiemtra;
var i,j,y:integer;
    sum: longint;
begin
   d1:=0;
   assign(f,fo); reset(f);
   readln(f,snm,maxi);
   if snm>n then
   begin
       writeln('So nguoi moi > So nguoi cua Cong ty');
       readln; exit;
   end;
   for i:=1 to snm do readln(f,d[i]);
   close(f);
   for i:=1 to snm do
      if (d[i]<0) or (d[i]>n) then
      begin
          writeln('Loi: Khong co nguoi voi chi so ',d[i]);
          readln; exit;
      end;
   sum:=0;
   for i:=1 to snm do sum:=sum+v[d[i]];
   if sum<>maxi then
   begin
       writeln('Loi: Tong tinh theo loi giai khong dung',sum,' <> ',maxi);
       readln; exit;
   end;
   y:=whereY;
   for i:=1 to n do moi[i]:=0;
   for i:=1 to snm do moi[d[i]]:=1;
   for i:=1 to snm do
   begin
      gotoxy(1,y+1);
      writeln('Kiem tra khach moi: ',i);
      if (t[d[i]]<>0) and (moi[t[d[i]]]=1) then
      begin
         writeln('Loi: Nhan vien ',i,' duoc moi cung thu truong');
         readln; exit;
      end;
   end;
   writeln('******************************************');
   writeln('    C O R R E C T   S O L U T I O N !');
   writeln('******************************************');
   if sum>dapso[chon] then
   begin
       write('LOI:  Loi giai chua toi uu');
       readln; exit;
   end;
   d1:=5;
end;

BEGIN
   clrscr;
   writeln('         **********************************************');
   writeln('                  CHAM BAI: MOI KHACH DU TIEC');
   writeln('         **********************************************');
   write  ('                 Cho ten file test: GUEST.IN');chon:=readkey;
   writeln(chon);
   fn:='GUEST.IN'+chon;
   Nhap;
   Kiemtra;
   writeln('===================================');
   writeln('           Diem:  ',d1);
   writeln('===================================');
   readln;
END.
