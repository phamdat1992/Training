(*Tim day dai nhat co tong chia het cho k*)
program bai_43_turbo_pascal_nxm_vvtd;
uses crt;
var a:array[1..1000] of word;
    maxd,luu:array[0..15000] of word;
    f,f1:text;
    n,k,du:word;

procedure readfile;
var i:word;j:longint;
begin
  du:=0;
  assign(f,'bai_43tp.inp');
  reset(f);
  readln(f,n,k);
  for i:=1 to n do
   begin
     read(f,j);
     a[i]:=j mod k;
     du:=(du+a[i]) mod k;
   end;
   close(F);
end;

Procedure Innit;
Begin
 Fillchar(maxd,sizeof(maxd),0);
 Luu:=maxd;
 Maxd[0]:=1;
End;

Function Chuaxet(i,j:word):boolean;
Var k1:word;
Begin
 K1:=i-a[j];
 Chuaxet:=false;
 While k1>0 do
  Begin
   If luu[k1]=j then exit;
   K1:=k1-a[luu[k1]];
  End;
  Chuaxet:=true;
End;

procedure find;
var i,j:word;
begin
 innit;
 for i:=1 to du do
  for j:=1 to n do
   if a[j]>0 then
   if (a[j]<=i) and (maxd[i-a[j]]>0) then
     if chuaxet(i,j) then
      if (maxd[i]=0) or (maxd[i]>maxd[i-a[j]]+1) then
       begin
        maxd[i]:=maxd[i-a[j]]+1;
        luu[i]:=j;
       end;
 end;

 procedure xuat;
 var ok:array[1..1000] of boolean;
     i,du1:word;
 begin
  assign(f1,'bai_43tp.out');
  rewrite(f1);
  fillchar(ok,sizeof(ok),true);
  i:=0;du1:=du;
  while du1>0 do
   begin
     ok[luu[du1]]:=false;
     du1:=du1-a[luu[du1]];
     inc(i);
   end;
   writeln(f1,n-i);i:=0;
   for du1:=1 to n do
    if ok[du1] then
    begin
     inc(i);
     write(f1,du1,'    ');
     if i mod 20=0 then writeln(f1);
    end;
   close(f1);
 end;

 procedure xu_li;
 begin
  readfile;
  repeat
   find;
   if maxd[du]>1 then xuat
   else du:=du+k;
  until maxd[du]>1;
 end;

BEGIN clrscr;
 xu_li;
END.
