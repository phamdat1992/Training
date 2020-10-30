{CHO LUOI .MOT SO O CO VI KHUAN MOT SO KHONG.TAC DUNG MOT LOAI VAC XIN LEN VI KHUAN
PHU THUOC VAO SO VI KHUAN O LAN CAN.XET O NHO THUOC LA T0 VA 8 O LAN CAN
NEU:
1.O TRUNG TAM CO VI KHUAN
 A, NEU C0 2 DEN 3 VI KHUAN THI THUOC KHONG CO TAC DUNG
 B, NEU CO KHONG QUA MOT VI KHUAN THI VI KHUAN BI CHET DO BI CO LAP
 C, NEU CO >= 4 VI KHUAN LAN CAN THI VI KHUAN CHET DO BUNG NO.
2.  NEU CO KHONG CO VI KHUAN
    NEU CO 3 VI KHUAN PHAN DEU THI NO THEM MOT VI KHUAN
CHI RA PHUONG AN DIET VI KHUAN TOT NHAT }

uses crt;
type
      mang=array[0..30,0..30] of 0..1;
      ph=record
       t,h:integer;
       end;
var a,a1:mang;
    lim:array[1..100] of integer;
    m,n,dem,luu:integer;f:text;
    b:array[1..2,1..8] of -1..1;
    time1:longint absolute 0:$46c;
    time2:longint;
    luu1:array[1..100] of ph;
    ok1:boolean;

procedure  readfile;
var i,j:byte;
begin
 assign(f,'inp.vk');
 reset(f);
 readln(f,m,n);
 for i:=1 to m do
  for j:=1 to n do read(f,a[i,j]);
  close(f);a1:=a;
 writeln(m:4,n:4);      dem:=0;
 for i:=1 to m do
 begin for j:=1 to n do begin  inc(dem,a[i,j]);write(a[i,j]:4);end;
      writeln;
 end;
 b[1,1]:=-1;b[2,1]:=0;b[1,2]:=1;b[2,2]:=0;b[1,3]:=0;b[2,3]:=-1;b[1,4]:=0;b[2,4]:=1;
 b[1,5]:=-1;b[2,5]:=-1;b[1,6]:=-1;b[2,6]:=1;b[1,7]:=1 ;b[2,7]:=1;b[1,8]:=1;b[2,8]:=-1;
 time2:=time1;
end;

function hop_phap(i,j,d:byte):boolean;
begin
    hop_phap:=false;
    if (i+b[1,d]>0) and (i+b[1,d]<=m) and ( j+b[2,d]>0) and(j+b[2,d]<=n) then
    hop_phap:=true;
end;

function vk_lan_can(i,j:byte):byte;
var d,dem:byte;
begin
 dem:=0;
 for d:=1 to 8 do
  if hop_phap(i,j,d)and (a[i+b[1,d],j+b[2,d]]=1) then  inc(dem);
  vk_lan_can:=dem;
end;

function phan_deu(i,j:byte):boolean;
var  d,luu:byte;
begin
   if (i>1) and (j>1) and (vk_lan_can(i,j)=3) then
    begin
        phan_deu:=true;
        if  (a[i-1,j]=1) and (a[i+1,j-1]=1) and (a[i+1,j+1]=1) then exit;
        if (a[i,j+1]=1) and (a[i-1,j-1]=1) and (a[i+1,j-1]=1) then exit;
        if (a[i,j-1]=1) and (a[i-1,j+1]=1) and (a[i+1,j+1]=1) then exit;
        if (a[i+1,j]=1) and (a[i-1,j-1]=1) and (a[i-1,j+1]=1) then exit;
     end;
     phan_deu:=false;
end;

function dietvk(i,j:byte):boolean;
begin
     dietvk:=false;
     if (a[i,j]=1) and ((vk_lan_can(i,j)<=1) or(vk_lan_can(i,j)>=4)) then dietvk:=true;
end;

function  sinhvk(i,j:byte):boolean;
begin
  sinhvk:=false;
  if(a[i,j]=0) and phan_deu(i,j) then sinhvk:=true;
end;

procedure  xuat;
var  i,j,j1,loong:byte;
begin
writeln('diet duoc,cach diet la:');
writeln('dung het ',luu,' lieu');
 for i:=1 to luu do
   if lim[i]>0 then
   begin
     loong:=((lim[i]-1) mod m) +1;
     writeln('lieu  ',i  ,':sinh o:',(lim[i]-loong) div m + 1,'.',loong);
       writeln('trang thai luc nay:');
         for j1:=1 to m do
           begin
             for j:=1 to n do
               if (j1-1)*m+j=lim[i] then
               begin  a1[j1,j]:=1;write(a1[j1,j]:4);end
               else
               write(a1[j1,j]:4);  writeln;
            end;
        readln;
   end
     else
     begin
      loong:=((-lim[i]-1)  mod m)+1;
      writeln('lieu ',i, ':  diet o:',(-lim[i]-loong) div m +1,'.',loong);
          writeln('trang thai luc nay:');
           for j1:=1 to m do
             begin for j:=1 to n do
               if -((j1-1)*m+j)=lim[i]  then  begin a1[j1,j]:=0;write(a1[j1,j]:4);end
               else write(a1[j1,j]:4);
              writeln;
              end;
             readln;
       end;
       ok1:=false;
  end;

procedure  try(var a:mang);
var i,j:byte;
begin
if ok1  and  ( (time1-time2)/18.21 < 30) then
begin
  for i:=1 to m do
   for j:=1 to n do
    if sinhvk(i,j) or dietvk(i,j) then
     begin
       inc(luu);
       if a[i,j]=0 then
        begin
            a[i,j]:=1;
            inc(dem);
            lim[luu]:=(i-1)*m+j;
         end
       else
        begin
        a[i,j]:=0;
        dec(dem);
        lim[luu]:=-((i-1)*m+j);
         end;
       if dem=0 then  xuat
       else
        try(a);
        if a[i,j]=1 then
         begin
           a[i,j]:=0;
           dec(dem);
         end
         else
          begin
                 inc(dem);
                 a[i,j]:=1;
          end;
          lim[luu]:=0;
          dec(luu);
   end;
  end;
end;

 begin clrscr;
 readfile;
 ok1:=true;
 try(a);
 if ok1 then writeln('khong diet duoc:');
 readln
 end.

 11 6
 0 0 0 0 0 0
 0 0 0 1 1 1
 0 0 0 0 1 0
 0 0 1 0 0 0
 0 0 1 1 0 1
 0 0 0 0 1 0
 0 0 1 0 0 0
 1 0 1 1 0 1
 0 0 1 0 0 0
 0 1 0 1 0 0
 1 1 1 0 0 0

 14  5
 0 1 0 0 1
 1 0 1 0 1
 0 1 0 0 1
 0 0 0 1 1
 0 1 0 0 1
 1 0 1 0 1
 0 1 0 0 1
 0 1 0 0 1
 1 0 1 0 1
 0 1 0 0 1
 0 0 0 0 1
 0 1 0 0 1
 1 0 1 0 1
 0 1 0 0 1
 6 6
 0 0 0 0 1 0
 0 0 1 0 0 0
 1 0 1 1 0 1
 0 0 1 0 0 0
 0 1 0 1 0 0
 1 1 1 0 0 0
 8 8
 1 1 0 0 0 0 1 0
 1 1 0 0 0 1 1 0
 0 0 0 0 0 0 0 1
 0 0 0 0 0 1 0 0
 1 1 1 0 0 0 0 0
 1 0 0 1 0 0 0 1
 0 0 0 0 0 0 0 0
 0 0 0 1 1 0 0 0

10 10
1 1 1 1 0 0 0 0 1 1
1 1 0 1 0 0 0 0 1 1
1 0 1 0 0 0 0 0 0 0
1 1 1 1 1 1 1 1 0 0
0 0 0 0 1 1 1 0 0 0
0 0 0 1 1 1 1 1 1 1
0 0 0 0 1 1 0 0 0 1
1 1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 0 1 1
1 1 1 1 1 1 1 1 1 1