 (* cho n qua can doi mot khac nhau a1,a2..an.nguoi ta lan luot dat n qua can
    len mot trong hai dia can cua mot chiec can dia moi lan dat mot qua can
    len thi khong dat xuong nua.sau khi dat mot qua can len nguoi ta ghi lai
    trang thai cua ban can: L,R.
    KET QUA :khi dat n qua can len la mot xau do dai n gom cac ki tu L,R.
    bai toan:cho mot xau ki tu do dai n gom cac ki tu L,R.hay chi ra mot thu
    tu dat cac qua can len ban can chi ro dat ben nao sao cho ket qua sau khi
    dat xong n qua can la xau nay.
    du lieu cho tring file text co ten nhap tu ban phim dong dau la cac so a[i]
    cac dong tiep theo mon dong ghi mot xau ki tu ket qua.
    ket qua dua ra file text cach_dat.out.trong do ket qua cho cach dat mot xau
    ghi boi n dong lien tiep dong thu i ghi chi so cua qua can duoc dat len sau do
    la mot trong hai ki tu R,L chi ra tuong ung dat len trai hay phai ban can
    hai bo ket qua khac nhau ghi cach nhau boi mot dong trong *)
 uses crt;
 var a,val:array[1..50] of SHORTINT;
     b:array[1..50] of boolean;
     n,k,m:byte;
     st:string;
     d1,d2:integer;
     f,f1:text;

 function dat_phai(i:byte):boolean;
 begin
   dat_phai:=true;
   if st[k]='r' then
     if (d1<=d2) or ((d1>d2) and (d1<=a[i]+d2)) then exit;
   if st[k]='l'then
     if (d1>d2+a[i]) then exit;
   dat_phai:=false;
 end;

 function  dat_trai(i:byte):boolean;
 begin
   dat_trai:=true;
   if st[k]='l' then
     if (d1>=d2) or((d1<d2) and(d1+a[i]>d2)) then exit;
   if st[i]='r' then
     if d1+a[i]<=d2 then exit;
    dat_trai:=false;
 end;

 procedure  try;
 var i:byte;
 begin
  if k>n then
   begin
    d1:=0;d2:=0;
    writeln('OUTPUT:');
    for i:=1 to k-1 do
    begin
      write(st[i],'  ',abs(val[I]):8);
      if val[i]>0 then begin inc(d2,a[abs(val[i])]);write('  r  ',d1:6,d2:6 );end
      else begin inc(d1,a[abs(val[i])]);write('  l  ',d1:6,d2:6);end;
      writeln;
    end;
    m:=0;
    readln;
    halt;
    end
   else
   for i:=1 to n do
    if b[i] and (dat_trai(i) or dat_phai(i)) then
     begin
       if dat_phai(i) then
        begin
         val[k]:=i;
         inc(k);
         INC(D2,A[I]);
         b[i]:=false;
         try;
         DEC(D2,A[I]);
         b[i]:=true;
         dec(k);
        end;
       if dat_trai(i) then
        begin
         val[k]:=-i;
         INC(D1,A[I]);
         inc(k);
         b[i]:=false;
         try;
         b[i]:=true;
         dec(k);
         DEC(D1,A[I]);
        end;
     end;
 end;

 procedure  readfile;
 var i:byte;
 begin
   writeln(' INPUT:');
   assign(f,'dat_can.inp');
   reset(f);
   readln(f,n);
   for i:=1 to n do begin read(f,a[i]);write(a[i]:6);
   if i mod 10=0 then writeln;
   end;
   readln(f);
   k:=1;d1:=0;d2:=0;m:=n;
   fillchar(b,sizeof(b),true);
   readln(f,st);
   writeln;
   writeln('     ',st);
   try;
   if m<>0 then writeln('khong dat duoc');
 end;

 begin  clrscr;
 readfile;
 end.
17
1 6 8 7 9 4 2 3 2 4 6 7 8 9 15 16 21
lrrlrlrrrlrlrrlll

10
5 8 9 10 20 35 -60 65 80 100
lrrlrlrlll






































