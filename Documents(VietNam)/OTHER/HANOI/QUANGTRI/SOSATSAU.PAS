{sosatsaupas}
uses crt;
const mn=2000;
      fi='sosau1.inp';
      fo='sosau.out';
 var a:array[0..mn] of char;
 n:integer; f,g:text;
 Procedure doc;
 var i:integer;
     c:char;
 begin
   assign(f,fi); reset(f);
   readln(f,n);i:=0;
   while not eof(f) do
   begin
      read(f,c);
      if (c>='0') and (c<='9') then
      begin
         inc(i); a[i]:=c;
      end;
   end;
   for i:=1 to n do write(a[i]);
   writeln;
   close(f);
end;
{-------------------------------------}
function next:boolean;
var i,j:integer;
    tg:char;
  begin
    next:=false;i:=n-1;
    {duyet nguoc lan thu nhat tim diem gay}
    while a[i]>=a[i+1] do dec(i);
    writeln(i);
    if i=0 then exit;
    {duyet nguoc lan thu hai tim diem vuot}
    j:=n;
    while a[j]<=a[i] do dec(j);
    {hoan vi a[i] cho a[j];}
    tg:=a[i];a[i]:=a[j]; a[j]:=tg;
    inc(i);
    {lat doan a[i..n]};
    j:=n;
    while i<j do
    begin
      tg:=a[i]; a[i]:=a[j];a[j]:=tg;inc(i);dec(j);
    end;
    next:=true;
  end;
  Procedure ghi;
  {ghi ket qua vao tep}
  var i:integer;
  begin
     for i:=1 to n do
     write(g,a[i]);
     writeln(g);
  end;
  Procedure bailam;
  begin
  doc;
  a[0]:=pred('0');
  assign(g,fo);rewrite(g);
  if next then ghi
  else
    writeln(g,'0');
  close(g);
 end;
 BEGIN
   clrscr;
   bailam;
   readln;
 END.






