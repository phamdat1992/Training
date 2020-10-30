(*cau be nghi ra mot so goi la s gom 4 chu so khong nhat thiet la khac nhau
  trong cac so tu 1 den 6.de tim so do.may lan luout dua ra cac so du doan
  moi so gom 4 chu so khong nhat thiet khac nhau voi moi so du doan may nhan
  duoc 2 cau tra loi cua cau be cho hai cau hoi sau:
   CO BAO NHIEU  CHU SO TRONG M LA CHU SO CUA S NHUNG VI TRI XUAT HIEN CUA MOI
   CHU SO DO LA SAI ?
   CO BAO NHIEU CHU SO LA CHU SO TRONG S VA DONG THOI MOI S XUAT HIEN TRONG MOI
   SO LA DUNG
  hay hien len man hinh cac so may du doan,moi so do nhan hai cau tra loi tu cau
  be cho den khi duoc so dung nhu cau be nghi (so lan du doan<6);*)

 uses crt;
 type mang=array[1..4] of 1..6;
 var a,b,a1:mang;
     aa:array[1..1296] of mang;
     oko:array[1..1296] of boolean;
     d1,d2:1..6;
     dem:word;

 function  ok(b:mang):boolean;
 var i,dem,j:0..6;
     dk:boolean;
     vl:array[1..5] of boolean;
 begin
   ok:=false;
   fillchar(vl,sizeof(vl),true);
   i:=0;
   dem:=0;
   for i:=1 to 4 do
    if a1[i]=b[i] then begin vl[i]:=false;inc(dem);end;
   if dem<>d1 then exit;
   dem:=0;
   for i:=1 to 4 do
    for j:=1 to 4 do
     if (i<>j) and (b[i]=a1[j]) and vl[i] and vl[j] then inc(dem);
   if dem<>d2 then exit;
   ok:=true;
  end;

  procedure innit;
  var i,i1,i2,i3,i4:0..6;
  begin
    fillchar(oko,sizeof(oko),false);
    dem:=0;
    for i:=1 to 4 do
      a[i]:=i;
      a1:=a;
    writeln('so may doan:');
    for i:=1 to 4 do write(a1[i]);
    writeln;
    write('co bao nhieu so trung khac vi tri ?');readln(d2);
    write('co bao nhieu so trung cung vi tri ?');readln(d1);
    for i1:=1 to 6 do
     begin
      b[1]:=i1;
      for i2:=1 to 6 do
       begin
        b[2]:=i2;
        for i3:=1 to 6 do
         begin
         b[3]:=i3;
          for i4:=1 to 6 do
           begin
            b[4]:=i4;
             if ok(b) then
             begin
            inc(dem);
            aa[dem]:=b;
            oko[dem]:=true;
            end;
          end;
             end;
          end;
      end;
   end;

 procedure  xu_li;
 var  i:word;
 begin
  innit;
  a1[1]:=2;a1[2]:=1;a1[3]:=5;a1[4]:=6;
    writeln('so may doan:');
    for i:=1 to 4 do write(a1[i]);
    writeln;
    write('co bao nhieu so trung khac vi tri ?');readln(d2);
    write('co bao nhieu so trung cung vi tri ?');readln(d1);
    for i:=1 to dem do
     if oko[i] then
       if ok(aa[i])=false then oko[i]:=false;
  repeat
    i:=1;
    while oko[i]=false do inc(i);
   if i<=dem then
    begin
    oko[i]:=false;
    writeln('so may doan:');
    a1:=aa[i];
     for i:=1 to 4 do write(a1[i]);
       writeln;
       write('co bao nhieu so trung cung vi tri ?');readln(d1);
       write('co bao nhieu so trung khac vi tri ?');readln(d2);
    for i:=1 to dem do
     if oko[i] then
       if ok(aa[i])=false then oko[i]:=false
     end;
  until d1=4;
  writeln('may da doan dung!!');
 end;

 begin  clrscr;
  xu_li;
  readln;
 end.




























































































