uses crt;
const fi='static.inp';
      fo='static.out';
type  mang=array[1..20] of string;
var   luu:mang;
      n,sl:byte;
      s,b,a:string;
      dk:boolean;
      f,f1:text;


function ok(i:byte;b:string):boolean;
var  j:byte;
begin
 ok:=true;
 for j:=1 to length(b) do
  if b[j]=chr(ord('0')+i) then exit;
 ok:=false;
end;

procedure  init;
begin
 fillchar(luu,sizeof(luu),' ');
 sl:=1;luu[sl]:=s;
end;

function  sochuso(i:char;b:string):byte;
var  j,dem:byte;
begin
 dem:=0;
 for j:=1 to length(b) do
    if b[j]=i then
     begin
     inc(dem);
     end;
  sochuso:=dem;
end;

procedure  tao_so_moi(b:string;var a:string);
var i:byte;
    ln:string;
begin
 a:='';
 for i:=0 to n do
  if ok(i,b) then
   begin
     str(sochuso(chr(ord('0')+i),b),ln);
     a:=a+ln+chr(ord('0')+i);
    end;
end;

procedure kiemtra(a:string);
var  i:byte;
begin
  dk:=false;
  if (sl=1) and (luu[sl]=a) then begin writeln(s:50,'  Tu Sinh  ');exit;end;
  if luu[1]=a then begin writeln(s:50,'  Thuoc Chu Trinh  ',sl); exit;end;
  for i:=2 to sl do
   if luu[i]=a then  begin writeln(s:50,'  Tu Sinh Sau ',i-1,'  Buoc');exit;end;
   inc(sl);
   luu[sl]:=a;
  dk:=true;
end;

procedure xuli;
begin
 assign(f,fi);
 reset(f);
 while not eof(f) do
  begin
   readln(f,s);
   n:=length(s);
   init;
   dk:=true;
   while (sl<20) and dk do
    begin
     b:=luu[sl];
     tao_so_moi(b,a);
     kiemtra(a);
    end;
    if sl>=20 then writeln(s,'  khong thuoc so thong ke');
  end;
 close(f);
end;

procedure   main;
  begin
    assign(f1,fo);
    rewrite(f1);
    xuli;
    close(f1);
  end;

begin  clrscr;
  b:='86';
  main;
  readln;
end.
22
314213241519
21221314
12
32465465465416465465465
45546465465465465465465
46545678921347864364798
4567897451486798768
45646547981798798798798
66666666666666666666666666666666666666666666666
