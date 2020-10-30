uses crt;
var   a:array[0..100,0..100] of byte;
      b:array[0..100] of boolean;
      aa:array[1..100] of byte;
      n:byte;
      f:text;

procedure  readfile;
var   i,j:byte;
begin
  fillchar(a,sizeof(a),0);
  fillchar(aa,sizeof(aa),0);
  assign(f,'dientin.inp');
  reset(f);
  readln(f,n);
  for i:=1 to n do
   begin
    while not eoln(f) do
     begin
      read(f,j);
      a[i,j]:=1;
      inc(aa[i]);
     end;
     readln(f);
   end;
   close(f);
end;

procedure init;
begin
 fillchar(b,sizeof(b),true);
 b[1]:=false;
end;

function chon(i:byte):byte;
var   max,j,luu:byte;
begin
 max:=100;
 chon:=0;
 for j:=1 to n do
  if b[j]  and (a[i,j]=1) then
    if aa[j]<=max then
     begin
       max:=aa[j];
       luu:=j;
     end;
   dec(aa[i]);
   chon:=luu;
end;

function oko:boolean;
var i:byte;
begin
  oko:=false;
  for i:=1 to n do if b[i]  then exit;
  oko:=true;
end;
procedure  xuli;
var dem,dd,i,d1,k:byte;
    sl:array[1..100] of byte;
begin
 dem:=1;dd:=1;
 repeat
    d1:=0;
     for i:=1 to n do
      if (b[i]=false) and (aa[i]>0) then
        begin
          inc(d1);sl[d1]:=i;end;
           for i:=d1 downto 1 do
            begin
                k:=chon(sl[i]);
                  if (k>0)  and (k<=n) then
                     begin
                          write('[',sl[i],'.',k,']');
                          b[k]:=false;
                          inc(dd);
                      end;
              end;
                 inc(dem);
                 writeln;
 until oko;
 writeln('Thoi Gian Nho Nhat:  ',dem-1);
end;
begin  clrscr;
 readfile;
 init;
 xuli;
 readln
end.
9
12 3 4
2

9
2 3 4
5 6
6
7 8
0
0
0
0
9
2 3 4
0
5
6
7 8 9
8 9
0
0
0






















































































































































































































































































