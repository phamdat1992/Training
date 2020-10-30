(* CO N CONG VIEC VA HE THONG GOM M MAY CO TINH NANG HOAN TOAN GIONG NHAU.
   CAC CONG VIEC DUOC DANH SO TU 1->N,CAC MAY DUOC DANH SO YU 1->M.VOI MOI
   CONG VIEC I BIET
 - THOI GIAN HOAN THANH T[I]
 - THOI DIEM SAN SANG R[I] (CONG VIEC I KHONG DUOC TIEN HANH SOM HON R[I])
 - THOI HAN HOAN THANH D[I] (CONG VIEC I PHAI HOAN THANH KHONG MUON HON D[I])
   GIA THIET LA D[I]-R[I]>=T[I].
   QUA TRINH THUC HIEN CONG VIEC CHO PHEP DUOC NGAT QUANG NGIA LA TRONG QUA TRING
   THUC HIEN MOT MAY CO THE NGAT VIEC THUC HIEN CONG VIEC DANG TIEN HANH TREN NO DE CHUYEN SANG
   THUC HIEN MOT CONG VIEC KHAC VA CONG VIEC DANG THUC HIEN GIO CO THE LAI TIEP TUC THUC HIEN
   TRE BAT CU MAY NAO CUA HE THONG TAI BAT KI THOI DIEM NAO SAU DO.
 - TAI MOI THOI DIEM MOI MAY CHI THUC HIEN KHONG QUA MOT CONG VIEC VA MOI CONG VIEC
   VA MOI CONG VIEC DUOC THUC HIEN KHONG QUA MOT MAY.
 - THOI GIAN CHUYEN CV=0.
 THOI DIEM BAT DAU CONG VIEC LA KHONG.
 HAY LAP LICH DE TAT CA CAC CONG VIEC DUOC HOAN THANH DUNG HAN
 INPUT:
    VAO TU FILE VAN BAN VIEC.INP DONG DAU GHI HAI SO M,N (1<=M,N<=100);
    DONG THU I TRONG SO N DONG TIEP THEO GHI 3 SO NGUYEN DUONG T[I],R[I],D[I]
 OUTPUT:
     GHI RA FILE VIEC.OUT
     _ DONG DAU GHI (YES/NO) NEU NHU CO ( KHONG CO ) LICH THOA MAN YEU CAU DAT RA
       NEU CO LICH THI N NHOM DONG TIEP THEO SE MO TA LICH TIM DUOC
       TRONG DO NHOM DONG THU I  MO TA LICH THUC HIEN VIEC I;
 DONG DAU TIEN GHI K[I] >=0 RA SO LAN VIEC THUC HIEN CONG VIEC I
 BI NGAT QUANG
 2.DONG THU J TRONG SO K[I]+1 DONG TIEP THEO MO TA KHOANG THOI GIAN THU J
 TRONG QUA TRINH THUC HIEN CONG VIEC I BAO GOM BA SO NGUYEN DUONG THEO THU TU
 LA THOI DIEMBAT DAU VA THOI DIEM DUNG VA CHI SO CUA MAY THUC HIEN CONG VIEC I
 TRONG CAC FILE DU LIEU VA KET QUA CAC GIA TRI SO GHI TREN MOT DONG CACH NHAU IT NHAT MOT DAU TRANG.*)
uses crt;
const fin='viec.inp';
      fou='viec.out';
type
 viec=record
  t,r,d:longint;
 end;
 ghan=record
  d,c,sm:integer;
 end;
 mang=array[1..100] of viec;
var  a:mang;
     f,f1:text;
     m,n,min:byte;
     fb:array[1..100,0..100] of ghan;
     sl:array[1..100] of byte;
     i1:longint;
     t1,t2:set of byte;
     ok:array[1..1000] of 0..1;

procedure readfile;
var i:byte;
begin
 writeln('INPUT:');
 fillchar(sl,sizeof(sl),0);
 min:=100;
 assign(f,fin);
 reset(f);
 readln(f,n,m);
 writeln(n,'  ',m);
 for i:=1 to n do
 with a[i] do
  begin
    readln(f,t,r,d);
    writeln(t,'  ',r,'  ',d);
    if a[i].r<min then min:=a[i].r;
  end;
 close(f);
end;

procedure innit;
begin
 fillchar(fb,sizeof(fb),0);
end;

procedure botrimay;
var t:set of byte;
    i,j:byte;
begin
   t:=[];
   for i:=1 to n do
    if ok[i]=1 then
    if (sl[i]>0) and (fb[i,sl[i]].c+1=i1) then
     begin
       inc(fb[i,sl[i]].c);
       t2:=t2-[fb[i,sl[i]].sm];
       t:=t+[i];
     end;
    for i:=1 to n do
     if ok[i]=1 then
      if not (i in t) then
       begin
            inc(sl[i]);
            fb[i,sl[i]].d:=i1;
            fb[i,sl[i]].c:=i1;
            j:=1;
            while not (j in t2) do inc(j);
            fb[i,sl[i]].sm:=j;
            t2:=t2-[j];
       end;
end;

function  mins(i,j:longint):longint;
begin
 mins:=i;
 if i>j then mins:=j;
end;

procedure watch;
var i:byte;
begin
  writeln;
  for i:=1 to n do
  with a[i] do  writeln(t,'   ',r,'   ',d);
end;

procedure xuli;
var luu,luu1,max,j,i,lim,dem:byte;dk,dk1:boolean;
    oko:array[1..100] of 0..1;mind:longint;

begin
 fillchar(oko,sizeof(oko),0);
 i1:=min;
 dem:=0;
 dk:=false;
 t1:=[];
 for i:=1 to m do t1:=t1+[i];
 repeat
 t2:=t1;
 fillchar(ok,sizeof(ok),0);
   luu:=m;
   for i:=1 to n do
    if a[i].r<=i1 then a[i].r:=i1;
    dk1:=true;
    while (luu>0) and dk1 do
     begin
       mind:=1000;
       for i:=1 to n do
         if ok[i]=0 then
           if (a[i].t>0) and (a[i].r=i1) then
            if a[i].d-a[i].t+1<mind then
             begin
              mind:=a[i].d-a[i].t+1;
              luu1:=i;
             end;
         if mind<1000 then
          begin
           ok[luu1]:=1;
           dec(luu);
          end
         else dk1:=false;
     end;
  for i:=1 to n do
   if (ok[i]=1) then dec(a[i].t);
  for i:=1 to n do
      if (a[i].t=0) and (oko[i]=0) then begin inc(dem);oko[i]:=1;end;
  for i:=1 to n do
   if (a[i].t>0) and (a[i].t+a[i].r>=a[i].d) then dk:=true;
      botrimay;
      inc(i1);
      watch;readln;
 until dk or (dem>=n);
 writeln('OUTPUT:');
 if dem>=n then
 begin
 assign(f1,'viec.out');
 rewrite(f1);
 writeln(f1,'YES!':6);
 for i:=1 to n do
  begin
   writeln(f1,sl[i]-1:6);
   for j:=1 to sl[i] do writeln(f1,fb[i,j].d:6,fb[i,j].c:6,fb[i,j].sm:6);
  end;
  close(f1);
 end
else writeln('NO!');
end;

 begin   clrscr;
   readfile;
   xuli;
 end.

4 2
4 2 7
3 3 8
3 3 7
5 1 10
  YES!
     0
     2     5     2
     1
     4     4     1
     6     7     2
     1
     3     3     1
     5     6     1
     1
     1     2     1
     7     9     1














