uses crt;
type  mang=array[1..1000] of integer;
      arrayboolean=array[0..1000] of boolean;
var a:mang;
    b:array[1..1000] of 0..50;
    n,k,du,tong,minx,m,td:longint;
    mind,luu:array[0..13000] of integer;
    bra:arrayboolean;
    f,f1:text;
    t1:longint absolute 0:$46c;
    t2:longint;


procedure  readfile;
var i:word;
begin
 td:=7;
 textcolor(green);
 t2:=t1;
 fillchar(bra,sizeof(bra),true);
 assign(f,'maxloong.inp');
 reset(f);
 read(f,n,k);
 gotoxy(26,td);
 writeln(' This Is Data    : n=',n,'  k=',k);
 if n>300 then
 begin
 inc(td);
 gotoxy(26,td);
 writeln(' Program  Running:');
 end;
 m:=n;
 du:=0;tong:=0;
 for i:=1 to n do
  begin
   read(f,a[i]);
   du:=(du+a[i]) mod k;
   b[i]:=a[i] mod k;
   if b[i]=0 then begin bra[i]:=false;dec(m);end;
   inc(tong,b[i]);
  end;
 close(f);
end;

procedure innit;
begin
  fillchar(mind,sizeof(mind),0);
  luu:=mind;
  mind[0]:=1;
end;

procedure xuat;
var k1,i:longint;
    dk:arrayboolean;
begin
 fillchar(dk,sizeof(dk),true);
 k1:=du;
 I:=0;
 while k1>0 do
  begin
   dk[luu[k1]]:=false;
   inc(i);
   k1:=k1-b[luu[k1]];
  end;
  k1:=0;
  for i:=1 to n do
   if not dk[i] then
   begin
    inc(k1);
    bra[i]:=false;
    dec(tong,b[i]);
    dec(m);
   end;
end;


function  ok(i,j:longint):boolean;
var k1:longint;
begin
  ok:=true;
  k1:=j;
  k1:=k1-b[i];
  while k1>0 do
   begin
    if luu[k1]=i then exit;
    k1:=k1-b[luu[k1]];
   end;
   ok:=false;
end;

procedure find;
var i,j:longint;
begin
 innit;
 for i:=1 to du do
  for j:=1 to n do
   if bra[j] then
   if b[j]<>0 then
    if (b[j]<=i) and (mind[i-b[j]]>0) then
     if not ok(j,i) then
     if (mind[i]<mind[i-b[j]]+1) or (mind[i]=0) then
      begin
       mind[i]:=mind[i-b[j]]+1;
       luu[i]:=j;
      end;
 end;

 procedure xu_li;
 var  oko:boolean;
 begin
  readfile;
  du:=k;
  repeat
     repeat
      minx:=n+1;
       find;
       if (mind[du]>1)  and (mind[du]<minx) then
      begin
          minx:=mind[du];
          xuat;
      end;
     until mind[du]<=1;
     du:=du+k
  until du>tong;
  du:=0;tong:=0;
  for du:=1 to n do
   if bra[du]=false then
     begin
       inc(tong);
       write(f1,a[du]:9);
       if tong mod 10=0 then writeln(f1);
     end;
     writeln(f1,'So Cac So Hang Lon Nhat La   ',tong);
     gotoxy(26,td+1);
     writeln(' Program Finished:');
     gotoxy(26,td+2);
     writeln(' Time Run        :',((t1-t2)/18.21):6:6);
 end;

 BEGIN clrscr;
 assign(f1,'maxloong.out');
 rewrite(f1);
  xu_li;
  close(f1);
  readln
 END.

 20  22
 6 5 13 9 11 20 15 9 14 16 17 18 18 13 21 5 9 11 14 10
 12 10
 1 1 1 1 1 1 1 1 1 1 9 7
