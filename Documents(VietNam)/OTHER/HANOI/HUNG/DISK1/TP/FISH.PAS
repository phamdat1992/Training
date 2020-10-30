uses crt;
const fi='fish.inp';
      fo='fish.out';
type  mang=array[0..1000] of longint;
var   fb,t,d,ghi:mang;
      n,h,maxt,soca:longint;
      f:text;

procedure init;
begin
      fillchar(t,sizeof(t),0);
      d:=t;fb:=t;ghi:=t;
      soca:=0;
end;

procedure readfile;
var i:byte;
begin
        init;
        assign(f,fi);
        reset(f);maxt:=0;
        readln(f,n,h);
        h:=h*12;
        for i:=2 to n do begin  read(f,t[i]);t[i]:=t[i] div 5;t[i]:=t[i]+t[i-1] end;readln(f);
        for i:=1 to n do read(f,fb[i]);readln(f);
        for i:=1 to n do read(f,d[i]);
        close(f);
end;

function  max(i,j:integer):integer;
begin
   max:=i;
   if j>i then max:=j;
end;

function cacau(i,j:integer):longint;
var sl,sem,j1,dem:longint;
begin
     sl:=fb[i];dem:=0;j1:=j;
     while (j1>0) and (sl>0) do
      begin
         inc(dem,sl);
         dec(j1);
         sl:=max(0,sl-d[i]);
      end;
      cacau:=dem;
end;

function chon:longint;
var   maxx,luu,i,ka:longint;
begin
     maxx:=0;luu:=0;
     for i:=1 to n do
       begin
            if (t[i]>maxt) then
                begin
                  if  (h>=t[i]-maxt+1) then
                  begin
                      ka:=cacau(i,h-t[i]+maxt-1);
                      if ka>maxx then begin maxx:=ka;luu:=i;end;
                  end;
               end
            else
               begin
                    ka:=cacau(i,h);
                    if ka>maxx then begin maxx:=ka;luu:=i;end;
               end;
       end;
      chon:=luu;
end;

procedure  xulichon;
var k:integer;
begin
     k:=chon;
     inc(ghi[k]);
     inc(soca,fb[k]);
     dec(h);
     dec(h,max(0,t[k]-maxt));
     maxt:=max(t[k],maxt);
     fb[k]:=max(0,fb[k]-d[k]);
end;

procedure xuli;
var  i:byte;
begin
     repeat
         xulichon;
     until h<=0;
     writeln(f,soca);
     for i:=1 to n do write(f,ghi[i]*5,'  ');
     close(f);
end;

begin
   clrscr;
   readfile;
     assign(f,fo);
     rewrite(f);
   xuli;
 end.

