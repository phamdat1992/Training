uses crt;
const  fi='tricolor.inp';
       fo='tricolor.out';
type   toado=record
          x,y:longint;
       end;
       hinh=record
          dt,pt:toado;
          mau:shortint;
       end;
var    a:array[0..1000] of hinh;
       sl:array[0..3] of longint;
       n:integer;
       maxx,maxy,minx,miny,s1,s2:longint;
       fn,fg:text;


procedure  openfile;
begin
      assign(fn,fi);
      reset(fn);
      assign(fg,fo);
      rewrite(fg);
end;

procedure  closefile;
begin
      close(fg);close(fn);
end;

procedure  init;
begin
      fillchar(a,sizeof(a),0);
      s1:=0;s2:=0;
      maxx:=0;maxy:=0;minx:=0;miny:=0;
end;

function inside(i,j,k:longint):boolean;
begin
     inside:=true;
       if (i>=a[k].dt.x) and (i+1<=a[k].pt.x) and (j>=a[k].dt.y) and (j+1<=a[k].pt.y) then exit;
     inside:=false;
end;

function Tricolor:boolean;
begin
     tricolor:=false;
       if (sl[1]<>1) or ( sl[2]<>1) or (sl[3]<>1) then exit;
     tricolor:=true;
end;

function TRiColors:boolean;
begin
     tricolors:=false;
        if (sl[1]<1) or ( sl[2]<1) or (sl[3]<1) then exit;
     tricolors:=true;
end;

function  Insure_tricolors:boolean;
begin
      insure_tricolors:=true;
        if tricolors and (sl[1]+sl[2]+sl[3]>3) then exit;
      insure_tricolors:=false;
end;

procedure  find(i,j:longint);
var  k:longint;
begin
      fillchar(sl,sizeof(sl),0);
      for k:=1 to n do
        if inside(i,j,k) then
          begin
                inc(sl[a[k].mau]);
                if insure_tricolors then exit;
          end;
end;

procedure  process;
var i,j:longint;
begin
      for i:=minx to maxx do
       for j:=miny to maxy do
         begin
                find(i,j);
                if tricolor then begin inc(s1);inc(s2);end
                else if tricolors then inc(s2);
         end;
end;

procedure  writefile;
begin
     writeln(fg,s2,'    ',s1);
end;


function stop_test(i:integer):boolean;
begin
      stop_test:=false;
        if a[i].mau<>-1 then exit;
      stop_test:=true;
end;

procedure  findmaxmin;
begin
      if (maxx=0) or (maxx<a[n].pt.x) then maxx:=a[n].pt.x;
      if (maxy=0) or (maxy<a[n].pt.y) then maxy:=a[n].pt.y;
      if (minx=0) or (minx>a[n].dt.x) then minx:=a[n].dt.x;
      if (miny=0) or (miny>a[n].dt.y) then miny:=a[n].dt.y;
end;

procedure  readfile;
begin
      while not eof(fn) do
        begin
              init;
              n:=1;
              readln(fn,a[n].dt.x,a[n].dt.y,a[n].pt.x,a[n].pt.y,a[n].mau);
              while a[n].mau<>-1 do
                begin
                      inc(n);
                      readln(fn,a[n].dt.x,a[n].dt.y,a[n].pt.x,a[n].pt.y,a[n].mau);
                      if a[n].mau<>-1 then findmaxmin;
                end;
              dec(n);
              if n>0 then
              begin
                   process;
                   writefile;
              end;
        end;
end;

procedure  main;
begin
      openfile;
      readfile;
      closefile;
end;

procedure  test;
var i,j,k,l,i1,j1,j2,i2,sl:longint;
begin
      assign(fn,fi);
      rewrite(fn);
      randomize;
          k:=random(20)+1;
          for i:=1 to k do
            begin
                sl:=random(10)+1;
                for j:=1 to sl do
                begin
                   i1:=random(100);
                   i2:=random(100)+i1;
                   j1:=random(100);
                   j2:=random(100)+j1;
                   l:=random(3)+1;
                   writeln(fn,i1,'  ',j1,'  ',i2,'  ',j2,'  ',l);
               end;
               writeln(fn,-1,'  ',-1,'  ',-1,'  ',-1,'   ',-1);
            end;
      close(fn);
end;

begin  clrscr;
  {
  test
  end.}
     main;
end.

0 4 4 1 1
1 1 5 2 2
1 1 2 5 3
-1 -1 -1 -1
0 0 2 2 1
1 1 3 3 2
2 2 4 4 3
-1 -1 -1 -1
-1 -1 -1 -1