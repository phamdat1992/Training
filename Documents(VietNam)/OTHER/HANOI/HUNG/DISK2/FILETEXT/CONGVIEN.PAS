Uses crt;
const fi='congvien.inp';
      fo='congvien.out';
var   f,f1:text;
      a,b:array[0..1000] of longint;
      n,tong,kc:longint;
      t1:longint absolute 0:$46c;
      t2:longint;

procedure  readfile;
var  i:longint;
begin
   fillchar(a,sizeof(a),0);
   b:=a;
   assign(f,fi);
   reset(f);
   readln(f,n);
   tong:=0;
   for i:=1 to n-1 do
      begin
         read(f,b[i]);
         a[i]:=b[i]-b[i-1];
      end;
      tong:=b[n-1];
   close(f);
end;

function  ok(i:longint):boolean;
var j:longint;
begin
 ok:=true;
 for j:=1 to n-1 do
  if b[j]=i then exit;
 ok:=false;
end;

Function  KiemTraCachDat:boolean;
var   i:longint;
begin
   kiemtracachdat:=false;
   if tong mod kc<>0 then exit;
   for i:=1 to tong div kc do
    if ok(i*kc)=false then exit;
   kiemtracachdat:=true;
end;

procedure  DatTram;
var  i:longint;
begin
  kc:=b[1];
  i:=2;
  while (kc<=tong div 2) and not KiemTraCachDat do
  begin
   kc:=b[i];
   inc(i);
  end;
  assign(f,fo);
  rewrite(f);
  if kc<=tong div 2 then
   begin
     writeln(f,tong div kc+1);
     for i:=0 to n-1 do
      if b[i] mod kc =0 then
         writeln(f,i+1,'  ');
   end
   else begin writeln(f,2);writeln(f,'1  ',n);end;
   close(f);
end;

Begin  clrscr;
  t2:=t1;
  readfile;
  dattram;
  writeln('Time Run:',((t1-t2)/18.21):6:5);readln
end.

45
1 2 3 5 7 10
11 13 14 15 20
22 24 25 26 27 28 29 30
33 35 40 41 42 43 45 47 50 51 53 54
55 60 62 64 65 66 67 68 69 70 73 75 80

9
1
5
7
11
12
15
20
22
23

17
1
5
7
11
12
15
20
22
23
27
29
33
34
37
42
44
45


