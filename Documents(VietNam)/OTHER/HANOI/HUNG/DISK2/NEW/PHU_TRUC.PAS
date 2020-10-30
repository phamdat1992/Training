uses crt;
var f,ff:text;
    f1,f2:file of longint;
    m,n,p,dd:longint;

procedure readfile;
var i,j,i1:longint;
begin
  assign(f1,'phu_truc.data');
  rewrite(f1);
  assign(f,'phu_truc.inp');
  reset(f);
  readln(f,n);
  readln(f,m,p);
  for i1:=1 to n do
   begin
    readln(f,i,j);
    seek(f1,filesize(f1));
    write(f1,i,j);
  end;
  close(f);
  close(f1);
end;

function   ok(i:longint):boolean;
var j:longint;
begin
 ok:=false;
 reset(f2);
 for i:=0 to filesize(f2)-1 do
  begin
   seek(f2,filesize(f2));
   read(f2,j);
   if j=i then exit;
  end;
  ok:=true;
end;

function min(i,j:longint):longint;
begin
 min:=i;
 if i>j then min:=j;
end;

function max(i,j:longint):longint;
begin
  max:=i;
  if i<j then max:=j;
end;

function dodai(x,y:longint):longint;
begin
     dodai:=min(y,p)-m;
end;

function  chon:longint;
var maxd,luu,luu1,luu2,luu3,i,x,y:longint;
begin
  maxd:=0;luu1:=0;
  for i:=1 to n do
   begin
     seek(f1,(i-1)*2);
     read(f1,x,y);
     if x<=m then
     begin
     luu:=dodai(x,y);
     if luu>maxd then begin maxd:=luu;luu1:=i;luu2:=x;luu3:=y;end;
     end;
  end;
  p:=max(luu3,p);
  m:=min(luu3,p);
  chon:=luu1;
end;

procedure writefile;
var i,j:longint;
    fin,fou:text;
begin
 assign(fin,'phu_truc.out');
 rewrite(fin);
 writeln(fin,dd);
 if dd>0 then
  begin
   assign(fou,'p1.out');
   reset(fou);
   for i:=1 to dd do
    begin
     read(fou,j);
     writeln(fin,j);
    end;
    close(fou);
  end;
  close(fin);
end;

procedure xuli;
var dem:longint;
begin
   readfile;
   assign(ff,'p1.out');
   rewrite(ff);
   assign(f1,'phu_truc.dat');
   reset(f1);
   assign(f2,'phu_truc.da');
   rewrite(f2);
   dd:=0;
   repeat
    dem:=chon;
    if dem>0 then
   begin
    inc(dd);
    seek(f2,filesize(f2));
    write(f2,dem);
    writeln(ff,dem);writeln(dem);
    end;
   until (m>=p) or (dem=0);
   close(f2);
   close(f1);
   close(ff);
   writefile;
end;

begin  clrscr;
xuli;
end.
5
-15 10
-8 9
-18 5
9 10
5 8
7 9
3
2
1
3
