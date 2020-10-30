uses crt;
const fi='mavach.inp';
      fo='mavach.out';
type  xau_nhi_phan=string[40];
      mang=array[1..33] of byte;
var   a:array[1.. 50] of xau_nhi_phan;
      f:text;
      n,m,k,s,d:byte;
      b,c:mang;
      st:xau_nhi_phan;
      dem,luu:longint;

procedure  readfile;
var  i:byte;
begin dem:=0;luu:=1;
      assign(f,fi);
      reset(f);
      readln(f,n,k,m);
      readln(f,s);
      for i:=1 to s do readln(f,a[i]);
      close(f);
end;

procedure init;
begin
     assign(f,fo);
     rewrite(f);
     d:=0;
     fillchar(b,sizeof(b),0);
end;

procedure   quicksort(l,r:byte);
var  i,j:byte;x,tg:xau_nhi_phan;
begin
      i:=l;j:=r;x:=a[(i+j) div 2];
      repeat
          while a[i]<x do inc(i);
          while a[j]>x do dec(j);
          if i<=j then
           begin
              tg:=a[i];
              a[i]:=a[j];
              a[j]:=tg;
              inc(i);
              dec(j);
          end;
      until i>j;
      if i<r then quicksort(i,r);
      if j>l then quicksort(l,j);
end;

procedure chuyen2(b:mang;var st:xau_nhi_phan);
var dd,i:byte;
    ch:char;
begin
      st:='';ch:='1';
      for dd:=1 to k do
       begin
            for i:=1 to b[dd] do st:=st+ch;
            if odd(dd) then ch:='0'
            else ch:='1';
       end;
end;

function  min(i,j:byte):byte;
begin
     min:=i;
     if j<i then min:=j;
end;

function max(i,j:byte):byte;
begin
     max:=i;
     if j>i then max:=j;
end;

procedure xuat;
var  i:byte;
begin
      inc(dem);
      chuyen2(b,st);
      while st=a[luu] do begin writeln(a[luu],'  ',dem);inc(luu);end;
      if luu>s then begin close(f);halt;end;
end;

procedure  try;
var  i:byte;
begin
     if not odd(d) then
      for i:=1 to min(m,n-k+d+1) do
        begin
             inc(d);
             b[d]:=i;
             dec(n,i);
             if (n=0) and (d=k) then xuat
             else if (n>0) and (d<k) then try;
             dec(d);
             inc(n,i);
         end
     else
       for i:=min(m,n-k+d+1) downto 1 do
          begin
              inc(d);
              b[d]:=i;
              dec(n,i);
              if (n=0) and (d=k) then xuat
              else if (n>0) and (d<k) then try;
              dec(d);
              inc(n,i);
         end;
end;

begin  clrscr;
  readfile;
  quicksort(1,s);
  init;
  try;
end.
33 14 13
5
1001110
1110110
1001100
1001110
1000100