uses crt;
const fin='ban_bi.inp';
      fou='ban_bi.out';
type
    toado=record
     x,y:byte;
     end;
    mang=array[1.. 15] of toado;
    mang1=array[1..15] of byte;
    mang3=array[1..31,1..31] of byte;
    mangs=array[1..35000] of boolean;
var
  f:text;
  f3:file of byte;
  f1:file of mang1;
  n,k,ax,ay,ct,lim:byte;
  fb:mang;c:mang1;a:mang3;
  last,first,dd:longint;
  f2:file of longint;
  chiso:array[1..300] of byte;
  time1:longint absolute 0:$46c;
  time2:longint;
  logic:mangs;

procedure readfile;
var i,j,dem,l:byte;
begin
 writeln('INPUT:');
 fillchar(chiso,sizeof(chiso),0);
 assign(f,fin);
 reset(f);
 readln(f,n,lim);writeln(n,'  ',lim);
 dem:=0;
 for i:=1 to n do
  begin
    for j:=1 to n do
      begin
        read(f,l); write(l,' ');
        if l>0 then begin inc(dem);fb[dem].x:=i;fb[dem].y:=j;c[dem]:=l;end;
      end;
      writeln;
  end;
  k:=dem;
  close(f);
end;

function mu(k:byte):word;
var i:byte;s:word;
begin
 s:=1;
 for i:=1 to k do s:=s*2;
 mu:=s;
end;

function doimang(c1:mang1):word;
var s:word;i:byte;
begin
 s:=1;
 for i:=1 to k do
  s:=s+(c1[i]-1)*mu(k-i);
  doimang:=s;
end;

procedure doi_so(i,j:byte);
  begin
    a[i,j]:=3-a[i,j];
  end;

procedure quay_trai;
begin
 if odd(ct) then
  begin
    dec(ay,2-ct);
    ct:=ct-1;
  end
 else
  begin
    dec(ax,ct-1);
    ct:=3-ct;
  end;
end;

procedure quay_phai;
begin
 if odd(ct) then
  begin
   dec(ay,ct-2);
   ct:=3-ct;
  end
 else
  begin
   dec(ax,1-ct);
   ct:=ct+1;
  end;
end;

procedure di_thang;
begin
 if odd(ct) then inc(ax,ct-2)
 else dec(ay,1-ct);
end;

procedure lan_bi;
begin
 repeat
  if a[ax,ay]=0 then di_thang
  else
   begin
    doi_so(ax,ay);
    if a[ax,ay]=2 then quay_trai
    else quay_phai;
  end;
 until (ax=1) or (ax=n) or (ay=1) or (ay=n);
end;

procedure chuyen1(c1:mang1;var am:mang3);
var i:byte;
begin
 fillchar(am,sizeof(am),0);
 for i:=1 to k do
   am[fb[i].x,fb[i].y]:=c1[i];
end;

procedure chuyen2(am:mang3;var c1:mang1);
var i:byte;
begin
  for i:=1 to k do
    c1[i]:=am[fb[i].x,fb[i].y];
end;

function can_ban(i:byte):boolean;
var j:byte;
begin
 can_ban:=true;
 if i=lim then exit;
 for j:=1 to n do if a[i,j]<>0 then exit;
 can_ban:=false;
end;

function oko(p,c:mang1):boolean;
var i:byte;
begin
 oko:=true;
 for i:=1 to k do
  if p[i]<>c[i] then exit;
 oko:=false;
end;

procedure   get(c1:mang1;lom:byte);
var i:byte;
begin
  inc(last);
  seek(f1,filesize(f1));
  seek(f2,filesize(f2));
  write(f2,first);
  seek(f3,filesize(f3));
  write(f3,lom);
  write(f1,c1);
end;

procedure  put(var am:mang1);
var i:integer;
begin
 reset(f1);
 seek(f1,first);
 read(f1,am);
 inc(first);
end;

procedure innit;
var i:byte;
begin
 fillchar(logic,sizeof(logic),true);
 last:=1;first:=0;
 i:=0;
 logic[doimang(c)]:=false;
 seek(f2,filesize(f2));
 seek(f3,filesize(f3));
 write(f2,first);
 write(f3,i);
 seek(f1,filesize(f1));
 write(f1,c);
end;

procedure xuli;
var i,i2,j2:byte;a1:mang3;c1:mang1;dk:boolean;kl:word;
begin
  innit;
  time2:=time1;
  dk:=true;
  repeat
    put(c);
    chuyen1(c,a1);
    i:=2;
    while (i<n) and dk do
     begin
       if can_ban(i) then
       begin
       a:=a1;
       ax:=i;ay:=1;ct:=2;
       lan_bi;
       chuyen2(a,c1);
       kl:=doimang(c1);
       if (logic[kl]) or((ax=lim) and (ay=n))  then
        begin
         get(c1,i);
         logic[kl]:=false;
         if (ax=lim) and (ay=n) then dk:=false;
        end;
       end;
        inc(i);
     end;
 until (dk=false) or (last<=first);
 writeln('OUTPUT:');
 if not dk then
  begin
    reset(f3);
      reset(f2);
       dd:=0;
     while last>1 do
        begin
            dec(last);
            seek(f3,last);
            seek(f2,last);
            read(f2,first);
            read(f3,i);
            inc(dd);
            chiso[dd]:=i;
            last:=first;
         end;
       writeln('DA HA DUOC MUC TIEU!');
       writeln(dd);
       for first:=dd downto 1 do write(chiso[first],'  ');
       writeln;
  end
  else writeln('KHONG TRUNG MUC TIEU!');
 writeln('TIME RUN: ',(time1-time2)/18.21:6:6);
end;

procedure main;
begin
 readfile;
 assign(f1,'ban_bi.dat');
 rewrite(f1);
 assign(f2,'ban_bi.da');
 rewrite(f2);
 assign(f3,'ban_bi.d');
 rewrite(f3);
 xuli;
 close(f3);
 close(f2);
 close(f1);
end;

BEGIN clrscr;
 main;
 readln
END.

4 2
0 0 2 0
0 2 1 0
0 1 1 0
0 0 0 1
4 2
0 0 0 0
0 0 0 0
0 1 1 0
0 0 0 0

6 4
0 0 0 0 0 0
0 1 2 0 1 0
0 2 2 0 0 0
0 1 0 0 2 0
0 1 1 1 1 0
0 0 0 0 0 0

30 12
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 1 2 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 2 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 1 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

7 3
0 0 0 0 0 0 0
0 1 1 0 1 1 0
0 0 0 1 2 1 0
0 2 2 1 2 2 0
0 1 0 1 1 0 0
0 0 0 0 0 0 0
0 0 0 0 0 0 0

6 2
0 0 0 0 0 0
0 1 2 2 1 0
0 0 2 1 1 0
0 1 1 2 2 0
0 1 1 2 1 0
0 0 0 0 0 0

8 2
0 0 0 0 0 0 0 0
0 1 0 0 1 1 0 0
0 2 0 1 0 0 1 0
0 0 2 0 0 0 0 0
0 1 0 0 0 0 0 0
0 0 2 0 0 2 0 0
0 1 0 1 1 0 0 0
0 0 0 0 0 0 0 0

10 9
0 0 0 0 0 0 0 0 0 0
0 1 1 2 0 0 0 0 0 0
0 0 1 0 0 1 0 1 0 0
0 0 0 1 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 1 0 1 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0
0 0 0 1 0 1 0 0 0 0
0 0 2 0 0 2 0 0 0 0
0 0 0 0 0 0 0 0 0 0

12 8
0 0 0 0 0 0 0 0 0 0 0 0
0 1 0 1 0 1 0 0 0 0 0 0
0 2 0 0 0 0 0 2 0 0 0 0
0 1 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0
0 1 0 0 0 2 0 0 0 0 0 0
0 2 0 0 0 0 2 0 0 0 0 0
0 0 0 0 0 2 0 0 0 0 1 0
0 0 0 1 0 0 0 0 0 0 0 0
0 0 0 0 2 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0

20 6
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 2 0 0 0 0 0 0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 2 0 0 0 0 1 0 0 0 0 0
0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0
0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0
0 0 0 1 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
6 2
0 0 0 0 0 0 0 0
0 1 1 0 1 1 0 0
0 2 0 1 2 1 0 0
0 2 2 1 0 2 0 0
0 1 0 1 1 0 0 0
0 0 0 0 0 0 0 0